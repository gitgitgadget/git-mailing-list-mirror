Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DEDC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE9C61154
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhGLR6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhGLR6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75249C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:55:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so579015wmq.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WVzUUrIJ/ZeJb1IoUnzJ8m86P2xBwz9WGLM41vIW9y4=;
        b=ZK7qKGeCd2QawD5Q3f+n/ZkucMJkdJL5GtO5+AvAlT1/+buQ1I8Os3xZK+GjUtnffx
         xG7zYhrYghC6IPGxrR0RjOMZFou+jCzQ1cauf1FylFyluMn2ezJ/eP1DlHaD9s+KARVX
         JXFAQbrEOF5OgFEiY5Bzv2dS1CJ+nPIBWAwBFfJ8MWbJ+MCKy3FVAwXdiLpEuIDcPvg3
         op0YaeKTwIVZ+ED1YNHT5H1aSbwA+rBy5zdCFttiU7NKFaW4lcgwhxtrftJz+kXPLLOE
         CKB/i2REBl2vMkte+ojHtdElqD4rFDv7mtfz8IMhZUxM/A1w0UQQn8739q3jJcgddcbI
         gfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WVzUUrIJ/ZeJb1IoUnzJ8m86P2xBwz9WGLM41vIW9y4=;
        b=NgAdyIhnGutBF8DqyWI211+go/ZaquXMvYQyRYqYaZh9+TquqmXUx3XZoDs9Cg06xd
         NQmq5LWOkYdBjSyBb4MWXF6zlcfNQy2JVpYNgsGOBT0zGtW8jKYCk1u4ASPRPJM1kZSv
         fi+2eehfEQ1YB4IEQKojDr5gwbNUJV7agYBnSq2pzNHVE2AxqsGmIhKgWlemHd99VdUC
         wmbzXN5WAfJRi1P1HYekef1xBfa3hlogtykqLfLxD+HWDAUVt35scLj66ccCJ/HsnX/6
         sRkztYRb2x0xB0ZuUu4svEQJWOIo5I0dUYEwdbCrpiy/HUxvylgpzy7KnsABXjeLYx7V
         MBMQ==
X-Gm-Message-State: AOAM530fUbrh8bi5waKQrXvkSRL3/xWhbngc3OoZ+GS78XsPOL46KRA4
        xL29BehFDfZZ9TzzvAS0OLE8Djct7Bw=
X-Google-Smtp-Source: ABdhPJw3zntdZczsvVIZppANVqukxucSIfkQUEovkn5X4tZCCM2H41jZnXXgBHlgIAuU4eBSIUz3wg==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr403537wmp.165.1626112557978;
        Mon, 12 Jul 2021 10:55:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm7203408wrm.97.2021.07.12.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:55:57 -0700 (PDT)
Message-Id: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:41 +0000
Subject: [PATCH v8 00/15] Sparse-index: integrate with status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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


Update in V8
============

 * The directory/file conflict patch is removed and delayed to the next
   series where it will be required. (It will also be improved in that
   series.)

 * Some comments have been improved, including a new assert() that helps
   document the situation.

Derrick Stolee (15):
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

 builtin/commit.c                         |   3 +
 diff-lib.c                               |  19 +++
 dir.c                                    |  24 +++-
 read-cache.c                             |  10 +-
 sparse-index.c                           |  27 +++-
 t/t1092-sparse-checkout-compatibility.sh | 158 ++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh              |  49 +++++++
 unpack-trees.c                           | 142 +++++++++++++++++---
 wt-status.c                              |  65 +++++++++-
 wt-status.h                              |   1 +
 10 files changed, 464 insertions(+), 34 deletions(-)


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v7:

  1:  2a4a7256304 =  1:  1815c148e8c sparse-index: skip indexes with unmerged entries
  2:  f5bae86014d =  2:  7bcde075d8d sparse-index: include EXTENDED flag when expanding
  3:  d965669c766 =  3:  05981e30b97 t1092: replace incorrect 'echo' with 'cat'
  4:  e10fa11cfdb !  4:  d38b66e9ee4 t1092: expand repository data shape
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
       	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
       	do
       		test_all_match git checkout rename-base &&
     - 		test_all_match git checkout $branch -- .&&
     + 		test_all_match git checkout $branch -- . &&
      +		test_all_match git status --porcelain=v2 &&
      +		test_all_match git diff --staged --no-renames &&
      +		test_all_match git diff --staged --find-renames || return 1
  5:  e94ffa07d46 =  5:  95ddd3abe4e t1092: add tests for status/add and sparse files
  6:  a8dda933567 =  6:  b182b456613 unpack-trees: preserve cache_bottom
  7:  e52166f6e4c =  7:  988ddce4d45 unpack-trees: compare sparse directories correctly
  8:  d04b62381b8 =  8:  d67ad048b08 unpack-trees: rename unpack_nondirectories()
  9:  237ccf4e43d !  9:  c0b0b58584c unpack-trees: unpack sparse directory entries
     @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
      +	 * Check for a sparse-directory entry named "path/".
      +	 * Due to the input p->path not having a trailing
      +	 * slash, the negative 'pos' value overshoots the
     -+	 * expected position by at least one, hence "-2" here.
     ++	 * expected position, hence "-2" instead of "-1".
      +	 */
      +	pos = -pos - 2;
      +
     @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
       		return NULL;
      +
      +	/*
     -+	 * We might have multiple entries between 'pos' and
     -+	 * the actual sparse-directory entry, so start walking
     -+	 * back until finding it or passing where it would be.
     ++	 * Due to lexicographic sorting and sparse directory
     ++	 * entried ending with a trailing slash, our path as a
     ++	 * sparse directory (e.g "subdir/") and	our path as a
     ++	 * file (e.g. "subdir") might be separated by other
     ++	 * paths (e.g. "subdir-").
      +	 */
      +	while (pos >= 0) {
      +		ce = o->src_index->cache[pos];
 10:  9f31c691af6 <  -:  ----------- unpack-trees: handle dir/file conflict of sparse entries
 11:  2a43287c47e = 10:  76c7528f78f dir.c: accept a directory as part of cone-mode patterns
 12:  f83aa08ff6b ! 11:  d875a7f8585 diff-lib: handle index diffs with sparse dirs
     @@ diff-lib.c: static int show_modified(struct rev_info *revs,
       	unsigned dirty_submodule = 0;
       	struct index_state *istate = revs->diffopt.repo->index;
       
     ++	assert(S_ISSPARSEDIR(old_entry->ce_mode) ==
     ++	       S_ISSPARSEDIR(new_entry->ce_mode));
     ++
      +	/*
      +	 * If both are sparse directory entries, then expand the
     -+	 * modifications to the file level.
     ++	 * modifications to the file level. If only one was a sparse
     ++	 * directory, then they appear as an add and delete instead of
     ++	 * a modification.
      +	 */
     -+	if (old_entry && new_entry &&
     -+	    S_ISSPARSEDIR(old_entry->ce_mode) &&
     -+	    S_ISSPARSEDIR(new_entry->ce_mode)) {
     ++	if (S_ISSPARSEDIR(new_entry->ce_mode)) {
      +		diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
      +		return 0;
      +	}
 13:  35063ffb8ed = 12:  2b72cc2d985 status: skip sparse-checkout percentage with sparse-index
 14:  b4033a9bf36 = 13:  1c1feef3733 status: use sparse-index throughout
 15:  717a3f49f97 = 14:  dada1b91bdc wt-status: expand added sparse directory entries
 16:  1d744848ee6 = 15:  bdc771cf373 fsmonitor: integrate with sparse index

-- 
gitgitgadget
