Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB536C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1F422571
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbhAXGCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 01:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAXGCc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 01:02:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC7AC061756
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:43 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so6491758pfu.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDYCzfWISSnpEIaLfB/DCa8pMQQEe2Q1cOjxFAZyN9U=;
        b=JFLwWnOMqd5e+fTdQOsaDfunaeULwLihdF7jzPeNL/mAaHChXYCSzD/CB1xKigsOc1
         QCLRBlseEgm1MIg8n0eFdCqgvo/99UApwwYNgrkz5GvP90PAZYpXKMkcdVXwXpMTbDbj
         pUV7XwihV0uRjRlNoNwNZbo3Vc/vHEKOBXCxtAk9Esnja8XURgXlGnUD61UvY6WA4ezF
         4EU5pSiCkU8dp1VOnTUSqgcMVpIeqoeSF7FmsAW/oXvrOucq5H6ZE+dll0lCcobLGZ2+
         s1mzonWG8mQ2ZSnjiuPc8oRAMgHS31owtu2M8HBA0keyikHXOdfJdWn4Gbv8xWDIkGRE
         kzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDYCzfWISSnpEIaLfB/DCa8pMQQEe2Q1cOjxFAZyN9U=;
        b=tMtPlxJ/RGWcim/R+mRyDgXZDcWuWqpPZuujRTN7q7iTRdOv2k5nzxe4CTrXwe8APH
         f2hllSTbVWyjCPiH5OS9rXnrshdHozDTDnZ6j8lDF1piX4hzrlI0tAK7vo/9Cgoeo0rY
         g6SkJIE74IPTz7l+Tc6T7XENmeqg5pFWw5rvu3+34/HgxLBlU5qHvakufBjIhQ7auUlQ
         d6lA04Xqu443btRQV/tio5LZUX3dyfdT8xOiN9ni+aj5utfNUxlwrk+F0uK4iHxnIimT
         RETSYIi5+hE9157p85ZAu85RUX/ozMTystJSiYHNLQQWD5jKXvuxok4A96VPuro0wDGb
         ugvw==
X-Gm-Message-State: AOAM533XxvlFWyoOXa70zoDG7LbZvumUxSSbg5GoWk9LfXI2EnNgcamq
        4KhEaWJQBD+usJvaIFmzR+q6Pr/+RdU=
X-Google-Smtp-Source: ABdhPJy8I5CgiSRvLR/T+rNPd0zNFiDWUGEv7mWExP1FH6YVfAcGcRsUazLuAMqmilgVkdTkbrKz2A==
X-Received: by 2002:a63:844:: with SMTP id 65mr3281417pgi.371.1611468102784;
        Sat, 23 Jan 2021 22:01:42 -0800 (PST)
Received: from tiger.hsd1.ca.comcast.net ([2601:646:8d80:9ab0:f634:2e28:1242:da6])
        by smtp.gmail.com with ESMTPSA id i26sm13275331pfq.219.2021.01.23.22.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 22:01:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Subject: [PATCH v4 3/3] merge-ort: begin performance work; instrument with trace2_region_* calls
Date:   Sat, 23 Jan 2021 22:01:12 -0800
Message-Id: <20210124060112.1258291-4-newren@gmail.com>
X-Mailer: git-send-email 2.30.0.135.g7f7d4a3e17
In-Reply-To: <20210124060112.1258291-1-newren@gmail.com>
References: <20210115192958.3336755-1-newren@gmail.com>
 <20210124060112.1258291-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add some timing instrumentation for both merge-ort and diffcore-rename;
I used these to measure and optimize performance in both, and several
future patch series will build on these to reduce the timings of some
select testcases.

=== Setup ===

The primary testcase I used involved rebasing a random topic in the
linux kernel (consisting of 35 patches) against an older version.  I
added two variants, one where I rename a toplevel directory, and another
where I only rebase one patch instead of the whole topic.  The setup is
as follows:

  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
  $ git branch hwmon-updates fd8bdb23b91876ac1e624337bb88dc1dcc21d67e
  $ git branch hwmon-just-one fd8bdb23b91876ac1e624337bb88dc1dcc21d67e~34
  $ git branch base 4703d9119972bf586d2cca76ec6438f819ffa30e
  $ git switch -c 5.4-renames v5.4
  $ git mv drivers pilots  # Introduce over 26,000 renames
  $ git commit -m "Rename drivers/ to pilots/"
  $ git config merge.renameLimit 30000
  $ git config merge.directoryRenames true

=== Testcases ===

Now with REBASE standing for either "git rebase [--merge]" (using
merge-recursive) or "test-tool fast-rebase" (using merge-ort), the
testcases are:

Testcase #1: no-renames

  $ git checkout v5.4^0
  $ REBASE --onto HEAD base hwmon-updates

  Note: technically the name is misleading; there are some renames, but
  very few.  Rename detection only takes about half the overall time.

Testcase #2: mega-renames

  $ git checkout 5.4-renames^0
  $ REBASE --onto HEAD base hwmon-updates

Testcase #3: just-one-mega

  $ git checkout 5.4-renames^0
  $ REBASE --onto HEAD base hwmon-just-one

=== Timing results ===

Overall timings, using hyperfine (1 warmup run, 3 runs for mega-renames,
10 runs for the other two cases):

                       merge-recursive           merge-ort
    no-renames:       18.912 s ±  0.174 s    14.263 s ±  0.053 s
    mega-renames:   5964.031 s ± 10.459 s  5504.231 s ±  5.150 s
    just-one-mega:   149.583 s ±  0.751 s   158.534 s ±  0.498 s

A single re-run of each with some breakdowns:

                                    ---  no-renames  ---
                              merge-recursive   merge-ort
    overall runtime:              19.302 s        14.257 s
    inexact rename detection:      7.603 s         7.906 s
    everything else:              11.699 s         6.351 s

                                    --- mega-renames ---
                              merge-recursive   merge-ort
    overall runtime:            5950.195 s      5499.672 s
    inexact rename detection:   5746.309 s      5487.120 s
    everything else:             203.886 s        17.552 s

                                    --- just-one-mega ---
                              merge-recursive   merge-ort
    overall runtime:             151.001 s       158.582 s
    inexact rename detection:    143.448 s       157.835 s
    everything else:               7.553 s         0.747 s

=== Timing observations ===

0) Maximum speedup

The "everything else" row represents the maximum speedup we could
achieve if we were to somehow infinitely parallelize inexact rename
detection, but leave everything else alone.  The fact that this is so
much smaller than the real runtime (even in the case with virtually no
renames) makes it clear just how overwhelmingly large the time spent on
rename detection can be.

1) no-renames

1a) merge-ort is faster than merge-recursive, which is nice.  However,
this still should not be considered good enough.  Although the "merge"
backend to rebase (merge-recursive) is sometimes faster than the "apply"
backend, this is one of those cases where it is not.  In fact, even
merge-ort is slower.  The "apply" backend can complete this testcase in
    6.940 s ± 0.485 s
which is about 2x faster than merge-ort and 3x faster than
merge-recursive.  One goal of the merge-ort performance work will be to
make it faster than git-am on this (and similar) testcases.

2) mega-renames

2a) Obviously rename detection is a huge cost; it's where most the time
is spent.  We need to cut that down.  If we could somehow infinitely
parallelize it and drive its time to 0, the merge-recursive time would
drop to about 204s, and the merge-ort time would drop to about 17s.  I
think this particular stat shows I've subtly baked a couple performance
improvements into merge-ort and into fast-rebase already.

3) just-one-mega

3a) not much to say here, it just gives some flavor for how rebasing
only one patch compares to rebasing 35.

=== Goals ===

This patch is obviously just the beginning.  Here are some of my goals
that this measurement will help us achieve:

* Drive the cost of rename detection down considerably for merges
* After the above has been achieved, see if there are other slowness
  factors (which would have previously been overshadowed by rename
  detection costs) which we can then focus on and also optimize.
* Ensure our rebase testcase that requires little rename detection
  is noticeably faster with merge-ort than with apply-based rebase.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Taylor Blau <ttaylorr@github.com>
---
 diffcore-rename.c |  8 +++++++
 merge-ort.c       | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 90db9ebd6d..8fe6c9384b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -465,6 +465,7 @@ void diffcore_rename(struct diff_options *options)
 	int num_destinations, dst_cnt;
 	struct progress *progress = NULL;
 
+	trace2_region_enter("diff", "setup", options->repo);
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
 
@@ -510,14 +511,17 @@ void diffcore_rename(struct diff_options *options)
 			register_rename_src(p);
 		}
 	}
+	trace2_region_leave("diff", "setup", options->repo);
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
 		goto cleanup; /* nothing to do */
 
+	trace2_region_enter("diff", "exact renames", options->repo);
 	/*
 	 * We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
 	 */
 	rename_count = find_exact_renames(options);
+	trace2_region_leave("diff", "exact renames", options->repo);
 
 	/* Did we only want exact renames? */
 	if (minimum_score == MAX_SCORE)
@@ -545,6 +549,7 @@ void diffcore_rename(struct diff_options *options)
 		break;
 	}
 
+	trace2_region_enter("diff", "inexact renames", options->repo);
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
@@ -600,11 +605,13 @@ void diffcore_rename(struct diff_options *options)
 	if (detect_rename == DIFF_DETECT_COPY)
 		rename_count += find_renames(mx, dst_cnt, minimum_score, 1);
 	free(mx);
+	trace2_region_leave("diff", "inexact renames", options->repo);
 
  cleanup:
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
+	trace2_region_enter("diff", "write back to queue", options->repo);
 	DIFF_QUEUE_CLEAR(&outq);
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -680,5 +687,6 @@ void diffcore_rename(struct diff_options *options)
 		strintmap_clear(break_idx);
 		FREE_AND_NULL(break_idx);
 	}
+	trace2_region_leave("diff", "write back to queue", options->repo);
 	return;
 }
diff --git a/merge-ort.c b/merge-ort.c
index f04fab96d7..931b91438c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -752,7 +752,9 @@ static int collect_merge_info(struct merge_options *opt,
 	init_tree_desc(t + 1, side1->buffer, side1->size);
 	init_tree_desc(t + 2, side2->buffer, side2->size);
 
+	trace2_region_enter("merge", "traverse_trees", opt->repo);
 	ret = traverse_trees(NULL, 3, t, &info);
+	trace2_region_leave("merge", "traverse_trees", opt->repo);
 
 	return ret;
 }
@@ -2105,9 +2107,12 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_opts.show_rename_progress = opt->show_rename_progress;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&diff_opts);
+
+	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diff_tree_oid(&merge_base->object.oid, &side->object.oid, "",
 		      &diff_opts);
 	diffcore_std(&diff_opts);
+	trace2_region_leave("diff", "diffcore_rename", opt->repo);
 
 	if (diff_opts.needed_rename_limit > renames->needed_limit)
 		renames->needed_limit = diff_opts.needed_rename_limit;
@@ -2206,9 +2211,12 @@ static int detect_and_process_renames(struct merge_options *opt,
 
 	memset(&combined, 0, sizeof(combined));
 
+	trace2_region_enter("merge", "regular renames", opt->repo);
 	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
 	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
+	trace2_region_leave("merge", "regular renames", opt->repo);
 
+	trace2_region_enter("merge", "directory renames", opt->repo);
 	need_dir_renames =
 	  !opt->priv->call_depth &&
 	  (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE ||
@@ -2230,8 +2238,11 @@ static int detect_and_process_renames(struct merge_options *opt,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
 	QSORT(combined.queue, combined.nr, compare_pairs);
+	trace2_region_leave("merge", "directory renames", opt->repo);
 
+	trace2_region_enter("merge", "process renames", opt->repo);
 	clean &= process_renames(opt, &combined);
+	trace2_region_leave("merge", "process renames", opt->repo);
 
 	/* Free memory for renames->pairs[] and combined */
 	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
@@ -2913,20 +2924,30 @@ static void process_entries(struct merge_options *opt,
 						   STRING_LIST_INIT_NODUP,
 						   NULL, 0 };
 
+	trace2_region_enter("merge", "process_entries setup", opt->repo);
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
 		return;
 	}
 
 	/* Hack to pre-allocate plist to the desired size */
+	trace2_region_enter("merge", "plist grow", opt->repo);
 	ALLOC_GROW(plist.items, strmap_get_size(&opt->priv->paths), plist.alloc);
+	trace2_region_leave("merge", "plist grow", opt->repo);
 
 	/* Put every entry from paths into plist, then sort */
+	trace2_region_enter("merge", "plist copy", opt->repo);
 	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
 		string_list_append(&plist, e->key)->util = e->value;
 	}
+	trace2_region_leave("merge", "plist copy", opt->repo);
+
+	trace2_region_enter("merge", "plist special sort", opt->repo);
 	plist.cmp = string_list_df_name_compare;
 	string_list_sort(&plist);
+	trace2_region_leave("merge", "plist special sort", opt->repo);
+
+	trace2_region_leave("merge", "process_entries setup", opt->repo);
 
 	/*
 	 * Iterate over the items in reverse order, so we can handle paths
@@ -2937,6 +2958,7 @@ static void process_entries(struct merge_options *opt,
 	 * (because it allows us to know whether the directory is still in
 	 * the way when it is time to process the file at the same path).
 	 */
+	trace2_region_enter("merge", "processing", opt->repo);
 	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
 		char *path = entry->string;
 		/*
@@ -2955,7 +2977,9 @@ static void process_entries(struct merge_options *opt,
 			process_entry(opt, path, ci, &dir_metadata);
 		}
 	}
+	trace2_region_leave("merge", "processing", opt->repo);
 
+	trace2_region_enter("merge", "process_entries cleanup", opt->repo);
 	if (dir_metadata.offsets.nr != 1 ||
 	    (uintptr_t)dir_metadata.offsets.items[0].util != 0) {
 		printf("dir_metadata.offsets.nr = %d (should be 1)\n",
@@ -2970,6 +2994,7 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
 	string_list_clear(&dir_metadata.offsets, 0);
+	trace2_region_leave("merge", "process_entries cleanup", opt->repo);
 }
 
 /*** Function Grouping: functions related to merge_switch_to_result() ***/
@@ -3128,12 +3153,15 @@ void merge_switch_to_result(struct merge_options *opt,
 	if (result->clean >= 0 && update_worktree_and_index) {
 		struct merge_options_internal *opti = result->priv;
 
+		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
 			result->clean = -1;
 			return;
 		}
+		trace2_region_leave("merge", "checkout", opt->repo);
 
+		trace2_region_enter("merge", "record_conflicted", opt->repo);
 		if (record_conflicted_index_entries(opt, opt->repo->index,
 						    &opti->paths,
 						    &opti->conflicted)) {
@@ -3141,6 +3169,7 @@ void merge_switch_to_result(struct merge_options *opt,
 			result->clean = -1;
 			return;
 		}
+		trace2_region_leave("merge", "record_conflicted", opt->repo);
 	}
 
 	if (display_update_msgs) {
@@ -3150,6 +3179,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		struct string_list olist = STRING_LIST_INIT_NODUP;
 		int i;
 
+		trace2_region_enter("merge", "display messages", opt->repo);
+
 		/* Hack to pre-allocate olist to the desired size */
 		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
 			   olist.alloc);
@@ -3171,6 +3202,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		/* Also include needed rename limit adjustment now */
 		diff_warn_rename_limit("merge.renamelimit",
 				       opti->renames.needed_limit, 0);
+
+		trace2_region_leave("merge", "display messages", opt->repo);
 	}
 
 	merge_finalize(opt, result);
@@ -3212,6 +3245,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	int i;
 
 	/* Sanity checks on opt */
+	trace2_region_enter("merge", "sanity checks", opt->repo);
 	assert(opt->repo);
 
 	assert(opt->branch1 && opt->branch2);
@@ -3250,11 +3284,13 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 		assert(!opt->priv->toplevel_dir ||
 		       0 == strlen(opt->priv->toplevel_dir));
 	}
+	trace2_region_leave("merge", "sanity checks", opt->repo);
 
 	/* Default to histogram diff.  Actually, just hardcode it...for now. */
 	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
 
 	/* Initialization of opt->priv, our internal merge data */
+	trace2_region_enter("merge", "allocate/init", opt->repo);
 	if (opt->priv) {
 		clear_or_reinit_internal_opts(opt->priv, 1);
 		trace2_region_leave("merge", "allocate/init", opt->repo);
@@ -3292,6 +3328,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * subset of the overall paths that have special output.
 	 */
 	strmap_init(&opt->priv->output);
+
+	trace2_region_leave("merge", "allocate/init", opt->repo);
 }
 
 /*** Function Grouping: merge_incore_*() and their internal variants ***/
@@ -3307,6 +3345,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 {
 	struct object_id working_tree_oid;
 
+	trace2_region_enter("merge", "collect_merge_info", opt->repo);
 	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
 		/*
 		 * TRANSLATORS: The %s arguments are: 1) tree hash of a merge
@@ -3319,10 +3358,16 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 		result->clean = -1;
 		return;
 	}
+	trace2_region_leave("merge", "collect_merge_info", opt->repo);
 
+	trace2_region_enter("merge", "renames", opt->repo);
 	result->clean = detect_and_process_renames(opt, merge_base,
 						   side1, side2);
+	trace2_region_leave("merge", "renames", opt->repo);
+
+	trace2_region_enter("merge", "process_entries", opt->repo);
 	process_entries(opt, &working_tree_oid);
+	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
 	result->tree = parse_tree_indirect(&working_tree_oid);
@@ -3423,9 +3468,15 @@ void merge_incore_nonrecursive(struct merge_options *opt,
 			       struct tree *side2,
 			       struct merge_result *result)
 {
+	trace2_region_enter("merge", "incore_nonrecursive", opt->repo);
+
+	trace2_region_enter("merge", "merge_start", opt->repo);
 	assert(opt->ancestor != NULL);
 	merge_start(opt, result);
+	trace2_region_leave("merge", "merge_start", opt->repo);
+
 	merge_ort_nonrecursive_internal(opt, merge_base, side1, side2, result);
+	trace2_region_leave("merge", "incore_nonrecursive", opt->repo);
 }
 
 void merge_incore_recursive(struct merge_options *opt,
@@ -3434,9 +3485,15 @@ void merge_incore_recursive(struct merge_options *opt,
 			    struct commit *side2,
 			    struct merge_result *result)
 {
+	trace2_region_enter("merge", "incore_recursive", opt->repo);
+
 	/* We set the ancestor label based on the merge_bases */
 	assert(opt->ancestor == NULL);
 
+	trace2_region_enter("merge", "merge_start", opt->repo);
 	merge_start(opt, result);
+	trace2_region_leave("merge", "merge_start", opt->repo);
+
 	merge_ort_internal(opt, merge_bases, side1, side2, result);
+	trace2_region_leave("merge", "incore_recursive", opt->repo);
 }
-- 
2.30.0.135.g7f7d4a3e17

