Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B27C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8D561108
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFVIHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFVIHA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 04:07:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B2C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m18so22508349wrv.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FG4i05dMYNP26ttLGuULYQ8SguCK3R9X0p6/mLWQm4U=;
        b=iqKd2ya9AS8HS0vRPEAj8LLU9Tz8Qz/ocNx8VCDHfH6gf4g8zASo9hRpKkv4dgaM1R
         KhJGN2N6Fqs6Ml1bnMyAJZaPuoV0CVSt8cJPApgJuBvy4N7iNInuc0vEjVVg/IjCzVKy
         2VMwLm651sBiUujfYcyAKdGvVe3DIzMomNlmLnkWJwCX7ZnPuDu49p4RstF3AooXgDt2
         9h2j9ngJvBQi5o6RjRC/yVRexHbUc2B5/2Y/apRzJp8PZbV5Eqe2ZsQl5laFlqTGKRoJ
         UlIE7VvlbW/iGB6FExWuXHT2iI+N5IjRi1VJTF8olFN/8scyfHK9Nc3cOIXoNTNZpnO8
         k4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FG4i05dMYNP26ttLGuULYQ8SguCK3R9X0p6/mLWQm4U=;
        b=IBWG7FDelskHUcv3RmGXL/8wAtwcfLfkpxrRFhn0b1qCLl68IBp/SXahnu/C/tQyGF
         lQi4bY2urAjNafVvVk8BTp1QUvzqly2Kac+8ydZgoM6zmDTd8qHRHhukIFN4gV+TvWVW
         JzO8yGg1QS184jCUJacBZSw4BHiMALS6cXoYYL2FHSzTY6rsMn1c0rj/4eiBE4Zr0LXG
         QFx4HLhOsEKRZ7rJbWnwMT1aeorDFqqPhI2RdtfcjkExozsXypN0AT59zp2VTXsnC5ZG
         9OO4sTBjlM4efqsOtDNtc8FhnKCsfWyHAbD8xq0CFsPPRz9YvpPnmAK1fj+D08+WoU/i
         VK4A==
X-Gm-Message-State: AOAM531+mQ8SC44Z78els5wwaYSpb5iukW/RfW30TISjMQUU4PP57kgo
        fVcu4sn3FeN4PldEzpo8nrKupKgbAhM=
X-Google-Smtp-Source: ABdhPJxMU1F0ZX9SH9KRE3DrrgU0Ap2n41zgOljfg2ECcz1Vvy0IJjbtELjLWMAG7C42Tl8sov7hJw==
X-Received: by 2002:a5d:5984:: with SMTP id n4mr3189367wri.294.1624349083208;
        Tue, 22 Jun 2021 01:04:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c133sm1997855wmf.0.2021.06.22.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 01:04:42 -0700 (PDT)
Message-Id: <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 08:04:36 +0000
Subject: [PATCH v3 0/5] Optimization batch 13: partial clone optimizations for merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series optimizes blob downloading in merges for partial clones. It can
apply on master. It's independent of ort-perf-batch-12.

Changes since v2:

 * Incorporated the suggestions from Junio on patch 2.

Changes since v1:

 * Incorporated the suggestions from Stolee on patch 2.

=== High level summary ===

 1. diffcore-rename.c has had a prefetch() to get data needed for inexact
    renames for a while.
 2. find_basename_matches() only requires a small subset of what prefetch()
    provides.
 3. I added a basename_prefetch() for find_basename_matches()

In the worst case, the above means:

 * We download the same number of objects, in 2 steps instead of 1.

However, in practice, since rename detection can usually quit after
find_basename_matches() (usually due to the irrelevant check that cannot be
performed until after find_basename_matches()):

 * We download far fewer objects, and use barely more download steps than
   before.

Adding some prefetching to merge-ort.c allows us to also drop the number of
downloads overall.

=== Modified performance measurement method ===

The testcases I've been using so far to measure performance were not run in
a partial clone, so they aren't directly usable for comparison. Further,
partial clone performance depends on network speed which can be highly
variable. So I want to modify one of the existing testcases slightly and
focus on two different but more stable metrics:

 1. Number of git fetch operations during rebase
 2. Number of objects fetched during rebase

The first of these should already be decent due to Jonathan Tan's work to
batch fetching of missing blobs during rename detection (see commit
7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-05)), so we are
mostly looking to optimize the second but would like to also decrease the
first if possible.

The testcase we will look at will be a modification of the mega-renames
testcase from commit 557ac0350d ("merge-ort: begin performance work;
instrument with trace2_region_* calls", 2020-10-28). In particular, we
change

$ git clone \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git


to

$ git clone --sparse --filter=blob:none \
    https://github.com/github/linux


(The change in clone URL is just to get a server that supports the filter
predicate.)

We otherwise keep the test the same (in particular, we do not add any calls
to "git-sparse checkout {set,add}" which means that the resulting repository
will only have 7 total blobs from files in the toplevel directory before
starting the rebase).

=== Results ===

For the mega-renames testcase noted above (which rebases 35 commits across
an upstream with ~26K renames in a partial clone), I found the following
results for our metrics of interest:

     Number of `git fetch` ops during rebase

                     Before Series   After Series
merge-recursive:          62              63
merge-ort:                30              20


     Number of objects fetched during rebase

                     Before Series   After Series
merge-recursive:         11423          11423
merge-ort:               11391             63


So, we have a significant reduction (factor of ~3 relative to
merge-recursive) in the number of git fetch operations that have to be
performed in a partial clone to complete the rebase, and a dramatic
reduction (factor of ~180) in the number of objects that need to be fetched.

=== Summary ===

It's worth pointing out that merge-ort after the series needs only ~1.8
blobs per commit being transplanted to complete this particular rebase.
Essentially, this reinforces the fact the optimization work so far has taken
rename detection from often being an overwhelmingly costly portion of a
merge (leading many to just capitulate on it), to what I have observed in my
experience so far as being just a minor cost for merges.

Elijah Newren (5):
  promisor-remote: output trace2 statistics for number of objects
    fetched
  t6421: add tests checking for excessive object downloads during merge
  diffcore-rename: allow different missing_object_cb functions
  diffcore-rename: use a different prefetch for basename comparisons
  merge-ort: add prefetching for content merges

 diffcore-rename.c              | 149 ++++++++---
 merge-ort.c                    |  50 ++++
 promisor-remote.c              |   7 +-
 t/t6421-merge-partial-clone.sh | 440 +++++++++++++++++++++++++++++++++
 4 files changed, 612 insertions(+), 34 deletions(-)
 create mode 100755 t/t6421-merge-partial-clone.sh


base-commit: 6de569e6ac492213e81321ca35f1f1b365ba31e3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-969%2Fnewren%2Fort-perf-batch-13-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-969/newren/ort-perf-batch-13-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/969

Range-diff vs v2:

 1:  04f5ebdabe14 = 1:  04f5ebdabe14 promisor-remote: output trace2 statistics for number of objects fetched
 2:  0f786cfb4c95 ! 2:  4796e096fdb4 t6421: add tests checking for excessive object downloads during merge
     @@ t/t6421-merge-partial-clone.sh (new)
      +		echo g >dir/subdir/tweaked/g &&
      +		echo h >dir/subdir/tweaked/h &&
      +		echo subdirectory makefile >dir/subdir/tweaked/Makefile &&
     -+		for i in `test_seq 1 88`; do
     ++		for i in $(test_seq 1 88)
     ++		do
      +			echo content $i >dir/unchanged/file_$i
      +		done &&
      +		git add . &&
     @@ t/t6421-merge-partial-clone.sh (new)
      +		cd objects-single &&
      +
      +		git rev-list --objects --all --missing=print |
     -+			grep '\?' >missing-objects-before &&
     ++			grep "^?" | sort >missing-objects-before &&
      +
      +		git checkout -q origin/A &&
      +
     @@ t/t6421-merge-partial-clone.sh (new)
      +		test_line_count = 2 fetches &&
      +
      +		git rev-list --objects --all --missing=print |
     -+			grep ^? >missing-objects-after &&
     -+		test_cmp missing-objects-before missing-objects-after |
     -+			grep "^[-+]?" >found-and-new-objects &&
     -+		# We should not have any NEW missing objects
     -+		! grep ^+ found-and-new-objects &&
     -+		# Fetched 2+1=3 objects, so should have 3 fewer missing objects
     -+		test_line_count = 3 found-and-new-objects
     ++			grep "^?" | sort >missing-objects-after &&
     ++		comm -2 -3 missing-objects-before missing-objects-after >old &&
     ++		comm -1 -3 missing-objects-before missing-objects-after >new &&
     ++		# No new missing objects
     ++		test_must_be_empty new &&
     ++		# Fetched 2 + 1 = 3 objects
     ++		test_line_count = 3 old
      +	)
      +'
      +
     @@ t/t6421-merge-partial-clone.sh (new)
      +		cd objects-dir &&
      +
      +		git rev-list --objects --all --missing=print |
     -+			grep '\?' >missing-objects-before &&
     ++			grep "^?" | sort >missing-objects-before &&
      +
      +		git checkout -q origin/A &&
      +
     @@ t/t6421-merge-partial-clone.sh (new)
      +		test_line_count = 1 fetches &&
      +
      +		git rev-list --objects --all --missing=print |
     -+			grep ^? >missing-objects-after &&
     -+		test_cmp missing-objects-before missing-objects-after |
     -+			grep "^[-+]?" >found-and-new-objects &&
     -+		# We should not have any NEW missing objects
     -+		! grep ^+ found-and-new-objects &&
     -+		# Fetched 6 objects, so should have 6 fewer missing objects
     -+		test_line_count = 6 found-and-new-objects
     ++			grep "^?" | sort >missing-objects-after &&
     ++		comm -2 -3 missing-objects-before missing-objects-after >old &&
     ++		comm -1 -3 missing-objects-before missing-objects-after >new &&
     ++		# No new missing objects
     ++		test_must_be_empty new &&
     ++		# Fetched 6 objects
     ++		test_line_count = 6 old
      +	)
      +'
      +
     @@ t/t6421-merge-partial-clone.sh (new)
      +		cd objects-many &&
      +
      +		git rev-list --objects --all --missing=print |
     -+			grep '\?' >missing-objects-before &&
     ++			grep "^?" | sort >missing-objects-before &&
      +
      +		git checkout -q origin/A &&
      +
     @@ t/t6421-merge-partial-clone.sh (new)
      +		test_line_count = 4 fetches &&
      +
      +		git rev-list --objects --all --missing=print |
     -+			grep ^? >missing-objects-after &&
     -+		test_cmp missing-objects-before missing-objects-after |
     -+			grep "^[-+]?" >found-and-new-objects &&
     -+		# We should not have any NEW missing objects
     -+		! grep ^+ found-and-new-objects &&
     -+		# Fetched 12 + 5 + 3 + 2 == 22 objects
     -+		test_line_count = 22 found-and-new-objects
     ++			grep "^?" | sort >missing-objects-after &&
     ++		comm -2 -3 missing-objects-before missing-objects-after >old &&
     ++		comm -1 -3 missing-objects-before missing-objects-after >new &&
     ++		# No new missing objects
     ++		test_must_be_empty new &&
     ++		# Fetched 12 + 5 + 3 + 2 = 22 objects
     ++		test_line_count = 22 old
      +	)
      +'
      +
 3:  9f2a8ed8d61f = 3:  7ed0162cdb4e diffcore-rename: allow different missing_object_cb functions
 4:  f753f8035564 = 4:  c9b55241d831 diffcore-rename: use a different prefetch for basename comparisons
 5:  317bcc7f56cb = 5:  69011cfe9fae merge-ort: add prefetching for content merges

-- 
gitgitgadget
