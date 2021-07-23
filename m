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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E4C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4524C60E95
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhGWMO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhGWMO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:14:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D9C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e2so2255092wrq.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=fSnzsWmypp1tSe0jjpqcp4NhTKnpC3VMaHo8Qx8Pn4s=;
        b=mpGoErV0kYl6HidsJOfvDF/xyUKxdQuDRR+qrvcjIq4ramVAy65XSeBrPWy2L/lAgm
         W9suc9ggtfemdhX/7YfGv/mUV+0c9dUNxAsM8IYbjtsCvFusRUn+tHHnmWXmvtrrq5gm
         V8vFmVRm1j3EsivE5aJ8WSudfouR7MjUyLidCPCG8jijQVqnt2+UwgA29KPswhNgSLbS
         wKfTczkplUCNkbkCuKnSbPiKHLa+rSM0sSO7QugJfKtAZyNtzuWUzYPaBSDelVGcJfaI
         I9anbQGnw+KsgOeorBoyi+Z5CijlkypTP0mFnLBG5xyS1YaM76YPns4BezGx9veTV8Fp
         KUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fSnzsWmypp1tSe0jjpqcp4NhTKnpC3VMaHo8Qx8Pn4s=;
        b=ZGYl6u3yE3ba5LWRnZ6kJfzQGBGokpoxRBYKvIeO2djUX/ZLLJUtSEjlK7nnWXyqQr
         riFPvTZd0EVl+R3zmUmNtrMFznPHTe/S3mxC0M4FG69QXc8t1BlAL8R0wMKJmuj6xfbA
         1lWOAdnHi7uuPFF6/znrVqOvTMZ8gpPKQ5ZSRKJW3bfzCPLJ407sJOKhFwh07m0ttLi1
         ipMbyqBV0tlTL1Sho4D61cmo52ePc1xbmJiSul5NwzDTGKrtHLK7DPTekPmrb/hEi2jA
         xI1MGEUc6Y7GeG/tSWyee1qji/oKDBUYKbAbRTkOKaWc00wKxUXqXw/qTDrBxBH8rLfH
         iWjQ==
X-Gm-Message-State: AOAM530ADNbc9fzqWxwS/x7ZvR3TlF/DF5+oMndyxOSZW/TWPSiLJtn/
        b/trJZypoClBWHLc5kx5ASw0LoivOnQ=
X-Google-Smtp-Source: ABdhPJyZ3XsQAfGFOQ4DWxrnuh9eLZtka6ZOLdXJYC/GWc7FskqxSTQb1sdnwnQxozQlnjkcuG4+UA==
X-Received: by 2002:adf:a287:: with SMTP id s7mr5150555wra.120.1627044898953;
        Fri, 23 Jul 2021 05:54:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm34070612wrv.20.2021.07.23.05.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:54:58 -0700 (PDT)
Message-Id: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:54:50 +0000
Subject: [PATCH 0/7] Final optimization batch (#15): use memory pools
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series textually depends on en/ort-perf-batch-14, but the ideas are
orthogonal to it and orthogonal to previous series. It can be reviewed
independently.

This series is more about strmaps & memory pools than merge logic. CC'ing
Peff since he reviewed the strmap work[1], and that work included a number
of decisions that specifically had this series in mind.

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
  merge-ort: set up a memory pool
  merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
  merge-ort: switch our strmaps over to using memory pools
  diffcore-rename, merge-ort: add wrapper functions for filepair
    alloc/dealloc
  merge-ort: store filepairs and filespecs in our mem_pool
  merge-ort: reuse path strings in pool_alloc_filespec

 diffcore-rename.c |  66 +++++++++++--
 diffcore.h        |   3 +
 merge-ort.c       | 247 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 251 insertions(+), 65 deletions(-)


base-commit: c9ada8369e6575be488028aae0f654422a9b1410
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-990%2Fnewren%2Fort-perf-batch-15-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-990/newren/ort-perf-batch-15-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/990
-- 
gitgitgadget
