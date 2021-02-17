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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A5FC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4A064E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhBQVub (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhBQVuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:50:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF93C06178C
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l17so3670688wmq.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=V74TFL3N2fRR4EOCXtVc7/TVf5LJXv2dkACr/2JH1A++aIJF0B/B/UwTJSW/G4afps
         qqzLrKaylvTqQp+cdYEV1jWHigQP0hFVeB6PHX/hkCbJJWC3NKIvcyPyDaO+ltv+u+ob
         EkHczLQIe+8nMBpZnm+e1/2GySQkoad4ezyrjkdHkr75I/HQHgf5VtmQJfkAdxzn61kY
         eNv1TXOmWUANWrclfEpPi+0m390tZNrFHKJ/Hzj8F2FGKGGeqqOCp/vBieMiiUbd3A21
         RTWeSgvTUmc/jIgXzuyoO8tWPRD2wX0xUlGtdQHwEPPlUvmrdUIx5TsfsjNM8fLX54lR
         22uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=gcEIE14aCZxU/iI5hOW0pJoKVu+blRAyDXsQ9E0kuYBESf2wDA42pbpRbjafl5Rsca
         BXdLjzyYiF3P9nj6z/ybnHD8eYrt2ep8WCFB/fIgnIhxnp82rw2iSgmQRpbubKqMaZc5
         IbiGObsLetdSf2olUhbHAvSyQ0Qr9Y+/JUQaF3WNiBACndIcAq9mlAi68Z2Xa3wiE98f
         Jk81D3PlwC+USi56F122rtU0EEba9I+GsbkGhdpjsTA9VH6QG23BhzK8VoDBJVDPQDok
         dDlgsDqRJya7OrzvWfnu2PwQiWzO3jWSSbi/sSxJDqzmMdSGY16mKEM/ABSS7qZVYA29
         /k4g==
X-Gm-Message-State: AOAM530DkZQMiFiN9UFKoB974G3q7UcWHJGAx9vCzPY6hAnwqzdDijjQ
        /+pABlP2Yxq+URxozMqeadJN8KJqhgs=
X-Google-Smtp-Source: ABdhPJw0veR2kJXm8kvJJdfLMN9d9ZLsKFfsG4hD4AMFaDzt2TIbrAAxxpl8XuORfBpnGwUBiIjxQw==
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr714784wmp.41.1613598535103;
        Wed, 17 Feb 2021 13:48:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u137sm4961993wmu.20.2021.02.17.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:54 -0800 (PST)
Message-Id: <b368318e6a23f8c4e60f77a8b81b558c523d5b03.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:43 +0000
Subject: [PATCH v4 07/12] unix-socket: elimiate static unix_stream_socket()
 helper function
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

The static helper function `unix_stream_socket()` calls `die()`.  This
is not appropriate for all callers.  Eliminate the wrapper function
and make the callers propagate the error.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 19ed48be9902..69f81d64e9d5 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -1,14 +1,6 @@
 #include "cache.h"
 #include "unix-socket.h"
 
-static int unix_stream_socket(void)
-{
-	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	if (fd < 0)
-		die_errno("unable to create socket");
-	return fd;
-}
-
 static int chdir_len(const char *orig, int len)
 {
 	char *path = xmemdupz(orig, len);
@@ -73,13 +65,16 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 
 int unix_stream_connect(const char *path)
 {
-	int fd, saved_errno;
+	int fd = -1, saved_errno;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
-	fd = unix_stream_socket();
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		goto fail;
+
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
 	unix_sockaddr_cleanup(&ctx);
@@ -87,15 +82,16 @@ int unix_stream_connect(const char *path)
 
 fail:
 	saved_errno = errno;
+	if (fd != -1)
+		close(fd);
 	unix_sockaddr_cleanup(&ctx);
-	close(fd);
 	errno = saved_errno;
 	return -1;
 }
 
 int unix_stream_listen(const char *path)
 {
-	int fd, saved_errno;
+	int fd = -1, saved_errno;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx;
 
@@ -103,7 +99,9 @@ int unix_stream_listen(const char *path)
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
-	fd = unix_stream_socket();
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		goto fail;
 
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
@@ -116,8 +114,9 @@ int unix_stream_listen(const char *path)
 
 fail:
 	saved_errno = errno;
+	if (fd != -1)
+		close(fd);
 	unix_sockaddr_cleanup(&ctx);
-	close(fd);
 	errno = saved_errno;
 	return -1;
 }
-- 
gitgitgadget

