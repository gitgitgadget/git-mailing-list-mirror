Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7492BC11F67
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565A0610CB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhGMTgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhGMTf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:35:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA41AC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso3109509wmj.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=hZP7uk+qJCuimmRS7dbpfjEso1nqC0L0Y8F4jEarQEs=;
        b=eJUDWGE6onMZ5D0oNMJrAqCEjXXtGHEMXzwmVz8lHm1rtBke+n/uR86QfuJgihBXKj
         c7O6YIM5l5Yg7yB1uSfp1jY1vRA3Pfds825WZn7PFQ1pRU+NsJMIEM8ThyIk3TNlthnl
         aApMQf7pH/Z1bdYaRCOOecLX9toNQlqj/0SQpWzMiRi6JNtFmli/KK7z5hs/yX/wQiqi
         LieZdjPesqTy8/ruT8QKATnKKeiap1dt/2l2MN2v9bA831weVQCd4X2fU9UbivlxhiS6
         9SGzkFVotShlrnPH2BJOg/4olxP7x+Pe7IotEa4N0RDCNIsJM1QlIA/xqvyyq/XfXL7C
         FGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=hZP7uk+qJCuimmRS7dbpfjEso1nqC0L0Y8F4jEarQEs=;
        b=I6KK5736fjeY6D1PofquzkDGWi1sXfBjGVPboZwb7x/XKWMD6J1Fn0IkgtRDHPsj+N
         St2XKauHihSPvY8WUJVlLk/pWCcBFVjIoVjC6qZT6h8vgVg3FypS6YqDWxO3pAef0MuJ
         94ihnktH8wxGZ/FQYttPUvonMXlMHAApsHhZAL8a6FDYQaxm7BNIiPJFhh7CkfMGUz8v
         4A8ajSJJ5mk92NfEEr2GWS2+ZA8ViJK4BotxrP9LMlyL5tFxYk1vTqduUHXB3y7qd8d1
         VduEpkvaFjdT337VII1AV5mRo7HLBNr12XMpIfvPXXaaypiji7S5usSapDoSPKejTrIB
         sLnA==
X-Gm-Message-State: AOAM531ipwV0WXdZj415FoLXDVXLCGZnNlfbMp5Sj4xbEZTEWEkyFF0G
        OqMRqFvLP7T9H3CP/YUIVLpGZOR4VDs=
X-Google-Smtp-Source: ABdhPJywZz1S3iAt1B/7gRYfyNccDS9X46YXSdG04pG7gLrCfC3QpnH5tG3QBukTpbaeNb7YwH4G3w==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr1061924wmf.110.1626204785864;
        Tue, 13 Jul 2021 12:33:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm3173683wmg.46.2021.07.13.12.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:33:05 -0700 (PDT)
Message-Id: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.git.1625111177.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 19:32:56 +0000
Subject: [PATCH v2 0/7] Optimization batch 14: trivial directory resolution
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This is mostly unchanged since v1; I'm primarily resending since it's been
two weeks and I want to bump it so folks have a chance to notice and review
it. But there was one change, noted below.]

This series depends textually on ort-perf-batch-12, but is semantically
independent. (It is both semantically and textually independent of
ort-perf-batch-13.)

Most of my previous series dramatically accelerated cases with lots of
renames, while providing comparatively minor benefits for cases with few or
no renames. This series is the opposite; it provides huge benefits when
there are few or no renames, and comparatively smaller (though still quite
decent) benefits for cases with many uncached renames.

Changes since v1:

 * Minor tweak to the final patch to correct implicit assumption that rename
   detection running implies all renames were found (rename limits could
   have been exceeded and prevented finding renames)

=== Basic Optimization idea ===

unpack_trees has had a concept of trivial merges for individual files (see
Documentation/technical/trivial-merge.txt). The same idea can be applied in
merge-ort. It'd be really nice to extend that idea to trees as well, as it
could provide a huge performance boost; sadly however, applying it in
general would wreck both regular rename detection (the unmatched side can
have new files that serve as potential destinations in rename detection) and
directory rename detection (the unmatched side could have a new directory
that was moved into it).

If we somehow knew rename detection wasn't needed, we could do trivial
directory resolution. In the past, this wasn't possible. However...

With recent optimizations we have created a possibility to do trivial
directory resolutions in some cases. These came from the addition of the
"skipping irrelevant renames" optimizations (from ort-perf-batch-9 and
ort-perf-batch-10), and in particular noting that we added an ability to
entirely skip rename detection in commit f89b4f2bee ("merge-ort: skip rename
detection entirely if possible", 2021-03-11) when there are no relevant
sources. We can detect if there are no relevant sources without recursing
into the directories in question.

As a cherry on top, the caching of renames (from ort-perf-batch-11) allows
us to cover additional cases.

This series is all about adding all the special checks needed to safely
perform trival directory resolutions.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.235 s ±  0.042 s   204.2  ms ±  3.0  ms
mega-renames:      9.419 s ±  0.107 s     1.076 s ±  0.015 s
just-one-mega:   480.1  ms ±  3.9  ms   364.1  ms ±  7.0  ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (for merge-recursive as of git-2.30.0)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


Elijah Newren (7):
  merge-ort: resolve paths early when we have sufficient information
  merge-ort: add some more explanations in collect_merge_info_callback()
  merge-ort: add data structures for allowable trivial directory
    resolves
  merge-ort: add a handle_deferred_entries() helper function
  merge-ort: defer recursing into directories when merge base is matched
  merge-ort: avoid recursing into directories when we don't need to
  merge-ort: restart merge with cached renames to reduce process entry
    cost

 merge-ort.c                         | 408 +++++++++++++++++++++++++++-
 t/t6423-merge-rename-directories.sh |   2 +-
 2 files changed, 398 insertions(+), 12 deletions(-)


base-commit: 2eeee12b02e441ac05054a5a5ecbcea6964a1e6b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-988%2Fnewren%2Fort-perf-batch-14-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-988/newren/ort-perf-batch-14-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/988

Range-diff vs v1:

 1:  5dca982c0b = 1:  5dca982c0b merge-ort: resolve paths early when we have sufficient information
 2:  8aea371390 = 2:  8aea371390 merge-ort: add some more explanations in collect_merge_info_callback()
 3:  f7ac01055d = 3:  f7ac01055d merge-ort: add data structures for allowable trivial directory resolves
 4:  7e28323b62 = 4:  7e28323b62 merge-ort: add a handle_deferred_entries() helper function
 5:  317553eadb = 5:  317553eadb merge-ort: defer recursing into directories when merge base is matched
 6:  3409a6cd63 = 6:  3409a6cd63 merge-ort: avoid recursing into directories when we don't need to
 7:  76bc73262c ! 7:  7133f0efa5 merge-ort: restart merge with cached renames to reduce process entry cost
     @@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
       	}
       
       	partial_clear_dir_rename_count(&renames->dir_rename_count[side_index]);
     +@@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
     + 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
     + 	resolve_diffpair_statuses(&diff_queued_diff);
     + 
     ++	if (diff_opts.needed_rename_limit > 0)
     ++		renames->redo_after_renames = 0;
     + 	if (diff_opts.needed_rename_limit > renames->needed_limit)
     + 		renames->needed_limit = diff_opts.needed_rename_limit;
     + 
      @@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
       	diff_queued_diff.nr = 0;
       	diff_queued_diff.queue = NULL;
       	diff_flush(&diff_opts);
      +
     -+	if (renames->redo_after_renames) {
     -+		int i;
     -+		struct diff_filepair *p;
     -+
     -+		renames->redo_after_renames = 2;
     -+		for (i = 0; i < renames->pairs[side_index].nr; ++i) {
     -+			p = renames->pairs[side_index].queue[i];
     -+			possibly_cache_new_pair(renames, p, side_index, NULL);
     -+		}
     -+	}
      +	return 1;
       }
       
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      +	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
      +	detection_run |= detect_regular_renames(opt, MERGE_SIDE2);
      +	if (renames->redo_after_renames && detection_run) {
     ++		int i, side;
     ++		struct diff_filepair *p;
     ++
     ++		/* Cache the renames, we found */
     ++		for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
     ++			for (i = 0; i < renames->pairs[side].nr; ++i) {
     ++				p = renames->pairs[side].queue[i];
     ++				possibly_cache_new_pair(renames, p, side, NULL);
     ++			}
     ++		}
     ++
     ++		/* Restart the merge with the cached renames */
     ++		renames->redo_after_renames = 2;
      +		trace2_region_leave("merge", "regular renames", opt->repo);
      +		goto cleanup;
      +	}

-- 
gitgitgadget
