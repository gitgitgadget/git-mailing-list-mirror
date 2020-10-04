Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E9C4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1507A206A1
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEJh754L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJDLU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgJDLSd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 07:18:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F0C0613CF
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 04:18:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b17so3583631pji.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rSDQFwwU9U0XPnizLMK7RwRZdstZGhgKUdKQUokSiLU=;
        b=HEJh754Lwa7QZca0uV2+aBGLasBqTn3rEnNfORDXKjUBSB5RoCI4PTV2pWfzUrkYJf
         vrVl3mdvNtOMixK86QqnwaH6urnFXFbUjRnmgJ33AGRliyGprljCpMtvvdd/5TMScybz
         rNwCVB3Lk2u92kwufCkxnpWOO2hfE2sirif8JtEa/y9HmmNfCkaV3o8NfcGuuI2WJZR3
         8Z2fo236UHs8SQ/g1iil3wGvUv773GC7Glql1+x1nCOeXVdnE+n14br09T25HAx1UVlY
         oXqz/4qgASm7LweNC3hl6BLr47B4f5Rsnbu7pG+MIVRyRWCRn207sgHwoo/WWThpKQGM
         x1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSDQFwwU9U0XPnizLMK7RwRZdstZGhgKUdKQUokSiLU=;
        b=CHbnGJGj8go1NCanXd1aJ0brmO7MXRqSvt7c9qFcIcljHmWYRb6ZL3itq+gKVJ7JpR
         BTYsAGWxPyoYMZUs4V8pZtKOBWtduL96Z6vw6px2+TN8+4exVF4vsvpa/lHFfX9yWUfP
         wsT4bP8P6juG26CZbwho0xGVY/ldlmxV9E5ZJCnnBb6J+JlG30n3bCCM6WuXs46/unIy
         juUtiiv4tMnNoEgBNGDIcWsdB2mIB8Qg3aC+hesXXPPthkBzbGQ7Iwn5zGAyMmLC70uB
         2PGlsSE2Vfl9VrNvzkfbCYvJwB7FmczQ6zDlM6zl1ESrdmu+hNu5fjYiGpQuS4cP1skY
         8MZg==
X-Gm-Message-State: AOAM532CJWWcHa0TQ3agjdmYTfWnwioqS8dSZRWKS3/Kd9BVslvDzeNK
        dVirdLLheFAOGRKw2CEoKP9Xz/sDQVA=
X-Google-Smtp-Source: ABdhPJy0e2Zsht4OJNSnKijmX+XW4BR0knCblBKhryPuKOWlMDqfuJEpx13ZzZBGYRSsgLURCmMOSA==
X-Received: by 2002:a17:90a:77c7:: with SMTP id e7mr951179pjs.106.1601810311608;
        Sun, 04 Oct 2020 04:18:31 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id 78sm4298162pfz.211.2020.10.04.04.18.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 04:18:30 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] Documentation/config/checkout: replace sq with backticks
Date:   Sun,  4 Oct 2020 04:18:23 -0700
Message-Id: <f08d3f796a806b5ec20f12cc85683b2c2e99b1a8.1601810233.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1601810233.git.liu.denton@gmail.com>
References: <cover.1601810233.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The modern style for Git documentation is to use backticks to quote
any command-line documenation so that it is typeset in monospace.
Replace all single quotes with backticks to conform to this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/checkout.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 6b646813ab..e3684a5459 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -1,18 +1,18 @@
 checkout.defaultRemote::
-	When you run 'git checkout <something>'
-	or 'git switch <something>' and only have one
+	When you run `git checkout <something>`
+	or `git switch <something>` and only have one
 	remote, it may implicitly fall back on checking out and
-	tracking e.g. 'origin/<something>'. This stops working as soon
-	as you have more than one remote with a '<something>'
+	tracking e.g. `origin/<something>`. This stops working as soon
+	as you have more than one remote with a `<something>`
 	reference. This setting allows for setting the name of a
 	preferred remote that should always win when it comes to
 	disambiguation. The typical use-case is to set this to
 	`origin`.
 +
 Currently this is used by linkgit:git-switch[1] and
-linkgit:git-checkout[1] when 'git checkout <something>'
-or 'git switch <something>'
-will checkout the '<something>' branch on another remote,
-and by linkgit:git-worktree[1] when 'git worktree add' refers to a
+linkgit:git-checkout[1] when `git checkout <something>`
+or `git switch <something>`
+will checkout the `<something>` branch on another remote,
+and by linkgit:git-worktree[1] when `git worktree add` refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
-- 
2.28.0.942.g77c4c6094c

