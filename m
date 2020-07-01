Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E2C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95718206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfmzwDi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgGAN1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgGAN1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1BC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so22415032wmh.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bpSd26JJkwHub2tc4EIPsr3GA8o9y6QaWhV9MFml6bY=;
        b=JfmzwDi/uI/ov7PkCDmIP44FzFYuNODI8sRU/dYFR+GbJlC7/HXsZfbFuAx+RzEenA
         38HdwxRGope0qhBaDtPKNmwvLiAB5oIJOov5miiVk6O90IKG97p7F4jY4u0i6qZFYmo6
         b0j3Sp2jnsVWNsSedX1uN6jl0FXhO8VJs1vnuxXwBJXSMisrFyT3py5h0UmoYeECnN3/
         kZaA/6Eom0ATpqOkllMwzGwsJIzEbAFMu6U8AqnY5PGsVPVe+VPCrhLVnEHry9QMwar6
         HNVad9hk/JpMgCj2aB5o6piUdfYpktt/GsWpdNQ1q3kxmGqWv6veJkmG8avmTLnrA3wN
         0UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=bpSd26JJkwHub2tc4EIPsr3GA8o9y6QaWhV9MFml6bY=;
        b=CoJrr4+kq4s4mmEfsHb7PXyvTfueYp/N5bE5tAR7WkWKQ6anZKzEGZdhh+odXpe2yJ
         b+VUNNsN60rHlVzlFPxd6Vp6OuMNgcCWq/804/bCC1KO3A2qsreZ5FkDls8Xi4PjnTV9
         8Jy9zwhI6d0ha+5aQ01GtTzl5o3yJ36zchSg29CLG67x45ypksWP2FVXw52K2HXmK14k
         ohFBf3CLrv14MBWCjEGjJghlp07hr27QMXtot9++cv9bP642omSNmBROJ2e9BdsKzMSA
         HTe5avQtv4WB5q0Nf21hJTmcRPyI42npBYenaAtVU84wqe2ciYNA3CUkFo4YZUAYm6Mv
         wcNw==
X-Gm-Message-State: AOAM5320Hvf+27vUFZ2X2hUJYJWGqgUZ/F85T78OCpO5pnKFeyMSLOCz
        p9JyJx7FgfAgn7ptYhCTMQmUNCbm
X-Google-Smtp-Source: ABdhPJxISscfgs81Fp1NzmuvOyi47jMxFhHkHWPBTMhBZ0hECEXv5bkSW04tgdPWavSnNhXpxfWfdg==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr27054127wme.139.1593610051974;
        Wed, 01 Jul 2020 06:27:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm7496199wru.4.2020.07.01.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:31 -0700 (PDT)
Message-Id: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:20 +0000
Subject: [PATCH v4 00/10] More commit-graph/Bloom filter improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This builds on sg/commit-graph-cleanups, which took several patches from
Szeder's series [1] and applied them almost directly to a more-recent
version of Git [2].

[1] https://lore.kernel.org/git/20200529085038.26008-1-szeder.dev@gmail.com/
[2] 
https://lore.kernel.org/git/pull.650.git.1591362032.gitgitgadget@gmail.com/

This series adds a few extra improvements, several of which are rooted in
Szeder's original series. I maintained his authorship and sign-off, even
though the patches did not apply or cherry-pick at all.

(In v2, I have removed the range-diff comparison to Szeder's series, so look
at the v1 cover letter for that.)

The patches have been significantly reordered. René pointed out (and Szeder
discovered in the old thread) that we are not re-using the
bloom_filter_settings from the existing commit-graph when writing a new one.

 1. commit-graph: place bloom_settings in context
 2. commit-graph: change test to die on parse, not load

These are mostly the same, except we now use a pointer to the settings in
the commit-graph write context.

 3. bloom: get_bloom_filter() cleanups

This new patch is a subtle change in behavior that will become relevant in
the very next patch. In fact, if we swap patch 3 and 4, then
t4216-log-bloom.sh fails with a segfault due to a NULL filter.

 4. commit-graph: persist existence of changed-paths

This patch is now updated to use the existing changed-path filter settings.

 5. commit-graph: unify the signatures of all write_graph_chunk_*()
    functions
 6. commit-graph: simplify chunk writes into loop
 7. commit-graph: check chunk sizes after writing

These are all the same as before.

 8. revision.c: fix whitespace

This patch is the cleanup part of Taylor's patch.

 9. revision: empty pathspecs should not use Bloom filters

Here is Taylor's fix for empty pathspecs.

 10. commit-graph: check all leading directories in changed path Bloom
     filters
 11. bloom: enforce a minimum size of 8 bytes

Finally, we get these performance patches. Patch 10 is updated to have the
better logic around directory separators and empty paths. Also, the list of
Bloom keys is ordered with the deepest path first. That has some tiny
performance benefits for deep paths since we can short-circuit the multi-key
checks more often. That code path is much faster than the tree parsing, so
it is hard to measure any change.

Updates in V3:

 * Responded to René's feedback.
 * Fixed the test in Patch 4 to use GIT_TEST_ variables and extend the
   GIT_TRACE2 depth to work with 'seen' branch.

Update in V4;

 * Fixed the bug with "too large" commits. Test is added. The fixup! I sent
   earlier doesn't actually squash cleanly, so I resolved the conflicts
   during the rebase.

Thanks, -Stolee

Derrick Stolee (5):
  commit-graph: place bloom_settings in context
  commit-graph: change test to die on parse, not load
  bloom: fix logic in get_bloom_filter()
  commit-graph: persist existence of changed-paths
  revision.c: fix whitespace

SZEDER Gábor (4):
  commit-graph: unify the signatures of all write_graph_chunk_*()
    functions
  commit-graph: simplify chunk writes into loop
  commit-graph: check chunk sizes after writing
  commit-graph: check all leading directories in changed path Bloom
    filters

Taylor Blau (1):
  revision: empty pathspecs should not use Bloom filters

 Documentation/git-commit-graph.txt |   5 +-
 bloom.c                            |  14 ++-
 builtin/commit-graph.c             |   5 +-
 commit-graph.c                     | 146 +++++++++++++++++++++--------
 commit-graph.h                     |   3 +-
 revision.c                         |  63 +++++++++----
 revision.h                         |   6 +-
 t/t4216-log-bloom.sh               |  45 ++++++++-
 t/t5318-commit-graph.sh            |   2 +-
 9 files changed, 215 insertions(+), 74 deletions(-)


base-commit: 7fbfe07ab4d4e58c0971dac73001b89f180a0af3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-659%2Fderrickstolee%2Fbloom-2-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-659/derrickstolee/bloom-2-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/659

Range-diff vs v3:

  1:  57002040bc =  1:  57002040bc commit-graph: place bloom_settings in context
  2:  6b63f9bd8a =  2:  6b63f9bd8a commit-graph: change test to die on parse, not load
  3:  2f809499ab !  3:  3c532ebabc bloom: fix logic in get_bloom_filter()
     @@ Commit message
      
          Also clean up some style issues while we are here.
      
     +    One side-effect of returning a NULL filter is that the filters that are
     +    reported as "too large" will now be reported as NULL insead of length
     +    zero. This case was not properly covered before, so add a test. Further,
     +    remote the counting of the zero-length filters from revision.c and the
     +    trace2 logs.
     +
          Helped-by: René Scharfe <l.s.r@web.de>
     +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## bloom.c ##
     @@ bloom.c: struct bloom_filter *get_bloom_filter(struct repository *r,
       
       	repo_diff_setup(r, &diffopt);
       	diffopt.flags.recursive = 1;
     +
     + ## commit-graph.c ##
     +@@ commit-graph.c: static void write_graph_chunk_bloom_indexes(struct hashfile *f,
     + 
     + 	while (list < last) {
     + 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
     +-		cur_pos += filter->len;
     ++		size_t len = filter ? filter->len : 0;
     ++		cur_pos += len;
     + 		display_progress(progress, ++i);
     + 		hashwrite_be32(f, cur_pos);
     + 		list++;
     +@@ commit-graph.c: static void write_graph_chunk_bloom_data(struct hashfile *f,
     + 
     + 	while (list < last) {
     + 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
     ++		size_t len = filter ? filter->len : 0;
     + 		display_progress(progress, ++i);
     +-		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
     ++
     ++		if (len)
     ++			hashwrite(f, filter->data, len * sizeof(unsigned char));
     + 		list++;
     + 	}
     + 
     +
     + ## revision.c ##
     +@@ revision.c: static unsigned int count_bloom_filter_maybe;
     + static unsigned int count_bloom_filter_definitely_not;
     + static unsigned int count_bloom_filter_false_positive;
     + static unsigned int count_bloom_filter_not_present;
     +-static unsigned int count_bloom_filter_length_zero;
     + 
     + static void trace2_bloom_filter_statistics_atexit(void)
     + {
     +@@ revision.c: static void trace2_bloom_filter_statistics_atexit(void)
     + 
     + 	jw_object_begin(&jw, 0);
     + 	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_present);
     +-	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_zero);
     + 	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
     + 	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_not);
     + 	jw_object_intmax(&jw, "false_positive", count_bloom_filter_false_positive);
     +@@ revision.c: static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
     + 		return -1;
     + 	}
     + 
     +-	if (!filter->len) {
     +-		count_bloom_filter_length_zero++;
     +-		return -1;
     +-	}
     +-
     + 	result = bloom_filter_contains(filter,
     + 				       revs->bloom_key,
     + 				       revs->bloom_filter_settings);
     +
     + ## t/t4216-log-bloom.sh ##
     +@@ t/t4216-log-bloom.sh: setup () {
     + 
     + test_bloom_filters_used () {
     + 	log_args=$1
     +-	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"zero_length_filter\":0,\"maybe\""
     ++	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"maybe\""
     + 	setup "$log_args" &&
     + 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
     + 	test_cmp log_wo_bloom log_w_bloom &&
     +@@ t/t4216-log-bloom.sh: test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
     + 
     + test_bloom_filters_used_when_some_filters_are_missing () {
     + 	log_args=$1
     +-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":8,\"definitely_not\":6"
     ++	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":8,\"definitely_not\":6"
     + 	setup "$log_args" &&
     + 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
     + 	test_cmp log_wo_bloom log_w_bloom
     +@@ t/t4216-log-bloom.sh: test_expect_success 'Use Bloom filters if they exist in the latest but not all c
     + 	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
     + '
     + 
     ++test_expect_success 'correctly report changes over limit' '
     ++	git init 513changes &&
     ++	(
     ++		cd 513changes &&
     ++		for i in $(test_seq 1 513)
     ++		do
     ++			echo $i >file$i.txt || return 1
     ++		done &&
     ++		git add . &&
     ++		git commit -m "files" &&
     ++		git commit-graph write --reachable --changed-paths &&
     ++		for i in $(test_seq 1 513)
     ++		do
     ++			git -c core.commitGraph=false log -- file$i.txt >expect &&
     ++			git log -- file$i.txt >actual &&
     ++			test_cmp expect actual || return 1
     ++		done
     ++	)
     ++'
     ++
     + test_done
     + \ No newline at end of file
  4:  33e22d05cb !  4:  f1e3a8516e commit-graph: persist existence of changed-paths
     @@ t/t4216-log-bloom.sh: test_expect_success 'Use Bloom filters if they exist in th
      +	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
      +'
      +
     - test_done
     - \ No newline at end of file
     + test_expect_success 'correctly report changes over limit' '
     + 	git init 513changes &&
     + 	(
  5:  81c45d5260 =  5:  c079921473 commit-graph: unify the signatures of all write_graph_chunk_*() functions
  6:  8828dcd906 =  6:  5ed0ce20a4 commit-graph: simplify chunk writes into loop
  7:  ddbf297755 =  7:  b982c9bf80 commit-graph: check chunk sizes after writing
  8:  8b63706141 =  8:  af750d8887 revision.c: fix whitespace
  9:  7d6163305a =  9:  a95de3cceb revision: empty pathspecs should not use Bloom filters
 10:  40061233ca ! 10:  9c4a00ab08 commit-graph: check all leading directories in changed path Bloom filters
     @@ t/t4216-log-bloom.sh: test_expect_success 'setup - add commit-graph to the chain
       
       test_bloom_filters_used_when_some_filters_are_missing () {
       	log_args=$1
     --	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":8,\"definitely_not\":6"
     -+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":8"
     +-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":8,\"definitely_not\":6"
     ++	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":8"
       	setup "$log_args" &&
       	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
       	test_cmp log_wo_bloom log_w_bloom

-- 
gitgitgadget
