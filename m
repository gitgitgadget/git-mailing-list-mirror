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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C36EC43331
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A0652B2
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhCIAK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhCIAKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09BC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b18so13311178wrn.6
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=mTchDZQ+m2SGQmg5lNl6kUzFm63wyJTwL6KBBdWGwtc=;
        b=lB4ApT6aYE7IuefS80X5oSJ3jFXCz8IicfDrfGh1L+An8knGWWBTbKess7/xyJT1qG
         /wDnb9kZTFf21zHMIfFxlUZqHL5QJHYbvVOhROVOMLZXF2ZxzMML5874qQc93goIJWFM
         VBGANnFHo1TB6lCsZL/1fxjpbHub8ba7uaD8ePKUJil+FJhmY+7pY3cHxP3ev/Y+JzX0
         MSH7UElhCM4qNbX+K0w1oiVMNEiSBfJqxws38MEkAnzoPHtlhAb6U8RLO1/lJX9J6ilk
         4SjCk4kQFeL2JRzdb92DPkpX6UYMHhIY+ZbbtuqYLZQ7+d09zv0C7yREQ8C2PjSDAjW4
         WGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=mTchDZQ+m2SGQmg5lNl6kUzFm63wyJTwL6KBBdWGwtc=;
        b=Z1MRY8jKoMaHAZMSlLAjZoFx2Nz4E5GSusCDmDQMKRinelncFWd4BB5aH94nG+jhrA
         jTtE33MyjqZwIA3SCUncPe8uv/48bcN3huPHlJejhAdiGi352FQo5yMslPbdNemEJpUu
         vW0qQLaXaPcfGeilPMtwqUtgU9KcAmbQVW0FtpBmCPE/oUB/SpOtxHEG/oatJ9S/Lgc1
         2zBrIfPof/IB7/7Pjj45l87YaTBRxee3ddL/tp1TY1EsBZBGtL2uKbON6QNrX48dpncX
         +l0z1KECDGn287xISekMjzDjrlgx681JrOrPlIELLYpFtJaT008geKqhyTLH7V0p1siZ
         Y9GQ==
X-Gm-Message-State: AOAM530dnz1VUR80XU42E5cfPCGmowUM+HuFGmmg361uXbInxPJ//Dyk
        d82bYcPsVQoBWr0hz0yHP3h3gZemppo=
X-Google-Smtp-Source: ABdhPJxSv72bNGhQa5TLrgyjMKp0dFY5/pnwIqTtfBM0JIW+9/QrCRJRemHV5uNESpH3q+mSWgf3Fg==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr24867147wrs.135.1615248600980;
        Mon, 08 Mar 2021 16:10:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm22217315wrl.49.2021.03.08.16.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:10:00 -0800 (PST)
Message-Id: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 00:09:51 +0000
Subject: [PATCH v2 0/8] Optimization batch 9: avoid detecting irrelevant renames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends textually on ort-perf-batch-8, but semantically it's
almost completely unrelated and can be reviewed without any familiarity with
any of the previous patch series.

There are no changes since v1; it's just a resend just over a week later to
bump it so it isn't lost.

=== Basic Optimization idea ===

This series determines paths which meet special cases where detection of
renames is irrelevant, where the irrelevance is due to the fact that the
merge machinery will arrive at the same result regardless of whether a
rename is detected for any of those paths. This series represents
"Optimization #2" from my Git Merge 2020 talk[1], though this series has
some improvements on the optimization relative to what I had at that time.

The basic idea here is:

We only need expensive rename detection on the subset of files changed on
both sides of history (for the most part).

This is because:

 1. The primary reason for rename detection in merges is enabling three-way
    content merges
 2. The purpose of three-way content merges is reconciling changes when

both sides of history modified some file 3. If a file was only modified by
the side that renamed the file, then detecting the rename is irrelevant;
we'll get the same answer without knowing about the rename. 4. (Well...there
are rare cases where we need the rename for reasons other than three-way
content merges. Patch 5 explains those.)

Since commits being rebased or cherry-picked tend to only modify a few
files, this optimization tends to be particularly effective for rebases and
cherry-picks.

Basing rename detection on what the other side of history did to a file
means that extra information needs to be fed from merge-ort to
diffcore-rename in order to take advantage of such an optimization.

=== Comparison to previous series ===

This series differs from my two previous optimizations[2][3] (focusing on
basename-guided rename detection) in two important aspects:

 * there are no behavioral changes (there is no heuristic involved)
 * this optimization is merge specific (it does not help the diff/status/log
   family of commands, just merge/rebase/cherry-pick and such)

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:       12.596 s ±  0.061 s     5.680 s ±  0.096 s
mega-renames:    130.465 s ±  0.259 s    13.812 s ±  0.162 s
just-one-mega:     3.958 s ±  0.010 s   506.0  ms ±  3.9  ms


However, interestingly, if we had ignored the basename-guided rename
detection optimizations[2][3], then this optimization series would have
improved the performance as follows:

               Before Basename Series   After Just This Series
no-renames:      13.815 s ±  0.062 s      5.728 s ±  0.104 s
mega-renames:  1799.937 s ±  0.493 s     18.213 s ±  0.139 s
just-one-mega    51.289 s ±  0.019 s    891.9  ms ±  7.0  ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (as noted in the same commit message)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


=== Competition between optimizations ===

We now have three major rename-related optimizations:

 * exact rename detection
 * basename-guided rename detection[2][3]
 * skip-because-unnecessary (this series)

It is possible for all three to potentially apply for specific paths (they
do for the majority of renamed paths in our testcases), but we cannot use
more than one for any given path. It turns out that the priority we give
each optimization is very important and can drastically affect performance.
We get best results by prioritizing them as follows:

 1. exact rename detection
 2. skip-because-unnecessary
 3. basename-guided rename detection

Some of the commit messages discuss this ordering and another minor variant
of the skip-because-unnecessary optimization that was tried (and resulted in
less effective performance gains than reported here), as well as some of the
preparatory work over the past few years that this series relies on in order
to enable this optimization.

=== Near optimal? ===

You may remember that there was a row labelled "everything else" from the
commit message of 557ac0350d that represented the maximum possible speed-up
from accelerating rename detection alone; as stated in that commit, those
rows represented how fast the code could be if we had somehow infinitely
parallelized the inexact rename detection. However, if you compare those
"maximum speedup" numbers to what we have above, you'll note that the
infinitely parallelized inexact rename detection would have been slightly
slower than the results we have now achieved. (The reason this is possible,
despite the fact that we still spend time in rename detection after our
optimizations, is because we implemented two optimizations outside of
diffcore_rename() along the way.) However, this good news does also come
with a downside -- it means that our remaining optimization potential is
somewhat limited, and subsequent optimization series will have to fight for
much smaller gains.

[1]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf
[2]
https://lore.kernel.org/git/pull.843.git.1612651937.gitgitgadget@gmail.com/
[3]
https://lore.kernel.org/git/pull.844.git.1613289544.gitgitgadget@gmail.com/

Elijah Newren (8):
  diffcore-rename: enable filtering possible rename sources
  merge-ort: precompute subset of sources for which we need rename
    detection
  merge-ort: add data structures for an alternate tree traversal
  merge-ort: introduce wrappers for alternate tree traversal
  merge-ort: precompute whether directory rename detection is needed
  merge-ort: use relevant_sources to filter possible rename sources
  merge-ort: skip rename detection entirely if possible
  diffcore-rename: avoid doing basename comparisons for irrelevant
    sources

 diffcore-rename.c |  63 ++++++++++---
 diffcore.h        |   1 +
 merge-ort.c       | 236 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 285 insertions(+), 15 deletions(-)


base-commit: 4be565c472088d4144063b736308bf2a57331f45
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-845%2Fnewren%2Fort-perf-batch-9-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-845/newren/ort-perf-batch-9-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/845

Range-diff vs v1:

 1:  064fa5de1e20 = 1:  dab8e3c6aee5 diffcore-rename: enable filtering possible rename sources
 2:  69b42a41e83a = 2:  33c231331744 merge-ort: precompute subset of sources for which we need rename detection
 3:  042ce66011ef = 3:  89b43c9f75a0 merge-ort: add data structures for an alternate tree traversal
 4:  7673e4c23bbb = 4:  6497050c0012 merge-ort: introduce wrappers for alternate tree traversal
 5:  8dbf0a452545 = 5:  608d5a4c6ad7 merge-ort: precompute whether directory rename detection is needed
 6:  6b20977a5a81 = 6:  d62fdee45ad3 merge-ort: use relevant_sources to filter possible rename sources
 7:  d5486ab28462 = 7:  cd931286f24d merge-ort: skip rename detection entirely if possible
 8:  8fed92b62f37 = 8:  c443ba8abb89 diffcore-rename: avoid doing basename comparisons for irrelevant sources

-- 
gitgitgadget
