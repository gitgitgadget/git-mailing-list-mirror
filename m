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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC39C4332E
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2D064F69
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhCDUSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbhCDUSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:13 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44CC061763
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u125so10886101wmg.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=joSGEeQd7qaSUS7crnkQp9P4atiYF76wQjOoiVFTEic=;
        b=WfW2L6D4f+qAU+Y1MQ56187ngyNxYlUdisAnw1aQE5r0p1jzdhe+1OxxL++q874vKQ
         wBw0hJpmj8Q46iU6ZyD+cU5wh7n9UnOZ/ECkBZdS5khTcBOdwBYhS3qFuwFUSMTi75Zq
         Bt9Teu5vUHUwcSqWQrVvWJ9R4iknq7SbUYnt7krnK9dvO3eflDHhlORhpbrAC1twjgJE
         wM9O3sE22Y9/7M7o/4LerUjj0eNl3IvCJmqOLHNA93qyifYHvl6RIeRBDwKqR+6DbRYm
         XL4M2nQX3fjHjKwTjYHdioUTg5Zw+XBJjsmBp7DjstyZ+AEWB0EmPBvSEhwAYS51mmvE
         TSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=joSGEeQd7qaSUS7crnkQp9P4atiYF76wQjOoiVFTEic=;
        b=jdCRXX83DPR25yQDaYG8jdeiswdSG2awL6gD5ZJlmGYTz7khmYtfmhb6D/EoL/nRAi
         jSGh6px0yNzrAfw/DBQ6jXD3frjBkh6J7cItfXH/3I1GWZy/vn8PHTM6jb9IKrF55Mys
         39F+qTlvMuidzn9y+eUZIOHMDi0cTrLm7REwYA5rzNwYPqHrBqJFJBBPlpPdKKI97Pyi
         CX7PKwC4f6JOjALXtmRdeK0WwohoB+C+gecSxSmaPseKKEvE+oREmlVLBb/7A5TXvMub
         ajj4/LVSw1c9pjmLdSUDAzHymagiIa9h0mFjkIJeDOyAgQblhyk/cNH3O3KRCXe8FG7D
         SpRA==
X-Gm-Message-State: AOAM531+vtSILm9PkcrzP2ru0se3T8FShyOT0n/KLeyCh+FkzANAP4zC
        UQ3cFOHn9rbPCmAnVLkq/TkPwAaANxQ=
X-Google-Smtp-Source: ABdhPJxqb2NmQhlB9N3dbC/G8YiIM5BPEsZr6KNozqtZziv8wDWyx+M6Eh1Zkp4nednLWc+8Id7GXw==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr5651238wmj.48.1614889051320;
        Thu, 04 Mar 2021 12:17:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22sm771778wmb.31.2021.03.04.12.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:30 -0800 (PST)
Message-Id: <7be460771da6d0f4de91780d5bb4d20b3b856f6b.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:23 +0000
Subject: [PATCH 4/8] simple-ipc: move error handling up a level
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

Move error reporting for socket/named pipe creation out of platform
specific and simple-ipc layer code and rely on returned error value
and `errno`.

Update t/helper/test-simple-ipc.c to print errors.

Simplify testing for another server in `is_another_server_is_alive()`.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/simple-ipc/ipc-unix-socket.c | 48 ++++++++++++----------
 compat/simple-ipc/ipc-win32.c       | 14 ++++---
 simple-ipc.h                        |  4 ++
 t/helper/test-simple-ipc.c          | 10 ++++-
 unix-stream-server.c                | 63 +++++++++++++++--------------
 unix-stream-server.h                |  7 +++-
 6 files changed, 86 insertions(+), 60 deletions(-)

diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index b0264ca6cdc6..55cbb346328a 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -729,44 +729,51 @@ static void *accept_thread_proc(void *_accept_thread_data)
  */
 #define LISTEN_BACKLOG (50)
 
-static struct unix_stream_server_socket *create_listener_socket(
+static int create_listener_socket(
 	const char *path,
-	const struct ipc_server_opts *ipc_opts)
+	const struct ipc_server_opts *ipc_opts,
+	struct unix_stream_server_socket **new_server_socket)
 {
 	struct unix_stream_server_socket *server_socket = NULL;
 	struct unix_stream_listen_opts uslg_opts = UNIX_STREAM_LISTEN_OPTS_INIT;
+	int ret;
 
 	uslg_opts.listen_backlog_size = LISTEN_BACKLOG;
 	uslg_opts.disallow_chdir = ipc_opts->uds_disallow_chdir;
 
-	server_socket = unix_stream_server__listen_with_lock(path, &uslg_opts);
-	if (!server_socket)
-		return NULL;
+	ret = unix_stream_server__create(path, &uslg_opts, &server_socket);
+	if (ret)
+		return ret;
 
 	if (set_socket_blocking_flag(server_socket->fd_socket, 1)) {
 		int saved_errno = errno;
-		error_errno(_("could not set listener socket nonblocking '%s'"),
-			    path);
 		unix_stream_server__free(server_socket);
 		errno = saved_errno;
-		return NULL;
+		return -1;
 	}
 
+	*new_server_socket = server_socket;
+
 	trace2_data_string("ipc-server", NULL, "listen-with-lock", path);
-	return server_socket;
+	return 0;
 }
 
-static struct unix_stream_server_socket *setup_listener_socket(
+static int setup_listener_socket(
 	const char *path,
-	const struct ipc_server_opts *ipc_opts)
+	const struct ipc_server_opts *ipc_opts,
+	struct unix_stream_server_socket **new_server_socket)
 {
-	struct unix_stream_server_socket *server_socket;
+	int ret, saved_errno;
 
 	trace2_region_enter("ipc-server", "create-listener_socket", NULL);
-	server_socket = create_listener_socket(path, ipc_opts);
+
+	ret = create_listener_socket(path, ipc_opts, new_server_socket);
+
+	saved_errno = errno;
 	trace2_region_leave("ipc-server", "create-listener_socket", NULL);
+	errno = saved_errno;
 
-	return server_socket;
+	return ret;
 }
 
 /*
@@ -781,6 +788,7 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	struct ipc_server_data *server_data;
 	int sv[2];
 	int k;
+	int ret;
 	int nr_threads = opts->nr_threads;
 
 	*returned_server_data = NULL;
@@ -792,25 +800,23 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	 * connection or a shutdown request without spinning.
 	 */
 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
-		return error_errno(_("could not create socketpair for '%s'"),
-				   path);
+		return -1;
 
 	if (set_socket_blocking_flag(sv[1], 1)) {
 		int saved_errno = errno;
 		close(sv[0]);
 		close(sv[1]);
 		errno = saved_errno;
-		return error_errno(_("making socketpair nonblocking '%s'"),
-				   path);
+		return -1;
 	}
 
-	server_socket = setup_listener_socket(path, opts);
-	if (!server_socket) {
+	ret = setup_listener_socket(path, opts, &server_socket);
+	if (ret) {
 		int saved_errno = errno;
 		close(sv[0]);
 		close(sv[1]);
 		errno = saved_errno;
-		return -1;
+		return ret;
 	}
 
 	server_data = xcalloc(1, sizeof(*server_data));
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index f0cfbf9d15c3..5fd5960a1328 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -614,14 +614,16 @@ int ipc_server_run_async(struct ipc_server_data **returned_server_data,
 	*returned_server_data = NULL;
 
 	ret = initialize_pipe_name(path, wpath, ARRAY_SIZE(wpath));
-	if (ret < 0)
-		return error(
-			_("could not create normalized wchar_t path for '%s'"),
-			path);
+	if (ret < 0) {
+		errno = EINVAL;
+		return -1;
+	}
 
 	hPipeFirst = create_new_pipe(wpath, 1);
-	if (hPipeFirst == INVALID_HANDLE_VALUE)
-		return error(_("IPC server already running on '%s'"), path);
+	if (hPipeFirst == INVALID_HANDLE_VALUE) {
+		errno = EADDRINUSE;
+		return -2;
+	}
 
 	server_data = xcalloc(1, sizeof(*server_data));
 	server_data->magic = MAGIC_SERVER_DATA;
diff --git a/simple-ipc.h b/simple-ipc.h
index f7e72e966f9a..dc3606e30bd6 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -178,6 +178,8 @@ struct ipc_server_opts
  *
  * Returns 0 if the asynchronous server pool was started successfully.
  * Returns -1 if not.
+ * Returns -2 if we could not startup because another server is using
+ * the socket or named pipe.
  *
  * When a client IPC message is received, the `application_cb` will be
  * called (possibly on a random thread) to handle the message and
@@ -217,6 +219,8 @@ void ipc_server_free(struct ipc_server_data *server_data);
  *
  * Returns 0 after the server has completed successfully.
  * Returns -1 if the server cannot be started.
+ * Returns -2 if we could not startup because another server is using
+ * the socket or named pipe.
  *
  * When a client IPC message is received, the `application_cb` will be
  * called (possibly on a random thread) to handle the message and
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index d67eaa9a6ecc..d0e6127528a7 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -219,6 +219,8 @@ static int test_app_cb(void *application_data,
  */
 static int daemon__run_server(const char *path, int argc, const char **argv)
 {
+	int ret;
+
 	struct ipc_server_opts opts = {
 		.nr_threads = 5
 	};
@@ -243,7 +245,13 @@ static int daemon__run_server(const char *path, int argc, const char **argv)
 	 * instance data, so pass an arbitrary pointer (that we'll later
 	 * verify made the round trip).
 	 */
-	return ipc_server_run(path, &opts, test_app_cb, (void*)&my_app_data);
+	ret = ipc_server_run(path, &opts, test_app_cb, (void*)&my_app_data);
+	if (ret == -2)
+		error(_("socket/pipe already in use: '%s'"), path);
+	else if (ret == -1)
+		error_errno(_("could not start server on: '%s'"), path);
+
+	return ret;
 }
 
 #ifndef GIT_WINDOWS_NATIVE
diff --git a/unix-stream-server.c b/unix-stream-server.c
index ad175ba731ca..f00298ca7ec3 100644
--- a/unix-stream-server.c
+++ b/unix-stream-server.c
@@ -5,41 +5,44 @@
 
 #define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
 
+/*
+ * Try to connect to a unix domain socket at `path` (if it exists) and
+ * see if there is a server listening.
+ *
+ * We don't know if the socket exists, whether a server died and
+ * failed to cleanup, or whether we have a live server listening, so
+ * we "poke" it.
+ *
+ * We immediately hangup without sending/receiving any data because we
+ * don't know anything about the protocol spoken and don't want to
+ * block while writing/reading data.  It is sufficient to just know
+ * that someone is listening.
+ */
 static int is_another_server_alive(const char *path,
 				   const struct unix_stream_listen_opts *opts)
 {
-	struct stat st;
-	int fd;
-
-	if (!lstat(path, &st) && S_ISSOCK(st.st_mode)) {
-		/*
-		 * A socket-inode exists on disk at `path`, but we
-		 * don't know whether it belongs to an active server
-		 * or whether the last server died without cleaning
-		 * up.
-		 *
-		 * Poke it with a trivial connection to try to find
-		 * out.
-		 */
-		fd = unix_stream_connect(path, opts->disallow_chdir);
-		if (fd >= 0) {
-			close(fd);
-			return 1;
-		}
+	int fd = unix_stream_connect(path, opts->disallow_chdir);
+
+	if (fd >= 0) {
+		close(fd);
+		return 1;
 	}
 
 	return 0;
 }
 
-struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
+int unix_stream_server__create(
 	const char *path,
-	const struct unix_stream_listen_opts *opts)
+	const struct unix_stream_listen_opts *opts,
+	struct unix_stream_server_socket **new_server_socket)
 {
 	struct lock_file lock = LOCK_INIT;
 	long timeout;
 	int fd_socket;
 	struct unix_stream_server_socket *server_socket;
 
+	*new_server_socket = NULL;
+
 	timeout = opts->timeout_ms;
 	if (opts->timeout_ms <= 0)
 		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;
@@ -47,20 +50,17 @@ struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
 	/*
 	 * Create a lock at "<path>.lock" if we can.
 	 */
-	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout) < 0) {
-		error_errno(_("could not lock listener socket '%s'"), path);
-		return NULL;
-	}
+	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout) < 0)
+		return -1;
 
 	/*
 	 * If another server is listening on "<path>" give up.  We do not
 	 * want to create a socket and steal future connections from them.
 	 */
 	if (is_another_server_alive(path, opts)) {
-		errno = EADDRINUSE;
-		error_errno(_("listener socket already in use '%s'"), path);
 		rollback_lock_file(&lock);
-		return NULL;
+		errno = EADDRINUSE;
+		return -2;
 	}
 
 	/*
@@ -68,9 +68,10 @@ struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
 	 */
 	fd_socket = unix_stream_listen(path, opts);
 	if (fd_socket < 0) {
-		error_errno(_("could not create listener socket '%s'"), path);
+		int saved_errno = errno;
 		rollback_lock_file(&lock);
-		return NULL;
+		errno = saved_errno;
+		return -1;
 	}
 
 	server_socket = xcalloc(1, sizeof(*server_socket));
@@ -78,6 +79,8 @@ struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
 	server_socket->fd_socket = fd_socket;
 	lstat(path, &server_socket->st_socket);
 
+	*new_server_socket = server_socket;
+
 	/*
 	 * Always rollback (just delete) "<path>.lock" because we already created
 	 * "<path>" as a socket and do not want to commit_lock to do the atomic
@@ -85,7 +88,7 @@ struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
 	 */
 	rollback_lock_file(&lock);
 
-	return server_socket;
+	return 0;
 }
 
 void unix_stream_server__free(
diff --git a/unix-stream-server.h b/unix-stream-server.h
index 745849e31c30..f7e76dec59ac 100644
--- a/unix-stream-server.h
+++ b/unix-stream-server.h
@@ -12,10 +12,13 @@ struct unix_stream_server_socket {
 /*
  * Create a Unix Domain Socket at the given path under the protection
  * of a '.lock' lockfile.
+ *
+ * Returns 0 on success, -1 on error, -2 if socket is in use.
  */
-struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
+int unix_stream_server__create(
 	const char *path,
-	const struct unix_stream_listen_opts *opts);
+	const struct unix_stream_listen_opts *opts,
+	struct unix_stream_server_socket **server_socket);
 
 /*
  * Close and delete the socket.
-- 
gitgitgadget

