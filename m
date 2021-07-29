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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A9C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0496101C
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhG2D6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhG2D6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 23:58:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09F8C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m12so195106wru.12
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=x7WNc7hQ/87yK+rSOAV3CybJBbq50PTXMN0oy5wdz4w=;
        b=EjtteWGaySn23CO5rMWBjmK4BqaZkefapN01IfwndRacO6Rz88t4AOgkl3KpUB9ci1
         8M1FlUv7ALcvuXRLNwTdczMfhosiLaCtG7E/mwDZiW/XOZyVZ3nYMht3hTGSbwh/8CbX
         Gfen0GUeoowbWTi47HJTyzkG9N5j8V3jH7IYPuawtqBDbyWUDxE9D3ovmD81lSPgy+VW
         Hf1R3Xr1WTRUJuoyN2qVZllgchacnYEwgewy8mhXWsVFl9hzacxvmg7NcdPD2H3/6wKu
         3SjSWkiculPdsx+grThPftPMKawFQlMamqRdCpXnkdDTcck0Il+JP3tPP0oZGXDJkqIJ
         VXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=x7WNc7hQ/87yK+rSOAV3CybJBbq50PTXMN0oy5wdz4w=;
        b=ethepkKe4Mz6getDEmMNkB0RiOOlBF2QDZ6qRoG+oNxh4ULNq24PkFuVf7tA/zi/LX
         tCtH76NeCwj2MeiYs/fVVRHCB2naZdJXXtS1p8QW024jBCZeZ4dtgUTmIMXQ7DEYcLab
         A2RBvj2miwtr8aUeSEIY9BqjyMXGJiFnu/TA6Gkzkc99J+t4SGfD6kmkPLuvWAdJmtOk
         YLit3Nlf0dqQK3A/kSC+0Autuq9cC66KuJ6UDFXW3Fv+4LqudPFl78rwaFKiMwxcc/GD
         Zszrlz62MXifCxdpmoYUI/vDTaepTib0DkQNgC9Ohg8YU5FYYANoKowLdW1L+2S7qAr7
         AKxg==
X-Gm-Message-State: AOAM530Jy2Bj1DsXUbNRvtZGWjDwrHIDu1Kev1wHhGPbE4DPd/+wib8X
        76lQKly/BDgKAkuLrBfe28dieo7jj9U=
X-Google-Smtp-Source: ABdhPJxTvnNNQljTidYQ44CUsZCkW6muhMHLswro5svfARKDZVL5iTPuQ0IJNOPMFMdcLhyibBCR/w==
X-Received: by 2002:a5d:688e:: with SMTP id h14mr2337938wru.117.1627531122505;
        Wed, 28 Jul 2021 20:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm1764950wrt.24.2021.07.28.20.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:58:42 -0700 (PDT)
Message-Id: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 03:58:34 +0000
Subject: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
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

This series is more about strmaps & memory pools than merge logic. CC'ing
Peff since he reviewed the strmap work[1], and that work included a number
of decisions that specifically had this series in mind.

Changes since v1, addressing Eric's feedback:

 * Fixed a comment that became out-of-date in patch 1
 * Swapped commits 2 and 3 so that one can better motivate the other.

Note: Stolee also had an interesting question about whether we should tweak
the mem_pool_*() API; he and I were both worried it was a bit much, so I've
left it out unless others on list chime in with their opinions on that
change.

[1]
https://lore.kernel.org/git/20201111200701.GB39046@coredump.intra.peff.net/

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

Elijah Newren (7):
  diffcore-rename: use a mem_pool for exact rename detection's hashmap
  merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
  merge-ort: set up a memory pool
  merge-ort: switch our strmaps over to using memory pools
  diffcore-rename, merge-ort: add wrapper functions for filepair
    alloc/dealloc
  merge-ort: store filepairs and filespecs in our mem_pool
  merge-ort: reuse path strings in pool_alloc_filespec

 diffcore-rename.c |  68 +++++++++++--
 diffcore.h        |   3 +
 merge-ort.c       | 247 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 252 insertions(+), 66 deletions(-)


base-commit: c9ada8369e6575be488028aae0f654422a9b1410
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-990%2Fnewren%2Fort-perf-batch-15-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-990/newren/ort-perf-batch-15-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/990

Range-diff vs v1:

 1:  9f8ab62b842 ! 1:  ea08b34d29b diffcore-rename: use a mem_pool for exact rename detection's hashmap
     @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
       				  rename_src[i].p->one);
       
      @@ diffcore-rename.c: static int find_exact_renames(struct diff_options *options)
     + 	for (i = 0; i < rename_dst_nr; i++)
       		renames += find_identical_files(&file_table, i, options);
       
     - 	/* Free the hash data structure and entries */
     +-	/* Free the hash data structure and entries */
      -	hashmap_clear_and_free(&file_table, struct file_similarity, entry);
     ++	/* Free the hash data structure (entries will be freed with the pool) */
      +	hashmap_clear(&file_table);
       
       	return renames;
 3:  e30b8c8fea1 ! 2:  fdfc2b93ba4 merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
     @@ Commit message
          or
              mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
          depending on whether we have a non-NULL memory pool.  Add these
     -    functions; the next commit will make use of these.
     +    functions; a subsequent commit will make use of these.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
 2:  77367a69daa = 3:  c7150869107 merge-ort: set up a memory pool
 4:  8231c8e34cd = 4:  dd8839b2843 merge-ort: switch our strmaps over to using memory pools
 5:  2db932bc601 = 5:  560800a80ef diffcore-rename, merge-ort: add wrapper functions for filepair alloc/dealloc
 6:  629d042884a = 6:  94d60c8a476 merge-ort: store filepairs and filespecs in our mem_pool
 7:  17aa0a74849 = 7:  fda885dabe6 merge-ort: reuse path strings in pool_alloc_filespec

-- 
gitgitgadget
