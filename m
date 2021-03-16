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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A90BC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0EF65108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhCPQni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhCPQnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CCFC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1840817wmq.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ucaBn+ZqsVN3uUi0la1ms+s2bOuTr7fttvug1+KqBzg=;
        b=bgbKOup42VVXxod3Y45KacRuFVWdePZ11zA28nSBHd3JbamsVHP9t0CjW3dsHZouhY
         IquTGt52Z5f9UJ++4L2mZd7LxQJxtqjj2oEcJKc3WewVCgk5i7KcRybVWzHlSu34/7hC
         qNC0HcY5HuYCvhwfWyou54U6uP8fcJGuk2zlvjmtbVPQO+QzTv6N0NtPEKC2xWZVDyXd
         E7Ir5ABpl10bbe+pnKO2B1NwhQMU2ZxnYAFnk8DbjW4LxfCAd3D/idDuPbWjYMpxpTWn
         Sm1mI+HW0naNCoVQXPE1uWQdNFOLzgPjbQHsKsNW/kon92c8ryXvUKo4iXjZdJ6xPiII
         QR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ucaBn+ZqsVN3uUi0la1ms+s2bOuTr7fttvug1+KqBzg=;
        b=tlHXmEB8Ncln7pxK9C495pl8UcWIkhcAzi/PPPbxz1jEYLkNp9vyO5XmseWfByxXOs
         u35R6UuALVv26oUmS+MDMeJYgH56CiOCq9pE0DxRLvUuQ6Ok4khV+XuylaK873UTuzMV
         9RWqzhxzcL6Kjjhwv+EsOhGrYIIkU2sUXYBWKVTzRuQAArKRivwE3kvcqH4JHaiHxzca
         8c3z3Iv2NNrsZNIy5DyQvT2YzFn50viVaCwSAhzw9+M6wUYBKU3Ghm770unYha7z87pa
         3w77woLlkcK0m7wP1KfVqYQX3WzrWgjgrtMZrcMRWZsg2vTChf4lAr2Syuug4inlOV8N
         FQ1g==
X-Gm-Message-State: AOAM531WiBK84iuGGWwl5s5iTDSxMGOXTBSBj6Xo3WHfPtBpw+oryHoq
        tNlEGfL+dQtn3hw2PKEetBaXxR4fEtU=
X-Google-Smtp-Source: ABdhPJx+w3S34HTQiPJXruYo/viH6z+9pYMFFXEWHafQJQPPcBzZqoJivLQCNMKobQomdG2DQXQJ+A==
X-Received: by 2002:a1c:804e:: with SMTP id b75mr460920wmd.113.1615912984986;
        Tue, 16 Mar 2021 09:43:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm22440007wrx.79.2021.03.16.09.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:04 -0700 (PDT)
Message-Id: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:43 +0000
Subject: [PATCH v3 00/20] Sparse Index: Design, Format, Tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the first full patch series submission coming out of the
sparse-index RFC [1].

[1]
https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/

I won't waste too much space here, because PATCH 1 includes a sizeable
design document that describes the feature, the reasoning behind it, and my
plan for getting this implemented widely throughout the codebase.

There are some new things here that were not in the RFC:

 * Design doc and format updates. (Patch 1)
 * Performance test script. (Patches 2 and 20)

Notably missing in this series from the RFC:

 * The mega-patch inserting ensure_full_index() throughout the codebase.
   That will be a follow-up series to this one.
 * The integrations with git status and git add to demonstrate the improved
   performance. Those will also appear in their own series later.

I plan to keep my latest work in this area in my 'sparse-index/wip' branch
[2]. It includes all of the work from the RFC right now, updated with the
work from this series.

[2] https://github.com/derrickstolee/git/tree/sparse-index/wip


Updates in V3
=============

For this version, I took Ævar's latest patches and applied them to v2.31.0
and rebased this series on top. It uses his new "read_tree_at()" helper and
the associated changes to the function pointer type.

 * Fixed more typos. Thanks Martin and Elijah!
 * Updated the test_sparse_match() macro to use "$@" instead of $*
 * Added a test that git sparse-checkout init --no-sparse-index rewrites the
   index to be full.


Updates in V2
=============

 * Various typos and awkward grammar is fixed.
 * Cleaned up unnecessary commands in p2000-sparse-operations.sh
 * Added a comment to the sparse_index member of struct index_state.
 * Used tree_type, commit_type, and blob_type in test-read-cache.c.

Thanks, -Stolee

Derrick Stolee (20):
  sparse-index: design doc and format update
  t/perf: add performance test for sparse operations
  t1092: clean up script quoting
  sparse-index: add guard to ensure full index
  sparse-index: implement ensure_full_index()
  t1092: compare sparse-checkout to sparse-index
  test-read-cache: print cache entries with --table
  test-tool: don't force full index
  unpack-trees: ensure full index
  sparse-checkout: hold pattern list in index
  sparse-index: convert from full to sparse
  submodule: sparse-index should not collapse links
  unpack-trees: allow sparse directories
  sparse-index: check index conversion happens
  sparse-index: create extension for compatibility
  sparse-checkout: toggle sparse index from builtin
  sparse-checkout: disable sparse-index
  cache-tree: integrate with sparse directory entries
  sparse-index: loose integration with cache_tree_verify()
  p2000: add sparse-index repos

 Documentation/config/extensions.txt      |   8 +
 Documentation/git-sparse-checkout.txt    |  14 ++
 Documentation/technical/index-format.txt |   7 +
 Documentation/technical/sparse-index.txt | 173 +++++++++++++
 Makefile                                 |   1 +
 builtin/sparse-checkout.c                |  44 +++-
 cache-tree.c                             |  40 ++++
 cache.h                                  |  18 +-
 read-cache.c                             |  35 ++-
 repo-settings.c                          |  15 ++
 repository.c                             |  11 +-
 repository.h                             |   3 +
 setup.c                                  |   3 +
 sparse-index.c                           | 293 +++++++++++++++++++++++
 sparse-index.h                           |  11 +
 t/README                                 |   3 +
 t/helper/test-read-cache.c               |  66 ++++-
 t/perf/p2000-sparse-operations.sh        | 102 ++++++++
 t/t1091-sparse-checkout-builtin.sh       |  13 +
 t/t1092-sparse-checkout-compatibility.sh | 143 +++++++++--
 unpack-trees.c                           |  16 +-
 21 files changed, 979 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/technical/sparse-index.txt
 create mode 100644 sparse-index.c
 create mode 100644 sparse-index.h
 create mode 100755 t/perf/p2000-sparse-operations.sh


base-commit: 9c34e7ffd7b544199d889e2f3f7d9ba663c4357d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-883%2Fderrickstolee%2Fsparse-index%2Fformat-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-883/derrickstolee/sparse-index/format-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/883

Range-diff vs v2:

  1:  2fe413fdac80 !  1:  62ac13945bec sparse-index: design doc and format update
     @@ Documentation/technical/sparse-index.txt (new)
      +Hopefully, commands such as `git merge` and `git rebase` can benefit
      +instead from merge algorithms that do not use the index as a data
      +structure, such as the merge-ORT strategy. As these topics mature, we
     -+may enalbe the ORT strategy by default for repositories using the
     ++may enable the ORT strategy by default for repositories using the
      +sparse-index feature.
      +
      +Along with `git status` and `git add`, these commands cover the majority
  2:  540ab5495065 =  2:  d2197e895e4d t/perf: add performance test for sparse operations
  3:  5cbedb377b37 =  3:  d3cfd34b8418 t1092: clean up script quoting
  4:  6e21f776e883 =  4:  4472118cf903 sparse-index: add guard to ensure full index
  5:  399ddb0bad56 !  5:  99292cdbaae4 sparse-index: implement ensure_full_index()
     @@ sparse-index.c
      +}
      +
      +static int add_path_to_index(const struct object_id *oid,
     -+				struct strbuf *base, const char *path,
     -+				unsigned int mode, int stage, void *context)
     ++			     struct strbuf *base, const char *path,
     ++			     unsigned int mode, void *context)
      +{
      +	struct index_state *istate = (struct index_state *)context;
      +	struct cache_entry *ce;
     @@ sparse-index.c
      -	/* intentionally left blank */
      +	int i;
      +	struct index_state *full;
     ++	struct strbuf base = STRBUF_INIT;
      +
      +	if (!istate || !istate->sparse_index)
      +		return;
     @@ sparse-index.c
      +		ps.has_wildcard = 1;
      +		ps.max_depth = -1;
      +
     -+		read_tree_recursive(istate->repo, tree,
     -+				    ce->name, strlen(ce->name),
     -+				    0, &ps,
     -+				    add_path_to_index, full);
     ++		strbuf_setlen(&base, 0);
     ++		strbuf_add(&base, ce->name, strlen(ce->name));
     ++
     ++		read_tree_at(istate->repo, tree, &base, &ps,
     ++			     add_path_to_index, full);
      +
      +		/* free directory entries. full entries are re-used */
      +		discard_cache_entry(ce);
     @@ sparse-index.c
      +	istate->cache_nr = full->cache_nr;
      +	istate->cache_alloc = full->cache_alloc;
      +
     ++	strbuf_release(&base);
      +	free(full);
      +
      +	trace2_region_leave("index", "ensure_full_index", istate->repo);
  6:  eac2db5efc22 !  6:  fae5663a17bb t1092: compare sparse-checkout to sparse-index
     @@ Commit message
          add run_on_sparse and test_sparse_match helpers. These helpers will be
          used when the sparse index is implemented.
      
     -    Add GIT_TEST_SPARSE_INDEX environment variable to enable the
     -    sparse-index by default. This will be intended to use across the entire
     -    test suite, except that it will only affect cases where the
     -    sparse-checkout feature is enabled.
     +    Add the GIT_TEST_SPARSE_INDEX environment variable to enable the
     +    sparse-index by default. This can be enabled across all tests, but that
     +    will only affect cases where the sparse-checkout feature is enabled.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ t/t1092-sparse-checkout-compatibility.sh: test_all_match () {
       }
       
      +test_sparse_match () {
     -+	run_on_sparse $* &&
     ++	run_on_sparse "$@" &&
      +	test_cmp sparse-checkout-out sparse-index-out &&
      +	test_cmp sparse-checkout-err sparse-index-err
      +}
  7:  e9c82d2eda82 =  7:  dffe8821fde2 test-read-cache: print cache entries with --table
  8:  243541fc5820 =  8:  f4ad081f25bb test-tool: don't force full index
  9:  48f65093b3da =  9:  4780076a50df unpack-trees: ensure full index
 10:  83aac8b7a1ec = 10:  33fdba2b8cfd sparse-checkout: hold pattern list in index
 11:  f6db0c27a285 ! 11:  e41b14e03ebb sparse-index: convert from full to sparse
     @@ t/t1092-sparse-checkout-compatibility.sh
       
       test_description='compare full workdir to sparse workdir'
       
     ++# The verify_cache_tree() check is not sparse-aware (yet).
     ++# So, disable the check until that integration is complete.
      +GIT_TEST_CHECK_CACHE_TREE=0
      +GIT_TEST_SPLIT_INDEX=0
      +
     @@ t/t1092-sparse-checkout-compatibility.sh: run_on_all () {
       }
       
       test_sparse_match () {
     --	run_on_sparse $* &&
     -+	run_on_sparse "$@" &&
     - 	test_cmp sparse-checkout-out sparse-index-out &&
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_match () {
       	test_cmp sparse-checkout-err sparse-index-err
       }
       
 12:  f2a3e7298798 = 12:  b77cd6b02265 submodule: sparse-index should not collapse links
 13:  6f1ebe6ccc08 = 13:  4000c5cdd4cf unpack-trees: allow sparse directories
 14:  3fa684b315fb = 14:  1a2be38b2ca7 sparse-index: check index conversion happens
 15:  d74576d677f6 = 15:  f89891b0ae4e sparse-index: create extension for compatibility
 16:  e530ca5f668d ! 16:  bd703c76c859 sparse-checkout: toggle sparse index from builtin
     @@ Documentation/git-sparse-checkout.txt: To avoid interfering with other worktrees
      ++
      +**WARNING:** Using a sparse index requires modifying the index in a way
      +that is not completely understood by external tools. If you have trouble
     -+with this compatibility, then run `git sparse-checkout sparse-index disable`
     ++with this compatibility, then run `git sparse-checkout init --no-sparse-index`
      +to rewrite your index to not be sparse. Older versions of Git will not
      +understand the `sparseIndex` repository extension and may fail to interact
      +with your repository until it is disabled.
     @@ sparse-index.h: struct index_state;
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_description='compare full workdir to sparse workdir'
     - 
     + # So, disable the check until that integration is complete.
       GIT_TEST_CHECK_CACHE_TREE=0
       GIT_TEST_SPLIT_INDEX=0
      +GIT_TEST_SPARSE_INDEX=
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index cont
       
       	test-tool -C sparse-index read-cache --table >cache &&
       	for dir in deep/deeper2 folder1 folder2 x
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index contents' '
     + 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
     + 		grep "040000 tree $TREE	$dir/" cache \
     + 			|| return 1
     +-	done
     ++	done &&
     ++
     ++	# Disabling the sparse-index removes tree entries with full ones
     ++	git -C sparse-index sparse-checkout init --no-sparse-index &&
     ++
     ++	test-tool -C sparse-index read-cache --table >cache &&
     ++	! grep "040000 tree" cache &&
     ++	test_sparse_match test-tool read-cache --table
     + '
     + 
     + test_expect_success 'expanded in-memory index matches full index' '
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'submodule handling' '
       test_expect_success 'sparse-index is expanded and converted back' '
       	init_repos &&
 17:  42d0da9c5def = 17:  598557f90a2a sparse-checkout: disable sparse-index
 18:  6bb0976a6295 ! 18:  c2d0c17db31a cache-tree: integrate with sparse directory entries
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
       	trace2_region_leave("index", "convert_to_sparse", istate->repo);
       	return 0;
      @@ sparse-index.c: void ensure_full_index(struct index_state *istate)
     - 
     + 	strbuf_release(&base);
       	free(full);
       
      +	/* Clear and recompute the cache-tree */
 19:  07f34e80609a ! 19:  6fdd9323c14e sparse-index: loose integration with cache_tree_verify()
     @@ t/t1092-sparse-checkout-compatibility.sh
       
       test_description='compare full workdir to sparse workdir'
       
     +-# The verify_cache_tree() check is not sparse-aware (yet).
     +-# So, disable the check until that integration is complete.
      -GIT_TEST_CHECK_CACHE_TREE=0
       GIT_TEST_SPLIT_INDEX=0
       GIT_TEST_SPARSE_INDEX=
 20:  41e3b56b9c17 = 20:  3db06ac46dd5 p2000: add sparse-index repos

-- 
gitgitgadget
