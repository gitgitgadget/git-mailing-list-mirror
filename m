Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9BCC432C3
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363D665275
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhCIPD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhCIPC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435EEC06175F
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so3749934wmj.2
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uEmCwqIkaRyh2EUwKn9bEZLdHc1MywpkOcXMZAf7JT4=;
        b=cNCz+GUw73RthqBfXnT/vZWJqdHWfQtKg0SYQO+K3+XCpMutcdlnZik/oRIvXuMiUf
         kn8ahzGkAwI7BtZT8n67QUxxkn/K5YFAA8pj3jZD1gfd4iu+OZJPQ3p01vRHeJnowz+l
         zN28EfELW3P0RGBKklvq6LbB2LVux/Sd0gQIYiXzCD/dTxYTDWcprUx+WOms82ovbznu
         AH85OKMUcYG5uhNOqs7UjYkmA4JjAkKWSDD3RVk8Fo1xsK5JGBzuSKir+FNmK3dTXKIz
         qCmthToLjf28JdeaNrLwGvwvfzMroPPwHGQJjC6S0c0gzymwXB5CoxW49M2Jj8OS95K4
         uiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uEmCwqIkaRyh2EUwKn9bEZLdHc1MywpkOcXMZAf7JT4=;
        b=Ci5KYuTFsknpGAMnBv24EXmo5cUnhTpaJ3cQ48GgMZQaNZjyhugTqmTHoC6hChBn30
         gCaNljdmPlEbToljntzkd4Dp3JTf2Z26IssLUVz9TDRsQiIqde5r3PYbILkQrcz5xoaB
         YA6h253OSUjEmLEnXv3hRnAO1iJllcoAjDqlLmt+IAzOezDO+FRg34q4bFjsfGJgcbAK
         zJfizU7p2ZkltHVM6T8jHesrMS+zpT9Ibp2uXIW4QFzePQmEcgdlO7zI+Tn9AqFw3Hk6
         vdjIJQUd85Bni/NMDu+mzRS1IrJc+wpn5ImywmJ1FVHhXjgYUh9Q9UD/RXcxp/XE5dnk
         GO0Q==
X-Gm-Message-State: AOAM531h9VJwSJnvEXsj2LNxvM5/wrgboaNbgxAintWh/5pzdVZTZwS4
        KV4bpy66G3HhK8otnbC+G1MGnxR0U8s=
X-Google-Smtp-Source: ABdhPJxNNjt0AtB2LzdO9JhehhUXa5bg6ARPzrykx6dTrDf5f5bOKYBW3F8JIjnwMeMmc16GBj5b6w==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr4518925wmi.69.1615302174411;
        Tue, 09 Mar 2021 07:02:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm4345463wml.34.2021.03.09.07.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:54 -0800 (PST)
Message-Id: <6ccc7472096fb239fdeefe6b396ff747e198abe7.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:37 +0000
Subject: [PATCH v5 12/12] t0052: add simple-ipc tests and
 t/helper/test-simple-ipc tool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create t0052-simple-ipc.sh with unit tests for the "simple-ipc" mechanism.

Create t/helper/test-simple-ipc test tool to exercise the "simple-ipc"
functions.

When the tool is invoked with "run-daemon", it runs a server to listen
for "simple-ipc" connections on a test socket or named pipe and
responds to a set of commands to exercise/stress the communication
setup.

When the tool is invoked with "start-daemon", it spawns a "run-daemon"
command in the background and waits for the server to become ready
before exiting.  (This helps make unit tests in t0052 more predictable
and avoids the need for arbitrary sleeps in the test script.)

The tool also has a series of client "send" commands to send commands
and data to a server instance.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                   |   1 +
 t/helper/test-simple-ipc.c | 787 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 t/t0052-simple-ipc.sh      | 122 ++++++
 5 files changed, 912 insertions(+)
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh

diff --git a/Makefile b/Makefile
index 20dd65d19658..e556388d28d0 100644
--- a/Makefile
+++ b/Makefile
@@ -734,6 +734,7 @@ TEST_BUILTINS_OBJS += test-serve-v2.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
+TEST_BUILTINS_OBJS += test-simple-ipc.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
new file mode 100644
index 000000000000..42040ef81b1e
--- /dev/null
+++ b/t/helper/test-simple-ipc.c
@@ -0,0 +1,787 @@
+/*
+ * test-simple-ipc.c: verify that the Inter-Process Communication works.
+ */
+
+#include "test-tool.h"
+#include "cache.h"
+#include "strbuf.h"
+#include "simple-ipc.h"
+#include "parse-options.h"
+#include "thread-utils.h"
+#include "strvec.h"
+
+#ifndef SUPPORTS_SIMPLE_IPC
+int cmd__simple_ipc(int argc, const char **argv)
+{
+	die("simple IPC not available on this platform");
+}
+#else
+
+/*
+ * The test daemon defines an "application callback" that supports a
+ * series of commands (see `test_app_cb()`).
+ *
+ * Unknown commands are caught here and we send an error message back
+ * to the client process.
+ */
+static int app__unhandled_command(const char *command,
+				  ipc_server_reply_cb *reply_cb,
+				  struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	strbuf_addf(&buf, "unhandled command: %s", command);
+	ret = reply_cb(reply_data, buf.buf, buf.len);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * Reply with a single very large buffer.  This is to ensure that
+ * long response are properly handled -- whether the chunking occurs
+ * in the kernel or in the (probably pkt-line) layer.
+ */
+#define BIG_ROWS (10000)
+static int app__big_command(ipc_server_reply_cb *reply_cb,
+			    struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int row;
+	int ret;
+
+	for (row = 0; row < BIG_ROWS; row++)
+		strbuf_addf(&buf, "big: %.75d\n", row);
+
+	ret = reply_cb(reply_data, buf.buf, buf.len);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * Reply with a series of lines.  This is to ensure that we can incrementally
+ * compute the response and chunk it to the client.
+ */
+#define CHUNK_ROWS (10000)
+static int app__chunk_command(ipc_server_reply_cb *reply_cb,
+			      struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int row;
+	int ret;
+
+	for (row = 0; row < CHUNK_ROWS; row++) {
+		strbuf_setlen(&buf, 0);
+		strbuf_addf(&buf, "big: %.75d\n", row);
+		ret = reply_cb(reply_data, buf.buf, buf.len);
+	}
+
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * Slowly reply with a series of lines.  This is to model an expensive to
+ * compute chunked response (which might happen if this callback is running
+ * in a thread and is fighting for a lock with other threads).
+ */
+#define SLOW_ROWS     (1000)
+#define SLOW_DELAY_MS (10)
+static int app__slow_command(ipc_server_reply_cb *reply_cb,
+			     struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int row;
+	int ret;
+
+	for (row = 0; row < SLOW_ROWS; row++) {
+		strbuf_setlen(&buf, 0);
+		strbuf_addf(&buf, "big: %.75d\n", row);
+		ret = reply_cb(reply_data, buf.buf, buf.len);
+		sleep_millisec(SLOW_DELAY_MS);
+	}
+
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * The client sent a command followed by a (possibly very) large buffer.
+ */
+static int app__sendbytes_command(const char *received,
+				  ipc_server_reply_cb *reply_cb,
+				  struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf_resp = STRBUF_INIT;
+	const char *p = "?";
+	int len_ballast = 0;
+	int k;
+	int errs = 0;
+	int ret;
+
+	if (skip_prefix(received, "sendbytes ", &p))
+		len_ballast = strlen(p);
+
+	/*
+	 * Verify that the ballast is n copies of a single letter.
+	 * And that the multi-threaded IO layer didn't cross the streams.
+	 */
+	for (k = 1; k < len_ballast; k++)
+		if (p[k] != p[0])
+			errs++;
+
+	if (errs)
+		strbuf_addf(&buf_resp, "errs:%d\n", errs);
+	else
+		strbuf_addf(&buf_resp, "rcvd:%c%08d\n", p[0], len_ballast);
+
+	ret = reply_cb(reply_data, buf_resp.buf, buf_resp.len);
+
+	strbuf_release(&buf_resp);
+
+	return ret;
+}
+
+/*
+ * An arbitrary fixed address to verify that the application instance
+ * data is handled properly.
+ */
+static int my_app_data = 42;
+
+static ipc_server_application_cb test_app_cb;
+
+/*
+ * This is the "application callback" that sits on top of the
+ * "ipc-server".  It completely defines the set of commands supported
+ * by this application.
+ */
+static int test_app_cb(void *application_data,
+		       const char *command,
+		       ipc_server_reply_cb *reply_cb,
+		       struct ipc_server_reply_data *reply_data)
+{
+	/*
+	 * Verify that we received the application-data that we passed
+	 * when we started the ipc-server.  (We have several layers of
+	 * callbacks calling callbacks and it's easy to get things mixed
+	 * up (especially when some are "void*").)
+	 */
+	if (application_data != (void*)&my_app_data)
+		BUG("application_cb: application_data pointer wrong");
+
+	if (!strcmp(command, "quit")) {
+		/*
+		 * The client sent a "quit" command.  This is an async
+		 * request for the server to shutdown.
+		 *
+		 * We DO NOT send the client a response message
+		 * (because we have nothing to say and the other
+		 * server threads have not yet stopped).
+		 *
+		 * Tell the ipc-server layer to start shutting down.
+		 * This includes: stop listening for new connections
+		 * on the socket/pipe and telling all worker threads
+		 * to finish/drain their outgoing responses to other
+		 * clients.
+		 *
+		 * This DOES NOT force an immediate sync shutdown.
+		 */
+		return SIMPLE_IPC_QUIT;
+	}
+
+	if (!strcmp(command, "ping")) {
+		const char *answer = "pong";
+		return reply_cb(reply_data, answer, strlen(answer));
+	}
+
+	if (!strcmp(command, "big"))
+		return app__big_command(reply_cb, reply_data);
+
+	if (!strcmp(command, "chunk"))
+		return app__chunk_command(reply_cb, reply_data);
+
+	if (!strcmp(command, "slow"))
+		return app__slow_command(reply_cb, reply_data);
+
+	if (starts_with(command, "sendbytes "))
+		return app__sendbytes_command(command, reply_cb, reply_data);
+
+	return app__unhandled_command(command, reply_cb, reply_data);
+}
+
+struct cl_args
+{
+	const char *subcommand;
+	const char *path;
+	const char *token;
+
+	int nr_threads;
+	int max_wait_sec;
+	int bytecount;
+	int batchsize;
+
+	char bytevalue;
+};
+
+static struct cl_args cl_args = {
+	.subcommand = NULL,
+	.path = "ipc-test",
+	.token = NULL,
+
+	.nr_threads = 5,
+	.max_wait_sec = 60,
+	.bytecount = 1024,
+	.batchsize = 10,
+
+	.bytevalue = 'x',
+};
+
+/*
+ * This process will run as a simple-ipc server and listen for IPC commands
+ * from client processes.
+ */
+static int daemon__run_server(void)
+{
+	int ret;
+
+	struct ipc_server_opts opts = {
+		.nr_threads = cl_args.nr_threads,
+	};
+
+	/*
+	 * Synchronously run the ipc-server.  We don't need any application
+	 * instance data, so pass an arbitrary pointer (that we'll later
+	 * verify made the round trip).
+	 */
+	ret = ipc_server_run(cl_args.path, &opts, test_app_cb, (void*)&my_app_data);
+	if (ret == -2)
+		error(_("socket/pipe already in use: '%s'"), cl_args.path);
+	else if (ret == -1)
+		error_errno(_("could not start server on: '%s'"), cl_args.path);
+
+	return ret;
+}
+
+#ifndef GIT_WINDOWS_NATIVE
+/*
+ * This is adapted from `daemonize()`.  Use `fork()` to directly create and
+ * run the daemon in a child process.
+ */
+static int spawn_server(pid_t *pid)
+{
+	struct ipc_server_opts opts = {
+		.nr_threads = cl_args.nr_threads,
+	};
+
+	*pid = fork();
+
+	switch (*pid) {
+	case 0:
+		if (setsid() == -1)
+			error_errno(_("setsid failed"));
+		close(0);
+		close(1);
+		close(2);
+		sanitize_stdfds();
+
+		return ipc_server_run(cl_args.path, &opts, test_app_cb,
+				      (void*)&my_app_data);
+
+	case -1:
+		return error_errno(_("could not spawn daemon in the background"));
+
+	default:
+		return 0;
+	}
+}
+#else
+/*
+ * Conceptually like `daemonize()` but different because Windows does not
+ * have `fork(2)`.  Spawn a normal Windows child process but without the
+ * limitations of `start_command()` and `finish_command()`.
+ */
+static int spawn_server(pid_t *pid)
+{
+	char test_tool_exe[MAX_PATH];
+	struct strvec args = STRVEC_INIT;
+	int in, out;
+
+	GetModuleFileNameA(NULL, test_tool_exe, MAX_PATH);
+
+	in = open("/dev/null", O_RDONLY);
+	out = open("/dev/null", O_WRONLY);
+
+	strvec_push(&args, test_tool_exe);
+	strvec_push(&args, "simple-ipc");
+	strvec_push(&args, "run-daemon");
+	strvec_pushf(&args, "--name=%s", cl_args.path);
+	strvec_pushf(&args, "--threads=%d", cl_args.nr_threads);
+
+	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
+	close(in);
+	close(out);
+
+	strvec_clear(&args);
+
+	if (*pid < 0)
+		return error(_("could not spawn daemon in the background"));
+
+	return 0;
+}
+#endif
+
+/*
+ * This is adapted from `wait_or_whine()`.  Watch the child process and
+ * let it get started and begin listening for requests on the socket
+ * before reporting our success.
+ */
+static int wait_for_server_startup(pid_t pid_child)
+{
+	int status;
+	pid_t pid_seen;
+	enum ipc_active_state s;
+	time_t time_limit, now;
+
+	time(&time_limit);
+	time_limit += cl_args.max_wait_sec;
+
+	for (;;) {
+		pid_seen = waitpid(pid_child, &status, WNOHANG);
+
+		if (pid_seen == -1)
+			return error_errno(_("waitpid failed"));
+
+		else if (pid_seen == 0) {
+			/*
+			 * The child is still running (this should be
+			 * the normal case).  Try to connect to it on
+			 * the socket and see if it is ready for
+			 * business.
+			 *
+			 * If there is another daemon already running,
+			 * our child will fail to start (possibly
+			 * after a timeout on the lock), but we don't
+			 * care (who responds) if the socket is live.
+			 */
+			s = ipc_get_active_state(cl_args.path);
+			if (s == IPC_STATE__LISTENING)
+				return 0;
+
+			time(&now);
+			if (now > time_limit)
+				return error(_("daemon not online yet"));
+
+			continue;
+		}
+
+		else if (pid_seen == pid_child) {
+			/*
+			 * The new child daemon process shutdown while
+			 * it was starting up, so it is not listening
+			 * on the socket.
+			 *
+			 * Try to ping the socket in the odd chance
+			 * that another daemon started (or was already
+			 * running) while our child was starting.
+			 *
+			 * Again, we don't care who services the socket.
+			 */
+			s = ipc_get_active_state(cl_args.path);
+			if (s == IPC_STATE__LISTENING)
+				return 0;
+
+			/*
+			 * We don't care about the WEXITSTATUS() nor
+			 * any of the WIF*(status) values because
+			 * `cmd__simple_ipc()` does the `!!result`
+			 * trick on all function return values.
+			 *
+			 * So it is sufficient to just report the
+			 * early shutdown as an error.
+			 */
+			return error(_("daemon failed to start"));
+		}
+
+		else
+			return error(_("waitpid is confused"));
+	}
+}
+
+/*
+ * This process will start a simple-ipc server in a background process and
+ * wait for it to become ready.  This is like `daemonize()` but gives us
+ * more control and better error reporting (and makes it easier to write
+ * unit tests).
+ */
+static int daemon__start_server(void)
+{
+	pid_t pid_child;
+	int ret;
+
+	/*
+	 * Run the actual daemon in a background process.
+	 */
+	ret = spawn_server(&pid_child);
+	if (pid_child <= 0)
+		return ret;
+
+	/*
+	 * Let the parent wait for the child process to get started
+	 * and begin listening for requests on the socket.
+	 */
+	ret = wait_for_server_startup(pid_child);
+
+	return ret;
+}
+
+/*
+ * This process will run a quick probe to see if a simple-ipc server
+ * is active on this path.
+ *
+ * Returns 0 if the server is alive.
+ */
+static int client__probe_server(void)
+{
+	enum ipc_active_state s;
+
+	s = ipc_get_active_state(cl_args.path);
+	switch (s) {
+	case IPC_STATE__LISTENING:
+		return 0;
+
+	case IPC_STATE__NOT_LISTENING:
+		return error("no server listening at '%s'", cl_args.path);
+
+	case IPC_STATE__PATH_NOT_FOUND:
+		return error("path not found '%s'", cl_args.path);
+
+	case IPC_STATE__INVALID_PATH:
+		return error("invalid pipe/socket name '%s'", cl_args.path);
+
+	case IPC_STATE__OTHER_ERROR:
+	default:
+		return error("other error for '%s'", cl_args.path);
+	}
+}
+
+/*
+ * Send an IPC command token to an already-running server daemon and
+ * print the response.
+ *
+ * This is a simple 1 word command/token that `test_app_cb()` (in the
+ * daemon process) will understand.
+ */
+static int client__send_ipc(void)
+{
+	const char *command = "(no-command)";
+	struct strbuf buf = STRBUF_INIT;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+
+	if (cl_args.token && *cl_args.token)
+		command = cl_args.token;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	if (!ipc_client_send_command(cl_args.path, &options, command, &buf)) {
+		if (buf.len) {
+			printf("%s\n", buf.buf);
+			fflush(stdout);
+		}
+		strbuf_release(&buf);
+
+		return 0;
+	}
+
+	return error("failed to send '%s' to '%s'", command, cl_args.path);
+}
+
+/*
+ * Send an IPC command to an already-running server and ask it to
+ * shutdown.  "send quit" is an async request and queues a shutdown
+ * event in the server, so we spin and wait here for it to actually
+ * shutdown to make the unit tests a little easier to write.
+ */
+static int client__stop_server(void)
+{
+	int ret;
+	time_t time_limit, now;
+	enum ipc_active_state s;
+
+	time(&time_limit);
+	time_limit += cl_args.max_wait_sec;
+
+	cl_args.token = "quit";
+
+	ret = client__send_ipc();
+	if (ret)
+		return ret;
+
+	for (;;) {
+		sleep_millisec(100);
+
+		s = ipc_get_active_state(cl_args.path);
+
+		if (s != IPC_STATE__LISTENING) {
+			/*
+			 * The socket/pipe is gone and/or has stopped
+			 * responding.  Lets assume that the daemon
+			 * process has exited too.
+			 */
+			return 0;
+		}
+
+		time(&now);
+		if (now > time_limit)
+			return error(_("daemon has not shutdown yet"));
+	}
+}
+
+/*
+ * Send an IPC command followed by ballast to confirm that a large
+ * message can be sent and that the kernel or pkt-line layers will
+ * properly chunk it and that the daemon receives the entire message.
+ */
+static int do_sendbytes(int bytecount, char byte, const char *path,
+			const struct ipc_client_connect_options *options)
+{
+	struct strbuf buf_send = STRBUF_INIT;
+	struct strbuf buf_resp = STRBUF_INIT;
+
+	strbuf_addstr(&buf_send, "sendbytes ");
+	strbuf_addchars(&buf_send, byte, bytecount);
+
+	if (!ipc_client_send_command(path, options, buf_send.buf, &buf_resp)) {
+		strbuf_rtrim(&buf_resp);
+		printf("sent:%c%08d %s\n", byte, bytecount, buf_resp.buf);
+		fflush(stdout);
+		strbuf_release(&buf_send);
+		strbuf_release(&buf_resp);
+
+		return 0;
+	}
+
+	return error("client failed to sendbytes(%d, '%c') to '%s'",
+		     bytecount, byte, path);
+}
+
+/*
+ * Send an IPC command with ballast to an already-running server daemon.
+ */
+static int client__sendbytes(void)
+{
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+	options.uds_disallow_chdir = 0;
+
+	return do_sendbytes(cl_args.bytecount, cl_args.bytevalue, cl_args.path,
+			    &options);
+}
+
+struct multiple_thread_data {
+	pthread_t pthread_id;
+	struct multiple_thread_data *next;
+	const char *path;
+	int bytecount;
+	int batchsize;
+	int sum_errors;
+	int sum_good;
+	char letter;
+};
+
+static void *multiple_thread_proc(void *_multiple_thread_data)
+{
+	struct multiple_thread_data *d = _multiple_thread_data;
+	int k;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+	/*
+	 * A multi-threaded client should not be randomly calling chdir().
+	 * The test will pass without this restriction because the test is
+	 * not otherwise accessing the filesystem, but it makes us honest.
+	 */
+	options.uds_disallow_chdir = 1;
+
+	trace2_thread_start("multiple");
+
+	for (k = 0; k < d->batchsize; k++) {
+		if (do_sendbytes(d->bytecount + k, d->letter, d->path, &options))
+			d->sum_errors++;
+		else
+			d->sum_good++;
+	}
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Start a client-side thread pool.  Each thread sends a series of
+ * IPC requests.  Each request is on a new connection to the server.
+ */
+static int client__multiple(void)
+{
+	struct multiple_thread_data *list = NULL;
+	int k;
+	int sum_join_errors = 0;
+	int sum_thread_errors = 0;
+	int sum_good = 0;
+
+	for (k = 0; k < cl_args.nr_threads; k++) {
+		struct multiple_thread_data *d = xcalloc(1, sizeof(*d));
+		d->next = list;
+		d->path = cl_args.path;
+		d->bytecount = cl_args.bytecount + cl_args.batchsize*(k/26);
+		d->batchsize = cl_args.batchsize;
+		d->sum_errors = 0;
+		d->sum_good = 0;
+		d->letter = 'A' + (k % 26);
+
+		if (pthread_create(&d->pthread_id, NULL, multiple_thread_proc, d)) {
+			warning("failed to create thread[%d] skipping remainder", k);
+			free(d);
+			break;
+		}
+
+		list = d;
+	}
+
+	while (list) {
+		struct multiple_thread_data *d = list;
+
+		if (pthread_join(d->pthread_id, NULL))
+			sum_join_errors++;
+
+		sum_thread_errors += d->sum_errors;
+		sum_good += d->sum_good;
+
+		list = d->next;
+		free(d);
+	}
+
+	printf("client (good %d) (join %d), (errors %d)\n",
+	       sum_good, sum_join_errors, sum_thread_errors);
+
+	return (sum_join_errors + sum_thread_errors) ? 1 : 0;
+}
+
+int cmd__simple_ipc(int argc, const char **argv)
+{
+	const char * const simple_ipc_usage[] = {
+		N_("test-helper simple-ipc is-active    [<name>] [<options>]"),
+		N_("test-helper simple-ipc run-daemon   [<name>] [<threads>]"),
+		N_("test-helper simple-ipc start-daemon [<name>] [<threads>] [<max-wait>]"),
+		N_("test-helper simple-ipc stop-daemon  [<name>] [<max-wait>]"),
+		N_("test-helper simple-ipc send         [<name>] [<token>]"),
+		N_("test-helper simple-ipc sendbytes    [<name>] [<bytecount>] [<byte>]"),
+		N_("test-helper simple-ipc multiple     [<name>] [<threads>] [<bytecount>] [<batchsize>]"),
+		NULL
+	};
+
+	const char *bytevalue = NULL;
+
+	struct option options[] = {
+#ifndef GIT_WINDOWS_NATIVE
+		OPT_STRING(0, "name", &cl_args.path, N_("name"), N_("name or pathname of unix domain socket")),
+#else
+		OPT_STRING(0, "name", &cl_args.path, N_("name"), N_("named-pipe name")),
+#endif
+		OPT_INTEGER(0, "threads", &cl_args.nr_threads, N_("number of threads in server thread pool")),
+		OPT_INTEGER(0, "max-wait", &cl_args.max_wait_sec, N_("seconds to wait for daemon to start or stop")),
+
+		OPT_INTEGER(0, "bytecount", &cl_args.bytecount, N_("number of bytes")),
+		OPT_INTEGER(0, "batchsize", &cl_args.batchsize, N_("number of requests per thread")),
+
+		OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
+		OPT_STRING(0, "token", &cl_args.token, N_("token"), N_("command token to send to the server")),
+
+		OPT_END()
+	};
+
+	if (argc < 2)
+		usage_with_options(simple_ipc_usage, options);
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(simple_ipc_usage, options);
+
+	if (argc == 2 && !strcmp(argv[1], "SUPPORTS_SIMPLE_IPC"))
+		return 0;
+
+	cl_args.subcommand = argv[1];
+
+	argc--;
+	argv++;
+
+	argc = parse_options(argc, argv, NULL, options, simple_ipc_usage, 0);
+
+	if (cl_args.nr_threads < 1)
+		cl_args.nr_threads = 1;
+	if (cl_args.max_wait_sec < 0)
+		cl_args.max_wait_sec = 0;
+	if (cl_args.bytecount < 1)
+		cl_args.bytecount = 1;
+	if (cl_args.batchsize < 1)
+		cl_args.batchsize = 1;
+
+	if (bytevalue && *bytevalue)
+		cl_args.bytevalue = bytevalue[0];
+
+	/*
+	 * Use '!!' on all dispatch functions to map from `error()` style
+	 * (returns -1) style to `test_must_fail` style (expects 1).  This
+	 * makes shell error messages less confusing.
+	 */
+
+	if (!strcmp(cl_args.subcommand, "is-active"))
+		return !!client__probe_server();
+
+	if (!strcmp(cl_args.subcommand, "run-daemon"))
+		return !!daemon__run_server();
+
+	if (!strcmp(cl_args.subcommand, "start-daemon"))
+		return !!daemon__start_server();
+
+	/*
+	 * Client commands follow.  Ensure a server is running before
+	 * sending any data.  This might be overkill, but then again
+	 * this is a test harness.
+	 */
+
+	if (!strcmp(cl_args.subcommand, "stop-daemon")) {
+		if (client__probe_server())
+			return 1;
+		return !!client__stop_server();
+	}
+
+	if (!strcmp(cl_args.subcommand, "send")) {
+		if (client__probe_server())
+			return 1;
+		return !!client__send_ipc();
+	}
+
+	if (!strcmp(cl_args.subcommand, "sendbytes")) {
+		if (client__probe_server())
+			return 1;
+		return !!client__sendbytes();
+	}
+
+	if (!strcmp(cl_args.subcommand, "multiple")) {
+		if (client__probe_server())
+			return 1;
+		return !!client__multiple();
+	}
+
+	die("Unhandled subcommand: '%s'", cl_args.subcommand);
+}
+#endif
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f97cd9f48a69..287aa6002307 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -65,6 +65,7 @@ static struct test_cmd cmds[] = {
 	{ "sha1", cmd__sha1 },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
+	{ "simple-ipc", cmd__simple_ipc },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
 	{ "submodule-config", cmd__submodule_config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 28072c0ad5ab..9ea4b31011dd 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -55,6 +55,7 @@ int cmd__sha1(int argc, const char **argv);
 int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
+int cmd__simple_ipc(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
new file mode 100755
index 000000000000..ff98be31a51b
--- /dev/null
+++ b/t/t0052-simple-ipc.sh
@@ -0,0 +1,122 @@
+#!/bin/sh
+
+test_description='simple command server'
+
+. ./test-lib.sh
+
+test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
+	skip_all='simple IPC not supported on this platform'
+	test_done
+}
+
+stop_simple_IPC_server () {
+	test-tool simple-ipc stop-daemon
+}
+
+test_expect_success 'start simple command server' '
+	test_atexit stop_simple_IPC_server &&
+	test-tool simple-ipc start-daemon --threads=8 &&
+	test-tool simple-ipc is-active
+'
+
+test_expect_success 'simple command server' '
+	test-tool simple-ipc send --token=ping >actual &&
+	echo pong >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'servers cannot share the same path' '
+	test_must_fail test-tool simple-ipc run-daemon &&
+	test-tool simple-ipc is-active
+'
+
+test_expect_success 'big response' '
+	test-tool simple-ipc send --token=big >actual &&
+	test_line_count -ge 10000 actual &&
+	grep -q "big: [0]*9999\$" actual
+'
+
+test_expect_success 'chunk response' '
+	test-tool simple-ipc send --token=chunk >actual &&
+	test_line_count -ge 10000 actual &&
+	grep -q "big: [0]*9999\$" actual
+'
+
+test_expect_success 'slow response' '
+	test-tool simple-ipc send --token=slow >actual &&
+	test_line_count -ge 100 actual &&
+	grep -q "big: [0]*99\$" actual
+'
+
+# Send an IPC with n=100,000 bytes of ballast.  This should be large enough
+# to force both the kernel and the pkt-line layer to chunk the message to the
+# daemon and for the daemon to receive it in chunks.
+#
+test_expect_success 'sendbytes' '
+	test-tool simple-ipc sendbytes --bytecount=100000 --byte=A >actual &&
+	grep "sent:A00100000 rcvd:A00100000" actual
+'
+
+# Start a series of <threads> client threads that each make <batchsize>
+# IPC requests to the server.  Each (<threads> * <batchsize>) request
+# will open a new connection to the server and randomly bind to a server
+# thread.  Each client thread exits after completing its batch.  So the
+# total number of live client threads will be smaller than the total.
+# Each request will send a message containing at least <bytecount> bytes
+# of ballast.  (Responses are small.)
+#
+# The purpose here is to test threading in the server and responding to
+# many concurrent client requests (regardless of whether they come from
+# 1 client process or many).  And to test that the server side of the
+# named pipe/socket is stable.  (On Windows this means that the server
+# pipe is properly recycled.)
+#
+# On Windows it also lets us adjust the connection timeout in the
+# `ipc_client_send_command()`.
+#
+# Note it is easy to drive the system into failure by requesting an
+# insane number of threads on client or server and/or increasing the
+# per-thread batchsize or the per-request bytecount (ballast).
+# On Windows these failures look like "pipe is busy" errors.
+# So I've chosen fairly conservative values for now.
+#
+# We expect output of the form "sent:<letter><length> ..."
+# With terms (7, 19, 13) we expect:
+#   <letter> in [A-G]
+#   <length> in [19+0 .. 19+(13-1)]
+# and (7 * 13) successful responses.
+#
+test_expect_success 'stress test threads' '
+	test-tool simple-ipc multiple \
+		--threads=7 \
+		--bytecount=19 \
+		--batchsize=13 \
+		>actual &&
+	test_line_count = 92 actual &&
+	grep "good 91" actual &&
+	grep "sent:A" <actual >actual_a &&
+	cat >expect_a <<-EOF &&
+		sent:A00000019 rcvd:A00000019
+		sent:A00000020 rcvd:A00000020
+		sent:A00000021 rcvd:A00000021
+		sent:A00000022 rcvd:A00000022
+		sent:A00000023 rcvd:A00000023
+		sent:A00000024 rcvd:A00000024
+		sent:A00000025 rcvd:A00000025
+		sent:A00000026 rcvd:A00000026
+		sent:A00000027 rcvd:A00000027
+		sent:A00000028 rcvd:A00000028
+		sent:A00000029 rcvd:A00000029
+		sent:A00000030 rcvd:A00000030
+		sent:A00000031 rcvd:A00000031
+	EOF
+	test_cmp expect_a actual_a
+'
+
+test_expect_success 'stop-daemon works' '
+	test-tool simple-ipc stop-daemon &&
+	test_must_fail test-tool simple-ipc is-active &&
+	test_must_fail test-tool simple-ipc send --token=ping
+'
+
+test_done
-- 
gitgitgadget
