Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8573CC2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BBD2084C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 11:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn+e0Du2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKALmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 06:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgKALmT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 06:42:19 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC8C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 03:42:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i16so5890757wrv.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 03:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=T9y6Hjj9+hLUam3LoWjbHPmbTIFDLh+T4VxVEkglWMw=;
        b=Rn+e0Du2U6303RJmopkS0OhaXQOKpDCXJNBse5lVpINx6ZN9zc5RPWhqWLvtphX1Sa
         EGTFvTpKWAsRY332dPaYA5Jmi5tdaYtsP13sgY0xs7fIP8TBy9NTlRg1XW3qDyOPeYkg
         gWHAEciXK9JoSeNCsaXOeStFZMf2Nz3ASOrqPazFp0HnNr5dV4BQI3WA4VQ69T7+lyqI
         NiWHzKSN7IO6SpgHVzu5LVBEYyeSkhsYC0x9NkobQUY+RU6PzTKhtLdnhnTE7DA2vCPV
         VUfxLc1QxQNPWvJqXrfna3OxC3Y3zrKIGCltDNTfvV+jc/8DG+OxvFqF91ubBt8nXn7R
         UHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T9y6Hjj9+hLUam3LoWjbHPmbTIFDLh+T4VxVEkglWMw=;
        b=mCCUegaxWF6pC3HjEPZ/wXzNfateJOFWHFIRjUnaPISKpecUVFRfWLX5wZ1bGolhlk
         GL14FTlr9mKzbPT4mme6NW8X0VMK6zYglT4R4M35OqUf0vj3ccRBSfIw+GnVKJ2BaWzh
         WiwuV7iStZHEEQ5m5LClSbZ0ANmn1iHWf0ALmSD8DmI19oejmQK08SHzO5Bn+oO2KJ1e
         Suln9t5jzoqQoNYQbgBxLRd5rIaueEjN9V2SguwxOBw3ihN0/KsSzmk35YfLDqRyc6nm
         a4jtsvUT+EaaMEcchbj5L4YH6YpZ+s2Dgct74lu9BLm5i9K/v7uz9WDB4t9ddSznrN3j
         hlAA==
X-Gm-Message-State: AOAM532jdVDqmQjOPlZRyXQ5ZpVsrb7fszV7sH3iIOYOMrBa5uDsDJer
        tHpSguoZEnJEURrLFllJ/DKYEvGTvVw=
X-Google-Smtp-Source: ABdhPJx6jZFrqET7+ZYEclsIEsaMvaChVUn+/E5AZL0SYs2i7J1HAM7McmBanBr+i0eOvt+GO1CwGA==
X-Received: by 2002:adf:e889:: with SMTP id d9mr13457241wrm.134.1604230937622;
        Sun, 01 Nov 2020 03:42:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm11303054wme.48.2020.11.01.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 03:42:17 -0800 (PST)
Message-Id: <pull.907.git.git.1604230936338.gitgitgadget@gmail.com>
From:   "Alex Free via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 11:42:16 +0000
Subject: [PATCH] fix gcc 4.0 big endian sha1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Free <alex_free@email.com>, alex <you@example.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: alex <you@example.com>

The file sha1dc/sha1.c requires big endian to be defined by the compiler. If it is not defined, then it defaults to little endian mode, which when compiled and ran on a big endian machine results in a sha1 mismatch.

This change will allow git to correctly detect big endian on GCC 4.2 and GCC 4.0 running on PowerPC Mac OS X 10.4 and Mac OS X 10.5, resulting in a successful build that works correctly.

Signed-off-by: Alex Free <alex_free@email.com>
---
    fix gcc 4.0 big endian sha1
    
    Currently, sha1.c is compiled in little endian mode when using gcc 4.0
    on Mac OS X 10.4 PowerPC (which is big endian). This results in a build
    that always states there is a sha1 mismatch. The below patch allows big
    endian to be detected correctly using GCC 4.0 and probably older
    versions as well.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-907%2Falex-free%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-907/alex-free/master-v1
Pull-Request: https://github.com/git/git/pull/907

 sha1dc/sha1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index dede2cbddf..4899ffcc20 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -43,6 +43,14 @@
    you will have to add whatever macros your tool chain defines to indicate Big-Endianness.
  */
 
+#if defined(__BIG_ENDIAN__)
+#define SHA1DC_BIGENDIAN
+#endif
+
+/*
+   Required for GCC 4.0
+*/
+
 #if defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__)
 /*
  * Should detect Big Endian under GCC since at least 4.6.0 (gcc svn

base-commit: ad27df6a5cff694add500ab8c7f97234feb4a91f
-- 
gitgitgadget
