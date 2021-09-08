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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D217C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510576113D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbhIHBno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbhIHBnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A79C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q11so720943wrr.9
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qhaYK4+VasJXxOFT0wJIrBb2USwOti2cNsiZWscbCuI=;
        b=IuSfJRSzzU6jEzQ3QpGoxDNob0SU9UlHEW1UAzkPrAv4leVg6sBZcMV4R156L0xOAx
         w7CIljailAkXjRJsKMrZKfSI+RCuKz3bjF/T4cM8psP6trCy4BuQ/rHfZ6FJrVTaTXze
         OzFMVLiZxJsRb3B+NsDNNtmoJvbq7IB6IEg8Tf/WB3HyEejSBhpul5r0NtpSP8EXXeIH
         4py14adYg8z1BGuX9OdR93wTROcLd68QaKVrWA85EMJrPp4N/QR8XDQbfqAwgZajwP9L
         GER1jyl271OFAuTSP7PsRYH82PJHDpuX+tUW/AXWEuMMZrPvs0F2Z87zaUgvm0S0TrbZ
         k8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=qhaYK4+VasJXxOFT0wJIrBb2USwOti2cNsiZWscbCuI=;
        b=FWxD9RJmN/0s57xsiZAlYHqIe0WBHpXdfPJMeIltrHzgWOBIYKbUZ3VBNC+h+5k0Uh
         6Q+nntRRtsoBg/46IjTwVXX4pwIjBrgG0zq60VHsTTj8Ik8mDRIiTsiCghy8f3o+dBfr
         0lbIZe8lNVbnXHAi+rMVt8e4Ya2yGyl16HQk03Gdw6GCyUAn0qzj28WdtKZlmIw4Kuhs
         VX/PN04FnXLXfMl3b6aIQx8/voswJSTq7K+grhMf2BCuO454ogISewPkj1qCbLkxF/bG
         OLH1zlfGQtW9yer30dMWALv7lrf16j8n1XriWg9UAXrZyyxQXTBqbmWcNOcYtxumrkr8
         leVg==
X-Gm-Message-State: AOAM530Mj3HRfEADG4zrxAV3RshzpWpGPQ28Gpnypoqs3js2oTmwuJe7
        GsPbsevfW4r7BlP9W7gy6CyzwWvoPI0=
X-Google-Smtp-Source: ABdhPJz/VzeQJrIUt5zFWXFtw8X2IEBslr6DxhLPpDrtyndZAaUsb5HuqmzLZQjpCmq34ZNqhVLZBw==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr1068281wrr.376.1631065355181;
        Tue, 07 Sep 2021 18:42:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm621727wmp.26.2021.09.07.18.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:34 -0700 (PDT)
Message-Id: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:24 +0000
Subject: [PATCH v5 0/9] Sparse index: delete ignored files outside sparse cone
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We launched an experimental release [1] of the sparse-index feature to our
internal users. We immediately discovered a problem due to the isolated way
in which we tested the sparse index: we were never building the project and
changing our sparse-checkout definition.

[1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp

Users who ran a build in one project and then moved to another still had
build artifacts in their worktree that lived inside the old directories.
Since the files are marked by the .gitignore patterns, these files were not
removed by the 'git sparse-checkout set' command. However, they make the
sparse-index unusable because every 'git status' command needs to expand the
sparse-directory entries in order to see if the files are tracked or not.
This made the first experimental release actually slower for all users
because of this cost.

The solution we shipped to these customers was to change the way our fork
handles these ignored files. Specifically, instead of Git completely
ignoring the files, we changed Git to understand that with cone-mode
sparse-checkout patterns, the users is asking for entire directories to be
removed from the worktree. The link [1] included earlier has this change.

I believe that this is a reasonable expectation, though I recognize that it
might look like breaking the expectations of how .gitignore files work.

Since feedback demonstrated that this is a desired behavior, v2 includes
this behavior for all "cone mode" repositories.

I'm interested in the community's thoughts about this change, as it seems
like one that we should make carefully and intentionally.

While the rewrite of the t7519 test seems unrelated, it is required to avoid
a test failure with this change that deletes files outside of the cone. By
moving the test into repositories not at $TRASH_DIRECTORY, we gain more
control over the repository structure.


Updates in V5
=============

 * Updated the locality of a cache_entry pointer.

 * Rephrased a comment.

 * Removed the patch adding a config option.

 * I tried, but failed, to create a scenario where the call to
   cache_tree_update() causes a test to fail. I still think this is valuable
   as defensive programming for the reasons mentioned in the patch, which is
   why I didn't remove them here.


Updates in V4
=============

 * Fixed an issue with the split index.

 * The helper methods are used more consistently.

 * The helper method path_in_cone_mode_sparse_checkout() is introduced.

 * Commit messages are edited for clarity.

 * A new config option is added to disable the behavior being added in this
   series.

 * I split the commit that involves cache_tree_update(). I have not yet
   succeeded in creating tests to demonstrate why this is required outside
   of needing it in the Scalar functional tests, which includes a version of
   partial clone. I will continue to investigate recreating this scenario in
   the Git test suite, but I wanted to send this version out to get feedback
   on the things that have changed.


Update in V3
============

 * As promised [2], the helper methods are fixed to work with non-cone-mode
   patterns. A later series will use them to their fullest potential
   (changing git add, git rm, and git mv when interacting with sparse
   entries).

[2]
https://lore.kernel.org/git/bac76c72-955d-1ade-4ecf-778ffc45f297@gmail.com/


Updates in V2
=============

 * This version correctly leaves untracked files alone. If untracked files
   are found, then the directory is left as-is, in case those ignored files
   are important to the user's work resolving those untracked files.

 * This behavior is now enabled by core.sparseCheckoutCone=true.

 * To use a sparse index as an in-memory data structure even when
   index.sparse is disabled, a new patch is included to modify the prototype
   of convert_to_sparse() to include a flags parameter.

 * A few cleanup patches that I was collecting based on feedback from the
   experimental release and intending for my next series were necessary for
   this implementation.

 * Cleaned up the tests (no NEEDSWORK) and the remainders of a previous
   implementation that used run_subcommand().

Thanks, -Stolee

Derrick Stolee (9):
  t7519: rewrite sparse index test
  sparse-index: silently return when not using cone-mode patterns
  unpack-trees: fix nested sparse-dir search
  sparse-index: silently return when cache tree fails
  sparse-index: use WRITE_TREE_MISSING_OK
  sparse-checkout: create helper methods
  attr: be careful about sparse directories
  sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
  sparse-checkout: clear tracked sparse dirs

 Documentation/git-sparse-checkout.txt | 10 +++
 attr.c                                | 15 +++++
 builtin/add.c                         |  7 +-
 builtin/sparse-checkout.c             | 94 +++++++++++++++++++++++++++
 dir.c                                 | 52 +++++++++++++++
 dir.h                                 |  8 +++
 read-cache.c                          |  4 +-
 sparse-index.c                        | 76 ++++++++++++----------
 sparse-index.h                        |  3 +-
 t/t1091-sparse-checkout-builtin.sh    | 59 +++++++++++++++++
 t/t7519-status-fsmonitor.sh           | 38 ++++++-----
 unpack-trees.c                        |  8 ++-
 12 files changed, 312 insertions(+), 62 deletions(-)


base-commit: 80b8d6c56b8a5f5db1d5c2a0159fd808e8a7fc4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1009%2Fderrickstolee%2Fsparse-index%2Fignored-files-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1009/derrickstolee/sparse-index/ignored-files-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1009

Range-diff vs v4:

  1:  c407b2cb346 =  1:  c407b2cb346 t7519: rewrite sparse index test
  2:  8660877ba7a =  2:  8660877ba7a sparse-index: silently return when not using cone-mode patterns
  5:  acdded0f762 !  3:  edb00d3f9aa unpack-trees: fix nested sparse-dir search
     @@ unpack-trees.c: static int sparse_dir_matches_path(const struct cache_entry *ce,
       {
      -	struct cache_entry *ce;
      +	const char *path;
     -+	struct cache_entry *ce = NULL;
       	int pos = find_cache_pos(info, p->path, p->pathlen);
       	struct unpack_trees_options *o = info->data;
       
      @@ unpack-trees.c: static struct cache_entry *find_cache_entry(struct traverse_info *info,
     + 	 * paths (e.g. "subdir-").
     + 	 */
       	while (pos >= 0) {
     - 		ce = o->src_index->cache[pos];
     +-		ce = o->src_index->cache[pos];
     ++		struct cache_entry *ce = o->src_index->cache[pos];
       
      -		if (strncmp(ce->name, p->path, p->pathlen))
      +		if (!skip_prefix(ce->name, info->traverse_path, &path) ||
  3:  a669740af9a =  4:  c8620de61eb sparse-index: silently return when cache tree fails
  4:  b379b8fc61a =  5:  37171612424 sparse-index: use WRITE_TREE_MISSING_OK
  6:  1958751aa0e =  6:  98b4cae2297 sparse-checkout: create helper methods
  7:  e496f3cee66 !  7:  6ec3cb2042e attr: be careful about sparse directories
     @@ attr.c: static struct attr_stack *read_attr_from_index(struct index_state *istat
      +	 * .gitattributes file since it will not matter.
      +	 *
      +	 * In the case of a sparse index, it is critical that we don't go
     -+	 * looking for a .gitattributes file, as the index will expand.
     ++	 * looking for a .gitattributes file, as doing so would cause the
     ++	 * index to expand.
      +	 */
      +	if (!path_in_cone_mode_sparse_checkout(path, istate))
      +		return NULL;
  8:  cab9360b1e9 =  8:  d57f48c445c sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
  9:  c19d93ec5d7 =  9:  91b53f20109 sparse-checkout: clear tracked sparse dirs
 10:  8d55a6ba2fd <  -:  ----------- sparse-checkout: add config to disable deleting dirs

-- 
gitgitgadget
