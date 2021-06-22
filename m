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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD335C49EA2
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17A261351
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhFVIHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFVIHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 04:07:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD10C061760
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b3so12236494wrm.6
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yjljHMsI83jMnc6ysuMNAloovg3NdkTceuIBTZHhyB0=;
        b=p9NMNXL0MbPfxo7wLm++l3fnsb/NJH/JVvLtVCqOLCtNhWfkd+qbAxUwZIB4dRvN0g
         KNxbGaCVnsWWCUfcAX5TLl1QG9tE2CbpHzIVuWdFPjUdERBA3tWuFo3FvVlfo2hSXgN6
         7JWDc5lU5M4fkhwSo/iOAhZeYTxbxXVYQrt4t0t2jtR3Mg2qwlLtMcrRqSLbZxhcMkcK
         ntwRvHxLKHd2RANSMroInS8DI6CMvdM1duJKV2+B/7bHHimkRBAanG8PXDNxCCt6v9+E
         ImglbFfq06hCN6Q97FPrhGFfWVOM5Leojf2CfEyMfWsEiTTumobzzr5uC3ueRH0UORYM
         DTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yjljHMsI83jMnc6ysuMNAloovg3NdkTceuIBTZHhyB0=;
        b=kf92ojd9rTWvmcAyBkLKEAubVheEbsSH8CA3SdMaDOPnJmvzZpvNYN1eUgdaOu03G+
         qO+By2Y3+w+f0AFQZ1+zDX20qiDQ4o5rauFq3P51SqrlkZ+WUl5/t4KDsKCC1PHSyzqy
         +9cqAbdM9jOq3ULIvI+RJZoLmY+5M7vv202gEAoaaWeC659oKrfLExWj9j93L+udblRn
         ZiT5yS7DnM2fZBPuXA52lSKhT7J+jRzFe/N3DQyVFQNAWO6Xu+nWUrWNP6SruglOtl8O
         MOlgETdzcEG25BvVkVD+iY8lkWO2rze9QtdXGDIQRxE+bsg3yh33nnchPKy/gl5dyorZ
         AErw==
X-Gm-Message-State: AOAM532rzlZCAYo2SMWzdfzd0TudF5VyWWrb/Mw84dyYt5qHSm+JTey9
        PwBCFMbOk2f7qdqJVjXQhvJArHSeNnk=
X-Google-Smtp-Source: ABdhPJyOa/331FMl/Me2NXOdfxRIQihwC4Au9bVDudO7KDCJwcj1U/Cr4Ks0ymBU1oQ84XiwPdeutg==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr3174651wrm.31.1624349084926;
        Tue, 22 Jun 2021 01:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm1426489wmp.39.2021.06.22.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 01:04:44 -0700 (PDT)
Message-Id: <7ed0162cdb4e3fe20c122bffa093d366c30df9c7.1624349082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
        <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 08:04:39 +0000
Subject: [PATCH v3 3/5] diffcore-rename: allow different missing_object_cb
 functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

estimate_similarity() was setting up a diff_populate_filespec_options
every time it was called, requiring the caller of estimate_similarity()
to pass in some data needed to set up this option.  Currently the needed
data consisted of a single variable (skip_unmodified), but we want to
also have the different estimate_similarity() callsites start using
different missing_object_cb functions as well.  Rather than also passing
that data in, just have the caller pass in the whole
diff_populate_filespec_options, and reduce the number of times we need to
set it up.

As a side note, this also drops the number of calls to
has_promisor_remote() dramatically.  If L is the number of basename
paths to compare, M is the number of inexact sources, and N is the
number of inexact destinations, then the number of calls to
has_promisor_remote() drops from L+M*N down to at most 2 -- one for each
of the sites that calls estimate_similarity().  has_promisor_remote() is
a very fast function so this almost certainly has no measurable
performance impact, but it seems cleaner to avoid calling that function
so many times.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 58 +++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 35378d84e8f1..e13e52046026 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -126,7 +126,7 @@ static int estimate_similarity(struct repository *r,
 			       struct diff_filespec *src,
 			       struct diff_filespec *dst,
 			       int minimum_score,
-			       int skip_unmodified)
+			       struct diff_populate_filespec_options *dpf_opt)
 {
 	/* src points at a file that existed in the original tree (or
 	 * optionally a file in the destination tree) and dst points
@@ -143,15 +143,6 @@ static int estimate_similarity(struct repository *r,
 	 */
 	unsigned long max_size, delta_size, base_size, src_copied, literal_added;
 	int score;
-	struct diff_populate_filespec_options dpf_options = {
-		.check_size_only = 1
-	};
-	struct prefetch_options prefetch_options = {r, skip_unmodified};
-
-	if (r == the_repository && has_promisor_remote()) {
-		dpf_options.missing_object_cb = prefetch;
-		dpf_options.missing_object_data = &prefetch_options;
-	}
 
 	/* We deal only with regular files.  Symlink renames are handled
 	 * only when they are exact matches --- in other words, no edits
@@ -169,11 +160,13 @@ static int estimate_similarity(struct repository *r,
 	 * is a possible size - we really should have a flag to
 	 * say whether the size is valid or not!)
 	 */
+	dpf_opt->check_size_only = 1;
+
 	if (!src->cnt_data &&
-	    diff_populate_filespec(r, src, &dpf_options))
+	    diff_populate_filespec(r, src, dpf_opt))
 		return 0;
 	if (!dst->cnt_data &&
-	    diff_populate_filespec(r, dst, &dpf_options))
+	    diff_populate_filespec(r, dst, dpf_opt))
 		return 0;
 
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
@@ -191,11 +184,11 @@ static int estimate_similarity(struct repository *r,
 	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
-	dpf_options.check_size_only = 0;
+	dpf_opt->check_size_only = 0;
 
-	if (!src->cnt_data && diff_populate_filespec(r, src, &dpf_options))
+	if (!src->cnt_data && diff_populate_filespec(r, src, dpf_opt))
 		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(r, dst, &dpf_options))
+	if (!dst->cnt_data && diff_populate_filespec(r, dst, dpf_opt))
 		return 0;
 
 	if (diffcore_count_changes(r, src, dst,
@@ -862,7 +855,11 @@ static int find_basename_matches(struct diff_options *options,
 	int i, renames = 0;
 	struct strintmap sources;
 	struct strintmap dests;
-
+	struct diff_populate_filespec_options dpf_options = {
+		.check_binary = 0,
+		.missing_object_cb = NULL,
+		.missing_object_data = NULL
+	};
 	/*
 	 * The prefeteching stuff wants to know if it can skip prefetching
 	 * blobs that are unmodified...and will then do a little extra work
@@ -873,7 +870,10 @@ static int find_basename_matches(struct diff_options *options,
 	 * the extra work necessary to check if rename_src entries are
 	 * unmodified would be a small waste.
 	 */
-	int skip_unmodified = 0;
+	struct prefetch_options prefetch_options = {
+		.repo = options->repo,
+		.skip_unmodified = 0
+	};
 
 	/*
 	 * Create maps of basename -> fullname(s) for remaining sources and
@@ -910,6 +910,11 @@ static int find_basename_matches(struct diff_options *options,
 			strintmap_set(&dests, base, i);
 	}
 
+	if (options->repo == the_repository && has_promisor_remote()) {
+		dpf_options.missing_object_cb = prefetch;
+		dpf_options.missing_object_data = &prefetch_options;
+	}
+
 	/* Now look for basename matchups and do similarity estimation */
 	for (i = 0; i < rename_src_nr; ++i) {
 		char *filename = rename_src[i].p->one->path;
@@ -953,7 +958,7 @@ static int find_basename_matches(struct diff_options *options,
 			one = rename_src[src_index].p->one;
 			two = rename_dst[dst_index].p->two;
 			score = estimate_similarity(options->repo, one, two,
-						    minimum_score, skip_unmodified);
+						    minimum_score, &dpf_options);
 
 			/* If sufficiently similar, record as rename pair */
 			if (score < minimum_score)
@@ -1272,6 +1277,14 @@ void diffcore_rename_extended(struct diff_options *options,
 	int num_sources, want_copies;
 	struct progress *progress = NULL;
 	struct dir_rename_info info;
+	struct diff_populate_filespec_options dpf_options = {
+		.check_binary = 0,
+		.missing_object_cb = NULL,
+		.missing_object_data = NULL
+	};
+	struct prefetch_options prefetch_options = {
+		.repo = options->repo
+	};
 
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
@@ -1433,6 +1446,13 @@ void diffcore_rename_extended(struct diff_options *options,
 				(uint64_t)num_destinations * (uint64_t)num_sources);
 	}
 
+	/* Finish setting up dpf_options */
+	prefetch_options.skip_unmodified = skip_unmodified;
+	if (options->repo == the_repository && has_promisor_remote()) {
+		dpf_options.missing_object_cb = prefetch;
+		dpf_options.missing_object_data = &prefetch_options;
+	}
+
 	CALLOC_ARRAY(mx, st_mult(NUM_CANDIDATE_PER_DST, num_destinations));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].p->two;
@@ -1458,7 +1478,7 @@ void diffcore_rename_extended(struct diff_options *options,
 			this_src.score = estimate_similarity(options->repo,
 							     one, two,
 							     minimum_score,
-							     skip_unmodified);
+							     &dpf_options);
 			this_src.name_score = basename_same(one, two);
 			this_src.dst = i;
 			this_src.src = j;
-- 
gitgitgadget

