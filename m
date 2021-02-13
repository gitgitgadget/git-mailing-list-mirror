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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E5DC433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198A164D5D
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhBMAK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhBMAKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A2C061793
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i9so1380933wmq.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3DE2LGbxZPS99naynGsZAiR5LTnfiDo7m2CNe53QjEk=;
        b=gl6TLB07y0RBDaClruZhfjRI2g7dfJ9K06K1bKq1bsqLvL6hr5bHh5RgLiq1rDDswr
         9u7hivpHZaqkqFYOMHK5cPZ03Pn5v0/4/NS0XvMC+K74OiOiM1Hilo+NRMy0vyBNsvO0
         BTJiolpnAO6wW0M5+rTm5tst/Q/bMGYqFrhhD1x2OI3XfdOlGCBDzaheWhgQFdmNlxy9
         tQ/omIYdDi+aCczzUEvFR65qeN/UmalEnuLnarEDFiK0Uvh1F1f8sS+Srnw1Mz6+cVBj
         6iywoYRHtjOmZwNNb2a0dS9RARzudJ3nuL/RiZWlYwiDceeKTZ9SFfjSkOaEMHJzQELI
         IVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3DE2LGbxZPS99naynGsZAiR5LTnfiDo7m2CNe53QjEk=;
        b=aAgjfxdL8Pe4YGWgQYQWxg5ZwWX5JepzXX8Kzw6+/xDYdxzOKyozQB28fw90L3cimA
         S2VwBi56xfAHib62hug2kb4dr3JhsXozLWMH0Ci5KYPSlBy3I+dYKcJMHUty9wHwYtD9
         CTWNhkGzNECTGHNcd2EuQXotDse0cxwcEQzYGY4o2Pyk84/7EeSwUHtuc35fX9t9TsrO
         Ir3pSK0XmX1/qpPxHuED8UvluDUDW0ZmaBVSkWyProu66j3g+iZ4YMr5vzuRbSQHUCsW
         DBNJLwUw2vZdqGnKyz4iP3AbDluqV4I/m0B51inMcWzc/Oas/GrPLaDNPOEAbX5SAPSV
         uLuw==
X-Gm-Message-State: AOAM530S4hirDj1B9JajszICVLL56xXNKY352ZGjfI53+aGjnCFxsUlb
        5fvGkqtB4/iNE7QfXcqgBzsV1enQQK4=
X-Google-Smtp-Source: ABdhPJyeGnPLRNzeYLyvajabTfk3jKd29c5v8MY9Cw9uNRvK/FuZ0+3cRkSlCqT/wve20GfngM1hEQ==
X-Received: by 2002:a1c:e255:: with SMTP id z82mr4582705wmg.93.1613174961247;
        Fri, 12 Feb 2021 16:09:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm8638879wra.17.2021.02.12.16.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:20 -0800 (PST)
Message-Id: <985b2e02b2df7725d70f1365f7cd2e525c9f3ade.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:09 +0000
Subject: [PATCH v3 08/12] unix-socket: add backlog size option to
 unix_stream_listen()
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

Update `unix_stream_listen()` to take an options structure to override
default behaviors.  This commit includes the size of the `listen()` backlog.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/credential-cache--daemon.c |  3 ++-
 unix-socket.c                      |  9 +++++++--
 unix-socket.h                      | 14 +++++++++++++-
 3 files changed, 22 insertions(+), 4 deletions(-)

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
index 69f81d64e9d5..5ac7dafe9828 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -89,9 +89,11 @@ int unix_stream_connect(const char *path)
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
 
@@ -106,7 +108,10 @@ int unix_stream_listen(const char *path)
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
index e271aeec5a07..06a5a05b03fe 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -1,7 +1,19 @@
 #ifndef UNIX_SOCKET_H
 #define UNIX_SOCKET_H
 
+struct unix_stream_listen_opts {
+	int listen_backlog_size;
+};
+
+#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
+
+#define UNIX_STREAM_LISTEN_OPTS_INIT \
+{ \
+	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
+}
+
 int unix_stream_connect(const char *path);
-int unix_stream_listen(const char *path);
+int unix_stream_listen(const char *path,
+		       const struct unix_stream_listen_opts *opts);
 
 #endif /* UNIX_SOCKET_H */
-- 
gitgitgadget

