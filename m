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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55636C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3FA613D6
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhEUMBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhEUMBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185BFC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c14so19032932wrx.3
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lTMxyBY+9KKHqk7BrBCvKQYC/t0Es9dIy31ADauFeS4=;
        b=P1vTLyvTJueyXdyxJlkHypUakkcrhxBph6zYs29o9SW/oJeyfmJTIDZEhxqFIo6J9l
         bT27KR42Y92pWe8NG2c2TqTMQvTEsNgexSx5cA7noS/VA+5ogdVok/gzDfG13ha4Feby
         or/ijO8BGsoyBPlA2GPZ0KHoGkhnerCEjAuKlUk9KTvqotDF16Tldwfv10tgP5QhQnjA
         oQzysL1BmSdMwDa34rmuzxEF5tY3Sj4GCKURhRZPrHSc/9Z771hi5WukTWJAW811D7d8
         l2SrNKazcgMwfnVDPOysPPbOLBEmrtyQqIgbGZkUuOpiALANkLqIlEESJCtnV5PWXg2y
         KfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lTMxyBY+9KKHqk7BrBCvKQYC/t0Es9dIy31ADauFeS4=;
        b=eD7vpwZQKcaPyj4QpklNUKNWp33KH7zNA4BaumTKUZYuSFwxwMYGHs7nZHqQ6J5/4w
         BE7pKSXspHhB8/QpvSIX7UdBifqITS22TpC7bueME/LfGlbpAFW7oFrN7aG8Nyn01BOy
         jghLkYw6WBf5PxbQ6Hru4wz7Dg0Z6oQPTmcuTVumvgLrX9Izks5Jd0bB4obZzG1EgisN
         MmBO8FT75DMmItoGcUEd7hDqdQyjuROCY40ZtXox6637KhaoMvQ5oyO1BRumVTLvL8YI
         1wIGR/A/NNL5wzKVPi2JGe6jDxWZM7NEsxvZ37bLMo5wHYjOlEOhdOnTVQa2Fz4uk/U6
         34Fg==
X-Gm-Message-State: AOAM531yvBdcDljpfBzBXOOLsziRAbtf3hvz33jwXvBh2F4Bz5NHI5rS
        uuIlIFNT0P45ocZEdgidDtlwDFgw0Uw=
X-Google-Smtp-Source: ABdhPJxsi1mgHYsM6IhR6x51cKP03GdkJHSK2yRmb3iQlyCGgAqgUj/GFA809QLOfdH5MnEoitaLnw==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr9324491wrr.58.1621598383765;
        Fri, 21 May 2021 04:59:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm5910085wml.6.2021.05.21.04.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:43 -0700 (PDT)
Message-Id: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:29 +0000
Subject: [PATCH v4 00/12] Sparse-index: integrate with status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first "payoff" series in the sparse-index work. It makes 'git
status' very fast when a sparse-index is enabled on a repository with
cone-mode sparse-checkout (and a small populated set).

This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
The latter branch is needed because it changes the behavior of 'git add'
around sparse entries, which changes the expectations of a test added in
patch 1.

The approach here is to audit the places where ensure_full_index() pops up
while doing normal commands with pathspecs within the sparse-checkout
definition. Each of these are checked and tested. In the end, the
sparse-index is integrated with these features:

 * git status
 * FS Monitor index extension.

The performance tests in p2000-sparse-operations.sh improve by 95% or more,
even when compared with the full-index cases, not just the sparse-index
cases that previously had extra overhead.

Hopefully this is the first example of how ds/sparse-index-protections has
done the basic work to do these conversions safely, making them look easier
than they seemed when starting this adventure.

Thanks, -Stolee


Updates in V4
=============

 * The previous patch "unpack-trees: stop recursing into sparse directories"
   was confusing, and actually a bit sloppy.
 * It has been replaced with "unpack-trees: be careful around sparse
   directory entries" which takes the sparse-directory checks and raises
   them higher up into unpack_trees.c instead of in diff-lib.c.


Updates in V3
=============

Sorry that this was a long time coming. I got a little side-tracked on other
projects, but I also worked to get the sparse-index feature working against
the Scalar functional tests, which contain many special cases around the
sparse-checkout feature as they were inherited from special cases that arose
in the virtualized environment of VFS for Git. This version contains my
fixes based on that investigation. Most of these were easy to identify and
fix, but I was blocked for a long time struggling with a bug when combining
the sparse-index with the builtin FS Monitor feature, but I've reported my
findings already [1].

[1]
https://lore.kernel.org/git/0b9e54ba-ac27-e537-7bef-1b4448f92352@gmail.com/

 * Updated comments and tests based on the v2 feedback.
 * Expanded the test repository data shape based on the special cases found
   during my investigation.
 * Added several commits that either fix errors in the status code, or fix
   errors in the previous sparse-index series, specifically:
   * When in a conflict state, the cache-tree fails to update. For now, skip
     writing a sparse-index until this can be resolved more carefully.
   * When expanding a sparse-directory entry, we set the CE_SKIP_WORKTREE
     bit but forgot the CE_EXTENDED bit.
   * git status had failures if there was a sparse-directory entry as the
     first entry within a directory.
   * When expanding a directory to report its status, such as when a
     sparse-directory is staged but doesn't exist at HEAD (such as in an
     orphaned commit) we did not previously recurse correctly into
     subdirectories.
   * Be extra careful with the FS Monitor data when expanding or contracting
     an index. This version now abandons all FS Monitor data at these
     conversion points with the expectation that in the future these
     conversions will be rare so the FS Monitor feature can work
     efficiently. Updates in V2

----------------------------------------------------------------------------

 * Based on the feedback, it is clear that 'git add' will require much more
   careful testing and thought. I'm splitting it out of this series and it
   will return with a follow-up.
 * Test cases are improved, both in coverage and organization.
 * The previous "unpack-trees: make sparse aware" patch is split into three
   now.
 * Stale messages based on an old implementation of the "protections" topic
   are now fixed.
 * Performance tests were re-run.

Derrick Stolee (12):
  sparse-index: skip indexes with unmerged entries
  sparse-index: include EXTENDED flag when expanding
  t1092: expand repository data shape
  t1092: add tests for status/add and sparse files
  unpack-trees: preserve cache_bottom
  unpack-trees: compare sparse directories correctly
  unpack-trees: be careful around sparse directory entries
  dir.c: accept a directory as part of cone-mode patterns
  status: skip sparse-checkout percentage with sparse-index
  status: use sparse-index throughout
  wt-status: expand added sparse directory entries
  fsmonitor: integrate with sparse index

 builtin/commit.c                         |   3 +
 dir.c                                    |  11 +++
 read-cache.c                             |  10 +-
 sparse-index.c                           |  27 +++++-
 t/t1092-sparse-checkout-compatibility.sh | 117 ++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh              |  48 ++++++++++
 unpack-trees.c                           |  26 ++++-
 wt-status.c                              |  64 ++++++++++++-
 wt-status.h                              |   1 +
 9 files changed, 295 insertions(+), 12 deletions(-)


base-commit: f723f370c89ad61f4f40aabfd3540b1ce19c00e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v3:

  1:  5a2ed3d1d701 =  1:  5a2ed3d1d701 sparse-index: skip indexes with unmerged entries
  2:  8aa41e749471 =  2:  8aa41e749471 sparse-index: include EXTENDED flag when expanding
  3:  70971b1f9261 =  3:  70971b1f9261 t1092: expand repository data shape
  4:  a80b5a41153f =  4:  a80b5a41153f t1092: add tests for status/add and sparse files
  5:  07a45b661c4a =  5:  07a45b661c4a unpack-trees: preserve cache_bottom
  6:  cc4a526e7947 =  6:  cc4a526e7947 unpack-trees: compare sparse directories correctly
  7:  598375d3531f <  -:  ------------ unpack-trees: stop recursing into sparse directories
  -:  ------------ >  7:  e28df7f9395d unpack-trees: be careful around sparse directory entries
  8:  47da2b317237 =  8:  2cc3a93d4434 dir.c: accept a directory as part of cone-mode patterns
  9:  bc1512981493 =  9:  5011feb1aa04 status: skip sparse-checkout percentage with sparse-index
 10:  5b1ae369a7cd = 10:  9f2ce5301dc9 status: use sparse-index throughout
 11:  3b42783d4a86 = 11:  24417e095243 wt-status: expand added sparse directory entries
 12:  b72507f514d1 = 12:  584d4b559a91 fsmonitor: integrate with sparse index

-- 
gitgitgadget
