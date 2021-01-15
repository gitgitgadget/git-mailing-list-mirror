Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A07C43381
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1763423A9D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbhAOTaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388567AbhAOTaw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 14:30:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1EDC0613C1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 11:30:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id h10so6105851pfo.9
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 11:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKz1PXT9CF9hRZmtjIem7hOh2R8WpMMpzGLt2mmTANI=;
        b=cDMblizsafdSc2zyURdbZy4c+fO7TJJFuu0Fj20Nv2hF5pVSmVRbH/LhyDHXVLhGQd
         dQLU4EkABMa6TznV/roEL07/rKNs5rjBYECY9iMvqzZNlm4T/JaeRVUqw0B6ymbeeYmb
         hUXR1FtohIidiYtN+oksYawDUJubj4iqHX/HGEZ5kZ6SpBgcFoOFHfhZWZkNkb7CrYSZ
         /rBbTLf+vd4dwgRtxj8jVqPNXArZsvQDdj2Sg4tRIIYhhchqNgk5E0av2reyyqFba7/A
         sAbH2X3DEXZSrjs5YoeGSCCUxhwqz2BgKpVZPF98qoZ+YnYEAoV0BWpkxzWw5HHNjhHP
         KWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKz1PXT9CF9hRZmtjIem7hOh2R8WpMMpzGLt2mmTANI=;
        b=WZBGyyyyQoE0flc/cBnL2NMlgWtUSUfG7tVNYcTpxs9zuWgocMyOJDN1z00rN/bOII
         Pf9aOcqH7BLDVQvwUzGdOdFouUVHZjgG3i/gOYhoXxF0Y5uRXLsHnKxH6yPhoMcgx8J3
         gkmzgAbi27TAhZy7SNINDpkCMeulEwx0Ax+ScY7ONuayA3yRaAMFNIZC9K/A07jkAHbG
         UVftCnmUNQQG55Y3z20DC2W4hATbalxAnvtLt2EDT5/mT9u45bTJZnRn4k5IzESzWBLC
         O9yAEdIOP9jEkMDY5WfcTLWhaKAav0O9Mps2HmZ/UhQqwo4+GjgRQlv9DzmdTqWFLxKM
         wBsw==
X-Gm-Message-State: AOAM530bMcCaEuOFrRVsfTeAvuGBkrQGT0dBGbKfR7lYAzfi7ilqwFM5
        tdYFV50hc1GF1oOufeXgSIrQuxMYFGc=
X-Google-Smtp-Source: ABdhPJyMpNb800t+i4zr4qVJHN34mNhJil6+pfbYcJmwVj2Osx4s9hyHKaqTb/Pf5v+cA4pZnpDnWw==
X-Received: by 2002:a63:b18:: with SMTP id 24mr14272091pgl.160.1610739010889;
        Fri, 15 Jan 2021 11:30:10 -0800 (PST)
Received: from tiger.hsd1.ca.comcast.net ([2601:646:8d80:9ab0:f634:2e28:1242:da6])
        by smtp.gmail.com with ESMTPSA id fh7sm8625657pjb.43.2021.01.15.11.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:30:10 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        Sangeeta <sangunb09@gmail.com>, Elijah Newren <newren@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Subject: [PATCH v3 1/1] merge-ort: begin performance work; instrument with trace2_region_* calls
Date:   Fri, 15 Jan 2021 11:29:58 -0800
Message-Id: <20210115192958.3336755-2-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.551.g3e6b12e63d.dirty
In-Reply-To: <20210115192958.3336755-1-newren@gmail.com>
References: <20210113221158.2869128-1-newren@gmail.com>
 <20210115192958.3336755-1-newren@gmail.com>
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

                  merge-recursive         merge-ort
  no-renames:        18.912 s ±  0.174 s    12.975 s ±  0.037 s
  mega-renames:    5964.031 s ± 10.459 s  5154.338 s ± 19.139 s
  just-one-mega:    149.583 s ±  0.751 s   146.703 s ±  0.852 s

A single re-run of each with some breakdowns:

                                  ---  no-renames  ---
                            merge-recursive   merge-ort
  overall runtime:              19.302 s        13.017 s
  inexact rename detection:      7.603 s         7.695 s
  everything else:              11.699 s         5.322 s

                                  --- mega-renames ---
                            merge-recursive   merge-ort
  overall runtime:            5950.195 s      5132.851 s
  inexact rename detection:   5746.309 s      5119.215 s
  everything else:             203.886 s        13.636 s

                                  --- just-one-mega ---
                            merge-recursive   merge-ort
  overall runtime:             151.001 s       146.478 s
  inexact rename detection:    143.448 s       145.901 s
  everything else:               7.553 s         0.577 s

=== Timing observations ===

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
drop to about 204s, and the merge-ort time would drop to about 14s.  I
think this particular stat shows I've subtly baked a couple performance
improvements into merge-ort[A] (one of them large) and into
fast-rebase[B] already.

    [A] Avoid quadratic behavior with O(N) insertions or removals
	of entries in the index & avoid unconditional dropping and
        re-reading of the index
    [B] Avoid updating the on-disk index or the working directory
        for intermediate patches -- only update at the end

2b) rename-detection is somehow ~10% cheaper for merge-ort than
merge-recursive.  This was and is a big surprise to me.  Both of them
call diff_tree_oid() and diffcore_std() with the EXACT same inputs.  I
don't have an explanation, but it is very consistent even after
re-running many times.  Interestingly, the rename detection for the
first patch is more expensive (just barely) for merge-ort than
merge-recursive, and that is also consistent.  I won't investigate this
further, as I'm just going to focus on 1a & 2a.

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
index 8f4ca4fe83..0f3ad78f3c 100644
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
@@ -2095,9 +2097,12 @@ static void detect_regular_renames(struct merge_options *opt,
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
@@ -2196,9 +2201,12 @@ static int detect_and_process_renames(struct merge_options *opt,
 
 	memset(&combined, 0, sizeof(combined));
 
+	trace2_region_enter("merge", "regular renames", opt->repo);
 	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
 	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
+	trace2_region_leave("merge", "regular renames", opt->repo);
 
+	trace2_region_enter("merge", "directory renames", opt->repo);
 	need_dir_renames =
 	  !opt->priv->call_depth &&
 	  (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE ||
@@ -2220,8 +2228,11 @@ static int detect_and_process_renames(struct merge_options *opt,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
 	QSORT(combined.queue, combined.nr, compare_pairs);
+	trace2_region_leave("merge", "directory renames", opt->repo);
 
+	trace2_region_enter("merge", "process renames", opt->repo);
 	clean &= process_renames(opt, &combined);
+	trace2_region_leave("merge", "process renames", opt->repo);
 
 	/* Free memory for renames->pairs[] and combined */
 	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
@@ -2903,20 +2914,30 @@ static void process_entries(struct merge_options *opt,
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
@@ -2927,6 +2948,7 @@ static void process_entries(struct merge_options *opt,
 	 * (because it allows us to know whether the directory is still in
 	 * the way when it is time to process the file at the same path).
 	 */
+	trace2_region_enter("merge", "processing", opt->repo);
 	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
 		char *path = entry->string;
 		/*
@@ -2945,7 +2967,9 @@ static void process_entries(struct merge_options *opt,
 			process_entry(opt, path, ci, &dir_metadata);
 		}
 	}
+	trace2_region_leave("merge", "processing", opt->repo);
 
+	trace2_region_enter("merge", "process_entries cleanup", opt->repo);
 	if (dir_metadata.offsets.nr != 1 ||
 	    (uintptr_t)dir_metadata.offsets.items[0].util != 0) {
 		printf("dir_metadata.offsets.nr = %d (should be 1)\n",
@@ -2960,6 +2984,7 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
 	string_list_clear(&dir_metadata.offsets, 0);
+	trace2_region_leave("merge", "process_entries cleanup", opt->repo);
 }
 
 /*** Function Grouping: functions related to merge_switch_to_result() ***/
@@ -3118,12 +3143,15 @@ void merge_switch_to_result(struct merge_options *opt,
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
@@ -3131,6 +3159,7 @@ void merge_switch_to_result(struct merge_options *opt,
 			result->clean = -1;
 			return;
 		}
+		trace2_region_leave("merge", "record_conflicted", opt->repo);
 	}
 
 	if (display_update_msgs) {
@@ -3140,6 +3169,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		struct string_list olist = STRING_LIST_INIT_NODUP;
 		int i;
 
+		trace2_region_enter("merge", "display messages", opt->repo);
+
 		/* Hack to pre-allocate olist to the desired size */
 		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
 			   olist.alloc);
@@ -3161,6 +3192,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		/* Also include needed rename limit adjustment now */
 		diff_warn_rename_limit("merge.renamelimit",
 				       opti->renames.needed_limit, 0);
+
+		trace2_region_leave("merge", "display messages", opt->repo);
 	}
 
 	merge_finalize(opt, result);
@@ -3202,6 +3235,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	int i;
 
 	/* Sanity checks on opt */
+	trace2_region_enter("merge", "sanity checks", opt->repo);
 	assert(opt->repo);
 
 	assert(opt->branch1 && opt->branch2);
@@ -3228,11 +3262,13 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	assert(opt->obuf.len == 0);
 
 	assert(opt->priv == NULL);
+	trace2_region_leave("merge", "sanity checks", opt->repo);
 
 	/* Default to histogram diff.  Actually, just hardcode it...for now. */
 	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
 
 	/* Initialization of opt->priv, our internal merge data */
+	trace2_region_enter("merge", "allocate/init", opt->repo);
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 
 	/* Initialization of various renames fields */
@@ -3265,6 +3301,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * subset of the overall paths that have special output.
 	 */
 	strmap_init(&opt->priv->output);
+
+	trace2_region_leave("merge", "allocate/init", opt->repo);
 }
 
 /*** Function Grouping: merge_incore_*() and their internal variants ***/
@@ -3280,6 +3318,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 {
 	struct object_id working_tree_oid;
 
+	trace2_region_enter("merge", "collect_merge_info", opt->repo);
 	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
 		/*
 		 * TRANSLATORS: The %s arguments are: 1) tree hash of a merge
@@ -3292,10 +3331,16 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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
@@ -3396,9 +3441,15 @@ void merge_incore_nonrecursive(struct merge_options *opt,
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
@@ -3407,9 +3458,15 @@ void merge_incore_recursive(struct merge_options *opt,
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
2.29.2.506.ga68ba46ed0.dirty

