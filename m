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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E894AC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE48A64DC3
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhBMAL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhBMAKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDEAC061797
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g10so1388650wrx.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BxZO76/AviWURZU430dd0Mk+fI3Wg10NNXpI5VTJui4=;
        b=OOmZq4+g6x2ZrKtuHwzGu7uYTFhCMhRDUS6OyobpnkUF+iAK5XSNiS4Tpr5bsawOwX
         XXjeL7J3UCGl+pLEnpn2HIDKajCVqPZZ3fF4pVG5Ux9stFiU7jQQ5aVd+2yPEE+/+uRF
         jllLqJPO7qL9gMq1sZzdSAhgflvUMermhdTZfsWz3sqgRS8F1H8FvL/z7zUXSN1hV8au
         18dVamSXVIt4ScyrNeDa5bjHQAq+BHIe/vg5fN3UcEQsrDz6ACLyme355aZl/ctDzVTR
         v9IRDoalBsWw1WwRkbjL4vUCzcqRpf7hVwSrIIURp8n4UK5Y1SNFsQBrlWPC5GZy09rM
         BTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BxZO76/AviWURZU430dd0Mk+fI3Wg10NNXpI5VTJui4=;
        b=bk/YDTq9TjVjw9jYsHYr3cqaPxTk6HEePPYlrrOlgiU2ms0YWZbgcXnJSwrOTwLltB
         Z2mvs9dImDocR8c472ZyNc9sgqEoIyEHeLafoxxi7sYOUvGrYNxW0lPRQZwMY/VoX9I0
         MmEDJZbcJahGqtIZ4TUAjyeAc97lrjYyr1VfBB1fXGKFQhn4MopRfx9rY6SO7nqA5GBf
         4djwCT2hbUOuB5zkdexC2AMC6PwXgPzTET1tRqufjYv/IDXecq/kXjUwZku97/SE5D+u
         HmcYtSI0uuPYsjKdKvEg5MeWHm7v2XT46AhQBEbYjqvloTPsXV1OyHz5Tq/1iG1l8vRb
         EOEA==
X-Gm-Message-State: AOAM533DOcITl8K3F8oqQo0RrSLuDk8tXwuxLh/mlVKedvslau6hSY1c
        A8iHOn7XovUFtTZOS8VGnpTUvE60UmU=
X-Google-Smtp-Source: ABdhPJwogP9orp6WLole0Kp5bl/xX3rnqQ70YaC7JC5PYtH4ojZR2NXuQluwuVbQRbalPDKtX24evQ==
X-Received: by 2002:adf:ee84:: with SMTP id b4mr5979795wro.339.1613174962422;
        Fri, 12 Feb 2021 16:09:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm14832850wrx.63.2021.02.12.16.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:22 -0800 (PST)
Message-Id: <b443e11ac32fd3082a59ada42ada8c8973fa0b8a.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:11 +0000
Subject: [PATCH v3 10/12] unix-socket: create
 `unix_stream_server__listen_with_lock()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a version of `unix_stream_listen()` that uses a ".lock" lockfile
to create the unix domain socket in a race-free manner.

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
socket ("<path>") is has an active server.  If not, create a new
socket and begin listening.  Then we rollback the lockfile in all
cases.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++
 unix-socket.h |  29 +++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/unix-socket.c b/unix-socket.c
index 1eaa8cf759c0..647bbde37f97 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "unix-socket.h"
 
 static int chdir_len(const char *orig, int len)
@@ -132,3 +133,117 @@ int unix_stream_listen(const char *path,
 	errno = saved_errno;
 	return -1;
 }
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
+	int fd_socket;
+	struct unix_stream_server_socket *server_socket;
+
+	/*
+	 * Create a lock at "<path>.lock" if we can.
+	 */
+	if (hold_lock_file_for_update_timeout(&lock, path, 0,
+					      opts->timeout_ms) < 0) {
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
diff --git a/unix-socket.h b/unix-socket.h
index 2c0b2e79d7b3..8faf5b692f90 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -2,14 +2,17 @@
 #define UNIX_SOCKET_H
 
 struct unix_stream_listen_opts {
+	long timeout_ms;
 	int listen_backlog_size;
 	unsigned int disallow_chdir:1;
 };
 
+#define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
 #define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
 
 #define UNIX_STREAM_LISTEN_OPTS_INIT \
 { \
+	.timeout_ms = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT, \
 	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
 	.disallow_chdir = 0, \
 }
@@ -18,4 +21,30 @@ int unix_stream_connect(const char *path, int disallow_chdir);
 int unix_stream_listen(const char *path,
 		       const struct unix_stream_listen_opts *opts);
 
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
 #endif /* UNIX_SOCKET_H */
-- 
gitgitgadget

