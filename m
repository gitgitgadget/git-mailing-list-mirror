Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3302C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD0922571
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbhAXGCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 01:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbhAXGCW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 01:02:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64915C061573
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so5641776plr.9
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8t/EsjlAOkB5pL5f/M8C+YopIGp/BrdV42yNdQFSwE=;
        b=XqfoBqvK2RytYsDF1aGdMAGg77fBBvGE4mrjvID5va+Mt565FGPNRxnzjyYpnJCuc0
         yu/BLozkz32WeutREJQQN+BoPdZzUv1cr8YGWliXjb3SPBsIfllRVgMb23ocWGi8P5qu
         2jvEppag9VZ7AXKBd+MD9Xtxqvrx7YXh6m3/lw6M8gN2YAKzH4xcWeiA37bN9JkF0O+V
         bh+3hFq1fdImRLf9D9UMgqJM00OHyzaIQbRvFCTLUTId/bkoXNUgasU+PV88X8pdJamm
         cT8EsUQzJNcbM/mU7d7hfSMnKqZ1bcZDP9BbdmWF4lVlvFFV439r0sbaDqqStY/KfzEL
         5eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8t/EsjlAOkB5pL5f/M8C+YopIGp/BrdV42yNdQFSwE=;
        b=tmKCKM/qSg6buPvnJl+Qb54Gwr3PUxengZhDdzc+2WMYWaVA4zNxMpLxpED2gP5pNy
         5PzBnYDYOXFn6O07+x9RmkQgSp8CTLwHBt8Rauwow05698YemV01/qFAtcvK0rdOW4pR
         7lKJ0HK8/rD6gSneXkm22bpVf/DiLuUQMoHWRM8LBcR99i65U2TCJLQ4XgWRKF8F9Jlf
         TmHb+B4fXZLvKELy3LksNVRshPcro0diKsHM1t1044TVDzMohlgkq9+lBgtX0pfpnEYy
         9oDK2b5XPaRzWqBcB8l0s9mQzNwwHBUhkX6Ms4vR3iW5trQOvHd29ySf9doCJvclrWYE
         6rwg==
X-Gm-Message-State: AOAM532/a8TWWDrnNeEDAsWrM256LT+0ZbeNrQVoWZqUPm8R1oL33MRU
        8PIgxKkUbIIeEYMZ365VvITGqT/pFMU=
X-Google-Smtp-Source: ABdhPJx1Rp5dyA4AQJLKgTNCXWdxVldMyAGj7B4FgTdsnqjLUmv6UPtCay+thTjZlMcgqK0ggIGoRw==
X-Received: by 2002:a17:90a:1e65:: with SMTP id w92mr14805172pjw.64.1611468098438;
        Sat, 23 Jan 2021 22:01:38 -0800 (PST)
Received: from tiger.hsd1.ca.comcast.net ([2601:646:8d80:9ab0:f634:2e28:1242:da6])
        by smtp.gmail.com with ESMTPSA id i26sm13275331pfq.219.2021.01.23.22.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 22:01:37 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 0/3] And so it begins...merge/rename performance work
Date:   Sat, 23 Jan 2021 22:01:09 -0800
Message-Id: <20210124060112.1258291-1-newren@gmail.com>
X-Mailer: git-send-email 2.30.0.135.g7f7d4a3e17
In-Reply-To: <20210115192958.3336755-1-newren@gmail.com>
References: <20210115192958.3336755-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This depends on a merge of en/ort-conflict-handling, en/diffcore-rename,
and en/ort-directory-rename.

Changes since v3:
  * Add a couple preliminary patches needed for later performance work,
    including fixing a big memory leak (in some series that has already
    been merged to master, I should have included a small additional
    section of code from my 'ort' branch, but I overlooked it).
  * Update the performance numbers in the commit message of the final
    patch based on the changes; the memory leak makes a noticeable
    difference on the overall timings since it basically represents
    a combination of all the data allocated during the merge algorithm.

Elijah Newren (3):
  merge-ort: fix massive leak
  merge-ort: ignore the directory rename split conflict for now
  merge-ort: begin performance work; instrument with trace2_region_*
    calls

 diffcore-rename.c |  8 +++++
 merge-ort.c       | 87 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 1 deletion(-)

Range-diff:
-:  ---------- > 1:  549a63cd2a merge-ort: fix massive leak
-:  ---------- > 2:  817a197dbc merge-ort: ignore the directory rename split conflict for now
1:  36d1f87d05 ! 3:  7f7d4a3e17 merge-ort: begin performance work; instrument with trace2_region_* calls
    @@ Commit message
         Overall timings, using hyperfine (1 warmup run, 3 runs for mega-renames,
         10 runs for the other two cases):
     
    -                      merge-recursive         merge-ort
    -      no-renames:        18.912 s ±  0.174 s    12.975 s ±  0.037 s
    -      mega-renames:    5964.031 s ± 10.459 s  5154.338 s ± 19.139 s
    -      just-one-mega:    149.583 s ±  0.751 s   146.703 s ±  0.852 s
    +                           merge-recursive           merge-ort
    +        no-renames:       18.912 s ±  0.174 s    14.263 s ±  0.053 s
    +        mega-renames:   5964.031 s ± 10.459 s  5504.231 s ±  5.150 s
    +        just-one-mega:   149.583 s ±  0.751 s   158.534 s ±  0.498 s
     
         A single re-run of each with some breakdowns:
     
    -                                      ---  no-renames  ---
    -                                merge-recursive   merge-ort
    -      overall runtime:              19.302 s        13.017 s
    -      inexact rename detection:      7.603 s         7.695 s
    -      everything else:              11.699 s         5.322 s
    +                                        ---  no-renames  ---
    +                                  merge-recursive   merge-ort
    +        overall runtime:              19.302 s        14.257 s
    +        inexact rename detection:      7.603 s         7.906 s
    +        everything else:              11.699 s         6.351 s
     
    -                                      --- mega-renames ---
    -                                merge-recursive   merge-ort
    -      overall runtime:            5950.195 s      5132.851 s
    -      inexact rename detection:   5746.309 s      5119.215 s
    -      everything else:             203.886 s        13.636 s
    +                                        --- mega-renames ---
    +                                  merge-recursive   merge-ort
    +        overall runtime:            5950.195 s      5499.672 s
    +        inexact rename detection:   5746.309 s      5487.120 s
    +        everything else:             203.886 s        17.552 s
     
    -                                      --- just-one-mega ---
    -                                merge-recursive   merge-ort
    -      overall runtime:             151.001 s       146.478 s
    -      inexact rename detection:    143.448 s       145.901 s
    -      everything else:               7.553 s         0.577 s
    +                                        --- just-one-mega ---
    +                                  merge-recursive   merge-ort
    +        overall runtime:             151.001 s       158.582 s
    +        inexact rename detection:    143.448 s       157.835 s
    +        everything else:               7.553 s         0.747 s
     
         === Timing observations ===
     
    +    0) Maximum speedup
    +
    +    The "everything else" row represents the maximum speedup we could
    +    achieve if we were to somehow infinitely parallelize inexact rename
    +    detection, but leave everything else alone.  The fact that this is so
    +    much smaller than the real runtime (even in the case with virtually no
    +    renames) makes it clear just how overwhelmingly large the time spent on
    +    rename detection can be.
    +
         1) no-renames
     
         1a) merge-ort is faster than merge-recursive, which is nice.  However,
    @@ Commit message
         2a) Obviously rename detection is a huge cost; it's where most the time
         is spent.  We need to cut that down.  If we could somehow infinitely
         parallelize it and drive its time to 0, the merge-recursive time would
    -    drop to about 204s, and the merge-ort time would drop to about 14s.  I
    +    drop to about 204s, and the merge-ort time would drop to about 17s.  I
         think this particular stat shows I've subtly baked a couple performance
    -    improvements into merge-ort[A] (one of them large) and into
    -    fast-rebase[B] already.
    -
    -        [A] Avoid quadratic behavior with O(N) insertions or removals
    -            of entries in the index & avoid unconditional dropping and
    -            re-reading of the index
    -        [B] Avoid updating the on-disk index or the working directory
    -            for intermediate patches -- only update at the end
    -
    -    2b) rename-detection is somehow ~10% cheaper for merge-ort than
    -    merge-recursive.  This was and is a big surprise to me.  Both of them
    -    call diff_tree_oid() and diffcore_std() with the EXACT same inputs.  I
    -    don't have an explanation, but it is very consistent even after
    -    re-running many times.  Interestingly, the rename detection for the
    -    first patch is more expensive (just barely) for merge-ort than
    -    merge-recursive, and that is also consistent.  I won't investigate this
    -    further, as I'm just going to focus on 1a & 2a.
    +    improvements into merge-ort and into fast-rebase already.
     
         3) just-one-mega
     
    @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_res
      
      	assert(opt->branch1 && opt->branch2);
     @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
    - 	assert(opt->obuf.len == 0);
    - 
    - 	assert(opt->priv == NULL);
    + 		assert(!opt->priv->toplevel_dir ||
    + 		       0 == strlen(opt->priv->toplevel_dir));
    + 	}
     +	trace2_region_leave("merge", "sanity checks", opt->repo);
      
      	/* Default to histogram diff.  Actually, just hardcode it...for now. */
    @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_res
      
      	/* Initialization of opt->priv, our internal merge data */
     +	trace2_region_enter("merge", "allocate/init", opt->repo);
    - 	opt->priv = xcalloc(1, sizeof(*opt->priv));
    - 
    - 	/* Initialization of various renames fields */
    + 	if (opt->priv) {
    + 		clear_or_reinit_internal_opts(opt->priv, 1);
    + 		trace2_region_leave("merge", "allocate/init", opt->repo);
     @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
      	 * subset of the overall paths that have special output.
      	 */
-- 
2.30.0.135.g7f7d4a3e17

