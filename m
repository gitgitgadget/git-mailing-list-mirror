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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD21C11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA536128B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhGNNPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhGNNPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03808C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3864160wmh.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CaUD6dlYrJvE/dp3Bz2gwvyqoMnHvP/CEKcgsd+YhH8=;
        b=r+bjB2vAY+L3U6Q2NjIJ9NcURZmqOkHGngMaZg8+4lqThWpYIs+KAyXnDvuLNQwNJF
         oK++SXAPlejmae9mnJh5i419O+3/SJrK9JAF3fqtQSU2WEuw+MUbWkMT3IZY+JlX1y/1
         ON3K9ZiHTzWaDsqc6ydp3IF32j35ToRtuw4/BnDhn28ttP5jOCP2yF+Da8HCgJg010Pv
         gALgdBTYtI8Vn6jE/smD3dS4exqqXPL5+x8CRsTJ4jyLKYouj5FWD/UaVIv+/ARGjaY2
         fUD5bEpus4CyfTxvXwwIU8KUD5uRQv/DBwAQsc9u3zYdCITi1uBXyoIJemBS/wRM3OzD
         oPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CaUD6dlYrJvE/dp3Bz2gwvyqoMnHvP/CEKcgsd+YhH8=;
        b=pXH4zVt50XCzCsopv6jmWyR/SD9IKrVmxOc+c1iaV8FKGErqs+xd1901sNAU0Za8KW
         0XDg1nN7WEeRgYABQRGcUDxCiOS7ySVxuS4ALi4idR0vYhS5Nl46Z0W0eLyF7l+y39gI
         kzxsViuvXEQAc0iim8zz6WsUsMe9kGtD3hsb/fate5VpYYR20Xam/a5RgNs4+QSDKP5p
         1YIt4hWpcT7LU7NKXxw8+gyz/YrlpfWIoCOj9iXcaJ6X1UbdunvyKPhLo6+JKNHGgRVe
         2exA9e+XCI+FqU1EdemwdM1xgpWO3FIVrKlPBq5+BOO0wl0WiTOuSiHQN6NMytUUG/Hv
         Nw9w==
X-Gm-Message-State: AOAM532pyiPLioDTcRdMGYcndDE+GkrZdrnX61leb5YmHpl0Aro15Nae
        rNrp3/NtiYT3B6SICakWwv5nvOQ+22A=
X-Google-Smtp-Source: ABdhPJyXh0ZsUp6tCI1yzlrRe00bVvwyYY4RDgVS6T38WYaxMACuKMrHPLckVFxftp2ZSCg0W7VrYA==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr3951288wmb.158.1626268362493;
        Wed, 14 Jul 2021 06:12:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm2755506wro.3.2021.07.14.06.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:41 -0700 (PDT)
Message-Id: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:24 +0000
Subject: [PATCH v9 00/16] Sparse-index: integrate with status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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


Update in V9
============

 * Fixed typo.

 * All patches are marked as Reviewed-by Elijah. Thanks for the careful
   review!

Derrick Stolee (16):
  sparse-index: skip indexes with unmerged entries
  sparse-index: include EXTENDED flag when expanding
  t1092: replace incorrect 'echo' with 'cat'
  t1092: expand repository data shape
  t1092: add tests for status/add and sparse files
  unpack-trees: preserve cache_bottom
  unpack-trees: compare sparse directories correctly
  unpack-trees: rename unpack_nondirectories()
  unpack-trees: unpack sparse directory entries
  dir.c: accept a directory as part of cone-mode patterns
  diff-lib: handle index diffs with sparse dirs
  status: skip sparse-checkout percentage with sparse-index
  status: use sparse-index throughout
  wt-status: expand added sparse directory entries
  fsmonitor: integrate with sparse index
  t1092: document bad sparse-checkout behavior

 builtin/commit.c                         |   3 +
 diff-lib.c                               |  19 +++
 dir.c                                    |  24 +++-
 read-cache.c                             |  10 +-
 sparse-index.c                           |  27 +++-
 t/t1092-sparse-checkout-compatibility.sh | 168 +++++++++++++++++++++--
 t/t7519-status-fsmonitor.sh              |  49 +++++++
 unpack-trees.c                           | 142 ++++++++++++++++---
 wt-status.c                              |  65 ++++++++-
 wt-status.h                              |   1 +
 10 files changed, 470 insertions(+), 38 deletions(-)


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v8:

  1:  1815c148e8c !  1:  ecab56fd57f sparse-index: skip indexes with unmerged entries
     @@ Commit message
          conversion does not need to happen. Thus, this can be deferred until the
          merge machinery is made to integrate with the sparse-index.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## sparse-index.c ##
  2:  7bcde075d8d !  2:  f3de9ce7baa sparse-index: include EXTENDED flag when expanding
     @@ Commit message
          feature, but has no significance to its correctness in the user-facing
          functionality.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## sparse-index.c ##
  3:  05981e30b97 !  3:  5b59436011c t1092: replace incorrect 'echo' with 'cat'
     @@ Commit message
          detection to work properly now that the 'larger-content' file actually
          has meaningful lines.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
  4:  d38b66e9ee4 !  4:  4d06d972911 t1092: expand repository data shape
     @@ Commit message
          Later tests will take advantage of these shapes, but they also deepen
          the tests that already exist.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
  5:  95ddd3abe4e !  5:  cc83a0cd307 t1092: add tests for status/add and sparse files
     @@ Commit message
          be more sensible, and this test could be modified to satisfy the new
          expected behavior.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
  6:  b182b456613 !  6:  18cb1f6ea9b unpack-trees: preserve cache_bottom
     @@ Commit message
          the cache_bottom will be modified as the cache-tree walk advances. Do
          not update it as well within mark_ce_used().
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## unpack-trees.c ##
  7:  988ddce4d45 !  7:  bdd47bd30e0 unpack-trees: compare sparse directories correctly
     @@ Commit message
          exact string match on a sparse directory entry. The final check is a
          length comparison between the strings.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## unpack-trees.c ##
  8:  d67ad048b08 !  8:  0e4b7390f47 unpack-trees: rename unpack_nondirectories()
     @@ Commit message
          apply. The new name reflects that we will not recurse into trees in
          order to resolve the conflicts.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## unpack-trees.c ##
  9:  c0b0b58584c !  9:  602525f5d71 unpack-trees: unpack sparse directory entries
     @@ Commit message
          markers in the case that the entries correspond to directories and we
          already have a sparse directory entry.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## unpack-trees.c ##
     @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
      +
      +	/*
      +	 * Due to lexicographic sorting and sparse directory
     -+	 * entried ending with a trailing slash, our path as a
     ++	 * entries ending with a trailing slash, our path as a
      +	 * sparse directory (e.g "subdir/") and	our path as a
      +	 * file (e.g. "subdir") might be separated by other
      +	 * paths (e.g. "subdir-").
 10:  76c7528f78f ! 10:  b051c0847a5 dir.c: accept a directory as part of cone-mode patterns
     @@ Commit message
          assuming we are in cone mode. Since sparse index requires cone mode
          patterns, this is an acceptable assumption.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## dir.c ##
 11:  d875a7f8585 ! 11:  e749fd41cda diff-lib: handle index diffs with sparse dirs
     @@ Commit message
      
          Use diff_tree_oid() appropriately to compute the diff.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## diff-lib.c ##
 12:  2b72cc2d985 ! 12:  7f782e3fe50 status: skip sparse-checkout percentage with sparse-index
     @@ Commit message
          this message is equal across both modes, but instead just the important
          information about staged, modified, and untracked files are compared.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
 13:  1c1feef3733 ! 13:  ad1715e3319 status: use sparse-index throughout
     @@ Commit message
          other way. Correct integration with FS Monitor will be validated in
          later changes.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/commit.c ##
 14:  dada1b91bdc ! 14:  aa2258be302 wt-status: expand added sparse directory entries
     @@ Commit message
          Somehow, this loop over the cache entries was not guarded by
          ensure_full_index() as intended.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
 15:  bdc771cf373 ! 15:  1d4b1f8aea0 fsmonitor: integrate with sparse index
     @@ Commit message
          to a tracked directory outside of the sparse cone will trigger
          ensure_full_index().
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## sparse-index.c ##
  -:  ----------- > 16:  45861118991 t1092: document bad sparse-checkout behavior

-- 
gitgitgadget
