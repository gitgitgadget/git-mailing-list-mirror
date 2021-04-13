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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC572C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA975611CE
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhDMOCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhDMOCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A63C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g9so552532wrx.0
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=z4iUU/Itq20LvfylDagsBnOrTWwR+Q8ty//IbVZM7FE=;
        b=YCBJNk9ADj+soeFh0c2yFp7IgH2cdv8GF6ygKdn8XZjb4OHgcjLfJFqMjVua9Vo0WA
         iEJ9rDSqIOKFt4tFjklK2clLvdsoJL/119ivX4IJG2E/wdRCUqOwOG8pEyFs4WQXKg7o
         iw2/3cHiO2zK1n/fq3N7gWDqyqLeAx5MdAfnoSq6ntdRThkVk/X9toYf1gfPnDEOyqul
         z9HZmRzRpQweysJZj/P/PJ+F3w6yTy8Uk1VdbzbGDgwalPgS1g+c9eKQ1QG+k+9YF6u7
         ItQ1ebz9s+Uqh3kgl32NQnWNqqIT4XX2k73yUJ6D515KlxH3pP0OLL4ixU/ThZ5uC8v0
         5AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z4iUU/Itq20LvfylDagsBnOrTWwR+Q8ty//IbVZM7FE=;
        b=m4GPgEFbfCQmgWe0XGEBlxG0hJeZvx4lNhbFktcCrRMPOIy06EeHqryZWKBN9qiCzW
         fFG/grPWV/wSu1iT3ggOUa0EbR/g3ZzH29QVQyttjV2KwEv7Pk2XQVwYbn9Fmx5gd7Lu
         JDvBkOY/BpDe1ii2Ptcf9NWYze51rdTR5LaqwpO3p5zwj+a+8na9QYJkuCogUwlJb3Ji
         9V+yXaEPdsPA4WviXGYjGTNHC8mrsz2cWuAHRtcob0eZgOK1T6Gtt1KN/UhfezUDEG8t
         9DgrLrvKc9PKrEdiSkDkvYvKH+4PHnUg8we/FpWDWwtQjnPb9TtbrYm21r28Z8HGc82U
         075Q==
X-Gm-Message-State: AOAM530lBCR60peSmivpx+YnxcyA6q4oLIDw6ka7MlMEksGL/vikQ4d2
        Dx8HrOQ2DG72BuXRZQ61+WuuXeEN0eg=
X-Google-Smtp-Source: ABdhPJzNQQDaEHPigwrpk4poHVNHpRkfXZx3iavijycHyxOQvhjgQ8z7cjGUmo1bD+kgqDTM7oY6rw==
X-Received: by 2002:a5d:4bce:: with SMTP id l14mr2809466wrt.359.1618322499334;
        Tue, 13 Apr 2021 07:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm2457925wmp.42.2021.04.13.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:38 -0700 (PDT)
Message-Id: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:27 +0000
Subject: [PATCH 00/10] Sparse-index: integrate with status and add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first "payoff" series in the sparse-index work. It makes 'git
status' and 'git add' very fast when a sparse-index is enabled on a
repository with cone-mode sparse-checkout (and a small populated set).

This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
The latter branch is needed because it changes the behavior of 'git add'
around sparse entries, which changes the expectations of a test added in
patch 1.

The approach here is to audit the places where ensure_full_index() pops up
while doing normal commands with pathspecs within the sparse-checkout
definition. Each of these are checked and tested. In the end, the
sparse-index is integrated with these features:

 * git status
 * git add -A
 * git add . (and other pathspecs)
 * FS Monitor index extension.

The performance tests in p2000-sparse-operations.sh improve by 95% or more,
even when compared with the full-index cases, not just the sparse-index
cases that previously had extra overhead.

Hopefully this is the first example of how ds/sparse-index-protections has
done the basic work to do these conversions safely, making them look easier
than they seemed when starting this adventure.

Thanks, -Stolee

Derrick Stolee (10):
  t1092: add tests for status/add and sparse files
  unpack-trees: make sparse aware
  dir.c: accept a directory as part of cone-mode patterns
  status: skip sparse-checkout percentage with sparse-index
  status: use sparse-index throughout
  dir: use expand_to_path() for sparse directories
  add: allow operating on a sparse-only index
  pathspec: stop calling ensure_full_index
  t7519: add sparse directories to FS monitor tests
  fsmonitor: test with sparse index

 builtin/add.c                            |  3 +
 builtin/commit.c                         |  3 +
 dir.c                                    |  5 ++
 dir.h                                    |  2 +-
 pathspec.c                               |  2 -
 preload-index.c                          |  2 +
 read-cache.c                             |  5 +-
 t/t1092-sparse-checkout-compatibility.sh | 73 +++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh              | 65 +++++++++++++++++++++
 unpack-trees.c                           | 24 +++++++-
 wt-status.c                              | 14 ++++-
 wt-status.h                              |  1 +
 12 files changed, 186 insertions(+), 13 deletions(-)


base-commit: f723f370c89ad61f4f40aabfd3540b1ce19c00e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/932
-- 
gitgitgadget
