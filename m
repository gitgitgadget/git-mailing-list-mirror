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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DDEC433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6EB619C9
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhC3NLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3NLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF32C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso10282081wmi.3
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h6V+hhIADxXg3iyukAYawv3f2b0KoUyy/q9C2S2L3xc=;
        b=itELi8ycvWHXIesZsGUhw29V0iuY4Z373jOoAPSGgVbaLKgnFjIAe+0wp1vlKzduX7
         2gGmaxuB3lmNlsCpShu0U1TIHAKt4gq+5P5fVDcJJVc4r6e8v3ye6NROhj6B2COq9Xx1
         9cmaTTe4xeUlkbGC8W3O9Xtf3tHJirdPDj9u9lTB3IpwQ01JpgDgJqN6YVqJXEGu0jGH
         C4rGmELeyclxn1HKzAj+3YqFMERsM2XbEWXiZNjNMC3qmxGpRNdtlrzYRb7jJie718KL
         f1Hi+r06QoJ+dObRRfzrMHWGJDmXJfb34juOO1PVQcPcOahtUmvU+kL6kB3iMiCFmGgz
         OkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h6V+hhIADxXg3iyukAYawv3f2b0KoUyy/q9C2S2L3xc=;
        b=uOkepPAth2KlX/L7o4rLYSikkEpx5+ifmwBpJkuDfvaBpol4G/QW7bomAda4wn28T0
         +my0RjH/OD1Xk6EkLu32BXPubhO29MF6oljwrltsl+Ri/2uwGaBG5IuSw1cCVwk0BZS9
         v5688AVrrbb276O570HJsDxjTPpQ3oKyF/OucxfGWn+AdKdJRQm9jxWAgYPsNRk6GLpk
         cPfjyUp8f7vPkcrmCdswgQKSWwtf7HT6RlVrrrflBQ80z5GKydjUbYpjJ+21AlN+qOTg
         gO48SzSpf96af++j892XNWv5aAonbUPdZjyoJ2fNTijGjP4ppZLx6/HX04HtTBkgIu9y
         TrFg==
X-Gm-Message-State: AOAM533kysdlzjVTwoOxgBW0q75ZbPOZBMfn/kSYObJLdNhxgIWnxvLH
        MzGso52VZy6JdtcJVnTM43ElV82iwkk=
X-Google-Smtp-Source: ABdhPJy09vSDs/LErvIv5FAJTO9XiroQn3dsSPypUBwIW65grAL5XvIF1c2TMjX1Y4zcT2wh+E+J3A==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr3978864wmi.107.1617109866447;
        Tue, 30 Mar 2021 06:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm33433669wrx.28.2021.03.30.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:05 -0700 (PDT)
Message-Id: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:43 +0000
Subject: [PATCH v5 00/21] Sparse Index: Design, Format, Tests
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


Updates in V5
=============

This version is updated to use an index extension instead of a repository
format extension. Thanks, Szeder! This one change affects the range-diff
quite a bit, so please review those changes carefully.

In particular: git sparse-checkout init --cone --sparse-index now sets a new
index.sparse config option as an indicator that we should attempt writing
the index in sparse form.


Updates in V4
=============

 * Rebased onto the latest copy of ab/read-tree.
 * Updated the design document as per Junio's comments.
 * Updated the submodule handling in the performance test.
 * Followed up on some other review from Ævar, mostly style or commit
   message things.


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

Derrick Stolee (21):
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
  sparse-index: add 'sdir' index extension
  sparse-index: convert from full to sparse
  submodule: sparse-index should not collapse links
  unpack-trees: allow sparse directories
  sparse-index: check index conversion happens
  sparse-index: add index.sparse config option
  sparse-checkout: toggle sparse index from builtin
  sparse-checkout: disable sparse-index
  cache-tree: integrate with sparse directory entries
  sparse-index: loose integration with cache_tree_verify()
  p2000: add sparse-index repos

 Documentation/config/index.txt           |   5 +
 Documentation/git-sparse-checkout.txt    |  14 ++
 Documentation/technical/index-format.txt |  19 ++
 Documentation/technical/sparse-index.txt | 175 ++++++++++++++
 Makefile                                 |   1 +
 builtin/sparse-checkout.c                |  44 +++-
 cache-tree.c                             |  40 ++++
 cache.h                                  |  18 +-
 read-cache.c                             |  44 +++-
 repo-settings.c                          |  15 ++
 repository.c                             |  11 +-
 repository.h                             |   3 +
 sparse-index.c                           | 285 +++++++++++++++++++++++
 sparse-index.h                           |  11 +
 t/README                                 |   3 +
 t/helper/test-read-cache.c               |  66 +++++-
 t/perf/p2000-sparse-operations.sh        | 101 ++++++++
 t/t1091-sparse-checkout-builtin.sh       |  13 ++
 t/t1092-sparse-checkout-compatibility.sh | 143 ++++++++++--
 unpack-trees.c                           |  17 +-
 20 files changed, 988 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/technical/sparse-index.txt
 create mode 100644 sparse-index.c
 create mode 100644 sparse-index.h
 create mode 100755 t/perf/p2000-sparse-operations.sh


base-commit: 47957485b3b731a7860e0554d2bd12c0dce1c75a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-883%2Fderrickstolee%2Fsparse-index%2Fformat-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-883/derrickstolee/sparse-index/format-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/883

Range-diff vs v4:

  1:  6426a5c60e53 !  1:  7b600d536c6e sparse-index: design doc and format update
     @@ Documentation/technical/sparse-index.txt (new)
      +The only noticeable change in behavior will be that the serialized index
      +file contains sparse-directory entries.
      +
     -+To start, we use a new repository extension, `extensions.sparseIndex`, to
     -+allow inserting sparse-directory entries into indexes with file format
     ++To start, we use a new required index extension, `sdir`, to allow
     ++inserting sparse-directory entries into indexes with file format
      +versions 2, 3, and 4. This prevents Git versions that do not understand
     -+the sparse-index from operating on one, but it also prevents other
     -+operations that do not use the index at all. A new format, index v5, will
     -+be introduced that includes sparse-directory entries by default. It might
     -+also introduce other features that have been considered for improving the
     ++the sparse-index from operating on one, while allowing tools that do not
     ++understand the sparse-index to operate on repositories as long as they do
     ++not interact with the index. A new format, index v5, will be introduced
     ++that includes sparse-directory entries by default. It might also
     ++introduce other features that have been considered for improving the
      +index, as well.
      +
      +Next, consumers of the index will be guarded against operating on a
  2:  7eabc1d0586c =  2:  202253ec82f3 t/perf: add performance test for sparse operations
  3:  c9e21d78ecba =  3:  437a0f144e57 t1092: clean up script quoting
  4:  03cdde756563 =  4:  b7e1bf5c55a7 sparse-index: add guard to ensure full index
  5:  6b3b6d86385d =  5:  e41d55d2cca9 sparse-index: implement ensure_full_index()
  6:  7f67adba0498 =  6:  7bfbfbd17321 t1092: compare sparse-checkout to sparse-index
  7:  7ebd9570b1ad =  7:  a1b8135c0fc8 test-read-cache: print cache entries with --table
  8:  db7bbd06dbcc =  8:  dd84a2a9121b test-tool: don't force full index
  9:  3ddd5e794b5e =  9:  b276d2ed5323 unpack-trees: ensure full index
 10:  7308c87697f1 = 10:  c3651e26dc3a sparse-checkout: hold pattern list in index
  -:  ------------ > 11:  f926cf8b2e01 sparse-index: add 'sdir' index extension
 11:  7c10d653ca6b = 12:  c870ae5e8749 sparse-index: convert from full to sparse
 12:  6db36f33e960 = 13:  bcf0da959ef3 submodule: sparse-index should not collapse links
 13:  d24bd3348d98 = 14:  7191b48237de unpack-trees: allow sparse directories
 14:  08d9f5f3c0d1 = 15:  57be9b4a728b sparse-index: check index conversion happens
 15:  6f38cef196b0 ! 16:  c22b4111e49e sparse-index: create extension for compatibility
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    sparse-index: create extension for compatibility
     +    sparse-index: add index.sparse config option
      
     -    Previously, we enabled the sparse index format only using
     -    GIT_TEST_SPARSE_INDEX=1. This is not a feasible direction for users to
     -    actually select this mode. Further, sparse directory entries are not
     -    understood by the index formats as advertised.
     -
     -    We _could_ add a new index version that explicitly adds these
     -    capabilities, but there are nuances to index formats 2, 3, and 4 that
     -    are still valuable to select as options. Until we add index format
     -    version 5, create a repo extension, "extensions.sparseIndex", that
     -    specifies that the tool reading this repository must understand sparse
     -    directory entries.
     -
     -    This change only encodes the extension and enables it when
     -    GIT_TEST_SPARSE_INDEX=1. Later, we will add a more user-friendly CLI
     -    mechanism.
     +    When enabled, this config option signals that index writes should
     +    attempt to use sparse-directory entries.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     - ## Documentation/config/extensions.txt ##
     -@@ Documentation/config/extensions.txt: extensions.objectFormat::
     - Note that this setting should only be set by linkgit:git-init[1] or
     - linkgit:git-clone[1].  Trying to change it after initialization will not
     - work and will produce hard-to-diagnose issues.
     + ## Documentation/config/index.txt ##
     +@@ Documentation/config/index.txt: index.recordOffsetTable::
     + 	Defaults to 'true' if index.threads has been explicitly enabled,
     + 	'false' otherwise.
     + 
     ++index.sparse::
     ++	When enabled, write the index using sparse-directory entries. This
     ++	has no effect unless `core.sparseCheckout` and
     ++	`core.sparseCheckoutCone` are both enabled. Defaults to 'false'.
      +
     -+extensions.sparseIndex::
     -+	When combined with `core.sparseCheckout=true` and
     -+	`core.sparseCheckoutCone=true`, the index may contain entries
     -+	corresponding to directories outside of the sparse-checkout
     -+	definition in lieu of containing each path under such directories.
     -+	Versions of Git that do not understand this extension do not
     -+	expect directory entries in the index.
     + index.threads::
     + 	Specifies the number of threads to spawn when loading the index.
     + 	This is meant to reduce index load time on multiprocessor machines.
      
       ## cache.h ##
      @@ cache.h: struct repository_format {
     @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
      +	 * Initialize this as off.
      +	 */
      +	r->settings.sparse_index = 0;
     -+	if (!repo_config_get_bool(r, "extensions.sparseindex", &value) && value)
     ++	if (!repo_config_get_bool(r, "index.sparse", &value) && value)
      +		r->settings.sparse_index = 1;
       }
      
     @@ repository.h: struct repo_settings {
       
       struct repository {
      
     - ## setup.c ##
     -@@ setup.c: static enum extension_result handle_extension(const char *var,
     - 			return error("invalid value for 'extensions.objectformat'");
     - 		data->hash_algo = format;
     - 		return EXTENSION_OK;
     -+	} else if (!strcmp(ext, "sparseindex")) {
     -+		data->sparse_index = 1;
     -+		return EXTENSION_OK;
     - 	}
     - 	return EXTENSION_UNKNOWN;
     - }
     -
       ## sparse-index.c ##
      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
       	return num_converted - start_converted;
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
      +{
      +	const char *config_path = repo_git_path(repo, "config.worktree");
      +
     -+	if (upgrade_repository_format(1) < 0) {
     -+		warning(_("unable to upgrade repository format to enable sparse-index"));
     -+		return -1;
     -+	}
      +	git_config_set_in_file_gently(config_path,
     -+				      "extensions.sparseIndex",
     ++				      "index.sparse",
      +				      "true");
      +
      +	prepare_repo_settings(repo);
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
      +
      +	/*
      +	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
     -+	 * extensions.sparseIndex config variable to be on.
     ++	 * index.sparse config variable to be on.
      +	 */
      +	if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
      +		int err = enable_sparse_index(istate->repo);
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
      -	 * GIT_TEST_SPARSE_INDEX environment variable. We will relax
      -	 * this once we have a proper way to opt-in (and later still,
      -	 * opt-out).
     -+	 * Only convert to sparse if extensions.sparseIndex is set.
     ++	 * Only convert to sparse if index.sparse is set.
       	 */
      -	if (!git_env_bool("GIT_TEST_SPARSE_INDEX", 0))
      +	prepare_repo_settings(istate->repo);
 16:  923081e7e079 ! 17:  75fe9b0f57da sparse-checkout: toggle sparse index from builtin
     @@ Documentation/git-sparse-checkout.txt: To avoid interfering with other worktrees
      +that is not completely understood by external tools. If you have trouble
      +with this compatibility, then run `git sparse-checkout init --no-sparse-index`
      +to rewrite your index to not be sparse. Older versions of Git will not
     -+understand the `sparseIndex` repository extension and may fail to interact
     -+with your repository until it is disabled.
     ++understand the sparse directory entries index extension and may fail to
     ++interact with your repository until it is disabled.
       
       'set'::
       	Write a set of patterns to the sparse-checkout file, as given as
     @@ builtin/sparse-checkout.c: static int sparse_checkout_init(int argc, const char
      
       ## sparse-index.c ##
      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
     + 	return num_converted - start_converted;
     + }
       
     - static int enable_sparse_index(struct repository *repo)
     +-static int enable_sparse_index(struct repository *repo)
     ++static int set_index_sparse_config(struct repository *repo, int enable)
       {
      -	const char *config_path = repo_git_path(repo, "config.worktree");
     -+	int res;
     - 
     - 	if (upgrade_repository_format(1) < 0) {
     - 		warning(_("unable to upgrade repository format to enable sparse-index"));
     - 		return -1;
     - 	}
     +-
      -	git_config_set_in_file_gently(config_path,
     --				      "extensions.sparseIndex",
     +-				      "index.sparse",
      -				      "true");
     -+	res = git_config_set_gently("extensions.sparseindex", "true");
     ++	int res;
     ++	char *config_path = repo_git_path(repo, "config.worktree");
     ++	res = git_config_set_in_file_gently(config_path,
     ++					    "index.sparse",
     ++					    enable ? "true" : NULL);
     ++	free(config_path);
       
       	prepare_repo_settings(repo);
       	repo->settings.sparse_index = 1;
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
      +
      +int set_sparse_index_config(struct repository *repo, int enable)
      +{
     -+	int res;
     -+
     -+	if (enable)
     -+		return enable_sparse_index(repo);
     -+
     -+	/* Don't downgrade repository format, just remove the extension. */
     -+	res = git_config_set_gently("extensions.sparseindex", NULL);
     ++	int res = set_index_sparse_config(repo, enable);
      +
      +	prepare_repo_settings(repo);
     -+	repo->settings.sparse_index = 0;
     ++	repo->settings.sparse_index = enable;
      +	return res;
       }
       
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
       	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
       		return 0;
      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
     - 		istate->repo = the_repository;
     - 
     - 	/*
     --	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
     --	 * extensions.sparseIndex config variable to be on.
     -+	 * If GIT_TEST_SPARSE_INDEX=1, then trigger extensions.sparseIndex
     -+	 * to be fully enabled. If GIT_TEST_SPARSE_INDEX=0 (set explicitly),
     -+	 * then purposefully disable the setting.
     + 	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
     + 	 * index.sparse config variable to be on.
       	 */
      -	if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
      -		int err = enable_sparse_index(istate->repo);
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
      +		set_sparse_index_config(istate->repo, test_env);
       
       	/*
     - 	 * Only convert to sparse if extensions.sparseIndex is set.
     + 	 * Only convert to sparse if index.sparse is set.
      
       ## sparse-index.h ##
      @@ sparse-index.h: struct index_state;
     @@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
      -	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout init --cone &&
      -	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep
      +	git -C sparse-index sparse-checkout init --cone --sparse-index &&
     -+	test_cmp_config -C sparse-index true extensions.sparseindex &&
     ++	test_cmp_config -C sparse-index true index.sparse &&
      +	git -C sparse-index sparse-checkout set deep
       }
       
 17:  6f1ad72c390d ! 18:  7f55a232e647 sparse-checkout: disable sparse-index
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-checkout disable
       
      +test_expect_success 'sparse-index enabled and disabled' '
      +	git -C repo sparse-checkout init --cone --sparse-index &&
     -+	test_cmp_config -C repo true extensions.sparseIndex &&
     ++	test_cmp_config -C repo true index.sparse &&
      +	test-tool -C repo read-cache --table >cache &&
      +	grep " tree " cache &&
      +
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-checkout disable
      +	test-tool -C repo read-cache --table >cache &&
      +	! grep " tree " cache &&
      +	git -C repo config --list >config &&
     -+	! grep extensions.sparseindex config
     ++	! grep index.sparse config
      +'
      +
       test_expect_success 'cone mode: init and set' '
 18:  bd94e6b7d089 = 19:  365901809d9d cache-tree: integrate with sparse directory entries
 19:  e7190376b806 = 20:  9b068c458898 sparse-index: loose integration with cache_tree_verify()
 20:  bcf0a58eb38c = 21:  66602733cc95 p2000: add sparse-index repos

-- 
gitgitgadget
