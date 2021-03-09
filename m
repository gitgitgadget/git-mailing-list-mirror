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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF370C4361A
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F12D650DF
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhCIPDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhCIPC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE65C061760
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso6552671wmi.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qlOZCMTPyNfnielN4OdxCaJ+bRduOPfd4dOIYkkvpAM=;
        b=epFU1jvjlK2GKI8LyfVTJXkgiWVsPivSpL5bygCJPxp/hUGVhWnsoIDFqrYiCIz+7v
         Yx3e+Q6UP/peKa31DlVxjUlVFjqEqxjBJMwZC1NuSRY8IkxlXDZfzkGpqFy10sKRJQmY
         ri0Ep7LosWKcGjZXMUw1DrC2Z0Z4SB+pj2/+bxYpE/5jOzh1I0bOus9nWLoQYUBwgU/R
         tZA0Oif+99bAklWhcjhp/I4TfcDwtN6mH4XdMhRs59ivTrzeZ0xe658E3X5Xrhn0OWiH
         eBawZmjFOlQTjcuCTi1DljFNqfIOg+hMlYMqLh8gTbuafjjCLBgfg9i+tjPAsKdVLXuM
         eazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qlOZCMTPyNfnielN4OdxCaJ+bRduOPfd4dOIYkkvpAM=;
        b=tpsoYVceo2e44isgFhFq59rRY1ivN14hYX9V257sAlbF+9MiCsgL4/rT+iIAXqlRIp
         np2t4VKXfYKg/KC2Vw5keFmBXhlnSE9Zh+feUWloTcGXi6qbmAdMFwaYfwsvhYyWRZnv
         KxSIqAKZroRatNgdyT4o4kM+gsRz25V7oCtJrh035aW+oC6FLzoVP5+f0RjiCJzaG3pz
         TKITsA0Xn81Er40kU5KXI0a5hQMlgFZ5DIip9Uqk2icp/z1N5kfI22AEhZWPsVFUha2Z
         JCRVw1/3cjwrpc1mvXErhKb99wcKW6gSKW3RaCyJ4/Hz0pndzCl5O9/wMqd4Ep9//R29
         Pliw==
X-Gm-Message-State: AOAM532q83sG8DB/6VkjfvAObWOkxZTgrdX/iAX84X933r5fk80bbdqR
        LLxMRn30Me7Dp2BcAoCaGHGQIysJ3hs=
X-Google-Smtp-Source: ABdhPJxKoP2OK6dr6aN/n47YTvUB2xiyu4gCl3VkXBZcEi7zF1GRihGo6BQ+9MAl8JNII9NrT3mXcQ==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr4533404wmk.135.1615302173146;
        Tue, 09 Mar 2021 07:02:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm24705081wrx.32.2021.03.09.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:52 -0800 (PST)
Message-Id: <1ee9de55a106e46dab6126fe8ca2a0aeace57b1a.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:35 +0000
Subject: [PATCH v5 10/12] unix-stream-server: create unix domain socket under
 lock
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

Create a wrapper class for `unix_stream_listen()` that uses a ".lock"
lockfile to create the unix domain socket in a race-free manner.

Unix domain sockets have a fundamental problem on Unix systems because
they persist in the filesystem until they are deleted.  This is
independent of whether a server is actually listening for connections.
Well-behaved servers are expected to delete the socket when they
shutdown.  A new server cannot easily tell if a found socket is
attached to an active server or is leftover cruft from a dead server.
The traditional solution used by `unix_stream_listen()` is to force
delete the socket pathname and then create a new socket.  This solves
the latter (cruft) problem, but in the case of the former, it orphans
the existing server (by stealing the pathname associated with the
socket it is listening on).

We cannot directly use a .lock lockfile to create the socket because
the socket is created by `bind(2)` rather than the `open(2)` mechanism
used by `tempfile.c`.

As an alternative, we hold a plain lockfile ("<path>.lock") as a
mutual exclusion device.  Under the lock, we test if an existing
socket ("<path>") is has an active server.  If not, we create a new
socket and begin listening.  Then we use "rollback" to delete the
lockfile in all cases.

This wrapper code conceptually exists at a higher-level than the core
unix_stream_connect() and unix_stream_listen() routines that it
consumes.  It is isolated in a wrapper class for clarity.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                            |   1 +
 contrib/buildsystems/CMakeLists.txt |   2 +-
 unix-stream-server.c                | 128 ++++++++++++++++++++++++++++
 unix-stream-server.h                |  36 ++++++++
 4 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 unix-stream-server.c
 create mode 100644 unix-stream-server.h

diff --git a/Makefile b/Makefile
index d3c42d3f4f9f..012694276f6d 100644
--- a/Makefile
+++ b/Makefile
@@ -1665,6 +1665,7 @@ ifdef NO_UNIX_SOCKETS
 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
 else
 	LIB_OBJS += unix-socket.o
+	LIB_OBJS += unix-stream-server.o
 endif
 
 ifdef USE_WIN32_IPC
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 40c9e8e3bd9d..c94011269ebb 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -243,7 +243,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
-	list(APPEND compat_SOURCES unix-socket.c)
+	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
 endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
diff --git a/unix-stream-server.c b/unix-stream-server.c
new file mode 100644
index 000000000000..5dfe2a9ac2c0
--- /dev/null
+++ b/unix-stream-server.c
@@ -0,0 +1,128 @@
+#include "cache.h"
+#include "lockfile.h"
+#include "unix-socket.h"
+#include "unix-stream-server.h"
+
+#define DEFAULT_LOCK_TIMEOUT (100)
+
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
+static int is_another_server_alive(const char *path,
+				   const struct unix_stream_listen_opts *opts)
+{
+	int fd = unix_stream_connect(path, opts->disallow_chdir);
+	if (fd >= 0) {
+		close(fd);
+		return 1;
+	}
+
+	return 0;
+}
+
+int unix_stream_server__create(
+	const char *path,
+	const struct unix_stream_listen_opts *opts,
+	long timeout_ms,
+	struct unix_stream_server_socket **new_server_socket)
+{
+	struct lock_file lock = LOCK_INIT;
+	int fd_socket;
+	struct unix_stream_server_socket *server_socket;
+
+	*new_server_socket = NULL;
+
+	if (timeout_ms < 0)
+		timeout_ms = DEFAULT_LOCK_TIMEOUT;
+
+	/*
+	 * Create a lock at "<path>.lock" if we can.
+	 */
+	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout_ms) < 0)
+		return -1;
+
+	/*
+	 * If another server is listening on "<path>" give up.  We do not
+	 * want to create a socket and steal future connections from them.
+	 */
+	if (is_another_server_alive(path, opts)) {
+		rollback_lock_file(&lock);
+		errno = EADDRINUSE;
+		return -2;
+	}
+
+	/*
+	 * Create and bind to a Unix domain socket at "<path>".
+	 */
+	fd_socket = unix_stream_listen(path, opts);
+	if (fd_socket < 0) {
+		int saved_errno = errno;
+		rollback_lock_file(&lock);
+		errno = saved_errno;
+		return -1;
+	}
+
+	server_socket = xcalloc(1, sizeof(*server_socket));
+	server_socket->path_socket = strdup(path);
+	server_socket->fd_socket = fd_socket;
+	lstat(path, &server_socket->st_socket);
+
+	*new_server_socket = server_socket;
+
+	/*
+	 * Always rollback (just delete) "<path>.lock" because we already created
+	 * "<path>" as a socket and do not want to commit_lock to do the atomic
+	 * rename trick.
+	 */
+	rollback_lock_file(&lock);
+
+	return 0;
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
+	if (st_now.st_dev != server_socket->st_socket.st_dev)
+		return 1;
+
+	if (!S_ISSOCK(st_now.st_mode))
+		return 1;
+
+	return 0;
+}
diff --git a/unix-stream-server.h b/unix-stream-server.h
new file mode 100644
index 000000000000..ef9241d0ef70
--- /dev/null
+++ b/unix-stream-server.h
@@ -0,0 +1,36 @@
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
+ *
+ * Returns 0 on success, -1 on error, -2 if socket is in use.
+ */
+int unix_stream_server__create(
+	const char *path,
+	const struct unix_stream_listen_opts *opts,
+	long timeout_ms,
+	struct unix_stream_server_socket **server_socket);
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

