Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3147C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738D260240
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhIOUhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AC3C061764
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so5825843wrr.9
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Ey5pVclP/nMS6WKkIL4uf44AVx+0z97PoZxSVXx7Vk=;
        b=nKegNZaZZ1ho3lyqtxnwKhDqLwdPECHeAFkX63yAQznEVXgtTEh8pIaSk0FvpYl8G3
         +LsuEjMge6/jn0LfhXZdl2Be8rTwpApIA8wlBLhd+7EDkclVmAkTtR2fd1aU4SvrMZH8
         KHuLCcYgS3AcZ6iA2tsMAe/rXDCOjTz0k8LbpfX49HqWsKJshvgsUUJ3lxwfwW9BLHJd
         RmlRNi4NSqocqIVetjoMRnyEcQ93qAvD/GGnmTO6qIbEqjhlAPxY+92NIPszwo5v2pEb
         cSxZGmXpND5uCHkrmCdCHn0A31i2dMMifgtLD3jkaEXWoIFdgX2YNOqN43Ha/+elva4m
         QdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Ey5pVclP/nMS6WKkIL4uf44AVx+0z97PoZxSVXx7Vk=;
        b=jeVB8VL905+iE3LXRVt3o3c2btEviQX4Jj3gFgp9LC0ZPTjQOcDkg8H31YHku8+qSO
         ceFPRhCIYaRMHj9qLVDh0xe+slocx7E4f3BXV0bNNQYtEq21A1vhiPAOGfiKQaxaeo5s
         rFeB4FTUtVyM681yJAYWPzVytS4HdYWN5NTVa0ANxXw99FFvsVaeLvCvqd/V9EOFP7Zd
         eUX1Xsb0TopgleRzH7B+o6UOSsT1rvtEbhbS6kOWIldewHLLnG9vJaauNMXpXJmBBTqD
         fHKqpoz4qME4fZYQZDF8qj3uwIYkxkOZ9EgaKcAtKfbQdKIHgYuEDPYBmmCIx7NIqoCh
         Q7Yw==
X-Gm-Message-State: AOAM531MF095YskEPhw5hYwMPYUPr6Cxr/MO/KM+xaZIQ7NaBw3VIODL
        RK8dSsanuDBOpnHsar1405raS9aNXqE=
X-Google-Smtp-Source: ABdhPJyKSPLssMNlLFSHe1sXThWWzoLv4trF19cao7sireSBLpdbJIvfIVnX9b8A8Vtx5yUndP+5KA==
X-Received: by 2002:adf:f48b:: with SMTP id l11mr2113527wro.254.1631738180261;
        Wed, 15 Sep 2021 13:36:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm1028070wrj.96.2021.09.15.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:20 -0700 (PDT)
Message-Id: <7182419f6dfa49d4d8415736943c72a575ab6753.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:12 +0000
Subject: [PATCH 2/7] simple-ipc: preparations for supporting binary messages.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add `command_len` argument to the Simple IPC API.

In my original Simple IPC API, I assumed that the request
would always be a null-terminated string of text characters.
The command arg was just a `const char *`.

I found a caller that would like to pass a binary command
to the daemon, so I want to ammend the Simple IPC API to
take `const char *command, size_t command_len` and pass
that to the daemon.  (Really, the first arg should just be
a `void *` or `const unsigned byte *` to make that clearer.)

Note, the response side has always been a `struct strbuf`
which includes the buffer and length, so we already support
returning a binary answer.  (Yes, it feels a little weird
returning a binary buffer in a `strbuf`, but it works.)

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/simple-ipc/ipc-unix-socket.c | 14 +++++++-----
 compat/simple-ipc/ipc-win32.c       | 14 +++++++-----
 simple-ipc.h                        |  7 ++++--
 t/helper/test-simple-ipc.c          | 34 +++++++++++++++++++----------
 4 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 1927e6ef4bc..4e28857a0a1 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -168,7 +168,8 @@ void ipc_client_close_connection(struct ipc_client_connection *connection)
 
 int ipc_client_send_command_to_connection(
 	struct ipc_client_connection *connection,
-	const char *message, struct strbuf *answer)
+	const char *message, size_t message_len,
+	struct strbuf *answer)
 {
 	int ret = 0;
 
@@ -176,7 +177,7 @@ int ipc_client_send_command_to_connection(
 
 	trace2_region_enter("ipc-client", "send-command", NULL);
 
-	if (write_packetized_from_buf_no_flush(message, strlen(message),
+	if (write_packetized_from_buf_no_flush(message, message_len,
 					       connection->fd) < 0 ||
 	    packet_flush_gently(connection->fd) < 0) {
 		ret = error(_("could not send IPC command"));
@@ -197,7 +198,8 @@ done:
 
 int ipc_client_send_command(const char *path,
 			    const struct ipc_client_connect_options *options,
-			    const char *message, struct strbuf *answer)
+			    const char *message, size_t message_len,
+			    struct strbuf *answer)
 {
 	int ret = -1;
 	enum ipc_active_state state;
@@ -208,7 +210,9 @@ int ipc_client_send_command(const char *path,
 	if (state != IPC_STATE__LISTENING)
 		return ret;
 
-	ret = ipc_client_send_command_to_connection(connection, message, answer);
+	ret = ipc_client_send_command_to_connection(connection,
+						    message, message_len,
+						    answer);
 
 	ipc_client_close_connection(connection);
 
@@ -503,7 +507,7 @@ static int worker_thread__do_io(
 	if (ret >= 0) {
 		ret = worker_thread_data->server_data->application_cb(
 			worker_thread_data->server_data->application_data,
-			buf.buf, do_io_reply_callback, &reply_data);
+			buf.buf, buf.len, do_io_reply_callback, &reply_data);
 
 		packet_flush_gently(reply_data.fd);
 	}
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8dc7bda087d..8e889d6a506 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -208,7 +208,8 @@ void ipc_client_close_connection(struct ipc_client_connection *connection)
 
 int ipc_client_send_command_to_connection(
 	struct ipc_client_connection *connection,
-	const char *message, struct strbuf *answer)
+	const char *message, size_t message_len,
+	struct strbuf *answer)
 {
 	int ret = 0;
 
@@ -216,7 +217,7 @@ int ipc_client_send_command_to_connection(
 
 	trace2_region_enter("ipc-client", "send-command", NULL);
 
-	if (write_packetized_from_buf_no_flush(message, strlen(message),
+	if (write_packetized_from_buf_no_flush(message, message_len,
 					       connection->fd) < 0 ||
 	    packet_flush_gently(connection->fd) < 0) {
 		ret = error(_("could not send IPC command"));
@@ -239,7 +240,8 @@ done:
 
 int ipc_client_send_command(const char *path,
 			    const struct ipc_client_connect_options *options,
-			    const char *message, struct strbuf *response)
+			    const char *message, size_t message_len,
+			    struct strbuf *response)
 {
 	int ret = -1;
 	enum ipc_active_state state;
@@ -250,7 +252,9 @@ int ipc_client_send_command(const char *path,
 	if (state != IPC_STATE__LISTENING)
 		return ret;
 
-	ret = ipc_client_send_command_to_connection(connection, message, response);
+	ret = ipc_client_send_command_to_connection(connection,
+						    message, message_len,
+						    response);
 
 	ipc_client_close_connection(connection);
 
@@ -458,7 +462,7 @@ static int do_io(struct ipc_server_thread_data *server_thread_data)
 	if (ret >= 0) {
 		ret = server_thread_data->server_data->application_cb(
 			server_thread_data->server_data->application_data,
-			buf.buf, do_io_reply_callback, &reply_data);
+			buf.buf, buf.len, do_io_reply_callback, &reply_data);
 
 		packet_flush_gently(reply_data.fd);
 
diff --git a/simple-ipc.h b/simple-ipc.h
index 2c48a5ee004..9c7330fcda0 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -107,7 +107,8 @@ void ipc_client_close_connection(struct ipc_client_connection *connection);
  */
 int ipc_client_send_command_to_connection(
 	struct ipc_client_connection *connection,
-	const char *message, struct strbuf *answer);
+	const char *message, size_t message_len,
+	struct strbuf *answer);
 
 /*
  * Used by the client to synchronously connect and send and receive a
@@ -119,7 +120,8 @@ int ipc_client_send_command_to_connection(
  */
 int ipc_client_send_command(const char *path,
 			    const struct ipc_client_connect_options *options,
-			    const char *message, struct strbuf *answer);
+			    const char *message, size_t message_len,
+			    struct strbuf *answer);
 
 /*
  * Simple IPC Server Side API.
@@ -144,6 +146,7 @@ typedef int (ipc_server_reply_cb)(struct ipc_server_reply_data *,
  */
 typedef int (ipc_server_application_cb)(void *application_data,
 					const char *request,
+					size_t request_len,
 					ipc_server_reply_cb *reply_cb,
 					struct ipc_server_reply_data *reply_data);
 
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 42040ef81b1..91345180750 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -112,7 +112,7 @@ static int app__slow_command(ipc_server_reply_cb *reply_cb,
 /*
  * The client sent a command followed by a (possibly very) large buffer.
  */
-static int app__sendbytes_command(const char *received,
+static int app__sendbytes_command(const char *received, size_t received_len,
 				  ipc_server_reply_cb *reply_cb,
 				  struct ipc_server_reply_data *reply_data)
 {
@@ -123,6 +123,13 @@ static int app__sendbytes_command(const char *received,
 	int errs = 0;
 	int ret;
 
+	/*
+	 * The test is setup to send:
+	 *     "sendbytes" SP <n * char>
+	 */
+	if (received_len < strlen("sendbytes "))
+		BUG("received_len is short in app__sendbytes_command");
+
 	if (skip_prefix(received, "sendbytes ", &p))
 		len_ballast = strlen(p);
 
@@ -160,7 +167,7 @@ static ipc_server_application_cb test_app_cb;
  * by this application.
  */
 static int test_app_cb(void *application_data,
-		       const char *command,
+		       const char *command, size_t command_len,
 		       ipc_server_reply_cb *reply_cb,
 		       struct ipc_server_reply_data *reply_data)
 {
@@ -173,7 +180,7 @@ static int test_app_cb(void *application_data,
 	if (application_data != (void*)&my_app_data)
 		BUG("application_cb: application_data pointer wrong");
 
-	if (!strcmp(command, "quit")) {
+	if (command_len == 4 && !strncmp(command, "quit", 4)) {
 		/*
 		 * The client sent a "quit" command.  This is an async
 		 * request for the server to shutdown.
@@ -193,22 +200,23 @@ static int test_app_cb(void *application_data,
 		return SIMPLE_IPC_QUIT;
 	}
 
-	if (!strcmp(command, "ping")) {
+	if (command_len == 4 && !strncmp(command, "ping", 4)) {
 		const char *answer = "pong";
 		return reply_cb(reply_data, answer, strlen(answer));
 	}
 
-	if (!strcmp(command, "big"))
+	if (command_len == 3 && !strncmp(command, "big", 3))
 		return app__big_command(reply_cb, reply_data);
 
-	if (!strcmp(command, "chunk"))
+	if (command_len == 5 && !strncmp(command, "chunk", 5))
 		return app__chunk_command(reply_cb, reply_data);
 
-	if (!strcmp(command, "slow"))
+	if (command_len == 4 && !strncmp(command, "slow", 4))
 		return app__slow_command(reply_cb, reply_data);
 
-	if (starts_with(command, "sendbytes "))
-		return app__sendbytes_command(command, reply_cb, reply_data);
+	if (command_len >= 10 && starts_with(command, "sendbytes "))
+		return app__sendbytes_command(command, command_len,
+					      reply_cb, reply_data);
 
 	return app__unhandled_command(command, reply_cb, reply_data);
 }
@@ -488,7 +496,9 @@ static int client__send_ipc(void)
 	options.wait_if_busy = 1;
 	options.wait_if_not_found = 0;
 
-	if (!ipc_client_send_command(cl_args.path, &options, command, &buf)) {
+	if (!ipc_client_send_command(cl_args.path, &options,
+				     command, strlen(command),
+				     &buf)) {
 		if (buf.len) {
 			printf("%s\n", buf.buf);
 			fflush(stdout);
@@ -556,7 +566,9 @@ static int do_sendbytes(int bytecount, char byte, const char *path,
 	strbuf_addstr(&buf_send, "sendbytes ");
 	strbuf_addchars(&buf_send, byte, bytecount);
 
-	if (!ipc_client_send_command(path, options, buf_send.buf, &buf_resp)) {
+	if (!ipc_client_send_command(path, options,
+				     buf_send.buf, buf_send.len,
+				     &buf_resp)) {
 		strbuf_rtrim(&buf_resp);
 		printf("sent:%c%08d %s\n", byte, bytecount, buf_resp.buf);
 		fflush(stdout);
-- 
gitgitgadget

