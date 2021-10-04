Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD89C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188D06115C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhJDBNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhJDBNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:13:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAEAC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so22199696wrb.0
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztCBguj/WuCDv+VQF5x/TEJ+6U9vBjPMMpPgYcMfx2k=;
        b=K5HBPkYCyWfzp7/SfWmumJDyFiEhd4GfuFtxxd0JKicDiCJ8ySEplV4+Ei8jWUHW4v
         p3c3d81M/Smoysu6J2+Q6she03xNKyvKj9ODePo0+gdWQHLve4M9af8qjpFHnYRVdGdg
         UpcyjjcNGK4Vd/LFXUwaaDnbyOeJrEU9/8i8i+JZU/78kxjHp25djEOQDDzc/IOR0U2G
         8a2RlsvUiJnyUPlzC5QA1vbmeen5wVGq23GZQFzVIFuE3qWTOegWyu8ytPMHLcW+NRzT
         hTq6RF5cQHLOTA5opsQLVN8eu1ZZkWMea8WK06jXKDO2gJxkOSq1QWHePlZ8AiI4g5+l
         OH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztCBguj/WuCDv+VQF5x/TEJ+6U9vBjPMMpPgYcMfx2k=;
        b=Jtf/a/l75qwIIhKu3I+GVobjszZ/+HZvdFcYS+z3KE5SrIEH7MZ9zlAi7m7EdA9wdj
         Re3etahj8lNI6+k6i/Ip+lISyLNNj/vVbCUQ5IESX/A2xNGEwap9LBiHASAhyRuHutMM
         C0hpPK2tgmblEWm1VnaC4VNFaiDHj8/e90rMQlPY1WoFMGayAGNFk7xdkznXzL1edxX5
         n497BE7coGI0e1ZSjLQ2Pz1n4gWWDDmtrAtUWLObSYHilhspicmygrCqkmxzgWh4CUKm
         0l+nFLJ8Vl1tOyLVJ43V4HqJnhQkcj0VPUDG3QAfoP8wKAIXZ1yf0nTfTMyQXfBqN3Gz
         jG/w==
X-Gm-Message-State: AOAM530evYdgRBzB2UXqu7z0WBZWykyR2A2u11YGqDANpD4OPyxtY7wt
        Sdw8886ugucFGINv/Ekf/+esVV3vYx4D2w==
X-Google-Smtp-Source: ABdhPJxfkbdZwceuEUUcVfnTblOxhDbGmzNIhTc+Uc5oJcRxKbalXf66jUbz+6vYgW2VrS8GDlcwzQ==
X-Received: by 2002:adf:f949:: with SMTP id q9mr11003024wrr.331.1633309921961;
        Sun, 03 Oct 2021 18:12:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 00/10] Fix various issues around removal of untracked files/directories
Date:   Mon,  4 Oct 2021 03:11:49 +0200
Message-Id: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an RFC proposed v4 of Elijah's en/removing-untracked-fixes
series[1] based on top of my memory leak fixes in the "unpack-trees" &
"dir" APIs[2].

As noted in [2] Elijah and I have been having a back & forth about the
approach his series takes to fixing memory leaks in those APIs. I
think submitting working code is more productive than continuing that
point-by-point discussion, so here we are.

I've avoided making any changes to this series except those narrowly
required to rebase it on top of mine, and to those parts of Elijah's
commit messages that became outdated as a result. In particular
3/10[3]'s is significantly changed, as much of its commit message
dicusses complexities that have gone away due to my preceding
series[2].

The "make dir an internal-only struct" has been replaced by a commit
that renames that struct member from "dir" to "private_dir". I think
even that is unnecessary as argued in [4], but I think the judgement
that something must be done to address that is Elijah's design
decision, so I did my best to retain it.

I did drop the dynamic allocation & it being a pointer, since with my
preceding [2] and subsequent unsubmitted memory leak fixes I've got on
top having it be embedded in "struct unpack_trees_options" makes
things easier to manage.

Havingn read through all this code quite thoroughly at this point I do
have other comments on it, but I'll reserve those until we've found
out what direction we're going forward with vis-a-vis what this will
be based on top of.

I'm (obviously) hoping for an answer of either on top of my series[2],
or alternatively that Elijah's series can stick to introducing the
"preserve_ignored" flag, but not change how the memory
management/name/type of the embedded "dir" happens (and we could thus
proceed in parallel).

But I'll hold off on any such general comments until we've got a way
forward with this, since if I start commenting inline on patches in
Elijah's v3, or this RFC-v4 on something unrelated to this proposed
re-arrangement that'll likely just confuse things, particularly as
some of those comments would be different depending on the base of his
v3 v.s. my series[2] in this RFC v4.

1. https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com
2. https://lore.kernel.org/git/cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com/
3. https://lore.kernel.org/git/RFC-patch-v4-03.10-739e9b871c4-20211004T004902Z-avarab@gmail.com
4. https://lore.kernel.org/git/87k0ivpzfx.fsf@evledraar.gmail.com

Elijah Newren (10):
  t2500: add various tests for nuking untracked files
  read-tree, merge-recursive: overwrite ignored files by default
  unpack-trees: introduce preserve_ignored to unpack_trees_options
  unpack-trees: rename "dir" to "private_dir"
  Remove ignored files by default when they are in the way
  Change unpack_trees' 'reset' flag into an enum
  unpack-trees: avoid nuking untracked dir in way of unmerged file
  unpack-trees: avoid nuking untracked dir in way of locally deleted
    file
  Comment important codepaths regarding nuking untracked files/dirs
  Documentation: call out commands that nuke untracked files/directories

 Documentation/git-checkout.txt   |   5 +-
 Documentation/git-read-tree.txt  |  23 +--
 Documentation/git-reset.txt      |   3 +-
 builtin/am.c                     |   3 +-
 builtin/checkout.c               |   9 +-
 builtin/clone.c                  |   1 +
 builtin/merge.c                  |   1 +
 builtin/read-tree.c              |  23 ++-
 builtin/reset.c                  |  10 +-
 builtin/stash.c                  |   5 +-
 builtin/submodule--helper.c      |   4 +
 contrib/rerere-train.sh          |   2 +-
 merge-ort.c                      |   5 +-
 merge-recursive.c                |   5 +-
 merge.c                          |   6 +-
 reset.c                          |   3 +-
 sequencer.c                      |   1 +
 submodule.c                      |   1 +
 t/t1013-read-tree-submodule.sh   |   1 -
 t/t2500-untracked-overwriting.sh | 244 +++++++++++++++++++++++++++++++
 t/t7112-reset-submodule.sh       |   1 -
 unpack-trees.c                   |  59 +++++++-
 unpack-trees.h                   |  16 +-
 23 files changed, 362 insertions(+), 69 deletions(-)
 create mode 100755 t/t2500-untracked-overwriting.sh

Range-diff against v3:
 1:  66270ffc74e !  1:  3a3203beee6 t2500: add various tests for nuking untracked files
    @@ Commit message
         removing untracked files and directories.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t2500-untracked-overwriting.sh (new) ##
     @@
 2:  0c74285b253 <  -:  ----------- checkout, read-tree: fix leak of unpack_trees_options.dir
 3:  2501a0c552a !  2:  8e5f4006604 read-tree, merge-recursive: overwrite ignored files by default
    @@ Commit message
         The read-tree changes happen to fix a bug in t1013.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-read-tree.txt ##
     @@ Documentation/git-read-tree.txt: SYNOPSIS
    @@ builtin/read-tree.c: static int list_tree(struct object_id *oid)
      	NULL
      };
      
    -@@ builtin/read-tree.c: static int index_output_cb(const struct option *opt, const char *arg,
    - static int exclude_per_directory_cb(const struct option *opt, const char *arg,
    - 				    int unset)
    - {
    --	struct dir_struct *dir;
    - 	struct unpack_trees_options *opts;
    - 
    - 	BUG_ON_OPT_NEG(unset);
    +@@ builtin/read-tree.c: static int exclude_per_directory_cb(const struct option *opt, const char *arg,
      
      	opts = (struct unpack_trees_options *)opt->value;
      
    --	if (opts->dir)
    +-	if (opts->dir.exclude_per_dir)
     -		die("more than one --exclude-per-directory given.");
     -
    --	dir = xcalloc(1, sizeof(*opts->dir));
    --	dir->flags |= DIR_SHOW_IGNORED;
    --	dir->exclude_per_dir = arg;
    --	opts->dir = dir;
    +-	opts->dir.flags |= DIR_SHOW_IGNORED;
    +-	opts->dir.exclude_per_dir = arg;
     -	/* We do not need to nor want to do read-directory
     -	 * here; we are merely interested in reusing the
     -	 * per directory ignore stack mechanism.
    @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *
      	if ((opts.update || opts.index_only) && !opts.merge)
      		die("%s is meaningless without -m, --reset, or --prefix",
      		    opts.update ? "-u" : "-i");
    --	if ((opts.dir && !opts.update))
    +-	if ((opts.dir.exclude_per_dir && !opts.update))
     -		die("--exclude-per-directory is meaningless unless -u");
     +	if (opts.update && !opts.reset) {
    -+		CALLOC_ARRAY(opts.dir, 1);
    -+		opts.dir->flags |= DIR_SHOW_IGNORED;
    -+		setup_standard_excludes(opts.dir);
    ++		opts.dir.flags |= DIR_SHOW_IGNORED;
    ++		setup_standard_excludes(&opts.dir);
     +	}
      	if (opts.merge && !opts.index_only)
      		setup_work_tree();
    @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *
     
      ## merge-recursive.c ##
     @@ merge-recursive.c: static int unpack_trees_start(struct merge_options *opt,
    - 	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
    + 	unpack_trees_options_init(&opt->priv->unpack_opts);
      	if (opt->priv->call_depth)
      		opt->priv->unpack_opts.index_only = 1;
     -	else
     +	else {
      		opt->priv->unpack_opts.update = 1;
    -+		/* FIXME: should only do this if !overwrite_ignore */
    -+		CALLOC_ARRAY(opt->priv->unpack_opts.dir, 1);
    -+		opt->priv->unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
    -+		setup_standard_excludes(opt->priv->unpack_opts.dir);
    ++		opt->priv->unpack_opts.dir.flags |= DIR_SHOW_IGNORED;
    ++		setup_standard_excludes(&opt->priv->unpack_opts.dir);
     +	}
      	opt->priv->unpack_opts.merge = 1;
      	opt->priv->unpack_opts.head_idx = 2;
      	opt->priv->unpack_opts.fn = threeway_merge;
    -@@ merge-recursive.c: static int unpack_trees_start(struct merge_options *opt,
    - 	init_tree_desc_from_tree(t+2, merge);
    - 
    - 	rc = unpack_trees(3, t, &opt->priv->unpack_opts);
    -+	if (opt->priv->unpack_opts.dir) {
    -+		dir_clear(opt->priv->unpack_opts.dir);
    -+		FREE_AND_NULL(opt->priv->unpack_opts.dir);
    -+	}
    - 	cache_tree_free(&opt->repo->index->cache_tree);
    - 
    - 	/*
     
      ## t/t1013-read-tree-submodule.sh ##
     @@ t/t1013-read-tree-submodule.sh: test_description='read-tree can handle submodules'
 4:  f1a0700e598 !  3:  739e9b871c4 unpack-trees: introduce preserve_ignored to unpack_trees_options
    @@ Commit message
     
         Currently, every caller of unpack_trees() that wants to ensure ignored
         files are overwritten by default needs to:
    -       * allocate unpack_trees_options.dir
    -       * flip the DIR_SHOW_IGNORED flag in unpack_trees_options.dir->flags
    -       * call setup_standard_excludes
    -    AND then after the call to unpack_trees() needs to
    -       * call dir_clear()
    -       * deallocate unpack_trees_options.dir
    -    That's a fair amount of boilerplate, and every caller uses identical
    -    code.  Make this easier by instead introducing a new boolean value where
    +
    +       * flip the DIR_SHOW_IGNORED flag in unpack_trees_options.dir.flags
    +       * call setup_standard_excludes(&unpack_trees_options.dir)
    +
    +    Avoid that boilerplate by introducing a new boolean value where
         the default value (0) does what we want so that new callers of
         unpack_trees() automatically get the appropriate behavior.  And move all
         the handling of unpack_trees_options.dir into unpack_trees() itself.
    @@ Commit message
         behavior we want.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/am.c ##
     @@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
    @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      				       &new_branch_info->commit->object.oid :
      				       &new_branch_info->oid, NULL);
     -		if (opts->overwrite_ignore) {
    --			topts.dir = xcalloc(1, sizeof(*topts.dir));
    --			topts.dir->flags |= DIR_SHOW_IGNORED;
    --			setup_standard_excludes(topts.dir);
    +-			topts.dir.flags |= DIR_SHOW_IGNORED;
    +-			setup_standard_excludes(&topts.dir);
     -		}
     +		topts.preserve_ignored = !opts->overwrite_ignore;
      		tree = parse_tree_indirect(old_branch_info->commit ?
      					   &old_branch_info->commit->object.oid :
      					   the_hash_algo->empty_tree);
    -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
    - 		init_tree_desc(&trees[1], tree->buffer, tree->size);
    - 
    - 		ret = unpack_trees(2, trees, &topts);
    --		if (topts.dir) {
    --			dir_clear(topts.dir);
    --			FREE_AND_NULL(topts.dir);
    --		}
    - 		clear_unpack_trees_porcelain(&topts);
    - 		if (ret == -1) {
    - 			/*
     
      ## builtin/clone.c ##
     @@ builtin/clone.c: static int checkout(int submodule_progress)
    @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *
      		die("%s is meaningless without -m, --reset, or --prefix",
      		    opts.update ? "-u" : "-i");
     -	if (opts.update && !opts.reset) {
    --		CALLOC_ARRAY(opts.dir, 1);
    --		opts.dir->flags |= DIR_SHOW_IGNORED;
    --		setup_standard_excludes(opts.dir);
    +-		opts.dir.flags |= DIR_SHOW_IGNORED;
    +-		setup_standard_excludes(&opts.dir);
     -	}
     +	if (opts.update && !opts.reset)
     +		opts.preserve_ignored = 0;
    @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *
      	if (opts.merge && !opts.index_only)
      		setup_work_tree();
      
    -@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
    - 	if (unpack_trees(nr_trees, t, &opts))
    - 		return 128;
    - 
    --	if (opts.dir) {
    --		dir_clear(opts.dir);
    --		FREE_AND_NULL(opts.dir);
    --	}
    --
    - 	if (opts.debug_unpack || opts.dry_run)
    - 		return 0; /* do not write the index out */
    - 
     
      ## builtin/reset.c ##
     @@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id *oid, int reset_t
    @@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int
     +		opts.preserve_ignored = 1;
      	opts.fn = oneway_merge;
      
    - 	if (unpack_trees(nr_trees, t, &opts))
    + 	if (unpack_trees(nr_trees, t, &opts)) {
     
      ## merge-ort.c ##
     @@ merge-ort.c: static int checkout(struct merge_options *opt,
    @@ merge-ort.c: static int checkout(struct merge_options *opt,
      	unpack_opts.verbose_update = (opt->verbosity > 2);
      	unpack_opts.fn = twoway_merge;
     -	if (1/* FIXME: opts->overwrite_ignore*/) {
    --		CALLOC_ARRAY(unpack_opts.dir, 1);
    --		unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
    --		setup_standard_excludes(unpack_opts.dir);
    +-		unpack_opts.dir.flags |= DIR_SHOW_IGNORED;
    +-		setup_standard_excludes(&unpack_opts.dir);
     -	}
     +	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore*/
      	parse_tree(prev);
      	init_tree_desc(&trees[0], prev->buffer, prev->size);
      	parse_tree(next);
    -@@ merge-ort.c: static int checkout(struct merge_options *opt,
    - 
    - 	ret = unpack_trees(2, trees, &unpack_opts);
    - 	clear_unpack_trees_porcelain(&unpack_opts);
    --	dir_clear(unpack_opts.dir);
    --	FREE_AND_NULL(unpack_opts.dir);
    - 	return ret;
    - }
    - 
     
      ## merge-recursive.c ##
     @@ merge-recursive.c: static int unpack_trees_start(struct merge_options *opt,
    + 		opt->priv->unpack_opts.index_only = 1;
      	else {
      		opt->priv->unpack_opts.update = 1;
    - 		/* FIXME: should only do this if !overwrite_ignore */
    --		CALLOC_ARRAY(opt->priv->unpack_opts.dir, 1);
    --		opt->priv->unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
    --		setup_standard_excludes(opt->priv->unpack_opts.dir);
    +-		opt->priv->unpack_opts.dir.flags |= DIR_SHOW_IGNORED;
    +-		setup_standard_excludes(&opt->priv->unpack_opts.dir);
    ++		/* FIXME: should only do this if !overwrite_ignore */
     +		opt->priv->unpack_opts.preserve_ignored = 0;
      	}
      	opt->priv->unpack_opts.merge = 1;
      	opt->priv->unpack_opts.head_idx = 2;
    -@@ merge-recursive.c: static int unpack_trees_start(struct merge_options *opt,
    - 	init_tree_desc_from_tree(t+2, merge);
    - 
    - 	rc = unpack_trees(3, t, &opt->priv->unpack_opts);
    --	if (opt->priv->unpack_opts.dir) {
    --		dir_clear(opt->priv->unpack_opts.dir);
    --		FREE_AND_NULL(opt->priv->unpack_opts.dir);
    --	}
    - 	cache_tree_free(&opt->repo->index->cache_tree);
    - 
    - 	/*
     
      ## merge.c ##
     @@ merge.c: int checkout_fast_forward(struct repository *r,
    - 	struct unpack_trees_options opts;
    - 	struct tree_desc t[MAX_UNPACK_TREES];
    - 	int i, nr_trees = 0;
    --	struct dir_struct dir = DIR_INIT;
    - 	struct lock_file lock_file = LOCK_INIT;
    - 
    - 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
    -@@ merge.c: int checkout_fast_forward(struct repository *r,
    + 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
      	}
      
    - 	memset(&opts, 0, sizeof(opts));
     -	if (overwrite_ignore) {
    --		dir.flags |= DIR_SHOW_IGNORED;
    --		setup_standard_excludes(&dir);
    --		opts.dir = &dir;
    +-		opts.dir.flags |= DIR_SHOW_IGNORED;
    +-		setup_standard_excludes(&opts.dir);
     -	}
    +-
     +	opts.preserve_ignored = !overwrite_ignore;
    - 
      	opts.head_idx = 1;
      	opts.src_index = r->index;
    -@@ merge.c: int checkout_fast_forward(struct repository *r,
    - 		clear_unpack_trees_porcelain(&opts);
    - 		return -1;
    - 	}
    --	dir_clear(&dir);
    - 	clear_unpack_trees_porcelain(&opts);
    - 
    - 	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
    + 	opts.dst_index = r->index;
     
      ## reset.c ##
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char *action,
    @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpac
      	}
      
     +	if (!o->preserve_ignored) {
    -+		CALLOC_ARRAY(o->dir, 1);
    -+		o->dir->flags |= DIR_SHOW_IGNORED;
    -+		setup_standard_excludes(o->dir);
    ++		o->dir.flags |= DIR_SHOW_IGNORED;
    ++		setup_standard_excludes(&o->dir);
     +	}
     +
      	if (!core_apply_sparse_checkout || !o->update)
      		o->skip_sparse_checkout = 1;
      	if (!o->skip_sparse_checkout && !o->pl) {
    -@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
    - done:
    - 	if (free_pattern_list)
    - 		clear_pattern_list(&pl);
    -+	if (o->dir) {
    -+		dir_clear(o->dir);
    -+		FREE_AND_NULL(o->dir);
    -+	}
    - 	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
    - 	trace_performance_leave("unpack_trees");
    - 	return ret;
     
      ## unpack-trees.h ##
     @@ unpack-trees.h: struct unpack_trees_options {
 5:  0d119142778 !  4:  296c1e03673 unpack-trees: make dir an internal-only struct
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    unpack-trees: make dir an internal-only struct
    +    unpack-trees: rename "dir" to "private_dir"
     
    -    Avoid accidental misuse or confusion over ownership by clearly making
    -    unpack_trees_options.dir an internal-only variable.
    +    Until the introduction of the "preserve_ignored" flag in the preceding
    +    commit callers who wanted its behavior needed to adjust "dir.flags"
    +    and call setup_standard_excludes() themselves.
    +
    +    Now that we have no external users of "dir" anymore let's rename it to
    +    "private_dir" and add a comment indicating that we'd like it not to be
    +    messed with by external callers. This should avoid avoid accidental
    +    misuse or confusion over its ownership.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## unpack-trees.c ##
    -@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
    - 	static struct cache_entry *dfc;
    - 	struct pattern_list pl;
    - 	int free_pattern_list = 0;
    -+	struct dir_struct dir = DIR_INIT;
    +@@ unpack-trees.c: void unpack_trees_options_init(struct unpack_trees_options *o)
    + void unpack_trees_options_release(struct unpack_trees_options *opts)
    + {
    + 	strvec_clear(&opts->msgs_to_free);
    +-	dir_clear(&opts->dir);
    ++	dir_clear(&opts->private_dir);
    + }
      
    - 	if (len > MAX_UNPACK_TREES)
    - 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
    -+	if (o->dir)
    -+		BUG("o->dir is for internal use only");
    - 
    - 	trace_performance_enter();
    - 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
    + static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
     @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
      	}
      
      	if (!o->preserve_ignored) {
    --		CALLOC_ARRAY(o->dir, 1);
    -+		o->dir = &dir;
    - 		o->dir->flags |= DIR_SHOW_IGNORED;
    - 		setup_standard_excludes(o->dir);
    - 	}
    -@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
    - 		clear_pattern_list(&pl);
    - 	if (o->dir) {
    - 		dir_clear(o->dir);
    --		FREE_AND_NULL(o->dir);
    -+		o->dir = NULL;
    +-		o->dir.flags |= DIR_SHOW_IGNORED;
    +-		setup_standard_excludes(&o->dir);
    ++		o->private_dir.flags |= DIR_SHOW_IGNORED;
    ++		setup_standard_excludes(&o->private_dir);
      	}
    - 	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
    - 	trace_performance_leave("unpack_trees");
    + 
    + 	if (!core_apply_sparse_checkout || !o->update)
    +@@ unpack-trees.c: static int verify_clean_subdirectory(const struct cache_entry *ce,
    + 	 */
    + 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
    + 
    +-	d.exclude_per_dir = o->dir.exclude_per_dir;
    ++	d.exclude_per_dir = o->private_dir.exclude_per_dir;
    + 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
    + 	dir_clear(&d);
    + 	free(pathbuf);
    +@@ unpack-trees.c: static int check_ok_to_remove(const char *name, int len, int dtype,
    + 	if (ignore_case && icase_exists(o, name, len, st))
    + 		return 0;
    + 
    +-	if (is_excluded(&o->dir, o->src_index, name, &dtype))
    ++	if (is_excluded(&o->private_dir, o->src_index, name, &dtype))
    + 		/*
    + 		 * ce->name is explicitly excluded, so it is Ok to
    + 		 * overwrite it.
     
      ## unpack-trees.h ##
     @@ unpack-trees.h: struct unpack_trees_options {
      		     dry_run;
      	const char *prefix;
      	int cache_bottom;
    --	struct dir_struct *dir;
    +-	struct dir_struct dir;
    ++	struct dir_struct private_dir; /* for internal use only */
      	struct pathspec *pathspec;
      	merge_fn_t fn;
      	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
     @@ unpack-trees.h: struct unpack_trees_options {
    - 	struct index_state result;
      
    - 	struct pattern_list *pl; /* for internal use */
    -+	struct dir_struct *dir; /* for internal use only */
    - 	struct checkout_metadata meta;
    - };
    + #define UNPACK_TREES_OPTIONS_INIT { \
    + 	.msgs_to_free = STRVEC_INIT, \
    +-	.dir = DIR_INIT, \
    ++	.private_dir = DIR_INIT, \
    + }
    + void unpack_trees_options_init(struct unpack_trees_options *o);
      
 6:  b7fe354efff !  5:  27496506430 Remove ignored files by default when they are in the way
    @@ Commit message
         Incidentally, this fixes a test failure in t7112.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/am.c ##
     @@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
    @@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int
     +		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
      	opts.fn = oneway_merge;
      
    - 	if (unpack_trees(nr_trees, t, &opts))
    + 	if (unpack_trees(nr_trees, t, &opts)) {
     
      ## merge-ort.c ##
     @@ merge-ort.c: static int checkout(struct merge_options *opt,
 7:  9eb20121fc3 !  6:  7b539a120b9 Change unpack_trees' 'reset' flag into an enum
    @@ Commit message
         [1] https://lore.kernel.org/git/15dad590-087e-5a48-9238-5d2826950506@gmail.com/
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/am.c ##
     @@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
    @@ t/t2500-untracked-overwriting.sh: test_expect_failure 'git rebase --abort and un
     
      ## unpack-trees.c ##
     @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
    + 	struct pattern_list pl;
      	int free_pattern_list = 0;
    - 	struct dir_struct dir = DIR_INIT;
      
     +	if (o->reset == UNPACK_RESET_INVALID)
     +		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
     +
      	if (len > MAX_UNPACK_TREES)
      		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
    - 	if (o->dir)
    + 
     @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
      		ensure_full_index(o->dst_index);
      	}
    @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpac
     +		BUG("UNPACK_RESET_OVERWRITE_UNTRACKED incompatible with preserved ignored files");
     +
      	if (!o->preserve_ignored) {
    - 		o->dir = &dir;
    - 		o->dir->flags |= DIR_SHOW_IGNORED;
    + 		o->private_dir.flags |= DIR_SHOW_IGNORED;
    + 		setup_standard_excludes(&o->private_dir);
     @@ unpack-trees.c: static int verify_absent_1(const struct cache_entry *ce,
      	int len;
      	struct stat st;
    @@ unpack-trees.c: static int verify_absent_1(const struct cache_entry *ce,
      ## unpack-trees.h ##
     @@ unpack-trees.h: void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
       */
    - void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
    + void unpack_trees_options_release(struct unpack_trees_options *opts);
      
     +enum unpack_trees_reset_type {
     +	UNPACK_RESET_NONE = 0,    /* traditional "false" value; still valid */
    @@ unpack-trees.h: struct unpack_trees_options {
     +	enum unpack_trees_reset_type reset;
      	const char *prefix;
      	int cache_bottom;
    - 	struct pathspec *pathspec;
    + 	struct dir_struct private_dir; /* for internal use only */
 8:  e4c42d43b09 !  7:  b6769f629ae unpack-trees: avoid nuking untracked dir in way of unmerged file
    @@ Commit message
         unpack-trees: avoid nuking untracked dir in way of unmerged file
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t2500-untracked-overwriting.sh ##
     @@ t/t2500-untracked-overwriting.sh: test_expect_failure 'git stash and untracked files' '
 9:  1a770681704 !  8:  10a7cbf049e unpack-trees: avoid nuking untracked dir in way of locally deleted file
    @@ Commit message
         unpack-trees: avoid nuking untracked dir in way of locally deleted file
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t2500-untracked-overwriting.sh ##
     @@ t/t2500-untracked-overwriting.sh: test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
10:  6b42a80bf3d !  9:  b2f27d961a9 Comment important codepaths regarding nuking untracked files/dirs
    @@ Commit message
         running in an empty directory.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/stash.c ##
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
11:  de416f887d7 ! 10:  e88f81baa50 Documentation: call out commands that nuke untracked files/directories
    @@ Commit message
         these cases.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-checkout.txt ##
     @@ Documentation/git-checkout.txt: OPTIONS
-- 
2.33.0.1404.g83021034c5d

