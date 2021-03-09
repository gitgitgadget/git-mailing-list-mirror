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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F75C4332E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CBB6527B
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhCIPDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhCIPCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77802C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 07:02:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h98so16199675wrh.11
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=aKwzmOOQLpZ1DPeOSNFCLve7agHM0Zru3656Ix3aPQiEz1rVkf1Mciznxg/B3hftnh
         BEeRibnpDnCHWAoEFvewp+/NW5AWwhmwBLx9CALWp9XdJ8OFc9k6XhBfSQqcZNeOf8UK
         +FtiUy86cXb8DpuMwudtoj5LbA6CTTrDqhvaiwFhBJtd3P2V4/NOw/eD/G+oFX7lZfS3
         fu+2ZTYr2aCldAeGwllYM/dznMx388uQ8Nou4cRH3n+8z0wnA8XNn4QexFdeL+NmXM4q
         B5ltMo1EQdvm3zSk773m/1VQnL6ZccyWAygHeOSmHaxo8eynRa23gcXWeMGo0RuHQNOo
         1Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+bNP+0W/NmpTzg2fcka3X+P2W1SFHzm3DqEPSuLjvIc=;
        b=Zlxxj9gvhBaBjwsmlHvOmaIq4E25TMtbty8XhrzI69EaMG4fCdq8dbkVfvwCYMo/VX
         lvua3knIrUCkYviJJQKfRPe+hCNFohYnzc4zrc/F9ARmDVcHfvsnSacn63eJ4QylTcgL
         WocZaVNg8Me1Aygklcc3Qb46rgNUuf6K7cnDQBonY/FZrxGuPjNKAdACTWYx7QG6HKjR
         XNL6LNjatJiPsdO1SeqTFZ3tpxewJNAi/PeFCKmtZF8rxLon6B1eThl03RC8hhPODLZ6
         DxfY9fn+apRzTirDHQoDm1BAxLRyRfph6HJ0nfLYK2v42NvC46u25ej1cbH0CtymJFK+
         1xBQ==
X-Gm-Message-State: AOAM530GxtdVutGMlrKUkBa2xDbZPQXe7DAzB4zs2+mXxkpc68UAiWQ7
        jBsCFmj32fzd0NfdSFkwQqnRbmXmaII=
X-Google-Smtp-Source: ABdhPJzoH/n5jwzAJS7AEvJVjDnL7Z09iOJ6NVDaLV1OqlU2lcnpE5/QNPSI8c6AbqTYH7NangCTnA==
X-Received: by 2002:adf:f94c:: with SMTP id q12mr11153269wrr.283.1615302171343;
        Tue, 09 Mar 2021 07:02:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm27200949wrm.36.2021.03.09.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:02:51 -0800 (PST)
Message-Id: <34df1af98e5b262ddf008da396c4a88ee24f3d42.1615302157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:02:32 +0000
Subject: [PATCH v5 07/12] unix-socket: eliminate static unix_stream_socket()
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

