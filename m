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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22879C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F284D613D3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhGPFZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhGPFZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:25:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C4C061762
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g12so5028387wme.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FtUYnKcAXMD3J625PPgToj9E5o38ivjOcMgHDszPyps=;
        b=Pb9NM0oFGNfFAZN5D3fVKWEEtQ20tD3C/cxti4VM+g9LaWmzWhonp1nfgxVFFyHpTt
         eDsBF8/N3rgEn5mZa7elQ/ylmfsSKCw5pFttj87487BFB4zpEyyS6KKF0+692KoVzshY
         Spn72HjaMHQdk+UPw3vbo7XWXrROFX530BMi3SiJUseuljfekLPigkb7ig66HcOelqwX
         /swICq24k3IRNBL9v8CKwQj8mBGHR9UN4SvaPHR0TyPuA5/Nz88mNb1b1G6ezrQfVCrn
         +NZUJz5+Igl/bwVOtM5R1mjwzFPF42kyzDC86aO5Y/aNzuoWQl/Iies8Ojehef6XJsvZ
         lqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FtUYnKcAXMD3J625PPgToj9E5o38ivjOcMgHDszPyps=;
        b=gOl3Qdrgu5oCbbNSxBd4nO0GrQVQfsUlHyJrP2tphEJfnshiLsgVZFlw67PHTxmcRQ
         3KqW9vJ3oCcFuZyklFxKJskWoIRZ4nuKOpxk175OUVQ0tMCtGnKkpfkeWiw3Z3BuKofE
         98R2+RqGlpmQQPcBV9+qq5209kisNDt4xpx8enNU4F2K1+3XGmR4fFZ/q5Jipei1bJaB
         EmkVGx8zfeeac/nECBormWVv+P6PskMCHi6yGgvZGYO8cE4Eyi4zEiwdKkGhsvUgok9E
         CIx6xe2iKd3XabSQg2HPq5z9IVhSjTIWYHoycpFDa7thuzfYxHIu0Luu3zU9rSNj2wPZ
         nIbg==
X-Gm-Message-State: AOAM530BHhKVAIfGtuYnR/SICvbHTQo31Wxm3cZ/WzgxNuFmN3rhm3PA
        IGZ1+aEgR1MTGJmVcw6B0VcRGxg1dX8=
X-Google-Smtp-Source: ABdhPJx26bClgIygkHjpGMwOwmbxG6aa8ODMYJpiluK4H1Azs2N4Z8emU6970cav/7EGM2XWEWtRGA==
X-Received: by 2002:a05:600c:4f05:: with SMTP id l5mr14387429wmq.96.1626412963113;
        Thu, 15 Jul 2021 22:22:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm8523970wri.31.2021.07.15.22.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:22:42 -0700 (PDT)
Message-Id: <572cc5e94d2fc3b4ae848ec6e48f0ef577a39fa6.1626412958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
        <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 05:22:36 +0000
Subject: [PATCH v3 6/7] merge-ort: avoid recursing into directories when we
 don't need to
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

This combines the work of the last several patches, and implements the
conditions when we don't need to recurse into directories.  It's perhaps
easiest to see the logic by separating the fact that a directory might
have both rename sources and rename destinations:

  * rename sources: only files present in the merge base can serve as
    rename sources, and only when one side deletes that file.  When the
    tree on one side matches the merge base, that means every file
    within the subtree matches the merge base.  This means that the
    skip-irrelevant-rename-detection optimization from before kicks in
    and we don't need any of these files as rename sources.

  * rename destinations: the tree that does not match the merge base
    might have newly added and hence unmatched destination files.
    This is what usually prevents us from doing trivial directory
    resolutions in the merge machinery.  However, the fact that we have
    deferred recursing into this directory until the end means we know
    whether there are any unmatched relevant potential rename sources
    elsewhere in this merge.  If there are no unmatched such relevant
    sources anywhere, then there is no need to look for unmatched
    potential rename destinations to match them with.

This informs our algorithm:
  * Search through relevant_sources; if we have entries, they better all
    be reflected in cached_pairs or cached_irrelevant, otherwise they
    represent an unmatched potential rename source (causing the
    optimization to be disallowed).
  * For any relevant_source represented in cached_pairs, we do need to
    to make sure to get the destination for each source, meaning we need
    to recurse into any ancestor directories of those destinations.
  * Once we've recursed into all the rename destinations for any
    relevant_sources in cached_pairs, we can then do the trivial
    directory resolution for the remaining directories.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.235 s ±  0.042 s   205.1  ms ±  3.8  ms
    mega-renames:      9.419 s ±  0.107 s     1.564 s ±  0.010 s
    just-one-mega:   480.1  ms ±  3.9  ms   479.5  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index dbccf8c62e2..a013708fa79 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1230,6 +1230,18 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
+static void resolve_trivial_directory_merge(struct conflict_info *ci, int side)
+{
+	VERIFY_CI(ci);
+	assert((side == 1 && ci->match_mask == 5) ||
+	       (side == 2 && ci->match_mask == 3));
+	oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+	ci->merged.result.mode = ci->stages[side].mode;
+	ci->merged.is_null = is_null_oid(&ci->stages[side].oid);
+	ci->match_mask = 0;
+	ci->merged.clean = 1; /* (ci->filemask == 0); */
+}
+
 static int handle_deferred_entries(struct merge_options *opt,
 				   struct traverse_info *info)
 {
@@ -1239,9 +1251,72 @@ static int handle_deferred_entries(struct merge_options *opt,
 	int side, ret = 0;
 
 	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
-		renames->deferred[side].trivial_merges_okay = 0;
-		strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
-					 &iter, entry) {
+		unsigned optimization_okay = 1;
+		struct strintmap copy;
+
+		/* Loop over the set of paths we need to know rename info for */
+		strset_for_each_entry(&renames->relevant_sources[side],
+				      &iter, entry) {
+			char *rename_target, *dir, *dir_marker;
+			struct strmap_entry *e;
+
+			/*
+			 * If we don't know delete/rename info for this path,
+			 * then we need to recurse into all trees to get all
+			 * adds to make sure we have it.
+			 */
+			if (strset_contains(&renames->cached_irrelevant[side],
+					    entry->key))
+				continue;
+			e = strmap_get_entry(&renames->cached_pairs[side],
+					     entry->key);
+			if (!e) {
+				optimization_okay = 0;
+				break;
+			}
+
+			/* If this is a delete, we have enough info already */
+			rename_target = e->value;
+			if (!rename_target)
+				continue;
+
+			/* If we already walked the rename target, we're good */
+			if (strmap_contains(&opt->priv->paths, rename_target))
+				continue;
+
+			/*
+			 * Otherwise, we need to get a list of directories that
+			 * will need to be recursed into to get this
+			 * rename_target.
+			 */
+			dir = xstrdup(rename_target);
+			while ((dir_marker = strrchr(dir, '/'))) {
+				*dir_marker = '\0';
+				if (strset_contains(&renames->deferred[side].target_dirs,
+						    dir))
+					break;
+				strset_add(&renames->deferred[side].target_dirs,
+					   dir);
+			}
+			free(dir);
+		}
+		renames->deferred[side].trivial_merges_okay = optimization_okay;
+		/*
+		 * We need to recurse into any directories in
+		 * possible_trivial_merges[side] found in target_dirs[side].
+		 * But when we recurse, we may need to queue up some of the
+		 * subdirectories for possible_trivial_merges[side].  Since
+		 * we can't safely iterate through a hashmap while also adding
+		 * entries, move the entries into 'copy', iterate over 'copy',
+		 * and then we'll also iterate anything added into
+		 * possible_trivial_merges[side] once this loop is done.
+		 */
+		copy = renames->deferred[side].possible_trivial_merges;
+		strintmap_init_with_options(&renames->deferred[side].possible_trivial_merges,
+					    0,
+					    NULL,
+					    0);
+		strintmap_for_each_entry(&copy, &iter, entry) {
 			const char *path = entry->key;
 			unsigned dir_rename_mask = (intptr_t)entry->value;
 			struct conflict_info *ci;
@@ -1254,6 +1329,13 @@ static int handle_deferred_entries(struct merge_options *opt,
 			VERIFY_CI(ci);
 			dirmask = ci->dirmask;
 
+			if (optimization_okay &&
+			    !strset_contains(&renames->deferred[side].target_dirs,
+					     path)) {
+				resolve_trivial_directory_merge(ci, side);
+				continue;
+			}
+
 			info->name = path;
 			info->namelen = strlen(path);
 			info->pathlen = info->namelen + 1;
@@ -1289,6 +1371,20 @@ static int handle_deferred_entries(struct merge_options *opt,
 			if (ret < 0)
 				return ret;
 		}
+		strintmap_clear(&copy);
+		strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
+					 &iter, entry) {
+			const char *path = entry->key;
+			struct conflict_info *ci;
+
+			ci = strmap_get(&opt->priv->paths, path);
+			VERIFY_CI(ci);
+
+			assert(renames->deferred[side].trivial_merges_okay &&
+			       !strset_contains(&renames->deferred[side].target_dirs,
+						path));
+			resolve_trivial_directory_merge(ci, side);
+		}
 	}
 	return ret;
 }
-- 
gitgitgadget

