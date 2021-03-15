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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BFDC4321A
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D0664F50
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhCOVIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCOVIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 17:08:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF263C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d191so8896269wmd.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lHzIhsUhBoGLcHN3G24uN3UPY7gPzQXhJA11HE1H76c=;
        b=ls8PLQOuUAilnvsLtPyOnb3PQ914A7s+UzKKEhKqXF0cxmnXAeEWiZ0VxmStI8AO4B
         ZyTJNLV9FsvvyHhJgFI04y8f9aCViowbvAz2J1TQJHRWE6dVlMwCoPcxemFLsskCZV5q
         TvYT3GMpHlc6MnFV2BF7zA51fNblLvGdi3F7rZ+binxJdF0yEGybC249uhM6GpzwfZVE
         ofOyCTDhQK4DRIfyec5JCYD/xJQ7D64N4okesL4Hmv3XiWT0UbNw+CyjkjA9hk/H0IfE
         YamjMWQbQUAOvsSitkE2LnDEOrKbGEicY5BfTgBYaKTf83Q+TsBtxT/FcTNUEiiBuDRE
         fuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lHzIhsUhBoGLcHN3G24uN3UPY7gPzQXhJA11HE1H76c=;
        b=qJU23dQK1jwKGLWfQAkWvKXXr8Dlhj+tQMkOzrfILx6DCBibofnKMZ1JvQIw974g2R
         Zil+2erErqNTBVlZ6touxrq05plgg7nNVR7DvFii/JU9oFQ/ZRrBu2RlzqWwkLPDDacE
         msCKO0qKifhEl2NcletLOoPQY29vI09qmCJNqWydUtLU0z6cmzliNiUBTvZPpkjCsVK6
         YduMKSydlvU/uvDBWwfRvdr+VJPkI2jl0AHcA0RKjBaSiaVGEcbCFOGmBBXtAiJAKG6U
         DtpkNTr3srSzFli2KPYTTPPZ+2b8XqeSAxxmFswLa3DZAGzyqE7rQquLGb2bsTM+qHRB
         ynSg==
X-Gm-Message-State: AOAM531PL/6ODtvIVX7ne8m172A5mbShcm16LzJ3ZmkFKaZ0ylFHZevW
        6nIZRS1SiD+3J4ZyMgTpCrhei+1cRuE=
X-Google-Smtp-Source: ABdhPJwDf+tpqUlpleKMvAyh31SbZoReLwTB28m1/nArR855aWbooTWO1WPIH/bjplRsGkXeLyzGsg==
X-Received: by 2002:a1c:1dd4:: with SMTP id d203mr1413307wmd.83.1615842516599;
        Mon, 15 Mar 2021 14:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k24sm753951wmr.48.2021.03.15.14.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 14:08:36 -0700 (PDT)
Message-Id: <5972a198361c153e000a9d11c05bec480cb9f4ce.1615842510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
References: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 21:08:26 +0000
Subject: [PATCH v6 09/12] unix-socket: disallow chdir() when creating unix
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

