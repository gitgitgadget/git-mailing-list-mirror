Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A05C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 14:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245677AbhLFOOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbhLFOOI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 09:14:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5AC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 06:10:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so7725623wmb.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 06:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e/bi1Z8raRy2wi8H35TpYNqPXPK2LFbhE1uBu9cQ8Ys=;
        b=BoDGarFjhYk6ENXY9y1A6GAw8soDgXlilPngK0eWKCQGt9gKcuVvFCgaz9UxJwaTex
         mS7QTtZAGcvFlLxyTOPLC0QN30lK1ab2koT4KBO1sTpjlq5M4zFtobL+6xm9lL4SDvRP
         /+PKaZPJtO9zPBOW++DKpA+r2+umV6YfmqdVgKRgeReZGeZIh+rGpxTOiT6hLwAh5nHM
         JfYCUIbJcwrpdYXs3+MZoeQheStR/ulOIgBgp28IoiKkmrCo5WPTiBUjc8ItmXULWIst
         lR1P+xH4atF8H5lAkzVH0t67V/3FDALYV4jamdn5SIrdS2TX87mmmPyv6Er1HEALLA8w
         UB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e/bi1Z8raRy2wi8H35TpYNqPXPK2LFbhE1uBu9cQ8Ys=;
        b=6gBVcE0+mzcyxAuPHtKMZrtX/r/+BSjHDGf+LFaVJdClZIemTEyLNsBLb1Y5mdoUbQ
         Dp1kFI6MHHBygh/AFg4d5N2uKKXirZZ/gQiJg4m7Oj9WFkKm90vSZ1zGj5Yu4R/fBv4C
         ZF0KPQOVi8XWedTwHVGipGL4uICcYoWVqQTjuN/bsyvW7dljHrNN+aGPX4q7MY2nz4Ih
         kbijGs3aeOy7ILYE4hDM/lMQZverU/Cl4S5KCpdduNRVqSntLJpNR8/lNh4fiGDT0IRU
         DXbytKeKDGSJvEB6ukM25eGIXjl4yAp9vydkuMmgDd6//89OWljT9yE7rmmz8noKWIKZ
         LQTQ==
X-Gm-Message-State: AOAM531Lusnf09G2yH7yBN42LhVfxTUbenEcTGAXXx+00Di7us9PT0z1
        zVvBqHzgeiJJEhH3kGPv7pEYBAxGntI=
X-Google-Smtp-Source: ABdhPJxRsavUrUoO0WYKLAUrCS7Uq+sCvNz/KR8hFDMKmelZluMdSo7gxbcTqx+vp2m9kcbtphUdfQ==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr39075317wmj.9.1638799838155;
        Mon, 06 Dec 2021 06:10:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm14900226wmq.11.2021.12.06.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:10:37 -0800 (PST)
Message-Id: <pull.1092.v2.git.1638799837.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 14:10:35 +0000
Subject: [PATCH v2 0/2] Sparse Index: fix a checkout bug with deep sparse-checkout patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, vdye@github.com, gitster@pobox.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This week, we rolled out the sparse index to a large internal monorepo. We
got two very similar bug reports that dealt with a strange error that
involved the same set of paths. One was during git pull (pull was a red
herring) and the other was git checkout. The git checkout case gave enough
of a reproduction to debug deep into unpack-trees.c and find the problem.

This bug dates back to 523506d (unpack-trees: unpack sparse directory
entries, 2021-07-14). The reason we didn't hit this before is because it
requires the following:

 1. The sparse-checkout definition needs to have recursive inclusion of deep
    folders (depth 3 or more).
 2. Adjacent to those deep folders, we need a deep sparse directory entry
    that receives changes.
 3. In this particular repo, deep directories are only added to the
    sparse-checkout in rare occasions and those adjacent folders are rarely
    updated. They happened to update this week and hit our sparse index
    dogfooders in surprising ways.

The first patch adds a test that fails without the fix. It requires
modifying our test data to make adjacent, deep sparse directory entries
possible. It's a rather simple test after we have that data change.

The second patch includes the actual fix. It's really just an error of not
understanding the difference between the name and traverse_path members of
the struct traverse_info structure. name only stores a single tree entry
while traverse_path actually includes the full name from root. The method we
are editing also has an additional struct name_entry that fills in the tree
entry on top of the traverse_path, which explains how this worked to depth
two, but not depth three.


Update in v2
============

 * Fixed the comment describing the sparse_dir_matches_path() method.

Thanks, -Stolee

Derrick Stolee (2):
  t1092: add deeper changes during a checkout
  unpack-trees: use traverse_path instead of name

 t/t1092-sparse-checkout-compatibility.sh | 16 +++++++++++++++-
 unpack-trees.c                           | 14 ++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1092%2Fderrickstolee%2Fsparse-index%2Fcheckout-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1092/derrickstolee/sparse-index/checkout-bug-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1092

Range-diff vs v1:

 1:  ba05d7d4149 = 1:  ba05d7d4149 t1092: add deeper changes during a checkout
 2:  c9142199656 ! 2:  aa37168dcb4 unpack-trees: use traverse_path instead of name
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
       	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
      
       ## unpack-trees.c ##
     +@@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
     + 
     + /*
     +  * Given a sparse directory entry 'ce', compare ce->name to
     +- * info->name + '/' + p->path + '/' if info->name is non-empty.
     ++ * info->traverse_path + p->path + '/' if info->traverse_path
     ++ * is non-empty.
     ++ *
     +  * Compare ce->name to p->path + '/' otherwise. Note that
     +  * ce->name must end in a trailing '/' because it is a sparse
     +  * directory entry.
      @@ unpack-trees.c: static int sparse_dir_matches_path(const struct cache_entry *ce,
       	assert(S_ISSPARSEDIR(ce->ce_mode));
       	assert(ce->name[ce->ce_namelen - 1] == '/');

-- 
gitgitgadget
