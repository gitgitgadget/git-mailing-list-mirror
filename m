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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3978C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792D723131
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391542AbhALPc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391148AbhALPc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799E5C0617A5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a12so2912043wrv.8
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d7ZVkvm1O2Grh2REMhf+Gasv/q3hvRasFYvdKTLwRGY=;
        b=hv7SW73mWatAC/uygYJ2Konsdc3QgwBFh3OmXEQDiTF6vqhKKTW53ax7fDQit70Ra6
         WyxdnqschjRE0vpxrYM+CBMAOp1bwLsjq2YL43pDWpkZewCqautUIHCCKSYs7X/XW9YF
         dIQgQcmlmCGj6/TGWxHAAMGzklPRbFiFxc8rRN/JJubErM4s90V27gGWXkZQVhNPIpY/
         qVomI1itXn8pVBgcg7lFcV0ZKmH5JHl3YpzsGLQejwFrfUWtyGN60utw6OB+Cuoa2TCR
         fn6sjprmmw3Fr6gTaWO1h78vyFLonrSUPKJ5wv0HfgjjmsEl36WA9nzvfsuhFbJuS4Ll
         qU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d7ZVkvm1O2Grh2REMhf+Gasv/q3hvRasFYvdKTLwRGY=;
        b=LJYIY6SDEeTptBO+0ReSx57t8GgHZR9ucKQT/dIYiFIesD8+kTJffb9e13rMD1IML1
         6Du17fSlF+54xp+q8li+iaz58nQKe6nFM7H60q4iLYdkLNnAt9I/s3bhntXh9P8vCUdQ
         wif6LWdAsYbr70NaQk0d/9pLiCEfofncJovPGNKdIyuDC0NeVBox060+ed1831dC1Azv
         /Ws+ATZJWR1G7Pxe8JWGHsjngRvp/WTPYccm9fuao38VDHQZU8S+PtPnbeBDPg4tIy8L
         rhqFMa0LZVfU2JDMHF8eztqXByxlD1u9FyOemXxUvTkDI+dtQcRPlW7hhjTB2idq3sZ4
         OvJQ==
X-Gm-Message-State: AOAM533/SGIn9EERL8xOcCuocNnTzVE4rCmPSiwnupOOkmFYpQP5oMLs
        PTlDhkYdw0Akglhz747W8vQf38UDMFY=
X-Google-Smtp-Source: ABdhPJz/CyCI4JvKTQV4Lq5y6pYNeZ42PB+6+2kp0LVCa3mmpUwK5MYw2/No6m96+dRl5TG3CdC9gg==
X-Received: by 2002:a5d:40ce:: with SMTP id b14mr4857562wrq.350.1610465501122;
        Tue, 12 Jan 2021 07:31:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a62sm4034548wmf.7.2021.01.12.07.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:40 -0800 (PST)
Message-Id: <383a9755669d4ed2d7dba348137dddd49ae2f3d5.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:30 +0000
Subject: [PATCH 08/10] unix-socket: add no-chdir option to
 unix_stream_listen_gently()
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

Calls to `chdir()` are dangerous in a multi-threaded context.  If
`unix_stream_listen()` is given a socket pathname that is too big to
fit in a `sockaddr_un` structure, it will `chdir()` to the parent
directory of the requested socket pathname, create the socket using a
relative pathname, and then `chdir()` back.  This is not thread-safe.

Add `disallow_chdir` flag to `struct unix_sockaddr_context` and change
all callers to pass an initialized context structure.

Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when flag
is set.

Extend the public interface to `unix_stream_listen_gently()` to also
expose this new flag.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 21 +++++++++++++++++----
 unix-socket.h |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 3a9ffc32268..f66987261e6 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -19,8 +19,15 @@ static int chdir_len(const char *orig, int len)
 
 struct unix_sockaddr_context {
 	char *orig_dir;
+	unsigned int disallow_chdir:1;
 };
 
+#define UNIX_SOCKADDR_CONTEXT_INIT \
+{ \
+	.orig_dir=NULL, \
+	.disallow_chdir=0, \
+}
+
 static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
 {
 	if (!ctx->orig_dir)
@@ -40,7 +47,11 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 {
 	int size = strlen(path) + 1;
 
-	ctx->orig_dir = NULL;
+	if (ctx->disallow_chdir && size > sizeof(sa->sun_path)) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+
 	if (size > sizeof(sa->sun_path)) {
 		const char *slash = find_last_dir_sep(path);
 		const char *dir;
@@ -75,7 +86,7 @@ int unix_stream_connect(const char *path)
 {
 	int fd, saved_errno;
 	struct sockaddr_un sa;
-	struct unix_sockaddr_context ctx;
+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
@@ -97,7 +108,7 @@ int unix_stream_listen(const char *path)
 {
 	int fd, saved_errno;
 	struct sockaddr_un sa;
-	struct unix_sockaddr_context ctx;
+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
 
 	unlink(path);
 
@@ -129,7 +140,9 @@ int unix_stream_listen_gently(const char *path,
 	int bind_successful = 0;
 	int saved_errno;
 	struct sockaddr_un sa;
-	struct unix_sockaddr_context ctx;
+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
+
+	ctx.disallow_chdir = opts->disallow_chdir;
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		goto fail;
diff --git a/unix-socket.h b/unix-socket.h
index 253f579f087..08d3d822111 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -7,6 +7,7 @@ int unix_stream_listen(const char *path);
 struct unix_stream_listen_opts {
 	int listen_backlog_size;
 	unsigned int force_unlink_before_bind:1;
+	unsigned int disallow_chdir:1;
 };
 
 int unix_stream_listen_gently(const char *path,
-- 
gitgitgadget

