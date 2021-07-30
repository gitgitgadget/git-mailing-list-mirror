Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A44C4320E
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134F560EE6
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhG3Lrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhG3Lrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:47:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB87C061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so3569645wms.2
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=nDGKe8Ebgz8RQVbwxV+A54y2fz6yCadF54ivZLZiq88=;
        b=b9JtJ2Z3geQNqgP76ynwR3qjqhm2y+20Q1RfXYbQELL5iJjli74tzKSsJ268mQX+AM
         Xr8qLwPFcB7iYMpu+rMH2/4pTAZ/reYoXLBYGOGBk2g7MTX4R/ERj4RUCFt5q+4necb8
         aRFMcupgwfR9+rAjHl8NPIQVeJjlmA1uEdx6Laj7NKBo6oZ+grZWEZma83rc54Sbpchc
         zgllZojDTb9vWqoiCnO462F/U3WqaXT7EHrBscBkTCEko1UX5CkJ/n59IO+sIJzJxxT5
         RJ6kHDrzHdOeyCIaghoa6m2DA4CuMvd1ZGdHkYK1U1QBwZv/cus1Nce0VgED4E277/xu
         q47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=nDGKe8Ebgz8RQVbwxV+A54y2fz6yCadF54ivZLZiq88=;
        b=fuswRIhmg+iPaJjjwY6jl59SiudOseZN2+wPkKsnw0JtkfeTT4rBEIEUYdzoePi7Nh
         fGceq+VwnTQrR/M41ci8/aYwmoR6TUKcwAviyGCPTkzhAg321RGSR+1qu3htwnG+Zs62
         1GsushG73j3XoyR89oQMbtUWdWi0ceYHliiKSsce0qlLD5yOLmeGKxfLAQixaZIm5Cf1
         jUKpyTROs+bZwsdqnYhqpCaFn2iaBIcwLDVaj4JhWR8m/w3DwWvVsUFTGxgqKI/5haJv
         zm62BjRi8jcy0ERvom8uU7aPb7uItGNnxz8WeM4SdrwYiWHj6pJKC/PHTmRglOcZU21i
         FSng==
X-Gm-Message-State: AOAM533ON5QI+jB0lx6Lp0E364Wa2sFyM5rF5uy5p/r9d2v/Ok4sULN4
        6r7+s0lCfnn7ZcRqUvmfdiXE3JA/hf4=
X-Google-Smtp-Source: ABdhPJwXhty6VvXSrcY+oAUzvfTvW6WZp8tjKLrWjITktRyOcFU6w72qjfz7Dsi9eIymFXUXym3yng==
X-Received: by 2002:a05:600c:5114:: with SMTP id o20mr2567988wms.176.1627645666398;
        Fri, 30 Jul 2021 04:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm1448763wru.50.2021.07.30.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:45 -0700 (PDT)
Message-Id: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:35 +0000
Subject: [PATCH v3 0/9] Final optimization batch (#15): use memory pools
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series textually depends on en/ort-perf-batch-14, but the ideas are
orthogonal to it and orthogonal to previous series. It can be reviewed
independently.

Changes since v1, addressing Eric's feedback:

 * Fixed a comment that became out-of-date in patch 1
 * Swapped commits 2 and 3 so that one can better motivate the other.

Changes since v2, addressing Peff's feedback

 * Rebased on en/ort-perf-batch-14 (resolving a trivial conflict with the
   new string_list_init_nodup() usage)
 * Added a new preliminary patch renaming str*_func() to str*_clear_func()
 * Added a new final patch that hardcodes that we'll just use memory pools

=== Basic Optimization idea ===

In this series, I make use of memory pools to get faster allocations and
deallocations for many data structures that tend to all be deallocated at
the same time anyway.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:      204.2  ms ±  3.0  ms    198.3 ms ±  2.9 ms
mega-renames:      1.076 s ±  0.015 s    661.8 ms ±  5.9 ms
just-one-mega:   364.1  ms ±  7.0  ms    264.6 ms ±  2.5 ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


=== Overall Results across all optimization work ===

This is my final prepared optimization series. It might be worth reviewing
how my optimizations fared overall, comparing the original merge-recursive
timings with three things: how much merge-recursive improved (as a
side-effect of optimizing merge-ort), how much improvement we would have
gotten from a hypothetical infinite parallelization of rename detection, and
what I achieved at the end with merge-ort:

                               Timings

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename    merge-ort
                 v2.30.0      current     detection     current
                ----------   ---------   -----------   ---------
no-renames:       18.912 s    18.030 s     11.699 s     198.3 ms
mega-renames:   5964.031 s   361.281 s    203.886 s     661.8 ms
just-one-mega:   149.583 s    11.009 s      7.553 s     264.6 ms

                           Speedup factors

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename
                 v2.30.0      current     detection    merge-ort
                ----------   ---------   -----------   ---------
no-renames:         1           1.05         1.6           95
mega-renames:       1          16.5         29           9012
just-one-mega:      1          13.6         20            565


And, for partial clone users:

             Factor reduction in number of objects needed

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename
                 v2.30.0      current     detection    merge-ort
                ----------   ---------   -----------   ---------
mega-renames:       1            1            1          181.3


=== Caveat ===

It may be worth noting, though, that my optimization numbers above for
merge-ort use test-tool fast-rebase. git rebase -s ort on the three
testcases above is 5-20 times slower (taking 3.835s, 6.798s, and 1.235s,
respectively). At this point, any further optimization work should go into
making a faster full-featured rebase by copying the ideas from fast-rebase:
avoid unnecessary process forking, avoid updating the index and working copy
until either the rebase is finished or you hit a conflict (and don't write
rebase metadata to disk until that point either), get rid of the glacially
slow revision walking of the upstream side of history (nuke
can_fast_forward(), make --reapply-cherry-picks the default) or at least
don't revision walk so many times (multiple calls to get_merge_bases in
can_fast_forward() plus a is_linear_history() walk, checking for upstream
cherry-picks, probably more), turn off per-commit hooks that probably should
have never been on anyway, etc.

Elijah Newren (9):
  merge-ort: rename str{map,intmap,set}_func()
  diffcore-rename: use a mem_pool for exact rename detection's hashmap
  merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
  merge-ort: set up a memory pool
  merge-ort: switch our strmaps over to using memory pools
  diffcore-rename, merge-ort: add wrapper functions for filepair
    alloc/dealloc
  merge-ort: store filepairs and filespecs in our mem_pool
  merge-ort: reuse path strings in pool_alloc_filespec
  merge-ort: remove compile-time ability to turn off usage of memory
    pools

 diffcore-rename.c |  68 +++++++++++--
 diffcore.h        |   3 +
 merge-ort.c       | 238 ++++++++++++++++++++++++++++++++--------------
 3 files changed, 231 insertions(+), 78 deletions(-)


base-commit: 8b09a900a1f1f00d4deb04f567994ae8f1804b5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-990%2Fnewren%2Fort-perf-batch-15-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-990/newren/ort-perf-batch-15-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/990

Range-diff vs v2:

  -:  ----------- >  1:  e075d985f26 merge-ort: rename str{map,intmap,set}_func()
  1:  ea08b34d29b =  2:  8416afa89fb diffcore-rename: use a mem_pool for exact rename detection's hashmap
  2:  fdfc2b93ba4 !  3:  2c0b90eaba5 merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
     @@ Metadata
       ## Commit message ##
          merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
      
     -    We need functions which will either call
     +    Make the code more flexible so that it can handle both being run with or
     +    without a memory pool by adding utility functions which will either call
              xmalloc, xcalloc, xstrndup
          or
              mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
     -    depending on whether we have a non-NULL memory pool.  Add these
     -    functions; a subsequent commit will make use of these.
     +    depending on whether we have a non-NULL memory pool.  A subsequent
     +    commit will make use of these.
     +
     +    (We will actually be dropping these functions soon and just assuming we
     +    always have a memory pool, but the flexibility was very useful during
     +    development of merge-ort so I want to be able to restore it if needed.)
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
  3:  c7150869107 =  4:  6646f6fd1ca merge-ort: set up a memory pool
  4:  dd8839b2843 !  5:  7c49aa601d0 merge-ort: switch our strmaps over to using memory pools
     @@ Commit message
      
       ## merge-ort.c ##
      @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
     - 	void (*strset_func)(struct strset *) =
     + 	void (*strset_clear_func)(struct strset *) =
       		reinitialize ? strset_partial_clear : strset_clear;
       
      -	/*
     @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_inte
      -	 * to deallocate them.
      -	 */
      -	free_strmap_strings(&opti->paths);
     --	strmap_func(&opti->paths, 1);
     +-	strmap_clear_func(&opti->paths, 1);
      +	if (opti->pool)
     -+		strmap_func(&opti->paths, 0);
     ++		strmap_clear_func(&opti->paths, 0);
      +	else {
      +		/*
      +		 * We marked opti->paths with strdup_strings = 0, so that
     @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_inte
      +		 * to these strings, it is time to deallocate them.
      +		 */
      +		free_strmap_strings(&opti->paths);
     -+		strmap_func(&opti->paths, 1);
     ++		strmap_clear_func(&opti->paths, 1);
      +	}
       
       	/*
       	 * All keys and values in opti->conflicted are a subset of those in
      @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
       	 */
     - 	strmap_func(&opti->conflicted, 0);
     + 	strmap_clear_func(&opti->conflicted, 0);
       
      -	/*
      -	 * opti->paths_to_free is similar to opti->paths; we created it with
     @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_res
       	 */
      -	strmap_init_with_options(&opt->priv->paths, NULL, 0);
      -	strmap_init_with_options(&opt->priv->conflicted, NULL, 0);
     --	string_list_init(&opt->priv->paths_to_free, 0);
     +-	string_list_init_nodup(&opt->priv->paths_to_free);
      +	strmap_init_with_options(&opt->priv->paths, pool, 0);
      +	strmap_init_with_options(&opt->priv->conflicted, pool, 0);
      +	if (!opt->priv->pool)
     -+		string_list_init(&opt->priv->paths_to_free, 0);
     ++		string_list_init_nodup(&opt->priv->paths_to_free);
       
       	/*
       	 * keys & strbufs in output will sometimes need to outlive "paths",
  5:  560800a80ef =  6:  08cf2498f96 diffcore-rename, merge-ort: add wrapper functions for filepair alloc/dealloc
  6:  94d60c8a476 =  7:  4ffa5af8b57 merge-ort: store filepairs and filespecs in our mem_pool
  7:  fda885dabe6 =  8:  1556f0443c3 merge-ort: reuse path strings in pool_alloc_filespec
  -:  ----------- >  9:  de30dbac25e merge-ort: remove compile-time ability to turn off usage of memory pools

-- 
gitgitgadget
