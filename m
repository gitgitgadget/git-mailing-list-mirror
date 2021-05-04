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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29E1C43461
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13B7611CB
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhEDCNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhEDCN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DAC06138B
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m9so7595602wrx.3
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CobXKWM5+11X/E2p/lSwwF9swOXqfgnDizKF7JRoeQc=;
        b=GNCnv8DfxGy3alE0Dq2D1VWZDsAZN6pA/vpDkVT9EzuBXiXYQMzbePHNQ/QIbUPsfF
         J6Jjf837B9uoaaj0sv6mJHLOYIVublPAroSezk9DN43x3HlpaGTb0gW4Rbmp8iGVUx9w
         Qad+2fiH8m3kkvAE6Nobs7djB1EOIUgsZ5MhomW8oKqnvh+raVtH5R7njqkQTkpXu3or
         629sAtxMtwc7XGj7s4OX32NEqHHdU9ZpxmDYug26pfKkuxi24dsLU6blxWVdtq9RUF3V
         hBmxkWb+LuzZ6jTNxU6JJ/0Oo2TfUUX2SnChGGFbOz5Hm6DSDkc/6G94uXi+mR9Nu9DY
         TmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CobXKWM5+11X/E2p/lSwwF9swOXqfgnDizKF7JRoeQc=;
        b=lc4yGc6GwuH0PgkQBLhHp8ra9Qv78ydodCnnz0yUAFO+Ga2f60UcxiyDLRnsVTjbx6
         szMHBiqISPglLz506l0hUq5+yiTM4LYeM6Fajlow81wHJr0ur4MO1/3uaTrW68a5fNQU
         Sze2GcCaW4oaigkVEh/4Hqx93fw85TLSykJzcPRYV3YrZ3GOE+vdWnrF74CvPeoLeobh
         XKfcEFN7Wbrco2aJO6qolS8ISgHeol/HGtXn+9TLM28KIC/9pcLLO7s5xCG94wop/erG
         KK6ltEilHhutXoCuMpRYh1t7yqfHQvp82En2t+nFMRT0AhaodPkups9rJz68/CPeUg61
         nFJw==
X-Gm-Message-State: AOAM531bdd5WxB3poDrBozkiKixaM/vsahu2CC7FAH2/STy6GPGFVilm
        KvDtUdIYEjKy9CZhBFxEkv3LhExqdAY=
X-Google-Smtp-Source: ABdhPJwmwcM3iVWwvBDotQ+NxbZVdc4t1i60bzu0+fKL2NQDjQRzl6tROA+waeJWmX3N5e7p7sntyA==
X-Received: by 2002:adf:f212:: with SMTP id p18mr28166440wro.120.1620094350696;
        Mon, 03 May 2021 19:12:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm1003768wmh.19.2021.05.03.19.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:30 -0700 (PDT)
Message-Id: <28b622a8261b8bf9190ecc9ce4189334ca553109.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:18 +0000
Subject: [PATCH v2 12/13] merge-ort: handle interactions of caching and
 rename/rename(1to1) cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As documented in Documentation/technical/remembering-renames.txt, and as
tested for in the two testcases in t6429 with "rename same file
identically" in their description, there is one case where we need to
have renames in one commit NOT be cached for the next commit in our
rebase sequence -- namely, rename/rename(1to1) cases.  Rather than
specifically trying to uncache those and fix up dir_rename_counts() to
match (which would also be valid but more work), we simply disable the
optimization when this really rare type of rename occurs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 741970cd05e7..2fc98b803d1c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2100,6 +2100,9 @@ static int process_renames(struct merge_options *opt,
 			VERIFY_CI(side2);
 
 			if (!strcmp(pathnames[1], pathnames[2])) {
+				struct rename_info *ri = &opt->priv->renames;
+				int j;
+
 				/* Both sides renamed the same way */
 				assert(side1 == side2);
 				memcpy(&side1->stages[0], &base->stages[0],
@@ -2109,6 +2112,16 @@ static int process_renames(struct merge_options *opt,
 				base->merged.is_null = 1;
 				base->merged.clean = 1;
 
+				/*
+				 * Disable remembering renames optimization;
+				 * rename/rename(1to1) is incredibly rare, and
+				 * just disabling the optimization is easier
+				 * than purging cached_pairs,
+				 * cached_target_names, and dir_rename_counts.
+				 */
+				for (j = 0; j < 3; j++)
+					ri->merge_trees[j] = NULL;
+
 				/* We handled both renames, i.e. i+1 handled */
 				i++;
 				/* Move to next rename */
@@ -3896,7 +3909,22 @@ static void merge_check_renames_reusable(struct merge_options *opt,
 
 	renames = &opti->renames;
 	merge_trees = renames->merge_trees;
-	/* merge_trees[0..2] will only be NULL if opti is */
+
+	/*
+	 * Handle case where previous merge operation did not want cache to
+	 * take effect, e.g. because rename/rename(1to1) makes it invalid.
+	 */
+	if (!merge_trees[0]) {
+		assert(!merge_trees[0] && !merge_trees[1] && !merge_trees[2]);
+		renames->cached_pairs_valid_side = 0; /* neither side valid */
+		return;
+	}
+
+	/*
+	 * Handle other cases; note that merge_trees[0..2] will only
+	 * be NULL if opti is, or if all three were manually set to
+	 * NULL by e.g. rename/rename(1to1) handling.
+	 */
 	assert(merge_trees[0] && merge_trees[1] && merge_trees[2]);
 
 	/* Check if we meet a condition for re-using cached_pairs */
-- 
gitgitgadget

