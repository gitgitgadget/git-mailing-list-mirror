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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB5C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136B564ECB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhBATth (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhBATqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19328C0617A9
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:46:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q7so17921206wre.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VzM+PE+3kF6zgcBTgKFXoFbs+d9tx2DOnwjzoMRPDAw=;
        b=a8Ljt8h0ZbQODOAcuSKdSDu/5mVrdmS8hs+DV+IgXtvrO3HDt3dbDKkYYdzG0IxB9P
         G5jvAJIBbnpZkQpJ6a7XTYhpmje3YCnKtIoGKlAZjidIGnTbkTm9NgIX0VlEsM2f8zVV
         U3bpP4wMrddVykn51uluO66HQkUcW8IEO+x7A79ZsUVNgKNj7knYI75+Vk98MJiV0X+r
         UKPEA6rxV8KLTtZBVtf+pit33UIWKWl20ZGpwUyRFIWGdp44NOHo2hPy07fxpEVqWz3P
         PG9vnUqgc0cvcX1ahWK3ZzJHhLGmIxn9OZgcsLj4U7GeJDSEUgpZXTm6c6rB8o+deQYe
         veGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VzM+PE+3kF6zgcBTgKFXoFbs+d9tx2DOnwjzoMRPDAw=;
        b=X4z3DF5uVNf2rV9GSLyaX7U4PxcsQ8d/kJPBUxJsSs8zVByuv+KxKuqVQKjTSvdGJV
         N8Rhi7Q2xwBYDEPvVEZxeH7g35lUSyqy8yE2GPZZl/kAizi7Cn88nh2S4xUwL8sf5VN1
         4y5gXzLenteZF9lVAkRdCfXKZ9+RoJyQS8JMaikAbHgi0RQckgdS9qG/IrW7ApkuftqQ
         Ljr5QEioxYd6UELBdj/KBmwiearLkiYM9n9NgR8fjz6+1WhN4RXwsuk2gKi7J00FH3HP
         bTckCwmSN0e/ldKpD88PZBbnLErpysFSukzaGdKFcsSE78Rcgf3/K7ZLuvl6RAAeyBF5
         ol+A==
X-Gm-Message-State: AOAM5326cv1zl338Wt7YCSsNnAdcfqJEUY5UIKT8CSJ3MoR0EAxNT2WA
        pCM2Lca+tTujtzXUomy0gmFttIEHgvI=
X-Google-Smtp-Source: ABdhPJz5CmcvoYN4qy3FXnSY8Bh9QrKHFRBBzkowU0399AJ89CPuXUgEb8Y0xxLI4FDxlN8TkQjLLg==
X-Received: by 2002:adf:f7cf:: with SMTP id a15mr20001606wrq.351.1612208760704;
        Mon, 01 Feb 2021 11:46:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm351033wmh.9.2021.02.01.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:46:00 -0800 (PST)
Message-Id: <745b6d5fb74699b7fe7e32080b18779aa4a82547.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:45 +0000
Subject: [PATCH v2 12/14] unix-socket: add no-chdir option to
 unix_stream_listen()
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

Calls to `chdir()` are dangerous in a multi-threaded context.  If
`unix_stream_listen()` is given a socket pathname that is too big to
fit in a `sockaddr_un` structure, it will `chdir()` to the parent
directory of the requested socket pathname, create the socket using a
relative pathname, and then `chdir()` back.  This is not thread-safe.

Add `disallow_chdir` flag to `struct unix_sockaddr_context` and change
all callers to pass an initialized context structure.

Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when flag
is set.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 19 ++++++++++++++++---
 unix-socket.h |  2 ++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 8bcef18ea55..9726992f276 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -11,8 +11,15 @@ static int chdir_len(const char *orig, int len)
 
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
@@ -32,7 +39,11 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
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
@@ -67,7 +78,7 @@ int unix_stream_connect(const char *path)
 {
 	int fd, saved_errno;
 	struct sockaddr_un sa;
-	struct unix_sockaddr_context ctx;
+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
@@ -96,7 +107,9 @@ int unix_stream_listen(const char *path,
 	int bind_successful = 0;
 	int backlog;
 	struct sockaddr_un sa;
-	struct unix_sockaddr_context ctx;
+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
+
+	ctx.disallow_chdir = opts->disallow_chdir;
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
diff --git a/unix-socket.h b/unix-socket.h
index c28372ef48e..5b0e8ccef10 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -4,12 +4,14 @@
 struct unix_stream_listen_opts {
 	int listen_backlog_size;
 	unsigned int force_unlink_before_bind:1;
+	unsigned int disallow_chdir:1;
 };
 
 #define UNIX_STREAM_LISTEN_OPTS_INIT \
 { \
 	.listen_backlog_size = 5, \
 	.force_unlink_before_bind = 1, \
+	.disallow_chdir = 0, \
 }
 
 int unix_stream_connect(const char *path);
-- 
gitgitgadget

