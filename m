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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A84C43619
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB17865279
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhCIPDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhCIPC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B1C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so6702626wmj.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lHzIhsUhBoGLcHN3G24uN3UPY7gPzQXhJA11HE1H76c=;
        b=JEYOHwz+P3u39dZe81lxlWl6oIJwZAXAuUVh06YI6iNBnj0bhUFPVk9Y2d0MRunvUs
         CcD40q7OxLfYiP0ymkCzuKUnEmt2RzVgbnXltrmDnp3Iv/eOCjLmmDiTOvGE8RR88Ay1
         PAFS1N77OHJ1ElFKQMDEDblvNl1z/UhCpk8elfFQmm42ByMVhWwjtNyj+l7/7KVdpSla
         47bkzpmQzLzxR2LG+YyAkKmGhFrep+5DJPkD91ccSCdGqzfzJCc7Vt9+oBb2uLTxpv2k
         vmjUo+tQgLhTYFyfgOkeMtbVkA6uZL5QMr7R7KVwLwWP3aq1eD6tt+JOb9erPEfHCefs
         WYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lHzIhsUhBoGLcHN3G24uN3UPY7gPzQXhJA11HE1H76c=;
        b=Fd9aPMVsVHeRhNC+ZHBhzQWCD5XTH25fWqKOTsyi6U4+1nbbE0YdlYo+75LLDQaAAV
         3kFCo8PTjORY+p10RsKV7a8RQRgpn3ZCgN+g7Q7bkoFZxL82B+06v8jMiv0kpjJDCSk6
         Y5AKigSSIq5kpzudIhOu/KdxYzFJrLo7VdE9YMoZXYJNJuy0hdkAbr+QZ0hCzStXXEob
         wGehtkmQB/zcYu/9hKlDSU+IfHAlQ1YsnfZF3/bduoFVShS2XA5SvspOjt10hHgEJpvu
         2VbSwDh7LbI8sgI3/y4atvianf+Pk+b9FmsxZWKtbzwP+lvUxzn00xuY89wKtWayUzJR
         rO5Q==
X-Gm-Message-State: AOAM5315UMo1m9gVlLm3B6rqsZlZ/RK7qG5hgH4iGTwsxu5WvRzt+fzB
        1J9aC2aUbTPyMpB1iyAdhi5diRjFQZc=
X-Google-Smtp-Source: ABdhPJy4wSsqLq65ySardMv0r/VPszV4z8jPUOmP/pWbojw1fDiMOWzoh8DOH6s3XUrGH5jDW5ovOQ==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr4588100wma.148.1615302172556;
        Tue, 09 Mar 2021 07:02:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm4301072wmq.40.2021.03.09.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:52 -0800 (PST)
Message-Id: <21b8d3c63dbf3d1e5a05274b9693612ac4a14a36.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:34 +0000
Subject: [PATCH v5 09/12] unix-socket: disallow chdir() when creating unix
 domain sockets
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

Calls to `chdir()` are dangerous in a multi-threaded context.  If
`unix_stream_listen()` or `unix_stream_connect()` is given a socket
pathname that is too long to fit in a `sockaddr_un` structure, it will
`chdir()` to the parent directory of the requested socket pathname,
create the socket using a relative pathname, and then `chdir()` back.
This is not thread-safe.

Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when this
flag is set.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/credential-cache.c |  2 +-
 unix-socket.c              | 17 ++++++++++++-----
 unix-socket.h              |  3 ++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 9b3f70990597..76a6ba37223f 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -14,7 +14,7 @@
 static int send_request(const char *socket, const struct strbuf *out)
 {
 	int got_data = 0;
-	int fd = unix_stream_connect(socket);
+	int fd = unix_stream_connect(socket, 0);
 
 	if (fd < 0)
 		return -1;
diff --git a/unix-socket.c b/unix-socket.c
index 012becd93d57..e0be1badb58d 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -30,16 +30,23 @@ static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
 }
 
 static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
-			      struct unix_sockaddr_context *ctx)
+			      struct unix_sockaddr_context *ctx,
+			      int disallow_chdir)
 {
 	int size = strlen(path) + 1;
 
 	ctx->orig_dir = NULL;
 	if (size > sizeof(sa->sun_path)) {
-		const char *slash = find_last_dir_sep(path);
+		const char *slash;
 		const char *dir;
 		struct strbuf cwd = STRBUF_INIT;
 
+		if (disallow_chdir) {
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+
+		slash = find_last_dir_sep(path);
 		if (!slash) {
 			errno = ENAMETOOLONG;
 			return -1;
@@ -65,13 +72,13 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 	return 0;
 }
 
-int unix_stream_connect(const char *path)
+int unix_stream_connect(const char *path, int disallow_chdir)
 {
 	int fd = -1, saved_errno;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
-	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
+	if (unix_sockaddr_init(&sa, path, &ctx, disallow_chdir) < 0)
 		return -1;
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (fd < 0)
@@ -101,7 +108,7 @@ int unix_stream_listen(const char *path,
 
 	unlink(path);
 
-	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
+	if (unix_sockaddr_init(&sa, path, &ctx, opts->disallow_chdir) < 0)
 		return -1;
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (fd < 0)
diff --git a/unix-socket.h b/unix-socket.h
index ec2fb3ea7267..8542cdd7995d 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -3,11 +3,12 @@
 
 struct unix_stream_listen_opts {
 	int listen_backlog_size;
+	unsigned int disallow_chdir:1;
 };
 
 #define UNIX_STREAM_LISTEN_OPTS_INIT { 0 }
 
-int unix_stream_connect(const char *path);
+int unix_stream_connect(const char *path, int disallow_chdir);
 int unix_stream_listen(const char *path,
 		       const struct unix_stream_listen_opts *opts);
 
-- 
gitgitgadget

