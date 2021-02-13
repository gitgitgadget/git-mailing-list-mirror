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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0BDC433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A426864DC3
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBMAL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhBMAKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0979BC061794
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so1365730wrx.4
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ASF8+rFWzj6aUvWIsRo10Spu216IfvU7//f0qbC+iF8=;
        b=sYxiAu+qt7noTY43B9g6XjklBE/saIPy0Oi4DxAIwadvuWyJuYBYNynB+IXrCEYhRc
         EYN5qTWiBZTeJseZ2Jvtv9XkIggrC2GAWxTKXTDrHymdskXXwz/a5EFillVBhAGHc7/O
         tziEUfQ6dph5iHnJOBxlIg5tR0BpSD+aOweg4KqvaY8q2riy7ETDgeySVV2FKoBOZPK8
         1hOPBajCoaHf9+69glHBvtVhpUxG4caPBCSsC9z2LvrLuffwN1KVyzVPfjoMXU1VM2nB
         cSuK+hPa4zyaZ9YddaZQYU1eiVqjcuPuY0kWLXn8K5DR7awHgwdU1vWifuW3jg50/B9I
         nvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ASF8+rFWzj6aUvWIsRo10Spu216IfvU7//f0qbC+iF8=;
        b=eoTjS0BVvXrJtCSi/x8qOueZDkWul56QlJZKAFmD91zdglJIKOqiw7KStXxcoOaDL1
         FOPWYguuG/86RfJsnihoOil4U85NZmMylr0FTvHUE+IxrkwicfSuNrzee5xwABDhVHtX
         ql4cf72xv3/iO9YrWe9S7PtUhUzLoHJJeU6m4P+CDDP1MaxqFN2uHoWlcIRNUT/MIDRw
         Mqc0INvSm76RAhLSqPItfvR795f+KYXrnQa2SQklrxrBxSnsc0fZMP/syJ8DzNRJ7v70
         gAnVIxA7V8M9L0q/tHB/7mj0/hXRuXEJAF2JZy01TdILd+yzUKu/exVB9pNk7PMyYyNS
         +I0A==
X-Gm-Message-State: AOAM530eV37APuTA/VNR5M80SkXKOtR6Ugo5ImlPMXk9HRrWXy+fSUjT
        vKwzo/DzGT+pzZC91a1b5y2pIlwBlU4=
X-Google-Smtp-Source: ABdhPJz+er/7xPAvbC3mEOdtBboVCkNwysgEf1Ex3tEVjwAa3i41C43KaKZyUT3IMUQqCCiFw2avLA==
X-Received: by 2002:adf:c40a:: with SMTP id v10mr6164876wrf.10.1613174961872;
        Fri, 12 Feb 2021 16:09:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b19sm15130940wmj.22.2021.02.12.16.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:21 -0800 (PST)
Message-Id: <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:10 +0000
Subject: [PATCH v3 09/12] unix-socket: disallow chdir() when creating unix
 domain sockets
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
 unix-socket.h              |  4 +++-
 3 files changed, 16 insertions(+), 7 deletions(-)

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
index 5ac7dafe9828..1eaa8cf759c0 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -28,16 +28,23 @@ static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
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
@@ -63,13 +70,13 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
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
@@ -99,7 +106,7 @@ int unix_stream_listen(const char *path,
 
 	unlink(path);
 
-	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
+	if (unix_sockaddr_init(&sa, path, &ctx, opts->disallow_chdir) < 0)
 		return -1;
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (fd < 0)
diff --git a/unix-socket.h b/unix-socket.h
index 06a5a05b03fe..2c0b2e79d7b3 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -3,6 +3,7 @@
 
 struct unix_stream_listen_opts {
 	int listen_backlog_size;
+	unsigned int disallow_chdir:1;
 };
 
 #define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
@@ -10,9 +11,10 @@ struct unix_stream_listen_opts {
 #define UNIX_STREAM_LISTEN_OPTS_INIT \
 { \
 	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
+	.disallow_chdir = 0, \
 }
 
-int unix_stream_connect(const char *path);
+int unix_stream_connect(const char *path, int disallow_chdir);
 int unix_stream_listen(const char *path,
 		       const struct unix_stream_listen_opts *opts);
 
-- 
gitgitgadget

