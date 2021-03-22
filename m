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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4BC433F1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B42619B6
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCVKal (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhCVK36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BC9C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o16so16096507wrn.0
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=CI1iHHQR+WicMFATyce2+jkUujtSX0x2SUYMLuYsZmWbEdVLKIDybkyJKmqqLlqqm3
         zqJfG4o9/g2VHyikx5y0ScW6itM+Uq4KwzXYzIVELM36x2GbIxJXzASLQwnbggNllAMN
         Z8ERc4j7lCq7n/Gde2SNXJatU7j69Vr0VzDxmbNHSgG0dmoZv+iZoj4jJNm5CclmFVj+
         VSd81eGSaovg8GIG1QXO+wHeYDrxLR6sK8qPMeBkyMHVa0Xv2rOY3IfUWVHbwFCh/IHQ
         +/UMwAiu/PllHnpgCj0Nj9Olca/pvupy4wflo7J5v916F/m40drBrxIwYdd+gpQwoFAJ
         Uvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=RquQ00jJeEKuKOuLuF2y7GE51GI0EuM/D57kdZrpEamxMJKvyzeHpbOikGRzn7vvLD
         qNj8pODYR3y3BiCirKERr0f8huJxnbadPJboyGoi4mZnV3Lewl9uyyJdgTfYPQRu1MuV
         9lOYc0VJUiX4urKgCiSNFy+AjaHJbdWQdL+DvZfAQJr60K1E4ME1iDGFfm++ZlmIfwVM
         Wj0Pt+I/NCKpXftN9miqAI+JgPaUzBjRayo+d0qNvOc8jVJEmLgKAWGjJp6Wfa+r5gpn
         MtBGMO5H3IR6ieUHxfQNI2WlrhdMeLmdSr1dDPMs7TEHuj54og+1/joNCBYtKYrRieur
         lJcQ==
X-Gm-Message-State: AOAM530Eb4+WVZ7yPWl1pWIlIN8NC9KElVRH76Y5O8MrotFJ4mrp4/jx
        v9DNm/X1eYK+2qzEaXSejnhgnY6hkOo=
X-Google-Smtp-Source: ABdhPJxVV4T9C09wqyIdXgFToLx1vDvH9EOTwMrEoQxzSfC22EPkLnc3ugdN+n0B/1TwWMfqB3q/Pg==
X-Received: by 2002:adf:e411:: with SMTP id g17mr17501684wrm.225.1616408996399;
        Mon, 22 Mar 2021 03:29:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm18700090wmj.14.2021.03.22.03.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:56 -0700 (PDT)
Message-Id: <4e8c352fb366471c02d1cdf605d37e017eb3f507.1616408989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
        <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:43 +0000
Subject: [PATCH v7 07/12] unix-socket: eliminate static unix_stream_socket()
 helper function
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

