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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A62C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53F661159
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhITPhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhITPhu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81EAC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so29178296wrg.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=icLaEkrW27nB6n3VpTAiOzUFJuxu99LJ0DDiPaBiKuk=;
        b=Btl/HQblQ5wkXAHFnpwzXcH3jhmbnbL9GFeJuBHhISbC2YMrQPxpWrId6wgweboQMa
         1lPRORSV5dNNs8UXoOuzJxU746ALiqNLOpEQfPwo0rL3hz266QDoM3etz4rFRRr37Y6b
         u1yCWiQxOh30rac+GvafaYflYMmvbRmKnhw9ufBNHyDOaet2XF16OJDQ2vMRQ09xIY/T
         bwaQ6EOw6muDD0e0xGjXdsCDBUq4VXH7yh8ReHfllYKz1wNyuPNXtSKnkIJ5lxMQZhMi
         jHdcHb4yCnVFwzgD5ZaBLTOirCckpG+F8cbUL0j7ZKWq/+R7zr9qiopKtSL9pPe+r/SX
         wM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=icLaEkrW27nB6n3VpTAiOzUFJuxu99LJ0DDiPaBiKuk=;
        b=8HPIUky+cAmBsD3bbx+iBZRcvJPlDPqdqGcNBwpbYlEZkqkZr7uw+cVegmU2+VeyWA
         z6Zegbj37ml0q0A2qKPTmXVIN3eLmAwJ53ZTmqVTd0osCXs5X3+uN2bWHwhE/5a3djgx
         s38O6OAXnX96oGWOumfb/PxzLaoTjF8QYH7cOEyAO0/K4HUqCfwykHOuS905Pwa7JbR3
         2UHkvH9s3Ua+RwykLx6tLR6Dq+esC1KN+xDCfVfSWgwMNuXHi1PDNB91bBuXCiDgb0my
         iLIMd8ZmKoE50w1AfywEQQAAPUYSvM/oRUk2T22fGdsDB7WBvwMf195eVssxkN4oLi75
         MFdg==
X-Gm-Message-State: AOAM533u4ePQqcRyQREHuq+8bvZyZzOigI+bnj4azHNn3vi+sr62pVC3
        y4ZuxdEu503nJbtlAptBMSr45a/wLY0=
X-Google-Smtp-Source: ABdhPJxcZrYnEaazDaiO+jXvIUoY2dzTykLP4cJmmci+X9k/1YZ+/1W/pIFu8Gdbgz2Gmrs3w2v+MQ==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr23380850wmq.151.1632152181509;
        Mon, 20 Sep 2021 08:36:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm2520307wmq.26.2021.09.20.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:36:21 -0700 (PDT)
Message-Id: <258baa0df8ca8c068fd953bd52cbe246d2e7fa09.1632152178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 15:36:13 +0000
Subject: [PATCH v2 2/7] simple-ipc: preparations for supporting binary
 messages.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add `command_len` argument to the Simple IPC API.

In my original Simple IPC API, I assumed that the request would always
be a null-terminated string of text characters.  The `command`
argument was just a `const char *`.

I found a caller that would like to pass a binary command to the
daemon, so I am amending the Simple IPC API to receive `const char
*command, size_t command_len` arguments.

I considered changing the `command` argument to be a `void *`, but the
IPC layer simply passes it to the pkt-line layer which takes a `const
char *`, so to avoid confusion I left it as is.

Note, the response side has always been a `struct strbuf` which
includes the buffer and length, so we already support returning a
binary answer.  (Yes, it feels a little weird returning a binary
buffer in a `strbuf`, but it works.)

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

