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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D46C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E848564E85
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhBQVur (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhBQVuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:50:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DEC061793
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u14so50339wri.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3DE2LGbxZPS99naynGsZAiR5LTnfiDo7m2CNe53QjEk=;
        b=UBGYZllc82WJvgc0K31fhq0lRuWxybDS9yC8L1ZUNCn1d9VhNc7muHYAlJmtxQEaS0
         p5XPL+5MFlKOMrXWuFRlxB9Lasy13Wyekw1JwjkidsUcgfX/xlBOY1eEVnhZ6NIcPhZm
         0SPu2xY7fFoN8fj+5f2ML5lu7SZ6wxIzh50G4nFjm/Hazq/RuKGu6abMIZTeGyz1fd/W
         oiTJZOspHcJ0LaDpG/xmN+3oCgXimun0X/noKRL1vmvrRMXnrQlKSm7AJgmIZDv1WTzl
         nSVDHhB3ISDpNg1CaEMABeLaJY+5LfcaYOLASv/LgqrQf/WXktGDgZw6ouyusUIwaWeJ
         cFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3DE2LGbxZPS99naynGsZAiR5LTnfiDo7m2CNe53QjEk=;
        b=epaP16GjAjlogXyYA3IRGF7+UDYkH/HmgqRAVkDYJUPC7KVKx8YFiRp6xGUO453Kq/
         2wVLYKGABkahvftjmgiuIS62rp7HSM2kQgUkOibxZe/9DzIZHOMnioBS+N08bXIyijXq
         SSfZn9QOGz4TL+ZAWTqNuA0je643/qHM4jldbAVSe9QGd5vMKrlxz9x3VtRjEqpbglg8
         j4T0yfIr03zKdU0ruPiHBhd1gC3VU2pEce2pK+suGMkDhyOa/ry5H3kSprs1Gcxwr1KW
         jsmvNZobPgkNvwAYHSblZXBM64nu1qD0oA9IFn1EtYG/Z2YDmo8FAypeHqs0c1O722N3
         Ki7Q==
X-Gm-Message-State: AOAM532iWsSbcNgbKkFW4Dffiq/ERF+JjGEmwHTdfcn+s3TxGmpbnhjU
        cRcitIpwNjTPAzdwQAApC+dex6dJb7w=
X-Google-Smtp-Source: ABdhPJzvCbfKW+1pBTza/1FGXQEwBPF19PNsPghQ7cNWCqE0Ui53R9mEBbS6y/+QHHyI5HvEgz/gqw==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr1141932wrp.61.1613598535697;
        Wed, 17 Feb 2021 13:48:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c128sm4186288wma.37.2021.02.17.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:55 -0800 (PST)
Message-Id: <985b2e02b2df7725d70f1365f7cd2e525c9f3ade.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:44 +0000
Subject: [PATCH v4 08/12] unix-socket: add backlog size option to
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

