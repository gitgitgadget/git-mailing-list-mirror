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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C34C433EB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C037B619A1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCVKai (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCVK37 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430FC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b9so16075111wrt.8
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lHzIhsUhBoGLcHN3G24uN3UPY7gPzQXhJA11HE1H76c=;
        b=ib+v/nqji2Mjpzs2h1I1/ewAV+wmHYp8j/qhC6/uobtUG4+RvL5e20AW5IKWymdNdF
         QolZkdOexC/iet223hvzhAk0M5xZMRDj2yI+J1CXA5+xV5CS3HvAqJJiOxUpziAU8dxY
         bHJ/VhtUpKGuoBxGazbAkOHNf14saiyVxY4llKvitUey4RUCi6BCgHErTO2HXweesSs4
         v4iUWpj6KsGmjqCLPaK9RxG+0Bw9PsF0vEcujQKvcE2qI+nyvNfyJwj50GMtZAhRalzf
         pP8hOSpDZGTpqhSeZJOLX2R9F/l9B7KdRqwsqZQ7LHy8Xhx/N3YGDRcBI7lJooMtyLqa
         wvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lHzIhsUhBoGLcHN3G24uN3UPY7gPzQXhJA11HE1H76c=;
        b=GMM9EfISPqEFjLQqbQbDLILRwic1iNuySkX2tPn7koY3sgdD67ORrN/+N5YjgGax0r
         klPQpp6UCiezd9k6FnedhddlHM18Jk9Wb6WihcDpHCsJ9ihgQ13LpioLAhTaxM6d+jsw
         0ZfPJ/QHliI0D6wRykhnXwdGEfeBi03+HIHliVbAJk2TFA/mOuv+MX9aGgZYQ6+Hh37G
         fxuY0N54E5oN1BgyYVot28SODSvcraEIy3d9TNNTy3nnOpI4W2Y7zcAEPHW1kjXVKVsT
         jqYzNJ4H2qsJgMCrDfVN8Eb7vM3gIQ6Lur7T3ua/Y0TSzxXVDl7+FUlpsYf0jgBYII5m
         11QA==
X-Gm-Message-State: AOAM531huc9kWfcR9THoS28S7llWwOpu3DvD1QBjZUWBfHI+RGeUFpSv
        plASwfPuVrhdPDtuED7U9XMipeJ3Vzo=
X-Google-Smtp-Source: ABdhPJxVTVxBUg+mOBTevYhSJ2H4P7E0hYkXGdsozQtJFu2segbaIvKn5bFJcKmIPAQ514BiDMbMqA==
X-Received: by 2002:adf:b1de:: with SMTP id r30mr17856584wra.125.1616408997724;
        Mon, 22 Mar 2021 03:29:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm23043062wro.36.2021.03.22.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:57 -0700 (PDT)
Message-Id: <5972a198361c153e000a9d11c05bec480cb9f4ce.1616408989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
        <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:45 +0000
Subject: [PATCH v7 09/12] unix-socket: disallow chdir() when creating unix
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

