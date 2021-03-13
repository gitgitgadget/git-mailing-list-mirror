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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E1C4332E
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D2A64EDA
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhCMWWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhCMWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA82AC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y16so6755246wrw.3
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=1jgEunsccZE1HpVdfOCrLPcGeq1vALAPb13bVD/+afo=;
        b=GtFC8uwTtU7Gq0l4jJNfIRlloCEKmPBNYeESPzKk2tz3+S1oVBwoSK7jKjGTMWVmr+
         MNk4LfWfUxCXptWrgUHxdLqXVpXSCsigtYMSTI4C15jCpqJG6wudFQCqg3Y6gh9YHnsT
         t5PnsQ8SIZ2kpKGulQNkgvPGHEWz+vJGc0HDuTjmSxayVCRbC5Zjx89KH/cONT/uNsCz
         CskFtqE2i1Rl/E5HxhHuxUBoSTqc9tcY+FeBndul3tq5AKtzES+qMejOYd9BkERkU8M8
         i2+tzsXiBxQueEQq3LWS/R1hH5Pbf3VrlfK4s5J45U0N4i7yPO/EVBf7RRYQgKb6YmBs
         mpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=1jgEunsccZE1HpVdfOCrLPcGeq1vALAPb13bVD/+afo=;
        b=pj86XPJFVDkZrF3xz8+7zOuFowqY5lsSjWki0mUAhkiQG2nBGp0MAnpVcOkSuNuVzT
         0BgMYUV04ZAfmuVSF5ZeV276sBqlJ4lMFSEhXNwTYA6WBYKo2hbAgLX693w3uIpbdBVP
         EpVpAYyjtZjOwjbEz6iTXqauBUC1EqYNY5ir5Ad4oJ3dtcEi/zGbH0AZthlmb8AvWVd7
         xHpHF2MtF5wCEoB6FUfGn4frELEYItiwkVtwBU7UH0cjV3NDp0b0c9KkBCvfiLYXfldo
         eyMQQmWQgLzyokgvTuWJ3psBK/egegH8i6Ysvvw1Zl0hZCz0qz7HkU75ET2QPvkfeyRf
         QOtQ==
X-Gm-Message-State: AOAM532G1G9+y4enZZWiObhRExQ3TGLbq7JXwkXX9Ywp5wONZaVsAuPv
        H2Q24t1raAHTt0XDzSklYSjTT+/PEk0=
X-Google-Smtp-Source: ABdhPJwkh5urja7C+EvVgY5UVJtxyPUOM9uz0vBPjtJ1suHpmAhVcjmQpc3SoDg78BZ1UwmUsFTprA==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr20574374wri.373.1615674129937;
        Sat, 13 Mar 2021 14:22:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm15443398wrj.62.2021.03.13.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:09 -0800 (PST)
Message-Id: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:00 +0000
Subject: [PATCH 0/8] Optimization batch 10: avoid detecting even more irrelevant renames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on ort-perf-batch-9.

=== Basic Optimization idea ===

This series adds additional special cases where detection of renames is
irrelevant, where the irrelevance is due to the fact that the merge
machinery will arrive at the same result regardless of whether a rename is
detected for any of those paths. That high level wording makes it sound the
same as ort-perf-batch-9, and basically it is, it's just trying to take the
optimization a step further.

As noted in the last series, there are two reasons that the merge machinery
needs renames:

 * in order to do three-way content merging (pairing appropriate files)
 * in order to find where directories have been renamed

ort-perf-batch-9 provided a rough approximation for the second criteria that
was good enough, but which still left us detecting more renames than
necessary. This series focuses further on that criteria and finds ways to
avoid the need to detect as many renames while still detecting directory
renames identically to before. Thus, this series is an improvement on
"Optimization #2" from my Git Merge 2020 talk[1].

=== Results ===

For the testcases mentioned in commit 557ac03 ("merge-ort: begin performance
work; instrument with trace2_region_* calls", 2020-10-28), the changes in
just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.680 s ±  0.096 s     5.665 s ±  0.129 s 
mega-renames:     13.812 s ±  0.162 s    11.435 s ±  0.158 s
just-one-mega:   506.0  ms ±  3.9  ms   494.2  ms ±  6.1  ms


While those results may look somewhat meager, it is important to note that
the previous optimizations have already reduced rename detection time to
nearly 0 for these particular testcases so there just isn't much left to
improve. The final patch in the series shows an alternate testcase where the
previous optimizations aren't as effective (a simple cherry-pick of a commit
that simply adds one new empty file), where there was a speedup factor of
approximately 3 due to this series:

                     Before Series           After Series
pick-empty:        1.936 s ±  0.024 s     688.1 ms ±  4.2 ms


There was also another testcase at $DAYJOB where I saw a factor 7
improvement from this particular optimization, so it certainly has the
potential to help when the previous optimizations are not quite enough.

As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (as noted in the same commit message)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


[1]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

Elijah Newren (8):
  diffcore-rename: take advantage of "majority rules" to skip more
    renames
  merge-ort, diffcore-rename: tweak dirs_removed and relevant_source
    type
  merge-ort: record the reason that we want a rename for a directory
  diffcore-rename: only compute dir_rename_count for relevant
    directories
  diffcore-rename: check if we have enough renames for directories early
    on
  diffcore-rename: add computation of number of unknown renames
  merge-ort: record the reason that we want a rename for a file
  diffcore-rename: determine which relevant_sources are no longer
    relevant

 diffcore-rename.c | 230 ++++++++++++++++++++++++++++++++++++++++------
 diffcore.h        |  19 +++-
 merge-ort.c       |  79 ++++++++++++----
 3 files changed, 281 insertions(+), 47 deletions(-)


base-commit: 98b0c7de5e70d62d47c3eeb3d290c6a234214f40
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-853%2Fnewren%2Fort-perf-batch-10-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-853/newren/ort-perf-batch-10-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/853
-- 
gitgitgadget
