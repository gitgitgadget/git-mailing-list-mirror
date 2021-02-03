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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64867C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1550864F68
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhBCUEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBCUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 15:04:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F3C06178A
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 12:03:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b3so701485wrj.5
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 12:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=4QUb5ZaVSd9xcO2R/eEbFvziOcvnWdARCA8Fa5EvnSI=;
        b=RMLHG7uN6Zn9MH0vCuNwDaZj/f6rks+mozQnt1f3lqwNHughTZFJmCwBHtksDCQliL
         uDd4v4kUszbF+HRbk9S3mnFqIG3Bj2J8OAX5FfcjPZftNVMrUrTYMQFQUdb/EPh19g1Y
         Syl/Y/319u+1KqsBFHwqkdRjhC2qzZj89kpsJXqvmqOVROjqk7yADQwOaUz2+ypNLh6N
         gSNaZ2XmR6ykXIfF8xXDXKNtoQqrgCwBRL8MdGNeZCkJMXshj4X1/uqg0YZRSo3lbC7k
         XiKzE5hxQmpVdYdH23bEY6o3UOTWaqnBuqPxBAQFAzwjKpm7tLIscQEGJF/yKipUxyOX
         YmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=4QUb5ZaVSd9xcO2R/eEbFvziOcvnWdARCA8Fa5EvnSI=;
        b=PsNHEifoepxqVLQHnQ5h18i5LI79zl0GN01Op5DQI2lwZ4RJKSkggB4CRM3nqPGKvJ
         rYg0vpwbVRANYOOI+NBUCrQ/Ne4YWY0Fr2jJfvdmr+44Wlgz8/56EFq8TFT83ZzoH8sO
         L11uBKN+foh5wM5y4UlVxHrSTS5ubUN1Rv9NgzWAaEuvMtTU1mAIMrq11w+AS8kEAwDO
         yB5vbOJSVUyG2WN9A5MUeAFKezbW819aYjymLS5zQx8afcdqMIzRepA3iKpkh07xBghB
         y+sxRwCLqAPjaZPfawePKpvmkdDzqSzs1BeCIwgeP45kjxCgXMxYcSIbLtP5VsbKQfrT
         ar0g==
X-Gm-Message-State: AOAM5320o/Dd8wbFUxYtduKJ6IxYPsoTnVVH6v+RJkxKjT5cL66ggVJO
        SDiaCR8G5PX+mvzWizvE+mGaFJ65RFU=
X-Google-Smtp-Source: ABdhPJylcdLHvtAibU+oBKvVLsJ4V6PAAidTGDADlIO9BHrzeu91DdoKLL90CbwHrRCD/xFUSMDVJg==
X-Received: by 2002:adf:a501:: with SMTP id i1mr5307461wrb.119.1612382630780;
        Wed, 03 Feb 2021 12:03:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b19sm3715044wmj.22.2021.02.03.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:03:50 -0800 (PST)
Message-Id: <770e894b4abdf24112fa51f963b6fce15be942c1.1612382628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 20:03:46 +0000
Subject: [PATCH v2 1/2] diffcore-rename: no point trying to find a match
 better than exact
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

diffcore_rename() had some code to avoid having destination paths that
already had an exact rename detected from being re-checked for other
renames.  Source paths, however, were re-checked because we wanted to
allow the possibility of detecting copies.  But if copy detection isn't
turned on, then this merely amounts to attempting to find a
better-than-exact match, which naturally ends up being an expensive
no-op.  In particular, copy detection is never turned on by the merge
machinery.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       14.263 s ±  0.053 s    14.119 s ±  0.101 s
    mega-renames:   5504.231 s ±  5.150 s  1802.044 s ±  0.828 s
    just-one-mega:   158.534 s ±  0.498 s    51.391 s ±  0.028 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8fe6c9384bc..8b118628b4e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -463,9 +463,11 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
 	int num_destinations, dst_cnt;
+	int num_sources, want_copies;
 	struct progress *progress = NULL;
 
 	trace2_region_enter("diff", "setup", options->repo);
+	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
 
@@ -502,7 +504,7 @@ void diffcore_rename(struct diff_options *options)
 				p->one->rename_used++;
 			register_rename_src(p);
 		}
-		else if (detect_rename == DIFF_DETECT_COPY) {
+		else if (want_copies) {
 			/*
 			 * Increment the "rename_used" score by
 			 * one, to indicate ourselves as a user.
@@ -532,12 +534,15 @@ void diffcore_rename(struct diff_options *options)
 	 * files still remain as options for rename/copies!)
 	 */
 	num_destinations = (rename_dst_nr - rename_count);
+	num_sources = rename_src_nr;
+	if (!want_copies)
+		num_sources -= rename_count;
 
 	/* All done? */
-	if (!num_destinations)
+	if (!num_destinations || !num_sources)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_destinations, rename_src_nr,
+	switch (too_many_rename_candidates(num_destinations, num_sources,
 					   options)) {
 	case 1:
 		goto cleanup;
@@ -553,7 +558,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				(uint64_t)num_destinations * (uint64_t)rename_src_nr);
+				(uint64_t)num_destinations * (uint64_t)num_sources);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
@@ -573,6 +578,9 @@ void diffcore_rename(struct diff_options *options)
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 
+			if (one->rename_used && !want_copies)
+				continue;
+
 			if (skip_unmodified &&
 			    diff_unmodified_pair(rename_src[j].p))
 				continue;
@@ -594,7 +602,7 @@ void diffcore_rename(struct diff_options *options)
 		}
 		dst_cnt++;
 		display_progress(progress,
-				 (uint64_t)dst_cnt * (uint64_t)rename_src_nr);
+				 (uint64_t)dst_cnt * (uint64_t)num_sources);
 	}
 	stop_progress(&progress);
 
@@ -602,7 +610,7 @@ void diffcore_rename(struct diff_options *options)
 	STABLE_QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
 
 	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
-	if (detect_rename == DIFF_DETECT_COPY)
+	if (want_copies)
 		rename_count += find_renames(mx, dst_cnt, minimum_score, 1);
 	free(mx);
 	trace2_region_leave("diff", "inexact renames", options->repo);
-- 
gitgitgadget

