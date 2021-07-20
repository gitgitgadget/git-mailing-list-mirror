Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B31C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08A7610F7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhGTJ6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhGTJ4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA4C0613E3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u1so25503886wrs.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1LulEbAv2WPM8qs/GmXqHDpMYcPiKqZowitUuekNilM=;
        b=njy/88iZhk7nq+goQ0Bj/gAA2XNn1ANPF6X64DmvIidw6Qbdeh1tRe43D48MDXLrQO
         16rbL4xGlj6sKpETiTQv5IKkDZkqoXWSEae95i+R+J8D32qdG9bPDB/2kKB5PE7JlXAL
         BlsSolc13eUVxO7XJzyWkkszm4wmWnLOK8TxByeXdbBi9TRWaJ3qPDj9FSm/OJIbi5gC
         SKuVW9XgUY+9i/0pYY2Ke+chRS5NiwBS3350qu0tQJK/e9w+hz0tg61rOOatNuaexRGT
         a8DOLLDSmU6ZPXWKvcvMSEzyYKYSmWN735xpNQV0KZB/ffkdN5tzOcQtjcZ6wzqaYe+N
         T3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1LulEbAv2WPM8qs/GmXqHDpMYcPiKqZowitUuekNilM=;
        b=DdHyav2dr/2p+96EftG8LQiNpi3xh+89R0WJm/EkVdA6GEbV5XSjiAuqVy2SoZre/B
         5sM1QLmEw3hUULvfqsXriZY6Kvh/qxKnL5H54xgOxhdUfC0gWk+iLpVv7fznumYEakyt
         o4v/Bto5R3sTclsRbHtrpACV3GQmBWWAlK8tq4eOGC96UXHdlsugQw5lDyGaf/dpupLc
         KzNTF9bmFJZ3/LpYhrGtddaU4I8/4uDcNFgpqXP4V0yyRt5FzG/HBow8+Po4+9QSaX2Z
         TKW2L4u5YGjE9Hava7ozgJqsDKZn63MjHPml75U0ttAnkgjVuK4ZSkqeyXbvK3zSUywc
         ReSg==
X-Gm-Message-State: AOAM531bbv541FziVjGoLFeTR1PRrhxD+2Wk15f/fkocLAvx6A2Cj3Qu
        6i1IdURIMMFFtJSNJAaiacVm1DMsDQw=
X-Google-Smtp-Source: ABdhPJzFcuMGZg+AepCypOQCPiBjT//Apf6Shu/J64jql6h/nGWR+7uZoV4D+rEgcZE+ksyunb5I6A==
X-Received: by 2002:adf:e581:: with SMTP id l1mr34478336wrm.116.1626777395421;
        Tue, 20 Jul 2021 03:36:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm1165008wmq.7.2021.07.20.03.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:35 -0700 (PDT)
Message-Id: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:21 +0000
Subject: [PATCH v2 00/12] diff --color-moved[-ws] speedups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Ævar and Elijah for their comments, I've reworded the commit
messages, addressed the enum initialization issue in patch 2 (now 3) and
added some perf tests.

There are two new patches in this round. The first patch is new and adds the
perf tests suggested by Ævar, the penultimate patch is also new and coverts
the existing code to use a designated initializer.

I've converted the benchmark results in the commit messages to use the new
tests, the percentage changes are broadly similar to the previous results
though I ended up running them on a different computer this time.

V1 cover letter:

The current implementation of diff --color-moved-ws=allow-indentation-change
is considerably slower that the implementation of diff --color-moved which
is in turn slower than a regular diff. This patch series starts with a
couple of bug fixes and then reworks the implementation of diff
--color-moved and diff --color-moved-ws=allow-indentation-change to speed
them up on large diffs. The time to run git diff --color-moved
--no-color-moved-ws v2.28.0 v2.29.0 is reduced by 33% and the time to run
git diff --color-moved --color-moved-ws=allow-indentation-change v2.28.0
v2.29.0 is reduced by 88%. There is a small slowdown for commit sized diffs
with --color-moved - the time to run git log -p --color-moved
--no-color-moved-ws --no-merges -n1000 v2.29.0 is increased by 2% on recent
processors. On older processors these patches reduce the running time in all
cases that I've tested. In general the larger the diff the larger the speed
up. As an extreme example the time to run diff --color-moved
--color-moved-ws=allow-indentation-change v2.25.0 v2.30.0 goes down from 8
minutes to 6 seconds.

Phillip Wood (12):
  diff --color-moved: add perf tests
  diff --color-moved=zebra: fix alternate coloring
  diff --color-moved: avoid false short line matches and bad zerba
    coloring
  diff: simplify allow-indentation-change delta calculation
  diff --color-moved-ws=allow-indentation-change: simplify and optimize
  diff --color-moved: call comparison function directly
  diff --color-moved: unify moved block growth functions
  diff --color-moved: shrink potential moved blocks as we go
  diff --color-moved: stop clearing potential moved blocks
  diff --color-moved-ws=allow-indentation-change: improve hash lookups
  diff: use designated initializers for emitted_diff_symbol
  diff --color-moved: intern strings

 diff.c                           | 377 ++++++++++++-------------------
 t/perf/p4002-diff-color-moved.sh |  45 ++++
 t/t4015-diff-whitespace.sh       | 137 +++++++++++
 3 files changed, 323 insertions(+), 236 deletions(-)
 create mode 100755 t/perf/p4002-diff-color-moved.sh


base-commit: 211eca0895794362184da2be2a2d812d070719d3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-981%2Fphillipwood%2Fwip%2Fdiff-color-moved-tweaks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-981/phillipwood/wip/diff-color-moved-tweaks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/981

Range-diff vs v1:

  -:  ----------- >  1:  8fc8914a37b diff --color-moved: add perf tests
  1:  374dbebcbf2 !  2:  9b4e4d2674a diff --color-moved=zerba: fix alternate coloring
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    diff --color-moved=zerba: fix alternate coloring
     +    diff --color-moved=zebra: fix alternate coloring
      
          b0a2ba4776 ("diff --color-moved=zebra: be stricter with color
          alternation", 2018-11-23) sought to avoid using the alternate colors
  2:  3d02a0a91a0 !  3:  5512145c70f diff --color-moved: avoid false short line matches and bad zerba coloring
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       	int pmb_nr = 0, pmb_alloc = 0;
       	int n, flipped_block = 0, block_length = 0;
      -	enum diff_symbol last_symbol = 0;
     -+	enum diff_symbol moved_symbol = 0;
     ++	enum diff_symbol moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
       
       
       	for (n = 0; n < o->emitted_symbols->nr; n++) {
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
      -			last_symbol = l->s;
      +		}
      +		if (!match) {
     -+			moved_symbol = 0;
     ++			moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
       			continue;
       		}
       
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
      +			if (pmb_nr)
      +				moved_symbol = l->s;
      +			else
     -+				moved_symbol = 0;
     ++				moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
      +
       			block_length = 0;
       		}
  3:  30f0ed44768 =  4:  93fdef30d64 diff: simplify allow-indentation-change delta calculation
  4:  ebb6eec1d92 !  5:  6b7a8aed4ec diff --color-moved-ws=allow-indentation-change: simplify and optimize
     @@ Commit message
          comparison to filter out the non-matching lines. Fixing this reduces
          time to run
            git diff --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
     -    by 88% and simplifies the code.
     +    by 93% compared to master and simplifies the code.
      
     -    Before this change
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
     -      Time (mean ± σ):      9.978 s ±  0.042 s    [User: 9.905 s, System: 0.057 s]
     -      Range (min … max):    9.917 s … 10.037 s    10 runs
     -
     -    After this change
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.220 s ±  0.004 s    [User: 1.160 s, System: 0.058 s]
     -      Range (min … max):    1.214 s …  1.226 s    10 runs
     +    Test                                                                  HEAD^              HEAD
     +    ---------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41( 0.38+0.03)   0.41(0.37+0.04)  +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.83( 0.79+0.04)   0.82(0.79+0.02)  -1.2%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change  13.68(13.59+0.07)   0.92(0.89+0.03) -93.3%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.31( 1.22+0.08)   1.31(1.21+0.10)  +0.0%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.47( 1.40+0.07)   1.47(1.36+0.10)  +0.0%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.87( 1.77+0.09)   1.50(1.41+0.09) -19.8%
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
  5:  cec0c2d04d7 !  6:  cfbdd447eee diff --color-moved: call comparison function directly
     @@ Metadata
       ## Commit message ##
          diff --color-moved: call comparison function directly
      
     -    Calling xdiff_compare_lines() directly rather than using a function
     -    pointer from the hash map reduces the time very slightly but more
     -    importantly it will allow us to easily combine pmb_advance_or_null()
     -    and pmb_advance_or_null_multi_match() in the next commit.
     +    This change will allow us to easily combine pmb_advance_or_null() and
     +    pmb_advance_or_null_multi_match() in the next commit. Calling
     +    xdiff_compare_lines() directly rather than using a function pointer
     +    from the hash map has little effect on the run time.
      
     -    Before this change
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.136 s ±  0.004 s    [User: 1.079 s, System: 0.053 s]
     -      Range (min … max):    1.130 s …  1.141 s    10 runs
     -
     -    After this change
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.118 s ±  0.003 s    [User: 1.062 s, System: 0.053 s]
     -      Range (min … max):    1.114 s …  1.121 s    10 runs
     +    Test                                                                  HEAD^             HEAD
     +    -------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.37+0.04)   0.41(0.39+0.02) +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.82(0.79+0.02)   0.83(0.79+0.03) +1.2%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.92(0.89+0.03)   0.91(0.85+0.05) -1.1%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.31(1.21+0.10)   1.33(1.22+0.10) +1.5%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.47(1.36+0.10)   1.47(1.39+0.08) +0.0%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.50(1.41+0.09)   1.51(1.42+0.09) +0.7%
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
  6:  050cef0081d =  7:  73ce9b54e86 diff --color-moved: unify moved block growth functions
  7:  9390e9a66eb =  8:  ef8ce0e6ebc diff --color-moved: shrink potential moved blocks as we go
  8:  1de99ac2bc3 =  9:  9d0a042eae1 diff --color-moved: stop clearing potential moved blocks
  9:  41cdedd6090 ! 10:  dd365ad115f diff --color-moved-ws=allow-indentation-change: improve hash lookups
     @@ Commit message
          As libxdiff does not have a whitespace flag to ignore the indentation
          the code for --color-moved-ws=allow-indentation-change uses
          XDF_IGNORE_WHITESPACE and then filters out any hash lookups where
     -    there are non-indentation changes. This is filtering is inefficient as
     +    there are non-indentation changes. This filtering is inefficient as
          we have to perform another string comparison.
      
          By using the offset data that we have already computed to skip the
          indentation we can avoid using XDF_IGNORE_WHITESPACE and safely remove
     -    the extra checks which improves the performance by 14% and paves the
     +    the extra checks which improves the performance by 11% and paves the
          way for the elimination of string comparisons in the next commit.
      
     -    This change slightly increases the runtime of other --color-moved
     +    This change slightly increases the run time of other --color-moved
          modes. This could be avoided by using different comparison functions
     -    for the different modes but after the changes in the next commit there
     -    is no measurable benefit.
     +    for the different modes but after the next two commits there is no
     +    measurable benefit in doing so.
      
     -    Before this change
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.116 s ±  0.005 s    [User: 1.057 s, System: 0.056 s]
     -      Range (min … max):    1.109 s …  1.123 s    10 runs
     -
     -    Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.216 s ±  0.005 s    [User: 1.155 s, System: 0.059 s]
     -      Range (min … max):    1.206 s …  1.223 s    10 runs
     -
     -    After this change
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.147 s ±  0.005 s    [User: 1.085 s, System: 0.059 s]
     -      Range (min … max):    1.140 s …  1.154 s    10 runs
     -
     -    Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.048 s ±  0.005 s    [User: 987.4 ms, System: 58.8 ms]
     -      Range (min … max):    1.043 s …  1.056 s    10 runs
     +    Test                                                                  HEAD^             HEAD
     +    --------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.38+0.03)   0.41(0.36+0.04) +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.82(0.76+0.05)   0.84(0.79+0.04) +2.4%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.91(0.88+0.03)   0.81(0.74+0.06) -11.0%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.32(1.21+0.10)   1.31(1.19+0.11) -0.8%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.47(1.37+0.10)   1.47(1.36+0.11) +0.0%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.51(1.42+0.09)   1.48(1.37+0.10) -2.0%
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
  -:  ----------- > 11:  c160222ab3c diff: use designated initializers for emitted_diff_symbol
 10:  220664dd907 ! 12:  753554587f9 diff --color-moved: intern strings
     @@ Commit message
          number of hash lookups a little (calculating the ids still involves
          one hash lookup per line) but the main benefit is that when growing
          blocks of potentially moved lines we can replace string comparisons
     -    which involve chasing a pointer with a simple integer comparison.  On
     -    a large diff this commit reduces the time to run 'diff --color-moved'
     -    by 33% and 'diff --color-moved-ws=allow-indentation-change' by 20%.
     +    which involve chasing a pointer with a simple integer comparison.
      
     -    Compared to master the time to run 'git log --patch --color-moved' is
     -    increased by 2% and 'git log --patch
     -    --color-moved-ws=allow-indentation-change' in reduced by 14%. These
     -    timings were performed on an i5-7200U, on an i5-3470 both commands are
     -    faster than master. The small speed decrease on commit sized diffs is
     -    unfortunate but I think it is small enough to be worth it for the
     -    gains on larger diffs.
     +    On a large diff this commit reduces the time to run
     +       diff --color-moved
     +    by 33% and
     +        diff --color-moved-ws=allow-indentation-change
     +    by 26%. Compared to master the time to run
     +        diff --color-moved-ws=allow-indentation-change
     +    is now reduced by 95% and the overhead compared to --no-color-moved is
     +    reduced to 50%.
      
     -    Large diff before this change:
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.147 s ±  0.005 s    [User: 1.085 s, System: 0.059 s]
     -      Range (min … max):    1.140 s …  1.154 s    10 runs
     +    Compared to the previous commit the time to run
     +        git log --patch --color-moved
     +    is increased slightly, but compared to master there is no change in
     +    run time.
      
     -    Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
     -      Time (mean ± σ):      1.048 s ±  0.005 s    [User: 987.4 ms, System: 58.8 ms]
     -      Range (min … max):    1.043 s …  1.056 s    10 runs
     +    Test                                                                  HEAD^             HEAD
     +    --------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.36+0.04)   0.41(0.37+0.03)  +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.83(0.79+0.03)   0.55(0.52+0.03) -33.7%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.81(0.77+0.04)   0.60(0.55+0.05) -25.9%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.30(1.20+0.09)   1.31(1.22+0.08)  +0.8%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.46(1.35+0.11)   1.47(1.30+0.16)  +0.7%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.46(1.38+0.07)   1.47(1.34+0.13)  +0.7%
      
     -    Large diff after this change
     -    Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
     -      Time (mean ± σ):     762.7 ms ±   2.8 ms    [User: 707.5 ms, System: 53.7 ms]
     -      Range (min … max):   758.0 ms … 767.0 ms    10 runs
     -
     -    Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
     -      Time (mean ± σ):     831.7 ms ±   1.7 ms    [User: 776.5 ms, System: 53.3 ms]
     -      Range (min … max):   829.2 ms … 835.1 ms    10 runs
     -
     -    Small diffs on master
     -    Benchmark #1: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --no-color-moved-ws --no-merges -n1000 v2.29.0
     -      Time (mean ± σ):      1.567 s ±  0.001 s    [User: 1.443 s, System: 0.121 s]
     -      Range (min … max):    1.566 s …  1.571 s    10 runs
     -
     -    Benchmark #2: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change -n1000 --no-merges v2.29.0
     -      Time (mean ± σ):      1.865 s ±  0.008 s    [User: 1.748 s, System: 0.112 s]
     -      Range (min … max):    1.857 s …  1.881 s    10 runs
     -
     -    Small diffs after this change
     -    Benchmark #1: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --no-color-moved-ws --no-merges -n1000 v2.29.0
     -      Time (mean ± σ):      1.597 s ±  0.003 s    [User: 1.413 s, System: 0.179 s]
     -      Range (min … max):    1.591 s …  1.601 s    10 runs
     -
     -    Benchmark #2: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change -n1000 --no-merges v2.29.0
     -      Time (mean ± σ):      1.606 s ±  0.006 s    [User: 1.420 s, System: 0.181 s]
     -      Range (min … max):    1.601 s …  1.622 s    10 runs
     +    Test                                                                  master            HEAD
     +    --------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.40( 0.36+0.03)  0.41(0.37+0.03)  +2.5%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.82( 0.77+0.04)  0.55(0.52+0.03) -32.9%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change  14.10(14.04+0.04)  0.60(0.55+0.05) -95.7%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.31( 1.21+0.09)  1.31(1.22+0.08)  +0.0%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.47( 1.37+0.09)  1.47(1.30+0.16)  +0.0%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.86( 1.76+0.10)  1.47(1.34+0.13) -21.0%
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
       				if (o->color_moved_ws_handling &
       				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
     -@@ diff.c: static void emit_diff_symbol_from_struct(struct diff_options *o,
     - static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
     - 			     const char *line, int len, unsigned flags)
     - {
     --	struct emitted_diff_symbol e = {line, len, flags, 0, 0, s};
     -+	struct emitted_diff_symbol e = {line, len, flags, 0, 0, 0, s};
     - 
     - 	if (o->emitted_symbols)
     - 		append_emitted_diff_symbol(o, &e);
      @@ diff.c: static void diff_flush_patch_all_file_pairs(struct diff_options *o)
       
       	if (o->emitted_symbols) {

-- 
gitgitgadget
