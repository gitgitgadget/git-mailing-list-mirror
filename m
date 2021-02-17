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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB26C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6376C64E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhBQVu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhBQVuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:50:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41661C061797
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id x4so5458062wmi.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BxZO76/AviWURZU430dd0Mk+fI3Wg10NNXpI5VTJui4=;
        b=UigOp15jJGovCHVVZNxODbu8Fq1zYixQB18vwvvNFUA3Q0WUAnzWfmHzh/1ZsWd+YK
         1qjMe5SAWU9XwXi/kLJ+EYr9W/Hf6v7Qu8LHT3/C9cdP9BJqt7MmEAOf3Hf+pwTVNLQ3
         QCYH2iXTW6b0W28cNm4B1JzuzcYMfx797RUuxRHEXe/l8RbG9ce2lrFyRWZT+aqaJOyI
         72nl2cG8EjH36VLgAN7j0rQvY2uSa5nE0nZjKX2zmB+o98aVv+2vCGZutVT0N+md1YK5
         hMjFctLao8kv9C8I6Kbnts+JCK6cL+clmjjK9FrVHmXLa9bcRUDSTTvQMwSWEx3F498L
         zjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BxZO76/AviWURZU430dd0Mk+fI3Wg10NNXpI5VTJui4=;
        b=q7LKX/Goa3DMhpDPhZDATqNZIuVb0BQYTmZUGZ8oMMjjacgjgBZjEiiTIfILANPATg
         4MMD22Fv24WEd6tLQhVGUgDuZ+bsbol6V9yvnipjkfjkMHQHIYRLsiGNlYL7HelDWtIJ
         XAKQYOdsE0xaF0/ow+7g9NzPdKr17RYr6t3V1r6gQH7eip8FTVQTGNES1pzsn7Dv3HLt
         NuLwTF4bC4t2ukGfkmX2PiyAZz5J91Ia1LpgKwOVjtDRs8co2uf1wSlLDd0hBa9n/VUs
         vv1PBkBBI36inokFk8Rve5z0Dc1LmfmB9BzqNGuohIBIbjb7QMFbVR7RwcSn1EOu8ahs
         7ekw==
X-Gm-Message-State: AOAM530kHyeBPVcnG+SqF4B4dRjYmxJTzuVgCBuUtKtqS1zBPJblzm1S
        4KEYWqbiHuE55TVnzz3mPEqdWT1zBOg=
X-Google-Smtp-Source: ABdhPJylXYpFSygNz13pRo3L5U7XHXSRH6W1GtgPOm2ddsdFsCwD7WOqd/CVoK7qyilHCQ9QgO1bGA==
X-Received: by 2002:a1c:3804:: with SMTP id f4mr734908wma.115.1613598536923;
        Wed, 17 Feb 2021 13:48:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm6050268wrr.3.2021.02.17.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:56 -0800 (PST)
Message-Id: <b443e11ac32fd3082a59ada42ada8c8973fa0b8a.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:46 +0000
Subject: [PATCH v4 10/12] unix-socket: create
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

