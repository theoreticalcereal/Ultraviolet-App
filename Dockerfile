FROM node:18-alpine

# Set environment to production
ENV NODE_ENV=production

# Install pnpm globally and required build tools
RUN apk add --no-cache python3 make g++ && \
    npm install -g pnpm

# Set working directory
WORKDIR /app

# Copy dependency definitions
COPY package.json pnpm-lock.yaml ./

# Install only production dependencies
RUN pnpm install --prod

# Copy rest of the app
COPY . .

# Expose the desired port
EXPOSE 8080/tcp

# Metadata
LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

# Start the app
ENTRYPOINT [ "node" ]
CMD [ "src/index.js" ]
