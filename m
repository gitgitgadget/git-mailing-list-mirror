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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C2C433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F2964E9A
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhBMAKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhBMAKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F39C06178C
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n10so1392661wmq.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=pLWcy94w9J4o818ymQpDkutL/w0jO3O/XtnO/MXGwZpZVWxegM/PLvOuJoujQ+nABJ
         +7ae8OlWcnpmlja3v36+cjMkIOYOuWYfmo0DNTZsXDkHQ7Vep7UZydHCOOxMIzyjA1At
         ovat8SIyLdGerKYEmQzoX53ANeVGeXkSBvoqIr4ParG43emiflCXvtLY2R6QGQP8rbO6
         4zGMmivs8CVHo0aU581tiM1PsS5iCR4DvkvBxPtMGKpG4o/ssnNFfwcAVk7O9rXOUXG6
         lzcZ3PBdHG6H3UJZlU8Lg8of6kqQGk16P7dNulLbvcbEKCHhXd+8jGU9d7rNPsrIzeIs
         i6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=XzGHv+WBD0UQYuZG8dVni/v9B8+Ue0OTi708m27XTSSAkEtDIloLvVrMX6r0WnPuqU
         yAUH/EaHtU6wLkQrcr1ijREaFmH5gXR8QMs7A+bAlqsiq2Fki1uoVg9Jzku+sMlkBKhO
         qN9zA+ouARI1z82/EPopQu997MaOYoG9Hg9M2OaarSkjfwnLC0F3fUVqC0VjWEKTECOU
         P5b6qf0sm+Hu6kj2aWKuIdgtbsllXrgT1hCMJEbZwMTz3t4VRt+PLd74i6rd/x3wwXPS
         8PHy3RjJ+mE4y/2FcxG+AJ3pr15l3YQRNV4r1b6/Ysh2wYdwPfFyrpuKBA1hnAnp9t+U
         D5Cg==
X-Gm-Message-State: AOAM533kIKT6T9l+PCup2srG2Xi9+YMENdck5Ln4R/kHadHQD7RkwjGm
        nkyBuhtB8Q01/NSeA/E7Dba3CvdK+X4=
X-Google-Smtp-Source: ABdhPJyVgfqj2+gvAb7d/aLZGnMO42uL9ZB/reaVEeK8/TUE/5klbk6WW/DG4rJcPbD90BWyDyEyhg==
X-Received: by 2002:a1c:dcd7:: with SMTP id t206mr4508275wmg.108.1613174960708;
        Fri, 12 Feb 2021 16:09:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm12842322wrv.73.2021.02.12.16.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:20 -0800 (PST)
Message-Id: <b368318e6a23f8c4e60f77a8b81b558c523d5b03.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:08 +0000
Subject: [PATCH v3 07/12] unix-socket: elimiate static unix_stream_socket()
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

