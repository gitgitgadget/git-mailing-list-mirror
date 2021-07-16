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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFDEC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC0613F2
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhGPFZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhGPFZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:25:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E270C061762
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g16so10597577wrw.5
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jTYYZdm9bq7NPN5b67LXlVdIpBH+R0ThjCtl7RWxqOU=;
        b=hcfi3Hw6QuTK15NzDEO61pR6UOpmX6TV8xnmtNrGs/W2dm6ymwzkR+NkWCp3bnyiX4
         hy+168NgYeSqbgIRvrj8/h1TGTjvE0qDqh371uCxSTADdZ81+SQmwe47TAIE3U6f/c+6
         nIDL07rTh6UjSsGZOSJB3ZxSVpeC9Cmst///Y0RNO75K1mJkm6WMVvtK42LI8aw1cfmB
         dhLbCGnz5G806oMRZBV6OzE6LEORqxYsolr/QUxb5Q3uMkuFGbgiEdyviCk8fWiJbEKx
         Gq0bIN9f5bHSPCgoTChFvz3mbH7/5jZyeyyKvSS79kcxNCrU3uyqTNYs0p8vtEmqLVHu
         E3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jTYYZdm9bq7NPN5b67LXlVdIpBH+R0ThjCtl7RWxqOU=;
        b=OdH3D1u+EMNVVxyCzrSyR7WvKPfH/ZRIX9EjD/ZqGNIqt+ffCxV7SPFRvw5b2klsRr
         C9sQcW6DEm4A0DvV0WQv563KiGNjkfcv2DL+pwnHY3rcJqBvGzJ2pJP3MKaFoT6rvtwL
         dYajn+bI92TRHe9sMCH5lqCgEHWVZ2xx+HNxWoNO4KE8PVDnyCBlB9+Wz3aryrlivYcB
         B4qqn5ch6MedigrvEW6gWYyDYQtPFNQ2/sVGaahIagaivJ3y8RHfIXScLJnMLE+wRU/E
         dUGUa1dcjwD9JoXbnT+Li2sUNkj4mrznTN7AE28s89AimyBWMjYEwckptECt0RZpXPQQ
         9oLA==
X-Gm-Message-State: AOAM532m7+GncTRRed/EQKCFq7DXPSHfv9AczB4jbIX3L+6eTmNr4qIT
        JH8nJCY2sgYH44gm299lv3nXzVmdr1Y=
X-Google-Smtp-Source: ABdhPJwOzxlFI0YHQV44NIcL45+yGfVsrL3hzmZBhBCAy9UBWdj4PjJqjFHLcW/H87/skK2bunk21Q==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr9899218wrw.166.1626412960626;
        Thu, 15 Jul 2021 22:22:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l39sm6309743wms.1.2021.07.15.22.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:22:40 -0700 (PDT)
Message-Id: <8aea3713902b7d006f527ccd76faf6f944529bdb.1626412958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
        <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 05:22:32 +0000
Subject: [PATCH v3 2/7] merge-ort: add some more explanations in
 collect_merge_info_callback()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The previous patch possibly raises some questions about whether
additional cases in collect_merge_info_callback() can be handled early.
Add some explanations in the form of comments to help explain these
better.  While we're at it, add a few comments to denote what a few
boolean '0' or '1' values stand for.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6299b4f9413..843fa693145 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1018,8 +1018,8 @@ static int collect_merge_info_callback(int n,
 	if (side1_matches_mbase && side2_matches_mbase) {
 		/* mbase, side1, & side2 all match; use mbase as resolution */
 		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
-				names, names+0, mbase_null, 0,
-				filemask, dirmask, 1);
+				names, names+0, mbase_null, 0 /* df_conflict */,
+				filemask, dirmask, 1 /* resolved */);
 		return mask;
 	}
 
@@ -1061,14 +1061,24 @@ static int collect_merge_info_callback(int n,
 	}
 
 	/*
-	 * Gather additional information used in rename detection.
+	 * Sometimes we can tell that a source path need not be included in
+	 * rename detection -- namely, whenever either
+	 *    side1_matches_mbase && side2_null
+	 * or
+	 *    side2_matches_mbase && side1_null
+	 * However, we call collect_rename_info() even in those cases,
+	 * because exact renames are cheap and would let us remove both a
+	 * source and destination path.  We'll cull the unneeded sources
+	 * later.
 	 */
 	collect_rename_info(opt, names, dirname, fullpath,
 			    filemask, dirmask, match_mask);
 
 	/*
-	 * Record information about the path so we can resolve later in
-	 * process_entries.
+	 * None of the special cases above matched, so we have a
+	 * provisional conflict.  (Rename detection might allow us to
+	 * unconflict some more cases, but that comes later so all we can
+	 * do now is record the different non-null file hashes.)
 	 */
 	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
 			names, NULL, 0, df_conflict, filemask, dirmask, 0);
-- 
gitgitgadget

