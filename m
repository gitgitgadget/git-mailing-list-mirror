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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51494C43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1724B64EC6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhBATsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhBATqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5A8C061797
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:46:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u14so333812wml.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CA3S0LJqlNcGPOU+UDmTskNqSc6aAfxyACjsPm8c3yk=;
        b=rdWsIvXTJEJXJBBqRSVlAAyUy475u//j/nsHCrQ5Am7vO8bDH5iswV5L91VlRH1e+p
         UTKo9m9MULUEWn6LuT4HeKMZpPLFF/BcRlnkshw6TOazDk0BtWTFRnBqBrl3s2e7At3G
         +rcRMBFgCkm546HQwwpsd+7mIe5k6CkidGBYvrw1nKgeFxqnvl+BU0vVh40jQE17bo7P
         YRdaiBwHyRJWoMIUNZUVukJ2JUq7INA+a7/h+gHdr7ITq7F+fJngZOvOTeyGkUpylX7+
         2LEOd66QHVjuk4xZl/uEdczWMu+XvqxPoUTniq5KFP1BFeFVdPmMmZBjxYbF25LJFuHc
         eX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CA3S0LJqlNcGPOU+UDmTskNqSc6aAfxyACjsPm8c3yk=;
        b=OI44tjXT26WrQSgIWRnpngV+lxL9Ui7Bs49C8mZm0Dt8+Q8dqBD53jtbgKyeNac/+6
         ylnkOK1kejRURH2sgVk8Dz79+nMGb94JETDkSO0N9vDcUygGzSHGs7Pr5aLQ0Y0t5U8O
         swTw9NKWrwBB+mMqG7Rt1iKPEC2DV0OnySgGW1XLNRwfDJEktN4vuD8kT0pB++fujMFL
         hYdAsdQOG0OCEKfrdyNpt3EfrIXzbeWUSXOiB1hrFyYlKh65oxA/8xDu9EYBfQKyhVP8
         RWY4qhtgiaWgAg295rDefEuLqCUNaG5MvjDcf58PVDJJl6YaHrTpP0+cEPXnER1ftE6y
         T/Qg==
X-Gm-Message-State: AOAM530Gf8eY8WtzyJxWavoyoza8H6sNsAAXsdAhpaU/IjJcVX/uCCza
        eHbqizAfnYAnZePWJ9TAiTPYdKI2PHM=
X-Google-Smtp-Source: ABdhPJx7sudddHeooTzYnTUteDfrg78dMwNHwVXcwkOUi6eu01v3sub4mpgRCdqL8ShgEawyaNNbgg==
X-Received: by 2002:a1c:2ec2:: with SMTP id u185mr395834wmu.83.1612208759714;
        Mon, 01 Feb 2021 11:45:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3sm320856wme.32.2021.02.01.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:59 -0800 (PST)
Message-Id: <7a6a69dfc20c6ff190cb020931c46bf4d88bab59.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:44 +0000
Subject: [PATCH v2 11/14] unix-socket: add options to unix_stream_listen()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update `unix_stream_listen()` to take an options structure to override
default behaviors.  This includes the size of the `listen()` backlog
and whether it should always unlink the socket file before trying to
create a new one.  Also eliminate calls to `die()` if it cannot create
a socket.

Normally, `unix_stream_listen()` always tries to `unlink()` the
socket-path before calling `bind()`.  If there is an existing
server/daemon already bound and listening on that socket-path, our
`unlink()` would have the effect of disassociating the existing
server's bound-socket-fd from the socket-path without notifying the
existing server.  The existing server could continue to service
existing connections (accepted-socket-fd's), but would not receive any
futher new connections (since clients rendezvous via the socket-path).
The existing server would effectively be offline but yet appear to be
active.

Furthermore, `unix_stream_listen()` creates an opportunity for a brief
race condition for connecting clients if they try to connect in the
interval between the forced `unlink()` and the subsequent `bind()` (which
recreates the socket-path that is bound to a new socket-fd in the current
process).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/credential-cache--daemon.c |  3 ++-
 unix-socket.c                      | 28 +++++++++++++++++++++-------
 unix-socket.h                      | 14 +++++++++++++-
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index c61f123a3b8..4c6c89ab0de 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -203,9 +203,10 @@ static int serve_cache_loop(int fd)
 
 static void serve_cache(const char *socket_path, int debug)
 {
+	struct unix_stream_listen_opts opts = UNIX_STREAM_LISTEN_OPTS_INIT;
 	int fd;
 
-	fd = unix_stream_listen(socket_path);
+	fd = unix_stream_listen(socket_path, &opts);
 	if (fd < 0)
 		die_errno("unable to bind to '%s'", socket_path);
 
diff --git a/unix-socket.c b/unix-socket.c
index ef2aeb46bcd..8bcef18ea55 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -88,24 +88,35 @@ int unix_stream_connect(const char *path)
 	return -1;
 }
 
-int unix_stream_listen(const char *path)
+int unix_stream_listen(const char *path,
+		       const struct unix_stream_listen_opts *opts)
 {
-	int fd, saved_errno;
+	int fd = -1;
+	int saved_errno;
+	int bind_successful = 0;
+	int backlog;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
-	unlink(path);
-
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
+
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (fd < 0)
-		die_errno("unable to create socket");
+		goto fail;
+
+	if (opts->force_unlink_before_bind)
+		unlink(path);
 
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
+	bind_successful = 1;
 
-	if (listen(fd, 5) < 0)
+	if (opts->listen_backlog_size > 0)
+		backlog = opts->listen_backlog_size;
+	else
+		backlog = 5;
+	if (listen(fd, backlog) < 0)
 		goto fail;
 
 	unix_sockaddr_cleanup(&ctx);
@@ -114,7 +125,10 @@ int unix_stream_listen(const char *path)
 fail:
 	saved_errno = errno;
 	unix_sockaddr_cleanup(&ctx);
-	close(fd);
+	if (fd != -1)
+		close(fd);
+	if (bind_successful)
+		unlink(path);
 	errno = saved_errno;
 	return -1;
 }
diff --git a/unix-socket.h b/unix-socket.h
index e271aeec5a0..c28372ef48e 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -1,7 +1,19 @@
 #ifndef UNIX_SOCKET_H
 #define UNIX_SOCKET_H
 
+struct unix_stream_listen_opts {
+	int listen_backlog_size;
+	unsigned int force_unlink_before_bind:1;
+};
+
+#define UNIX_STREAM_LISTEN_OPTS_INIT \
+{ \
+	.listen_backlog_size = 5, \
+	.force_unlink_before_bind = 1, \
+}
+
 int unix_stream_connect(const char *path);
-int unix_stream_listen(const char *path);
+int unix_stream_listen(const char *path,
+		       const struct unix_stream_listen_opts *opts);
 
 #endif /* UNIX_SOCKET_H */
-- 
gitgitgadget

