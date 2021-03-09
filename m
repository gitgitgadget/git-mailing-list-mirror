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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E1C4360C
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7269965275
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhCIPDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhCIPC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10005C06175F
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so6706327wmd.5
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZi6C6sQmeIRBlncuQOMliFiSKu+0LMYAJ0CX1WIRg0=;
        b=F4CXCVMdGp0MNFzw0IQVs3SUmAfQmS5QuPj5c9P3XYJBG3N275CSjnF9oIa25C+mF5
         uN6QPcWmjGFMoZX9a6zDXl3ZfrBLlyww4fsogLbY/ARTwpBgDHjGOLunLuhlhPRU1SNa
         I9wYqdxyORgH/aKj1qBwtnYsictOkILMMLVXRnLXD2mnKzFoIEkirTAxXQhgxzMYEvt+
         T5JyZOwa7zy8i8qr1a3eho6LtxeCGcKusE8Wkz0heh3drKtmNlSDTQaRzL96J/J7cwWX
         xh/ifZH0zA+2zSe/zrJFG6Z6uUOZWrTjD0AWuEt8MpqbGVlBZnOsm5Bsch34F0hG4B5L
         o3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZi6C6sQmeIRBlncuQOMliFiSKu+0LMYAJ0CX1WIRg0=;
        b=WHLdseK0RoVLFdonDQ78hpfZsmIHETzYaSBZ901enYUjNNO3PQW9pokGVsIZVntBNw
         WKIeOfqYB3CMCDGkRZ+QmGm38t38Tmsl9rLSOq+U4b4zIvhvzgyoiKOFHKteb2z4NJKy
         YRStRJLLTPNzo91WYIxIiYOyP0akCBULFmaIGDXTB7nO00HJQ7FjK/mhc3ixQ+cdRqlQ
         4L7AUg4376tuoBiVf8VE1m1LAthiFWGtgPEnRtCYWifhfidsG60/ksJBg1vMKMCV6n6U
         G9WV82Qg4pBiwDpLcDYr9cHPR6ui1ufZslV4TtfBpduXEepyjT/zWfsMa3CVTYgf11Ne
         o/8Q==
X-Gm-Message-State: AOAM530aCO8C807xH+UNCHzagfPyMlHbY1IGyLV+anJzJcJyH6pkm0pW
        EEwWFuyzn7ZnVhpAowFG7ei9eozFTKc=
X-Google-Smtp-Source: ABdhPJyPip/OJFYc1g4//I8oJpoWBzeG4rJ5JqHdkQiJV2IH7FzdqbvgHqDNColUnXiUG73EXhsNZg==
X-Received: by 2002:a1c:8005:: with SMTP id b5mr4583254wmd.130.1615302171922;
        Tue, 09 Mar 2021 07:02:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm4564070wmh.13.2021.03.09.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:51 -0800 (PST)
Message-Id: <d6ff6e0e050acf7efecfad86fcb963b711ee59ff.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:33 +0000
Subject: [PATCH v5 08/12] unix-socket: add backlog size option to
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

