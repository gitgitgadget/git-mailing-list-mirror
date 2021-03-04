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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A995C43381
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C8364F69
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhCDUSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbhCDUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:14 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4DC061765
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u187so9151909wmg.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mYoxVcsxU/jQwxzRJQihePvWNbwlT8KZgUy0bqywTzg=;
        b=mugLQxc9DFn4rtbRMPJQE7KDX7zIxwBZ62N0dxePNUsuL5Ad3zBghv6mpstKB1zB9X
         2XuFFXWu1cWmTrbQpbIig/qD6GxAntyT7RMLksw0vgor3TF++JshTg5M0CqjyoR+LOHm
         PjDt4kpUfRNXmthfnNX7mCgxcjJ6+799uDP7CGu/agjHQXeD7vpkDoZqRbGABML5lBkH
         Ba/VHCr8l9tFlKGVx2Ykid9ONEcMSHjGcRT8eb7runEC+iAs9eF44/sTvjiVUXODTVVf
         2Hxe2pI4HsLFqGpEX7r2dfw+oegHFLv0lUi3gwlYdbTOxnUB3E5EB+JzxyltdmF50d96
         wUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mYoxVcsxU/jQwxzRJQihePvWNbwlT8KZgUy0bqywTzg=;
        b=gMEXddb850RyGOMxte4QJwTNoM8MX3MBmC8wLuwldzUB3eI8x+/nO+JP501Y5ZtMp0
         8MqoWroFIYFykegdUJuonIPLZnvKiTns0n9gaLfoqPAZ/YWcEaBKLL4ZssufqCGSikM+
         XAyskCzaZG5jORsSEdNgoana7zGMFoPzn3osRSJAlnxlUvktibiR0u4F4vt2sRY5QR14
         imuYFAcGUd4YdI0JKSB4DzmdJWpJ9YBMYW+IueRBopaeAj95Fwnr0rklCyp2IX1+SSTH
         65OBsYP5rImWjGGHlCTcS9hLCQy4abQ1dWgQTi/JcP+bh7gMbtjyKBojiAr6HyOH1zhH
         P6qQ==
X-Gm-Message-State: AOAM531m5W5Lf8S8alC5W8MVS/xKoQDt2Sc2ehsfSkOb1uBhMELnmUOC
        0rhDC0W6NnaYrWQBfKXle++WBY6T2hY=
X-Google-Smtp-Source: ABdhPJzBJIfZoJXX9nhJwkTcZwnILM1VpTyyj9wfOa1ROy/em1SPsHaSi5CDH2XT+yY+noX8oKz4iA==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr5384608wmc.35.1614889052564;
        Thu, 04 Mar 2021 12:17:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm575510wrh.3.2021.03.04.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:32 -0800 (PST)
Message-Id: <db0467a7e4193adf525bf15ee333ec0bbab55872.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:25 +0000
Subject: [PATCH 6/8] test-simple-ipc: refactor command line option processing
 in helper
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

Refactor command line option processing in simple-ipc helper under
the main "simple-ipc" command rather than in the individual subcommands.

Update "start-daemon" subcommand to pass socket pathname to background
process on both platforms.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-simple-ipc.c | 307 ++++++++++++++++++-------------------
 1 file changed, 153 insertions(+), 154 deletions(-)

diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index d0e6127528a7..116c824d7555 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -213,43 +213,53 @@ static int test_app_cb(void *application_data,
 	return app__unhandled_command(command, reply_cb, reply_data);
 }
 
+struct cl_args
+{
+	const char *subcommand;
+	const char *path;
+
+	int nr_threads;
+	int max_wait_sec;
+	int bytecount;
+	int batchsize;
+
+	char bytevalue;
+};
+
+struct cl_args cl_args = {
+	.subcommand = NULL,
+	.path = "ipc-test",
+
+	.nr_threads = 5,
+	.max_wait_sec = 60,
+	.bytecount = 1024,
+	.batchsize = 10,
+
+	.bytevalue = 'x',
+};
+
 /*
  * This process will run as a simple-ipc server and listen for IPC commands
  * from client processes.
  */
-static int daemon__run_server(const char *path, int argc, const char **argv)
+static int daemon__run_server(void)
 {
 	int ret;
 
 	struct ipc_server_opts opts = {
-		.nr_threads = 5
-	};
-
-	const char * const daemon_usage[] = {
-		N_("test-helper simple-ipc run-daemon [<options>"),
-		NULL
+		.nr_threads = cl_args.nr_threads,
 	};
-	struct option daemon_options[] = {
-		OPT_INTEGER(0, "threads", &opts.nr_threads,
-			    N_("number of threads in server thread pool")),
-		OPT_END()
-	};
-
-	argc = parse_options(argc, argv, NULL, daemon_options, daemon_usage, 0);
-
-	if (opts.nr_threads < 1)
-		opts.nr_threads = 1;
 
 	/*
 	 * Synchronously run the ipc-server.  We don't need any application
 	 * instance data, so pass an arbitrary pointer (that we'll later
 	 * verify made the round trip).
 	 */
-	ret = ipc_server_run(path, &opts, test_app_cb, (void*)&my_app_data);
+	ret = ipc_server_run(cl_args.path, &opts, test_app_cb, (void*)&my_app_data);
 	if (ret == -2)
-		error(_("socket/pipe already in use: '%s'"), path);
+		error(_("socket/pipe already in use: '%s'"), cl_args.path);
 	else if (ret == -1)
-		error_errno(_("could not start server on: '%s'"), path);
+		error_errno(_("could not start server on: '%s'"), cl_args.path);
 
 	return ret;
 }
@@ -259,10 +269,12 @@ static int daemon__run_server(const char *path, int argc, const char **argv)
  * This is adapted from `daemonize()`.  Use `fork()` to directly create and
  * run the daemon in a child process.
  */
-static int spawn_server(const char *path,
-			const struct ipc_server_opts *opts,
-			pid_t *pid)
+static int spawn_server(pid_t *pid)
 {
+	struct ipc_server_opts opts = {
+		.nr_threads = cl_args.nr_threads,
+	};
+
 	*pid = fork();
 
 	switch (*pid) {
@@ -274,7 +286,8 @@ static int spawn_server(const char *path,
 		close(2);
 		sanitize_stdfds();
 
-		return ipc_server_run(path, opts, test_app_cb, (void*)&my_app_data);
+		return ipc_server_run(cl_args.path, &opts, test_app_cb,
+				      (void*)&my_app_data);
 
 	case -1:
 		return error_errno(_("could not spawn daemon in the background"));
@@ -289,9 +302,7 @@ static int spawn_server(const char *path,
  * have `fork(2)`.  Spawn a normal Windows child process but without the
  * limitations of `start_command()` and `finish_command()`.
  */
-static int spawn_server(const char *path,
-			const struct ipc_server_opts *opts,
-			pid_t *pid)
+static int spawn_server(pid_t *pid)
 {
 	char test_tool_exe[MAX_PATH];
 	struct strvec args = STRVEC_INIT;
@@ -305,7 +316,8 @@ static int spawn_server(const char *path,
 	strvec_push(&args, test_tool_exe);
 	strvec_push(&args, "simple-ipc");
 	strvec_push(&args, "run-daemon");
-	strvec_pushf(&args, "--threads=%d", opts->nr_threads);
+	strvec_pushf(&args, "--name=%s", cl_args.path);
+	strvec_pushf(&args, "--threads=%d", cl_args.nr_threads);
 
 	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
 	close(in);
@@ -325,8 +337,7 @@ static int spawn_server(const char *path,
  * let it get started and begin listening for requests on the socket
  * before reporting our success.
  */
-static int wait_for_server_startup(const char * path, pid_t pid_child,
-				   int max_wait_sec)
+static int wait_for_server_startup(pid_t pid_child)
 {
 	int status;
 	pid_t pid_seen;
@@ -334,7 +345,7 @@ static int wait_for_server_startup(const char * path, pid_t pid_child,
 	time_t time_limit, now;
 
 	time(&time_limit);
-	time_limit += max_wait_sec;
+	time_limit += cl_args.max_wait_sec;
 
 	for (;;) {
 		pid_seen = waitpid(pid_child, &status, WNOHANG);
@@ -354,7 +365,7 @@ static int wait_for_server_startup(const char * path, pid_t pid_child,
 			 * after a timeout on the lock), but we don't
 			 * care (who responds) if the socket is live.
 			 */
-			s = ipc_get_active_state(path);
+			s = ipc_get_active_state(cl_args.path);
 			if (s == IPC_STATE__LISTENING)
 				return 0;
 
@@ -377,7 +388,7 @@ static int wait_for_server_startup(const char * path, pid_t pid_child,
 			 *
 			 * Again, we don't care who services the socket.
 			 */
-			s = ipc_get_active_state(path);
+			s = ipc_get_active_state(cl_args.path);
 			if (s == IPC_STATE__LISTENING)
 				return 0;
 
@@ -404,39 +415,15 @@ static int wait_for_server_startup(const char * path, pid_t pid_child,
  * more control and better error reporting (and makes it easier to write
  * unit tests).
  */
-static int daemon__start_server(const char *path, int argc, const char **argv)
+static int daemon__start_server(void)
 {
 	pid_t pid_child;
 	int ret;
-	int max_wait_sec = 60;
-	struct ipc_server_opts opts = {
-		.nr_threads = 5
-	};
-
-	const char * const daemon_usage[] = {
-		N_("test-helper simple-ipc start-daemon [<options>"),
-		NULL
-	};
-
-	struct option daemon_options[] = {
-		OPT_INTEGER(0, "max-wait", &max_wait_sec,
-			    N_("seconds to wait for daemon to startup")),
-		OPT_INTEGER(0, "threads", &opts.nr_threads,
-			    N_("number of threads in server thread pool")),
-		OPT_END()
-	};
-
-	argc = parse_options(argc, argv, NULL, daemon_options, daemon_usage, 0);
-
-	if (max_wait_sec < 0)
-		max_wait_sec = 0;
-	if (opts.nr_threads < 1)
-		opts.nr_threads = 1;
 
 	/*
 	 * Run the actual daemon in a background process.
 	 */
-	ret = spawn_server(path, &opts, &pid_child);
+	ret = spawn_server(&pid_child);
 	if (pid_child <= 0)
 		return ret;
 
@@ -444,7 +431,7 @@ static int daemon__start_server(const char *path, int argc, const char **argv)
 	 * Let the parent wait for the child process to get started
 	 * and begin listening for requests on the socket.
 	 */
-	ret = wait_for_server_startup(path, pid_child, max_wait_sec);
+	ret = wait_for_server_startup(pid_child);
 
 	return ret;
 }
@@ -455,27 +442,27 @@ static int daemon__start_server(const char *path, int argc, const char **argv)
  *
  * Returns 0 if the server is alive.
  */
-static int client__probe_server(const char *path)
+static int client__probe_server(void)
 {
 	enum ipc_active_state s;
 
-	s = ipc_get_active_state(path);
+	s = ipc_get_active_state(cl_args.path);
 	switch (s) {
 	case IPC_STATE__LISTENING:
 		return 0;
 
 	case IPC_STATE__NOT_LISTENING:
-		return error("no server listening at '%s'", path);
+		return error("no server listening at '%s'", cl_args.path);
 
 	case IPC_STATE__PATH_NOT_FOUND:
-		return error("path not found '%s'", path);
+		return error("path not found '%s'", cl_args.path);
 
 	case IPC_STATE__INVALID_PATH:
-		return error("invalid pipe/socket name '%s'", path);
+		return error("invalid pipe/socket name '%s'", cl_args.path);
 
 	case IPC_STATE__OTHER_ERROR:
 	default:
-		return error("other error for '%s'", path);
+		return error("other error for '%s'", cl_args.path);
 	}
 }
 
@@ -486,9 +473,9 @@ static int client__probe_server(const char *path)
  * argv[2] contains a simple (1 word) command that `test_app_cb()` (in
  * the daemon process) will understand.
  */
-static int client__send_ipc(int argc, const char **argv, const char *path)
+static int client__send_ipc(const char *send_token)
 {
-	const char *command = argc > 2 ? argv[2] : "(no command)";
+	const char *command = send_token ? send_token : "(no-command)";
 	struct strbuf buf = STRBUF_INIT;
 	struct ipc_client_connect_options options
 		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
@@ -496,7 +483,7 @@ static int client__send_ipc(int argc, const char **argv, const char *path)
 	options.wait_if_busy = 1;
 	options.wait_if_not_found = 0;
 
-	if (!ipc_client_send_command(path, &options, command, &buf)) {
+	if (!ipc_client_send_command(cl_args.path, &options, command, &buf)) {
 		if (buf.len) {
 			printf("%s\n", buf.buf);
 			fflush(stdout);
@@ -506,7 +493,7 @@ static int client__send_ipc(int argc, const char **argv, const char *path)
 		return 0;
 	}
 
-	return error("failed to send '%s' to '%s'", command, path);
+	return error("failed to send '%s' to '%s'", command, cl_args.path);
 }
 
 /*
@@ -515,41 +502,23 @@ static int client__send_ipc(int argc, const char **argv, const char *path)
  * event in the server, so we spin and wait here for it to actually
  * shutdown to make the unit tests a little easier to write.
  */
-static int client__stop_server(int argc, const char **argv, const char *path)
+static int client__stop_server(void)
 {
-	const char *send_quit[] = { argv[0], "send", "quit", NULL };
-	int max_wait_sec = 60;
 	int ret;
 	time_t time_limit, now;
 	enum ipc_active_state s;
 
-	const char * const stop_usage[] = {
-		N_("test-helper simple-ipc stop-daemon [<options>]"),
-		NULL
-	};
-
-	struct option stop_options[] = {
-		OPT_INTEGER(0, "max-wait", &max_wait_sec,
-			    N_("seconds to wait for daemon to stop")),
-		OPT_END()
-	};
-
-	argc = parse_options(argc, argv, NULL, stop_options, stop_usage, 0);
-
-	if (max_wait_sec < 0)
-		max_wait_sec = 0;
-
 	time(&time_limit);
-	time_limit += max_wait_sec;
+	time_limit += cl_args.max_wait_sec;
 
-	ret = client__send_ipc(3, send_quit, path);
+	ret = client__send_ipc("quit");
 	if (ret)
 		return ret;
 
 	for (;;) {
 		sleep_millisec(100);
 
-		s = ipc_get_active_state(path);
+		s = ipc_get_active_state(cl_args.path);
 
 		if (s != IPC_STATE__LISTENING) {
 			/*
@@ -597,19 +566,8 @@ static int do_sendbytes(int bytecount, char byte, const char *path,
 /*
  * Send an IPC command with ballast to an already-running server daemon.
  */
-static int client__sendbytes(int argc, const char **argv, const char *path)
+static int client__sendbytes(void)
 {
-	int bytecount = 1024;
-	char *string = "x";
-	const char * const sendbytes_usage[] = {
-		N_("test-helper simple-ipc sendbytes [<options>]"),
-		NULL
-	};
-	struct option sendbytes_options[] = {
-		OPT_INTEGER(0, "bytecount", &bytecount, N_("number of bytes")),
-		OPT_STRING(0, "byte", &string, N_("byte"), N_("ballast")),
-		OPT_END()
-	};
 	struct ipc_client_connect_options options
 		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
 
@@ -617,9 +575,8 @@ static int client__sendbytes(int argc, const char **argv, const char *path)
 	options.wait_if_not_found = 0;
 	options.uds_disallow_chdir = 0;
 
-	argc = parse_options(argc, argv, NULL, sendbytes_options, sendbytes_usage, 0);
-
-	return do_sendbytes(bytecount, string[0], path, &options);
+	return do_sendbytes(cl_args.bytecount, cl_args.bytevalue, cl_args.path,
+			    &options);
 }
 
 struct multiple_thread_data {
@@ -666,43 +623,20 @@ static void *multiple_thread_proc(void *_multiple_thread_data)
  * Start a client-side thread pool.  Each thread sends a series of
  * IPC requests.  Each request is on a new connection to the server.
  */
-static int client__multiple(int argc, const char **argv, const char *path)
+static int client__multiple(void)
 {
 	struct multiple_thread_data *list = NULL;
 	int k;
-	int nr_threads = 5;
-	int bytecount = 1;
-	int batchsize = 10;
 	int sum_join_errors = 0;
 	int sum_thread_errors = 0;
 	int sum_good = 0;
 
-	const char * const multiple_usage[] = {
-		N_("test-helper simple-ipc multiple [<options>]"),
-		NULL
-	};
-	struct option multiple_options[] = {
-		OPT_INTEGER(0, "bytecount", &bytecount, N_("number of bytes")),
-		OPT_INTEGER(0, "threads", &nr_threads, N_("number of threads")),
-		OPT_INTEGER(0, "batchsize", &batchsize, N_("number of requests per thread")),
-		OPT_END()
-	};
-
-	argc = parse_options(argc, argv, NULL, multiple_options, multiple_usage, 0);
-
-	if (bytecount < 1)
-		bytecount = 1;
-	if (nr_threads < 1)
-		nr_threads = 1;
-	if (batchsize < 1)
-		batchsize = 1;
-
-	for (k = 0; k < nr_threads; k++) {
+	for (k = 0; k < cl_args.nr_threads; k++) {
 		struct multiple_thread_data *d = xcalloc(1, sizeof(*d));
 		d->next = list;
-		d->path = path;
-		d->bytecount = bytecount + batchsize*(k/26);
-		d->batchsize = batchsize;
+		d->path = cl_args.path;
+		d->bytecount = cl_args.bytecount + cl_args.batchsize*(k/26);
+		d->batchsize = cl_args.batchsize;
 		d->sum_errors = 0;
 		d->sum_good = 0;
 		d->letter = 'A' + (k % 26);
@@ -737,45 +671,110 @@ static int client__multiple(int argc, const char **argv, const char *path)
 
 int cmd__simple_ipc(int argc, const char **argv)
 {
-	const char *path = "ipc-test";
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
+
+		OPT_END()
+	};
+
+	if (argc < 2)
+		usage_with_options(simple_ipc_usage, options);
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(simple_ipc_usage, options);
 
 	if (argc == 2 && !strcmp(argv[1], "SUPPORTS_SIMPLE_IPC"))
 		return 0;
 
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
 	/*
 	 * Use '!!' on all dispatch functions to map from `error()` style
 	 * (returns -1) style to `test_must_fail` style (expects 1).  This
 	 * makes shell error messages less confusing.
 	 */
 
-	if (argc == 2 && !strcmp(argv[1], "is-active"))
-		return !!client__probe_server(path);
+	if (!strcmp(cl_args.subcommand, "is-active"))
+		return !!client__probe_server();
 
-	if (argc >= 2 && !strcmp(argv[1], "run-daemon"))
-		return !!daemon__run_server(path, argc, argv);
+	if (!strcmp(cl_args.subcommand, "run-daemon"))
+		return !!daemon__run_server();
 
-	if (argc >= 2 && !strcmp(argv[1], "start-daemon"))
-		return !!daemon__start_server(path, argc, argv);
+	if (!strcmp(cl_args.subcommand, "start-daemon"))
+		return !!daemon__start_server();
 
 	/*
 	 * Client commands follow.  Ensure a server is running before
-	 * going any further.
+	 * sending any data.  This might be overkill, but then again
+	 * this is a test harness.
 	 */
-	if (client__probe_server(path))
-		return 1;
 
-	if (argc >= 2 && !strcmp(argv[1], "stop-daemon"))
-		return !!client__stop_server(argc, argv, path);
+	if (!strcmp(cl_args.subcommand, "stop-daemon")) {
+		if (client__probe_server())
+			return 1;
+		return !!client__stop_server();
+	}
 
-	if ((argc == 2 || argc == 3) && !strcmp(argv[1], "send"))
-		return !!client__send_ipc(argc, argv, path);
+	if (!strcmp(cl_args.subcommand, "send")) {
+		const char *send_token = argv[0];
+		if (client__probe_server())
+			return 1;
+		return !!client__send_ipc(send_token);
+	}
 
-	if (argc >= 2 && !strcmp(argv[1], "sendbytes"))
-		return !!client__sendbytes(argc, argv, path);
+	if (!strcmp(cl_args.subcommand, "sendbytes")) {
+		if (client__probe_server())
+			return 1;
+		return !!client__sendbytes();
+	}
 
-	if (argc >= 2 && !strcmp(argv[1], "multiple"))
-		return !!client__multiple(argc, argv, path);
+	if (!strcmp(cl_args.subcommand, "multiple")) {
+		if (client__probe_server())
+			return 1;
+		return !!client__multiple();
+	}
 
-	die("Unhandled argv[1]: '%s'", argv[1]);
+	die("Unhandled subcommand: '%s'", cl_args.subcommand);
 }
 #endif
-- 
gitgitgadget

