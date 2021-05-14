Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5041C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B304C61440
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhENSc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhENSc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F51BC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p14-20020a05600c358eb029015c01f207d7so200486wmq.5
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/nBhupnVoVyNkza4TJEKDmZMVLyigmFlQCD3IVmPOj0=;
        b=eQ/r3RcY75iUru7ghlUdupWbPdIgkmITC4QinHhZEPcasqC/VUF4wxRYB70o3xCRZJ
         0X7qRhsqs6Vki72ym8bLHcTNed2QvmBWxyUDn07Id6x6Zbgqk65GiQwhzUaSK/eSEq+7
         6bSCj0HG5kXPyEysAODHYxSE7jZClFQmWYdiw0pIesnwcbjg/f251L5djRZV0bsDoy12
         Od+JyZ8T15Wfr1y8J++fI1PyGtkbkVC6RlsFQ6d+Xl+tXy0sBYPC66+uSSn72mVqcAId
         DbkJGC1HCa86HQwptSwEdZBByWjYXQJNQI+j0ChRvd5mAv6SkGPaVHKW6uefZDvWIARW
         7+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/nBhupnVoVyNkza4TJEKDmZMVLyigmFlQCD3IVmPOj0=;
        b=gGZ+75Xk5KoteXU+cz6zGa7Ad5arKeVDmj5XFNX4afct/tlLL7JFZt+B4Sa1yW7Lqo
         ECqvfsJ4PeYnVLVxeWfCoABgxSQwEVbGpRPiKdZNqgpQhSoG2qUUMnb2mDWI1k6tmCYP
         njc8nxb7sL9LI15dcka44ZNDfc+gtRAh8m29E8psLSmvl54wJUA0zI+UHM1gXoOFCEm4
         B+JTZzXYxuY93jkZ5qE20z/b3iEfAtBVY7QM9aj/EvimkJOSE9TVJ8vtipZ3N3vBG4ls
         pkxfMLXDi6Qtg1k40oA7Vj1B18p3GPCotcTcHFdqu/qBcwSlv6NWY2dgYxSlkSQnwVIK
         +P9Q==
X-Gm-Message-State: AOAM532PZzJIsKiN9uU33lAIbJbFrVyFPulKqaOjZfX0Vx7F7v5U1Mpw
        QziyEt1FSSCRmsC8hf1ZC5SWKeUR9bs=
X-Google-Smtp-Source: ABdhPJzSt/3oZtjQYsri85aXct2Km9ZNMDXCsVBxKmyFudGHMl+3Y02myk7j3THHTK4YRzEVfihcaQ==
X-Received: by 2002:a1c:2743:: with SMTP id n64mr10598828wmn.76.1621017073857;
        Fri, 14 May 2021 11:31:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm12137464wmj.2.2021.05.14.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:13 -0700 (PDT)
Message-Id: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:30:59 +0000
Subject: [PATCH v3 00/12] Sparse-index: integrate with status
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
  unpack-trees: stop recursing into sparse directories
  dir.c: accept a directory as part of cone-mode patterns
  status: skip sparse-checkout percentage with sparse-index
  status: use sparse-index throughout
  wt-status: expand added sparse directory entries
  fsmonitor: integrate with sparse index

 builtin/commit.c                         |   3 +
 diff-lib.c                               |   6 ++
 dir.c                                    |  11 +++
 read-cache.c                             |  10 +-
 sparse-index.c                           |  27 +++++-
 t/t1092-sparse-checkout-compatibility.sh | 117 ++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh              |  48 ++++++++++
 unpack-trees.c                           |  27 +++++-
 wt-status.c                              |  64 ++++++++++++-
 wt-status.h                              |   1 +
 10 files changed, 300 insertions(+), 14 deletions(-)


base-commit: f723f370c89ad61f4f40aabfd3540b1ce19c00e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v2:

  -:  ------------ >  1:  5a2ed3d1d701 sparse-index: skip indexes with unmerged entries
  -:  ------------ >  2:  8aa41e749471 sparse-index: include EXTENDED flag when expanding
  -:  ------------ >  3:  70971b1f9261 t1092: expand repository data shape
  1:  3bac9edae7d8 !  4:  a80b5a41153f t1092: add tests for status/add and sparse files
     @@ Commit message
          and files outside of the sparse cone.
      
          Specifically, 'folder1/a' is a file in our test repo, but 'folder1' is
     -    not in the sparse cone. When 'folder1/a' is modified, the file
     -    'folder1/a' is shown as modified, but adding it fails. This is new
     -    behavior as of a20f704 (add: warn when asked to update SKIP_WORKTREE
     -    entries, 2021-04-08). Before that change, these adds would be silently
     -    ignored.
     +    not in the sparse cone. When 'folder1/a' is modified, the file is not
     +    shown as modified and adding it will fail. This is new behavior as of
     +    a20f704 (add: warn when asked to update SKIP_WORKTREE entries,
     +    2021-04-08). Before that change, these adds would be silently ignored.
      
          Untracked files are fine: adding new files both with 'git add .' and
          'git add folder1/' works just as in a full checkout. This may not be
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
      +test_expect_success 'status/add: outside sparse cone' '
      +	init_repos &&
      +
     ++	# adding a "missing" file outside the cone should fail
     ++	test_sparse_match test_must_fail git add folder1/a &&
     ++
      +	# folder1 is at HEAD, but outside the sparse cone
      +	run_on_sparse mkdir folder1 &&
      +	cp initial-repo/folder1/a sparse-checkout/folder1/a &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
      +	write_script edit-contents <<-\EOF &&
      +	echo text >>$1
      +	EOF
     -+	run_on_all ../edit-contents folder1/a &&
     ++	run_on_sparse ../edit-contents folder1/a &&
      +	run_on_all ../edit-contents folder1/new &&
      +
      +	test_sparse_match git status --porcelain=v2 &&
      +
     -+	# This "git add folder1/a" is completely ignored
     -+	# by the sparse-checkout repos. It causes the
     -+	# full repo to have a different staged environment.
     -+	#
     -+	# This is not a desirable behavior, but this test
     -+	# ensures that the sparse-index is not the cause
     -+	# of a behavior change.
     ++	# This "git add folder1/a" fails with a warning
     ++	# in the sparse repos, differing from the full
     ++	# repo. This is intentional.
      +	test_sparse_match test_must_fail git add folder1/a &&
      +	test_sparse_match test_must_fail git add --refresh folder1/a &&
     -+	git -C full-checkout checkout HEAD -- folder1/a &&
      +	test_all_match git status --porcelain=v2 &&
      +
      +	test_all_match git add . &&
  2:  19344394379d =  5:  07a45b661c4a unpack-trees: preserve cache_bottom
  3:  24e71d8c0622 !  6:  cc4a526e7947 unpack-trees: compare sparse directories correctly
     @@ unpack-trees.c: static int compare_entry(const struct cache_entry *ce, const str
       	if (cmp)
       		return cmp;
       
     -+	/* If ce is a sparse directory, then allow an exact match. */
     ++	/*
     ++	 * At this point, we know that we have a prefix match. If ce
     ++	 * is a sparse directory, then allow an exact match. This only
     ++	 * works when the input name is a directory, since ce->name
     ++	 * ends in a directory separator.
     ++	 */
      +	if (S_ISSPARSEDIR(ce->ce_mode))
      +		return 0;
      +
  4:  d3c8948d0a33 !  7:  598375d3531f unpack-trees: stop recursing into sparse directories
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## diff-lib.c ##
     +@@ diff-lib.c: static void show_new_file(struct rev_info *revs,
     + 	unsigned int mode;
     + 	unsigned dirty_submodule = 0;
     + 
     ++	if (S_ISSPARSEDIR(new_file->ce_mode))
     ++		return;
     ++
     + 	/*
     + 	 * New file in the index: it might actually be different in
     + 	 * the working tree.
     +@@ diff-lib.c: static int show_modified(struct rev_info *revs,
     + 	const struct object_id *oid;
     + 	unsigned dirty_submodule = 0;
     + 
     ++	if (S_ISSPARSEDIR(new_entry->ce_mode))
     ++		return 0;
     ++
     + 	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
     + 			  &dirty_submodule, &revs->diffopt) < 0) {
     + 		if (report_missing)
     +
       ## unpack-trees.c ##
      @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
       	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
       	/* Find first entry with a real name (we could use "mask" too) */
       	while (!p->mode)
      @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
     - 					}
     - 				}
     - 				src[0] = ce;
     -+
     -+				if (S_ISSPARSEDIR(ce->ce_mode))
     -+					unpack_tree = 0;
     - 			}
     - 			break;
       		}
       	}
       
  5:  fd96b71968b6 =  8:  47da2b317237 dir.c: accept a directory as part of cone-mode patterns
  6:  1f4ba56e7416 =  9:  bc1512981493 status: skip sparse-checkout percentage with sparse-index
  7:  3d09368c0541 = 10:  5b1ae369a7cd status: use sparse-index throughout
  -:  ------------ > 11:  3b42783d4a86 wt-status: expand added sparse directory entries
  8:  1fd033a6ebb2 ! 12:  b72507f514d1 fsmonitor: test with sparse index
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor: test with sparse index
     +    fsmonitor: integrate with sparse index
      
     -    During the effort to protect uses of the index to operate on a full
     -    index, we did not modify fsmonitor.c. This is because it already works
     -    effectively with only the change to index_name_stage_pos(). The only
     -    thing left to do is to test that it works correctly.
     +    If we need to expand a sparse-index into a full one, then the FS Monitor
     +    bitmap is going to be incorrect. Ensure that we start fresh at such an
     +    event.
     +
     +    While this is currently a performance drawback, the eventual hope of the
     +    sparse-index feature is that these expansions will be rare and hence we
     +    will be able to keep the FS Monitor data accurate across multiple Git
     +    commands.
      
          These tests are added to demonstrate that the behavior is the same
          across a full index and a sparse index, but also that file modifications
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## sparse-index.c ##
     +@@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
     + 	cache_tree_free(&istate->cache_tree);
     + 	cache_tree_update(istate, 0);
     + 
     ++	istate->fsmonitor_has_run_once = 0;
     ++	FREE_AND_NULL(istate->fsmonitor_dirty);
     ++	FREE_AND_NULL(istate->fsmonitor_last_update);
     ++
     + 	istate->sparse_index = 1;
     + 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
     + 	return 0;
     +@@ sparse-index.c: void ensure_full_index(struct index_state *istate)
     + 	istate->cache = full->cache;
     + 	istate->cache_nr = full->cache_nr;
     + 	istate->cache_alloc = full->cache_alloc;
     ++	istate->fsmonitor_has_run_once = 0;
     ++	FREE_AND_NULL(istate->fsmonitor_dirty);
     ++	FREE_AND_NULL(istate->fsmonitor_last_update);
     + 
     + 	strbuf_release(&base);
     + 	free(full);
     +
       ## t/t7519-status-fsmonitor.sh ##
      @@ t/t7519-status-fsmonitor.sh: test_expect_success 'setup' '
       	expect*

-- 
gitgitgadget
