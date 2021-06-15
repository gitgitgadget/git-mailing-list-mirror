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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0BEC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB0460FEB
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFOWn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 18:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOWn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 18:43:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449EC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:41:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y7so322738wrh.7
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rIEODmACVR/o0WdZWMXc+6s/2AMtN9q8GZDriEmoXss=;
        b=CosnpDZaugyR65ubGbLPr1/G1A2HLyi9xg6xLiNTFQYG0dVGcZsFmi1pTbk4DDWMO9
         Ko7yJR3hfEx0eHz8Z2VKE6vpmNgWBQVSPS3z4zfkyApBYTvypEC3hAoql12s8XmCkUut
         o4b/g6JjxOeBzIHF8clZ2U/6CxutYBSbZSUcdAPBl9CMRuQRaCwRUlEc86hBY/TtBSXE
         9/wx3zxMrsjZqXxyr9TUTf8FCJf1yvAPy3FxZxjLx/GyZtB18Ft7f+tHZiCNRLKmAown
         tET8CKgOVt6jCH9U5xd5gfeKylBMas11cPxRsOgE7SQE23RYUJ/x1PV2S+bQZCLc2OL7
         CDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rIEODmACVR/o0WdZWMXc+6s/2AMtN9q8GZDriEmoXss=;
        b=l+eyai2lFTtR0jPQ7WMQysH58OKugnk6Ozg4EeQokvk87vECAho8EAWJ8Saommcq4J
         mjS20Mmw1VjLnLuKyjBGerNwomoFgcLpdcQ88qPuET2U7woyzC/4Tgxcq/s8C2TmlFH8
         Wk0Aib+INXhh0V7dz0vKLu+1+PQOgct66wpk6ktrqa6ISRuQvPmT4E+20fW++vxA7YEB
         b7n8EIe7bfEEJysSnV2+ClEIIXsrYK8CqWvl3DXb+8GLPlK9c79rpbc4bsG2MOFvKefl
         FVUnmVA2U9uj4GuuN+DQZXzAdYp9DPAWezenPjM5DhkXZshCoD2ob4t40s5JcQu/sseE
         gCXw==
X-Gm-Message-State: AOAM531rFP8azR8ZInDYhJpFftA6S0EG+nyo2O90CpEctmgP0eRWlg73
        /NWmCrzSLd7T9jPBNaIxCcDhb40VvUA=
X-Google-Smtp-Source: ABdhPJzl8rmI0CUIEIxd/UP5Udw2keZv+NO0GE7nldUV2M0mPK4HXshxbsz9+QeU9nEuvxSAzsOZJQ==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr1582014wrv.109.1623796909103;
        Tue, 15 Jun 2021 15:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d131sm3186036wmd.4.2021.06.15.15.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:41:48 -0700 (PDT)
Message-Id: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.git.1622856485.gitgitgadget@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 22:41:41 +0000
Subject: [PATCH v2 0/5] Optimization batch 13: partial clone optimizations for merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series optimizes blob downloading in merges for partial clones. It can
apply on master. It's independent of ort-perf-batch-12.

Changes since v1:

 * Incorporated the suggestions from Stolee on patch 2.

This series has a minor conflict with jt/partial-clone-submodule-1. I asked
about this previously and it was decided to just submit these topics
independently[1]. The conflict is that both topics add a "repo" argument to
fetch_objects(), but jt/partial-clone-submodule-1 also makes additional
nearby changes.

[1]
https://lore.kernel.org/git/20210609045804.2329079-1-jonathantanmy@google.com/

=== Basic Optimization idea ===

merge-ort was designed to minimize the computation needed to complete a
merge, and much of that (particularly the "irrelevant rename"
determinations) also dramatically reduced the amount of data needed for the
merge. Reducing the amount of data needed to do computations ought to
benefit partial clones as well by enabling them to download less
information. However, my previous series didn't modify the prefetch()
command in diffcore-rename to take advantage of these reduced data
requirements. This series changes that.

Further, although diffcore-rename batched downloads of objects for rename
detection, the merge machinery did not do the same for three-way content
merges of files. This series adds batch downloading of objects within
merge-ort to correct that.

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
 t/t6421-merge-partial-clone.sh | 439 +++++++++++++++++++++++++++++++++
 4 files changed, 611 insertions(+), 34 deletions(-)
 create mode 100755 t/t6421-merge-partial-clone.sh


base-commit: 6de569e6ac492213e81321ca35f1f1b365ba31e3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-969%2Fnewren%2Fort-perf-batch-13-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-969/newren/ort-perf-batch-13-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/969

Range-diff vs v1:

 1:  ad9b451d6823 = 1:  04f5ebdabe14 promisor-remote: output trace2 statistics for number of objects fetched
 2:  6462bb63310d ! 2:  0f786cfb4c95 t6421: add tests checking for excessive object downloads during merge
     @@ t/t6421-merge-partial-clone.sh (new)
      +
      +		git checkout -q origin/A &&
      +
     -+		GIT_TRACE2_PERF="$(pwd)/trace.output" git -c merge.directoryRenames=true merge --no-stat --no-progress origin/B-single &&
     ++		GIT_TRACE2_PERF="$(pwd)/trace.output" git \
     ++			-c merge.directoryRenames=true merge --no-stat \
     ++			--no-progress origin/B-single &&
      +
      +		# Check the number of objects we reported we would fetch
      +		cat >expect <<-EOF &&
     -+		 ..........fetch_count:2
     -+		 ......fetch_count:1
     ++		fetch_count:2
     ++		fetch_count:1
      +		EOF
     -+		grep fetch_count trace.output | cut -d "|" -f 9 >actual &&
     ++		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
      +		test_cmp expect actual &&
      +
      +		# Check the number of fetch commands exec-ed
     @@ t/t6421-merge-partial-clone.sh (new)
      +
      +		git checkout -q origin/A &&
      +
     -+		GIT_TRACE2_PERF="$(pwd)/trace.output" git -c merge.directoryRenames=true merge --no-stat --no-progress origin/B-dir &&
     ++		GIT_TRACE2_PERF="$(pwd)/trace.output" git \
     ++			-c merge.directoryRenames=true merge --no-stat \
     ++			--no-progress origin/B-dir &&
      +
      +		# Check the number of objects we reported we would fetch
      +		cat >expect <<-EOF &&
     -+		 ..........fetch_count:6
     ++		fetch_count:6
      +		EOF
     -+		grep fetch_count trace.output | cut -d "|" -f 9 >actual &&
     ++		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
      +		test_cmp expect actual &&
      +
      +		# Check the number of fetch commands exec-ed
     @@ t/t6421-merge-partial-clone.sh (new)
      +
      +		git checkout -q origin/A &&
      +
     -+		GIT_TRACE2_PERF="$(pwd)/trace.output" git -c merge.directoryRenames=true merge --no-stat --no-progress origin/B-many &&
     ++		GIT_TRACE2_PERF="$(pwd)/trace.output" git \
     ++			-c merge.directoryRenames=true merge --no-stat \
     ++			--no-progress origin/B-many &&
      +
      +		# Check the number of objects we reported we would fetch
      +		cat >expect <<-EOF &&
     -+		 ..........fetch_count:12
     -+		 ..........fetch_count:5
     -+		 ..........fetch_count:3
     -+		 ......fetch_count:2
     ++		fetch_count:12
     ++		fetch_count:5
     ++		fetch_count:3
     ++		fetch_count:2
      +		EOF
     -+		grep fetch_count trace.output | cut -d "|" -f 9 >actual &&
     ++		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
      +		test_cmp expect actual &&
      +
      +		# Check the number of fetch commands exec-ed
 3:  c4b3109c3b08 = 3:  9f2a8ed8d61f diffcore-rename: allow different missing_object_cb functions
 4:  f4ade3996d3f = 4:  f753f8035564 diffcore-rename: use a different prefetch for basename comparisons
 5:  ca3b2a743b8e = 5:  317bcc7f56cb merge-ort: add prefetching for content merges

-- 
gitgitgadget
