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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1EC11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1028C6147D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhGADsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhGADsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:48:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C41C0617AD
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p8so6282738wrr.1
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jTYYZdm9bq7NPN5b67LXlVdIpBH+R0ThjCtl7RWxqOU=;
        b=Eise8by0JYnyKEnZLYOpo4QihEu+67Wqhh9e4vqRsxCDVj6tNAxVXDRiaEwBCm6Z9n
         dy7l7C69rPz1iK6lJs0fPmzHDsoYtw+bh+AwRzlgpdG/PDeUAUlw5wabF2Exd74lkU/0
         VyUSSp6/jAnURn4EvenmkHAvB6+wZDYVyqgd98GMtOhXq1D+4sn0ogeTJdrnWH9XfJAh
         Hsdm0EqjCxGccF9NdDjeWSckWxJii1SDItEa70MDJjBk1qgHTBCLXcY84iFK8ZgUjpiW
         Y9sz1yVfTAAUlxz96aJwO6zqtqdxMEHEbYJ/L3Lij+fz9pCxXkqilvrQBleGyIFEE1jC
         qh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jTYYZdm9bq7NPN5b67LXlVdIpBH+R0ThjCtl7RWxqOU=;
        b=AWDWdiCgED2DSR3MxKDTl/9tSpCvlJfh8oAeRwpz6T/nzEwq8aTayFls+oPmGOGmLJ
         YbZzwxZHQGNpgTiWWn2/7l5dFl1jnZxqCTuy7CexJKm41UGVdc1nN677vxH+IrEM/ESI
         EcatSGz9laVWkTqWz5kZLoltNnucf4cnoVgF0T+uXfozgJIP1bWWH/liDsVjV9Euql92
         RsHiiwBlYtRvE8wxTNCH8u2Oh+WvbBJ94uFJlQe9y9euo3rGDxwKpkF2NdpNOCQyFfYT
         UniSdwCiLfHSrMfuC1346sR7714AkZz7c5+Oeldb4Bv7mwwRulSrfNhipUYAbijJeL5X
         bzqw==
X-Gm-Message-State: AOAM532NLOP87DFSWK71IUaxBLjQg+x9bJWIcB5QWZ/fdMU9w7fwHkYA
        AuvYcNYz9aw3T+HCPZIDPxzkjisHHcw=
X-Google-Smtp-Source: ABdhPJzM5NSDPaMkJYvWJCPnY7kJGo7YGSJ+oEo31pWunBi7IepEQ8ySC3lcI/tPzRQrRTfMANU7HA==
X-Received: by 2002:adf:9bd0:: with SMTP id e16mr43205254wrc.392.1625111179967;
        Wed, 30 Jun 2021 20:46:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm21408139wms.8.2021.06.30.20.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:46:19 -0700 (PDT)
Message-Id: <8aea3713902b7d006f527ccd76faf6f944529bdb.1625111177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.git.1625111177.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 03:46:12 +0000
Subject: [PATCH 2/7] merge-ort: add some more explanations in
 collect_merge_info_callback()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
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

