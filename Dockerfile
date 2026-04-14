FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY container/go.mod ./
RUN go mod download

COPY container/ .
RUN CGO_ENABLED=0 GOOS=linux go build -o container .

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/container .

EXPOSE 8080
ENTRYPOINT ["./container"]
