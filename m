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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7B4C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 04:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99ED64E4A
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 04:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhB1EAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 23:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhB1D7v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06995C061793
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:33 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u187so8620447wmg.4
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KWaxSZgzerRR2+AOXRgojJoGF8Bm1+wLklgOoYKNF54=;
        b=lIcqGOccJygHG5PqZjABJlYlXpSGFZ6JXBYesZ+1bvmesvYT7c2g9Q/23ClAjCi+ts
         krsO3hNS+kX3myma+C+ddHS6QOFFm4B6LX/hTOHTQggUQwHlOIAnXDcBUX+hn3ObQDhW
         zjjsCZmn1rJKm3fTRad9v+qYQoe/BsmBsdx2wwqoM5rrpQoc4qa7SALtfRYyUz7cUWYM
         j5LGS8IHEEf1hk31OJvTAJyXXtdSJzjlEKZC81YSV0UxnRQH0pYNKz62hUBVpmyNz56J
         4UGpWs7bLLdOWcte8kWYPXQa7aGaGV3GlDHZfi++Zitm5LF4CT1FclwO0UVRGO8Mey29
         Fnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=KWaxSZgzerRR2+AOXRgojJoGF8Bm1+wLklgOoYKNF54=;
        b=q0beUYts/YCRkJnafk8Z4Z+h+4lOZ3/QFmfGdF7OYZ6YsIN1CT681qKFZ6kcRE1xPc
         m3qvh9vl8j/E9UvJ1x7YIffSBZ4G5czkh9JdwIbqKi2zd4AyqKWKR9rMMI+7UM1MWqzh
         iBLB5qynaSRJEH+MxhDKMxnTo38URpXg2g/eWnitzQOd9jPZ8jZPEURlsSZzvH/uXuer
         PCd53aT0rWcaN4/f8oJOxOmJtV4BebirNYV64M55o1N41F8E2j0AMk+j+RNgsXUf+AL3
         R4UgJE/iBFT/ToY3YF2M+LZ3g3H+WqOA2jUU/j1KTm+o38r7FGkIOkF7y5f8I8k70OgJ
         nd4Q==
X-Gm-Message-State: AOAM530WqW0A6JgFCUWI8SbIN7EFpaH3iFOWn0nT026tMX5EtwmHkq0+
        lgECFzJiHH7N9MzWad/AKGrTwQaspSg=
X-Google-Smtp-Source: ABdhPJwf9rsbv82OQCIiuhuWaBgAG+GGPphRoe9+YumFGltUQ/ZRVsQi3cTzvrbic1UUeiDL7hf3GQ==
X-Received: by 2002:a05:600c:21d8:: with SMTP id x24mr9798065wmj.29.1614484711866;
        Sat, 27 Feb 2021 19:58:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm5995254wru.2.2021.02.27.19.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:31 -0800 (PST)
Message-Id: <d5486ab2846270486dd94bbfe81c5b27d18415d7.1614484707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:25 +0000
Subject: [PATCH 7/8] merge-ort: skip rename detection entirely if possible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

diffcore_rename_extended() will do a bunch of setup, then check for
exact renames, then abort before inexact rename detection if there are
no more sources or destinations that need to be matched.  It will
sometimes be the case, however, that either
  * we start with neither any sources or destinations
  * we start with no *relevant* sources
In the first of these two cases, the setup and exact rename detection
will be very cheap since there are 0 files to operate on.  In the second
case, it is quite possible to have thousands of files with none of the
source ones being relevant.  Avoid calling diffcore_rename_extended() or
even some of the setup before diffcore_rename_extended() when we can
determine that rename detection is unnecessary.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        6.003 s ±  0.048 s     5.708 s ±  0.111 s
    mega-renames:    114.009 s ±  0.236 s   102.171 s ±  0.440 s
    just-one-mega:     3.489 s ±  0.017 s     3.471 s ±  0.015 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 66892c63cee2..8602c7b8936f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2158,6 +2158,19 @@ static int process_renames(struct merge_options *opt,
 	return clean_merge;
 }
 
+static inline int possible_side_renames(struct rename_info *renames,
+					unsigned side_index)
+{
+	return renames->pairs[side_index].nr > 0 &&
+	       !strset_empty(&renames->relevant_sources[side_index]);
+}
+
+static inline int possible_renames(struct rename_info *renames)
+{
+	return possible_side_renames(renames, 1) ||
+	       possible_side_renames(renames, 2);
+}
+
 static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 {
 	/*
@@ -2194,6 +2207,16 @@ static void detect_regular_renames(struct merge_options *opt,
 	struct diff_options diff_opts;
 	struct rename_info *renames = &opt->priv->renames;
 
+	if (!possible_side_renames(renames, side_index)) {
+		/*
+		 * No rename detection needed for this side, but we still need
+		 * to make sure 'adds' are marked correctly in case the other
+		 * side had directory renames.
+		 */
+		resolve_diffpair_statuses(&renames->pairs[side_index]);
+		return;
+	}
+
 	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.rename_empty = 0;
@@ -2311,6 +2334,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	int need_dir_renames, s, clean = 1;
 
 	memset(&combined, 0, sizeof(combined));
+	if (!possible_renames(renames))
+		goto cleanup;
 
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detect_regular_renames(opt, MERGE_SIDE1);
@@ -2345,6 +2370,26 @@ static int detect_and_process_renames(struct merge_options *opt,
 	clean &= process_renames(opt, &combined);
 	trace2_region_leave("merge", "process renames", opt->repo);
 
+	goto simple_cleanup; /* collect_renames() handles some of cleanup */
+
+cleanup:
+	/*
+	 * Free now unneeded filepairs, which would have been handled
+	 * in collect_renames() normally but we're about to skip that
+	 * code...
+	 */
+	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
+		struct diff_queue_struct *side_pairs;
+		int i;
+
+		side_pairs = &renames->pairs[s];
+		for (i = 0; i < side_pairs->nr; ++i) {
+			struct diff_filepair *p = side_pairs->queue[i];
+			diff_free_filepair(p);
+		}
+	}
+
+simple_cleanup:
 	/* Free memory for renames->pairs[] and combined */
 	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
 		free(renames->pairs[s].queue);
-- 
gitgitgadget

