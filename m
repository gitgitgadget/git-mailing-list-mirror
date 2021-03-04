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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17CDC43332
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06E664F72
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbhCDUSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbhCDUSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B98C061762
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b18so22591880wrn.6
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n4uZto3Ixdp3JWQ2PwLctPd2qu7NdiwXcI9lyP9p3T4=;
        b=n705GU/aOCjXJyjPh7c84rqfJfoC+dDN9hZQb39BLiT+NmhZpHxbeFEy7zuvXkKmqe
         uwxIFCmGs8jhK8CsLHYN9xajDMNxlxfg/0ec2dndTF40GBDfBi4nP9mSQD3pVByy9wma
         ulpWWDoQH52tV9DNOFOjiAXdhluQkblTEFscRV/natzb69zYgM9ZJ+LxNlHVmKWnGYsu
         UQOpUVRbC9brVTK+Hlw/ZtKEHUWrb9w9D7nHko1OjmlJ0TsJGRd49+hPfQKJMI2wh2mH
         3p9rIRYYKGO1UTsXvG67PgKpABC3IL1IV4YL860a2BmIeb+msXByNoLpNN3015xxKSPl
         t+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n4uZto3Ixdp3JWQ2PwLctPd2qu7NdiwXcI9lyP9p3T4=;
        b=C42On7OCjhFo9Ak/GYysv88IQigj5q7d3QdrFlkx8X93l1VVHxgGyffxDBRqXrZw/K
         N65tkJBhXPk+DwCYxyY/61xQhu+fJxtr7HYy0ZX/27FYuA8ky7/VLbexwBzHC3SmhFnZ
         tybsX027M1m7e7VsA1RxsIwJ1qNhBAc1YmqHOf7UIc42u1zFFmMWJzJqtVCwHikMuNra
         PFsf84MN1QE1timOirkSWcxGfJljj8moixP41huuSfKx4zjE9VaI9dZrW7/E6vbeXPC8
         wXHXW0JZmdxJE906udV6xMbfEmCbaIFAFUH6ZZiO3T3+aOa1JJf7CNUiraM8G31aT5NT
         n5YQ==
X-Gm-Message-State: AOAM533WGLajlXUY5VJ9OpSRBveGw5eCIygIbxRonLY8ooeHUriUZH4D
        Nwl4bTliEdZkP6jl3V3bYHsXoPGwg3g=
X-Google-Smtp-Source: ABdhPJxSCHO/DZM4ln/VAXbBrrKgPBLj26WHz0zJXZfk+ic2trcTErAJNUlNS5ICEUzDryx16vaWKw==
X-Received: by 2002:adf:c389:: with SMTP id p9mr5737687wrf.410.1614889050646;
        Thu, 04 Mar 2021 12:17:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5sm560247wrs.35.2021.03.04.12.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:30 -0800 (PST)
Message-Id: <4ae4429a70e408a1ab52a59370a4e6d10ca9a0fd.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:22 +0000
Subject: [PATCH 3/8] unix-stream-server: create unix-stream-server.c
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

Move unix_stream_server__listen_with_lock() and associated routines
and data types out of unix-socket.[ch] and into their own source file.

We added code to safely create a Unix domain socket using a lockfile in:
9406d12e14 (unix-socket: create `unix_stream_server__listen_with_lock()`,
2021-02-13).  This code conceptually exists at a higher-level than the
core unix_stream_connect() and unix_stream_listen() routines that it
consumes and should be isolated for clarity.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                            |   1 +
 compat/simple-ipc/ipc-unix-socket.c |   1 +
 contrib/buildsystems/CMakeLists.txt |   2 +-
 unix-socket.c                       | 120 ---------------------------
 unix-socket.h                       |  26 ------
 unix-stream-server.c                | 124 ++++++++++++++++++++++++++++
 unix-stream-server.h                |  32 +++++++
 7 files changed, 159 insertions(+), 147 deletions(-)
 create mode 100644 unix-stream-server.c
 create mode 100644 unix-stream-server.h

diff --git a/Makefile b/Makefile
index 93f2e7ca9e1f..dfc37b0480e4 100644
--- a/Makefile
+++ b/Makefile
@@ -1678,6 +1678,7 @@ ifdef NO_UNIX_SOCKETS
 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
 else
 	LIB_OBJS += unix-socket.o
+	LIB_OBJS += unix-stream-server.o
 	LIB_OBJS += compat/simple-ipc/ipc-shared.o
 	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
 endif
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index b7fd0b34329e..b0264ca6cdc6 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -4,6 +4,7 @@
 #include "pkt-line.h"
 #include "thread-utils.h"
 #include "unix-socket.h"
+#include "unix-stream-server.h"
 
 #ifdef NO_UNIX_SOCKETS
 #error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4c27a373414a..629a1817459b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -243,7 +243,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
-	list(APPEND compat_SOURCES unix-socket.c)
+	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
 endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
diff --git a/unix-socket.c b/unix-socket.c
index c9ea1de43bd2..e0be1badb58d 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -1,8 +1,6 @@
 #include "cache.h"
-#include "lockfile.h"
 #include "unix-socket.h"
 
-#define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
 #define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
 
 static int chdir_len(const char *orig, int len)
@@ -136,121 +134,3 @@ int unix_stream_listen(const char *path,
 	errno = saved_errno;
 	return -1;
 }
-
-static int is_another_server_alive(const char *path,
-				   const struct unix_stream_listen_opts *opts)
-{
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
-	}
-
-	return 0;
-}
-
-struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
-	const char *path,
-	const struct unix_stream_listen_opts *opts)
-{
-	struct lock_file lock = LOCK_INIT;
-	long timeout;
-	int fd_socket;
-	struct unix_stream_server_socket *server_socket;
-
-	timeout = opts->timeout_ms;
-	if (opts->timeout_ms <= 0)
-		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;
-
-	/*
-	 * Create a lock at "<path>.lock" if we can.
-	 */
-	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout) < 0) {
-		error_errno(_("could not lock listener socket '%s'"), path);
-		return NULL;
-	}
-
-	/*
-	 * If another server is listening on "<path>" give up.  We do not
-	 * want to create a socket and steal future connections from them.
-	 */
-	if (is_another_server_alive(path, opts)) {
-		errno = EADDRINUSE;
-		error_errno(_("listener socket already in use '%s'"), path);
-		rollback_lock_file(&lock);
-		return NULL;
-	}
-
-	/*
-	 * Create and bind to a Unix domain socket at "<path>".
-	 */
-	fd_socket = unix_stream_listen(path, opts);
-	if (fd_socket < 0) {
-		error_errno(_("could not create listener socket '%s'"), path);
-		rollback_lock_file(&lock);
-		return NULL;
-	}
-
-	server_socket = xcalloc(1, sizeof(*server_socket));
-	server_socket->path_socket = strdup(path);
-	server_socket->fd_socket = fd_socket;
-	lstat(path, &server_socket->st_socket);
-
-	/*
-	 * Always rollback (just delete) "<path>.lock" because we already created
-	 * "<path>" as a socket and do not want to commit_lock to do the atomic
-	 * rename trick.
-	 */
-	rollback_lock_file(&lock);
-
-	return server_socket;
-}
-
-void unix_stream_server__free(
-	struct unix_stream_server_socket *server_socket)
-{
-	if (!server_socket)
-		return;
-
-	if (server_socket->fd_socket >= 0) {
-		if (!unix_stream_server__was_stolen(server_socket))
-			unlink(server_socket->path_socket);
-		close(server_socket->fd_socket);
-	}
-
-	free(server_socket->path_socket);
-	free(server_socket);
-}
-
-int unix_stream_server__was_stolen(
-	struct unix_stream_server_socket *server_socket)
-{
-	struct stat st_now;
-
-	if (!server_socket)
-		return 0;
-
-	if (lstat(server_socket->path_socket, &st_now) == -1)
-		return 1;
-
-	if (st_now.st_ino != server_socket->st_socket.st_ino)
-		return 1;
-
-	/* We might also consider the ctime on some platforms. */
-
-	return 0;
-}
diff --git a/unix-socket.h b/unix-socket.h
index bec925ee0213..b079e79cb3e1 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -18,30 +18,4 @@ int unix_stream_connect(const char *path, int disallow_chdir);
 int unix_stream_listen(const char *path,
 		       const struct unix_stream_listen_opts *opts);
 
-struct unix_stream_server_socket {
-	char *path_socket;
-	struct stat st_socket;
-	int fd_socket;
-};
-
-/*
- * Create a Unix Domain Socket at the given path under the protection
- * of a '.lock' lockfile.
- */
-struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
-	const char *path,
-	const struct unix_stream_listen_opts *opts);
-
-/*
- * Close and delete the socket.
- */
-void unix_stream_server__free(
-	struct unix_stream_server_socket *server_socket);
-
-/*
- * Return 1 if the inode of the pathname to our socket changes.
- */
-int unix_stream_server__was_stolen(
-	struct unix_stream_server_socket *server_socket);
-
 #endif /* UNIX_SOCKET_H */
diff --git a/unix-stream-server.c b/unix-stream-server.c
new file mode 100644
index 000000000000..ad175ba731ca
--- /dev/null
+++ b/unix-stream-server.c
@@ -0,0 +1,124 @@
+#include "cache.h"
+#include "lockfile.h"
+#include "unix-socket.h"
+#include "unix-stream-server.h"
+
+#define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
+
+static int is_another_server_alive(const char *path,
+				   const struct unix_stream_listen_opts *opts)
+{
+	struct stat st;
+	int fd;
+
+	if (!lstat(path, &st) && S_ISSOCK(st.st_mode)) {
+		/*
+		 * A socket-inode exists on disk at `path`, but we
+		 * don't know whether it belongs to an active server
+		 * or whether the last server died without cleaning
+		 * up.
+		 *
+		 * Poke it with a trivial connection to try to find
+		 * out.
+		 */
+		fd = unix_stream_connect(path, opts->disallow_chdir);
+		if (fd >= 0) {
+			close(fd);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
+	const char *path,
+	const struct unix_stream_listen_opts *opts)
+{
+	struct lock_file lock = LOCK_INIT;
+	long timeout;
+	int fd_socket;
+	struct unix_stream_server_socket *server_socket;
+
+	timeout = opts->timeout_ms;
+	if (opts->timeout_ms <= 0)
+		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;
+
+	/*
+	 * Create a lock at "<path>.lock" if we can.
+	 */
+	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout) < 0) {
+		error_errno(_("could not lock listener socket '%s'"), path);
+		return NULL;
+	}
+
+	/*
+	 * If another server is listening on "<path>" give up.  We do not
+	 * want to create a socket and steal future connections from them.
+	 */
+	if (is_another_server_alive(path, opts)) {
+		errno = EADDRINUSE;
+		error_errno(_("listener socket already in use '%s'"), path);
+		rollback_lock_file(&lock);
+		return NULL;
+	}
+
+	/*
+	 * Create and bind to a Unix domain socket at "<path>".
+	 */
+	fd_socket = unix_stream_listen(path, opts);
+	if (fd_socket < 0) {
+		error_errno(_("could not create listener socket '%s'"), path);
+		rollback_lock_file(&lock);
+		return NULL;
+	}
+
+	server_socket = xcalloc(1, sizeof(*server_socket));
+	server_socket->path_socket = strdup(path);
+	server_socket->fd_socket = fd_socket;
+	lstat(path, &server_socket->st_socket);
+
+	/*
+	 * Always rollback (just delete) "<path>.lock" because we already created
+	 * "<path>" as a socket and do not want to commit_lock to do the atomic
+	 * rename trick.
+	 */
+	rollback_lock_file(&lock);
+
+	return server_socket;
+}
+
+void unix_stream_server__free(
+	struct unix_stream_server_socket *server_socket)
+{
+	if (!server_socket)
+		return;
+
+	if (server_socket->fd_socket >= 0) {
+		if (!unix_stream_server__was_stolen(server_socket))
+			unlink(server_socket->path_socket);
+		close(server_socket->fd_socket);
+	}
+
+	free(server_socket->path_socket);
+	free(server_socket);
+}
+
+int unix_stream_server__was_stolen(
+	struct unix_stream_server_socket *server_socket)
+{
+	struct stat st_now;
+
+	if (!server_socket)
+		return 0;
+
+	if (lstat(server_socket->path_socket, &st_now) == -1)
+		return 1;
+
+	if (st_now.st_ino != server_socket->st_socket.st_ino)
+		return 1;
+
+	/* We might also consider the ctime on some platforms. */
+
+	return 0;
+}
diff --git a/unix-stream-server.h b/unix-stream-server.h
new file mode 100644
index 000000000000..745849e31c30
--- /dev/null
+++ b/unix-stream-server.h
@@ -0,0 +1,32 @@
+#ifndef UNIX_STREAM_SERVER_H
+#define UNIX_STREAM_SERVER_H
+
+#include "unix-socket.h"
+
+struct unix_stream_server_socket {
+	char *path_socket;
+	struct stat st_socket;
+	int fd_socket;
+};
+
+/*
+ * Create a Unix Domain Socket at the given path under the protection
+ * of a '.lock' lockfile.
+ */
+struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
+	const char *path,
+	const struct unix_stream_listen_opts *opts);
+
+/*
+ * Close and delete the socket.
+ */
+void unix_stream_server__free(
+	struct unix_stream_server_socket *server_socket);
+
+/*
+ * Return 1 if the inode of the pathname to our socket changes.
+ */
+int unix_stream_server__was_stolen(
+	struct unix_stream_server_socket *server_socket);
+
+#endif /* UNIX_STREAM_SERVER_H */
-- 
gitgitgadget

