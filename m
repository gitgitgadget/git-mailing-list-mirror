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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A092DC433E2
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4A3619C3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhCWNo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhCWNoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1EBC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c8so7920052wrq.11
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRE5rsFsL6iEYnD7K7Xpskkok18KUBHM/btS4jFjB4Q=;
        b=IDDsJPuQ6YRfnmxj2bhEI9qO45W/X28FUy+lQuZi9tQ40cU/1Z53XR0xeqK5AyQLCo
         yiXLLFLoPDrULg+v6fC5vEMBQN4mjuonYlLhMj9s9Fzsi4/A7C9/OywaGa4uBB4HA9Qr
         MVm5cg623ey50+bmJw82BWU5toC2KOZYKE2ym5vob6EzUzfvwzIMasfXgP5/uaG+0EGV
         CiI5IZiFrWjZBGkNqeY9obALblO9ehGrV7YbeiMXt+T8S7cah3MKOYQUTBLaOwD15KJo
         Ojig75qyUIWVKZRCzs+mXIfiqtOV0OFzemYBmbhUn14iDco500bPVBHgfJPwvMvz6Mxa
         9w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRE5rsFsL6iEYnD7K7Xpskkok18KUBHM/btS4jFjB4Q=;
        b=UZ9Yk8NZY96Tj0f5v1c2mDQKatH5/YbcuuQmvH1/kaCheL+G39+HQTjhGxH4X0x0Uc
         g0dwUgHR9R2hqHjUhSYZXztooXcHt/1ARkd7DTauy+wbGMQzep8LCRV9jDJBFo/EZvhT
         8RQkeGEFhx4oCjdJQU9uP46s9YGak7CeJcQEchnpxzjUsaQaBZFTHX5QlZG5c2PIQok0
         e0zJMBO74RBspvmakT8FaHIoknz8QAFWMurp94ZUvMAu6DvkYeZ7wMmWtb7ZT+3xFdcG
         FSQicEDpZ9/68XeJmsn2uRDWPT7H/W5FnEV0RaT9pQP67pwSTne5IsafesWWCEh9SsOC
         0lHA==
X-Gm-Message-State: AOAM532wbK4vgBNJZm3/tNQWDJVLCg0j73u9p8tgzz4ewsHFHGevzaQ8
        2wBOkuVtbImu9qdIo5GKOjLbAVCs4TM=
X-Google-Smtp-Source: ABdhPJxY407HUlE05qbb9rpF3JvJonirSW/O0BUNPRbj1VQP5N0kCjW+k6We6NZvFxxJ47YvVPtMwQ==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr4111623wrp.71.1616507071447;
        Tue, 23 Mar 2021 06:44:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm2633234wmi.22.2021.03.23.06.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:30 -0700 (PDT)
Message-Id: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:08 +0000
Subject: [PATCH v4 00/20] Sparse Index: Design, Format, Tests
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
 Documentation/technical/sparse-index.txt | 174 ++++++++++++++
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
 t/perf/p2000-sparse-operations.sh        | 101 ++++++++
 t/t1091-sparse-checkout-builtin.sh       |  13 +
 t/t1092-sparse-checkout-compatibility.sh | 143 +++++++++--
 unpack-trees.c                           |  17 +-
 21 files changed, 980 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/technical/sparse-index.txt
 create mode 100644 sparse-index.c
 create mode 100644 sparse-index.h
 create mode 100755 t/perf/p2000-sparse-operations.sh


base-commit: 47957485b3b731a7860e0554d2bd12c0dce1c75a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-883%2Fderrickstolee%2Fsparse-index%2Fformat-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-883/derrickstolee/sparse-index/format-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/883

Range-diff vs v3:

  1:  62ac13945bec !  1:  6426a5c60e53 sparse-index: design doc and format update
     @@ Documentation/technical/index-format.txt: Git index format
      +  is enabled in cone mode (`core.sparseCheckoutCone` is enabled) and the
      +  `extensions.sparseIndex` extension is enabled, then the index may
      +  contain entries for directories outside of the sparse-checkout definition.
     -+  These entries have mode `0040000`, include the `SKIP_WORKTREE` bit, and
     ++  These entries have mode `040000`, include the `SKIP_WORKTREE` bit, and
      +  the path ends in a directory separator.
      +
         32-bit ctime seconds, the last time a file's metadata changed
     @@ Documentation/technical/sparse-index.txt (new)
      +`core.sparseCheckoutCone`, allow for very fast pattern matching to
      +discover which files at HEAD belong in the sparse-checkout cone.
      +
     -+Three important scale dimensions for a Git worktree are:
     ++Three important scale dimensions for a Git working directory are:
      +
      +* `HEAD`: How many files are present at `HEAD`?
      +
     @@ Documentation/technical/sparse-index.txt (new)
      +
      +These dimensions are ordered by their magnitude: users (typically) modify
      +fewer files than are populated, and we can only populate files at `HEAD`.
     -+These dimensions are also ordered by how expensive they are per item: it
     -+is expensive to detect a modified file than it is to write one that we
     -+know must be populated; changing `HEAD` only really requires updating the
     -+index.
      +
      +Problems occur if there is an extreme imbalance in these dimensions. For
      +example, if `HEAD` contains millions of paths but the populated set has
     @@ Documentation/technical/sparse-index.txt (new)
      +At time of writing, sparse-directory entries violate expectations about the
      +index format and its in-memory data structure. There are many consumers in
      +the codebase that expect to iterate through all of the index entries and
     -+see only files. In addition, they expect to see all files at `HEAD`. One
     -+way to handle this is to parse trees to replace a sparse-directory entry
     -+with all of the files within that tree as the index is loaded. However,
     -+parsing trees is slower than parsing the index format, so that is a slower
     -+operation than if we left the index alone.
     ++see only files. In fact, these loops expect to see a reference to every
     ++staged file. One way to handle this is to parse trees to replace a
     ++sparse-directory entry with all of the files within that tree as the index
     ++is loaded. However, parsing trees is slower than parsing the index format,
     ++so that is a slower operation than if we left the index alone. The plan is
     ++to make all of these integrations "sparse aware" so this expansion through
     ++tree parsing is unnecessary and they use fewer resources than when using a
     ++full index.
      +
      +The implementation plan below follows four phases to slowly integrate with
      +the sparse-index. The intention is to incrementally update Git commands to
     @@ Documentation/technical/sparse-index.txt (new)
      +data structure can operate with its current assumption of every file at
      +`HEAD`.
      +
     -+At first, every index parse will expand the sparse-directory entries into
     -+the full list of paths at `HEAD`. This will be slower in all cases. The
     -+only noticable change in behavior will be that the serialized index file
     -+contains sparse-directory entries.
     ++At first, every index parse will call a helper method,
     ++`ensure_full_index()`, which scans the index for sparse-directory entries
     ++(pointing to trees) and replaces them with the full list of paths (with
     ++blob contents) by parsing tree objects. This will be slower in all cases.
     ++The only noticeable change in behavior will be that the serialized index
     ++file contains sparse-directory entries.
      +
      +To start, we use a new repository extension, `extensions.sparseIndex`, to
      +allow inserting sparse-directory entries into indexes with file format
  2:  d2197e895e4d !  2:  7eabc1d0586c t/perf: add performance test for sparse operations
     @@ t/perf/p2000-sparse-operations.sh (new)
      +
      +test_expect_success 'setup repo and indexes' '
      +	git reset --hard HEAD &&
     ++
      +	# Remove submodules from the example repo, because our
     -+	# duplication of the entire repo creates an unlikly data shape.
     -+	git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
     -+	git rm -f .gitmodules &&
     -+	for module in $(awk "{print \$2}" modules)
     -+	do
     -+		git rm $module || return 1
     -+	done &&
     -+	git commit -m "remove submodules" &&
     ++	# duplication of the entire repo creates an unlikely data shape.
     ++	if git config --file .gitmodules --get-regexp "submodule.*.path" >modules
     ++	then
     ++		git rm $(awk "{print \$2}" modules) &&
     ++		git commit -m "remove submodules" || return 1
     ++	fi &&
      +
      +	echo bogus >a &&
      +	cp a b &&
  3:  d3cfd34b8418 !  3:  c9e21d78ecba t1092: clean up script quoting
     @@ Commit message
          t1092: clean up script quoting
      
          This test was introduced in 19a0acc83e4 (t1092: test interesting
     -    sparse-checkout scenarios, 2021-01-23), but these issues with quoting
     -    were not noticed until starting this follow-up series. The old mechanism
     -    would drop quoting such as in
     +    sparse-checkout scenarios, 2021-01-23), but it contains issues with quoting
     +    that were not noticed until starting this follow-up series. The old
     +    mechanism would drop quoting such as in
      
             test_all_match git commit -m "touch README.md"
      
  4:  4472118cf903 =  4:  03cdde756563 sparse-index: add guard to ensure full index
  5:  99292cdbaae4 =  5:  6b3b6d86385d sparse-index: implement ensure_full_index()
  6:  fae5663a17bb =  6:  7f67adba0498 t1092: compare sparse-checkout to sparse-index
  7:  dffe8821fde2 !  7:  7ebd9570b1ad test-read-cache: print cache entries with --table
     @@ Commit message
          a sparse-index. Further, 'git ls-tree' does not use a trailing directory
          separator for its tree rows.
      
     -    This does not print the stat() information for the blobs. That could be
     +    This does not print the stat() information for the blobs. That will be
          added in a future change with another option. The tests that are added
          in the next few changes care only about the object types and IDs.
     +    However, this future need for full index information justifies the need
     +    for this test helper over extending a user-facing feature, such as 'git
     +    ls-files'.
      
          To make the option parsing slightly more robust, wrap the string
          comparisons in a loop adapted from test-dir-iterator.c.
  8:  f4ad081f25bb =  8:  db7bbd06dbcc test-tool: don't force full index
  9:  4780076a50df =  9:  3ddd5e794b5e unpack-trees: ensure full index
 10:  33fdba2b8cfd = 10:  7308c87697f1 sparse-checkout: hold pattern list in index
 11:  e41b14e03ebb ! 11:  7c10d653ca6b sparse-index: convert from full to sparse
     @@ cache.h: static inline unsigned int create_ce_mode(unsigned int mode)
       {
       	if (S_ISLNK(mode))
       		return S_IFLNK;
     -+	if (mode == S_IFDIR)
     ++	if (S_ISSPARSEDIR(mode))
      +		return S_IFDIR;
       	if (S_ISDIR(mode) || S_ISGITLINK(mode))
       		return S_IFGITLINK;
 12:  b77cd6b02265 = 12:  6db36f33e960 submodule: sparse-index should not collapse links
 13:  4000c5cdd4cf ! 13:  d24bd3348d98 unpack-trees: allow sparse directories
     @@ unpack-trees.c: static int index_pos_by_traverse_info(struct name_entry *names,
      +		if (!o->src_index->sparse_index ||
      +		    !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
      +			BUG("This is a directory and should not exist in index");
     -+	} else
     ++	} else {
      +		pos = -pos - 1;
     ++	}
       	if (pos >= o->src_index->cache_nr ||
       	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
       	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
 14:  1a2be38b2ca7 = 14:  08d9f5f3c0d1 sparse-index: check index conversion happens
 15:  f89891b0ae4e = 15:  6f38cef196b0 sparse-index: create extension for compatibility
 16:  bd703c76c859 = 16:  923081e7e079 sparse-checkout: toggle sparse index from builtin
 17:  598557f90a2a = 17:  6f1ad72c390d sparse-checkout: disable sparse-index
 18:  c2d0c17db31a = 18:  bd94e6b7d089 cache-tree: integrate with sparse directory entries
 19:  6fdd9323c14e = 19:  e7190376b806 sparse-index: loose integration with cache_tree_verify()
 20:  3db06ac46dd5 = 20:  bcf0a58eb38c p2000: add sparse-index repos

-- 
gitgitgadget
