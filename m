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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35EFC433EA
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4662619A3
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCVKaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCVK37 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48496C061756
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v4so16065822wrp.13
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZi6C6sQmeIRBlncuQOMliFiSKu+0LMYAJ0CX1WIRg0=;
        b=HIwRE5akY/zr21XjS6Iskx7BfvRKgBveRccWYlBI/v1+S4CXRzUgpqXDqrAS1qw7ok
         GobqTWflrrNArHJC4hbtiFhinjBRvEonmPRbqV6QQpelQxW9djC1znDb7qGffPfLCmwd
         8EqkC5fBglFa9j2wzZmPAFrL0FyHRrkc+68I5fM7Thskr3VqRr19oJRQXMKh2tuscp2T
         Frfcuve21vIFUzzTgmyl8GFh2LziHQBOAWL6X9nleMlrnp7p/5wRKxRwGjrC62k51VVZ
         SyHUFJUxv00lycikdqgkOYd85ogga8Z3Osurmq9idcZiBKsdqYvTQQqqOtUcEgS6nAh3
         E/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZi6C6sQmeIRBlncuQOMliFiSKu+0LMYAJ0CX1WIRg0=;
        b=sOGtbM97/66XhoqE46rco3Y/920Mwjj99PWRE5j8YDzJUkgzJIy0qN1QlfuwubBetb
         J8dIO8RuTFVD00ybSyOo68GUngdgsg/qBtTfBArBjrg52ZSNa0X5dYGDiWZAPPYLnyIK
         zMrwu2C9M8+YcHuwjnTIAk+KLB0DOcivO789EP7lBiF+qlALWycl7LS0LylzqVCKLYgA
         nXueVbF7WVVGPK2lbHsdhw9Hxhtcey7hjeiPHpSEPn6Jz9oHX/ozVYxKpB0TCvVDyBnI
         R2EfpJGuBR+aAUpsRef41964F/m0lkUD4DuIIkmGpzfkBHVl3MlSBGAMglTWE2kSOXu5
         eXdg==
X-Gm-Message-State: AOAM530PEAgPKmokGo2OGbT1yXMZkq6x6rB6Oe3GT04Vz+9ttvtmp05W
        +FZeLgWccxx0ATJk8vXNbYdbmjuBhhs=
X-Google-Smtp-Source: ABdhPJxrLytsmx6eX1/qY8jJc/u1p5sQdy43KnWanjUUEBhA2N/OcCddywTifyc4iTAh2bzjvbyOmw==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr17520325wrr.88.1616408997117;
        Mon, 22 Mar 2021 03:29:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm22232080wrw.63.2021.03.22.03.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:56 -0700 (PDT)
Message-Id: <3b71f52d862832f3eb65d4041baac4c3a9f3e153.1616408989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
        <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:44 +0000
Subject: [PATCH v7 08/12] unix-socket: add backlog size option to
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

