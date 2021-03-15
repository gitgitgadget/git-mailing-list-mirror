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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B8C4332E
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58B164F4C
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhCOVIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhCOVIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 17:08:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A5AC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v4so6379921wrp.13
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZi6C6sQmeIRBlncuQOMliFiSKu+0LMYAJ0CX1WIRg0=;
        b=mrlTfkU+sDk7FulVvMKvYGvGsX6wR/z02c1O3MalFMpwUDMnrVjPQTIgKDpfVSE99h
         XlEblsot2bJbXEfeONmk20BD7TfMPQccfkczQUl5KwLX0zEtka73NCCL27oIYVoU+idw
         /8sEw6y380mHTSN+lOddktjr6B9oTpDkOjYFynEbWiWpbiRRhYJq0Q0gY6g1Fq95dakE
         tW2GKJZJRX14rq644E3kpV7jwl/0A4N2/t1EzMaTs0hfXlQggLKAsbl6MBFEdki6lXmX
         H+0La94tZRDaTqNMeCB0n5FVnJcKRGb0vJJXehdVdX+HahheQ4vAiuDXxj07hlDMV7xr
         PbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZi6C6sQmeIRBlncuQOMliFiSKu+0LMYAJ0CX1WIRg0=;
        b=tlw/+t99RhxuKLgg2xCWJ9hC02SpgcmW+YkV2lQTcrfhbjaUvM3jFtPgEYyK1D+FtW
         tEO52ik1AC9p3k8qGPRiOvQeB/tApdb+unuQeN9NXcD7UOeurHJ/xOEiSgSohTJ0QL46
         kJqypJGhtPQ2QtqdswKkcLTTHBjK+Es0dXzXfaWtK5wXXGvNywi0O98z0+GjCNvYa1C0
         yllundOtgfCCadWlArsJ15h9U4o6/Jv7TpLPjJAe9p+IrZbgf25sE+UA5FGRlMZUCUzY
         n5k97wgJdRaWTK7oMa5dOKbdq5pwO8OGLb/5JXkKgDAcDQka8lUhVdE42N2LFI3LH+Qp
         RpRg==
X-Gm-Message-State: AOAM530ZfSn/YH55Uw+jJZqyWbKv3jP7rmaTiPiWaBHUWhxxb0fWuJLg
        SnitsT+vSLaEFv+KgI6jf8i2tRgDMqY=
X-Google-Smtp-Source: ABdhPJyrV4bV90d4tK28HeMrf6sv/PRWOBMK00S8bHLGIy2BS/bCj3tc9HVFrWdwHtrh1MuXRh7epw==
X-Received: by 2002:adf:a418:: with SMTP id d24mr1432197wra.187.1615842516038;
        Mon, 15 Mar 2021 14:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18sm19610478wrq.61.2021.03.15.14.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 14:08:35 -0700 (PDT)
Message-Id: <3b71f52d862832f3eb65d4041baac4c3a9f3e153.1615842510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
References: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 21:08:25 +0000
Subject: [PATCH v6 08/12] unix-socket: add backlog size option to
 unix_stream_listen()
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

Update `unix_stream_listen()` to take an options structure to override
default behaviors.  This commit includes the size of the `listen()` backlog.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/credential-cache--daemon.c |  3 ++-
 unix-socket.c                      | 11 +++++++++--
 unix-socket.h                      |  9 ++++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index c61f123a3b81..4c6c89ab0de2 100644
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
index 69f81d64e9d5..012becd93d57 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "unix-socket.h"
 
+#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
+
 static int chdir_len(const char *orig, int len)
 {
 	char *path = xmemdupz(orig, len);
@@ -89,9 +91,11 @@ int unix_stream_connect(const char *path)
 	return -1;
 }
 
-int unix_stream_listen(const char *path)
+int unix_stream_listen(const char *path,
+		       const struct unix_stream_listen_opts *opts)
 {
 	int fd = -1, saved_errno;
+	int backlog;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
@@ -106,7 +110,10 @@ int unix_stream_listen(const char *path)
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
 
-	if (listen(fd, 5) < 0)
+	backlog = opts->listen_backlog_size;
+	if (backlog <= 0)
+		backlog = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG;
+	if (listen(fd, backlog) < 0)
 		goto fail;
 
 	unix_sockaddr_cleanup(&ctx);
diff --git a/unix-socket.h b/unix-socket.h
index e271aeec5a07..ec2fb3ea7267 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -1,7 +1,14 @@
 #ifndef UNIX_SOCKET_H
 #define UNIX_SOCKET_H
 
+struct unix_stream_listen_opts {
+	int listen_backlog_size;
+};
+
+#define UNIX_STREAM_LISTEN_OPTS_INIT { 0 }
+
 int unix_stream_connect(const char *path);
-int unix_stream_listen(const char *path);
+int unix_stream_listen(const char *path,
+		       const struct unix_stream_listen_opts *opts);
 
 #endif /* UNIX_SOCKET_H */
-- 
gitgitgadget

