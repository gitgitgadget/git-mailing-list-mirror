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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45297C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F63B60F48
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbhIXGir (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbhIXGip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:38:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51AEC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t28so10680393wra.7
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XqKy0nZ+CtToDRnDYAKtJ7YAbgAkullleYNHC5V3rb8=;
        b=BL3cC/ySHcLcMQMGEuwbCuuIEj9GPupSyTqK7rOnLGysJUnar8giRyrkPfS4mNmmEP
         mMcd9/cSYHA+cjk8ED+/5UD5w88On/IZNUgZASUosgVv7jhoUJu5CycAXIn1c/+y36YF
         tJhEf3S265QWdINnU/8gklORa3kN5XkxJVug+JIYF9E1wGmTmoXdQuuUw8aQtsDItOds
         c3qDM8Fj9RO7qS2Kpukj8ANajOHOchwzye5jj7J4Rdbp7cp3SA7VcalGQzlDfcNjzl4P
         qktY0oZV8yLG15DRHFdJeU7Ec/D8DUtwahmh4yWwjEZdwAoQHExtOSONOhvvufOmnZTo
         XaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XqKy0nZ+CtToDRnDYAKtJ7YAbgAkullleYNHC5V3rb8=;
        b=GmQdy8Tdh3dYSiaKi63I+9BsAClV5AUu0OGd4FC82deq04uUEWQsQVQEFCx0gOGDMZ
         ryJCIRv7UOr9MKSbOVie4ShU4buRWvLcDzVliEJw+LkVBE41gT/UFCL7wQU2Maw37jCL
         PRX0sFW6GS5KLKjHifocxXZIBAVugyFPxXoGiVWA0H1N566ki0vDbj/JlQM2jPf65BIE
         T52m2Hgy5sKPGJfppZpllkvyu59oplix9jMBbmaPUbX4yUpGRjHX0pYdq76uq/GBZ9zr
         clOCmwolW0YS88852XJTU3r+v/ri/uAxB0Jw3sSAMdVPppdNjoXPFc1dlVWibfZfO+8h
         BZdg==
X-Gm-Message-State: AOAM531h6zQ+oXmHtzIaZc5D1dgdF16lywoyRhC4XhzSqYGvIZvllb7K
        sh+9ttNvKXDBRsrGLhhL+BY0be+Aqkw=
X-Google-Smtp-Source: ABdhPJwme/XgezBy4N7DbBsc/hj9tMxHeDtmunxv0ZoTbj7Ef0qkt63OIoMuDTJe32no0oJVMdAI4w==
X-Received: by 2002:a5d:4579:: with SMTP id a25mr9650352wrc.222.1632465431073;
        Thu, 23 Sep 2021 23:37:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c135sm11622320wme.6.2021.09.23.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:37:10 -0700 (PDT)
Message-Id: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 06:37:03 +0000
Subject: [PATCH v2 0/6] Fix various issues around removal of untracked files/directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/am-abort-fix.

We have multiple codepaths that delete untracked files/directories but
shouldn't. There are also some codepaths where we delete untracked
files/directories intentionally (based on mailing list discussion), but
where that intent is not documented. Fix the documentation, add several new
(mostly failing) testcases, fix some of the new testcases, and add comments
about some potential remaining problems. (I found these as a side-effect of
looking at [1], though [2] pointed out one explicitly while I was working on
it.)

Note that I'm using Junio's declaration about checkout -f and reset --hard
(and also presuming that since read-tree --reset is porcelain that its
behavior should be left alone)[3] in this series.

Changes since v1:

 * Various small cleanups (suggested by Ævar)
 * Fixed memory leaks of unpack_trees_opts->dir (also suggested by Ævar)
 * Use an enum for unpack_trees_options->reset, instead of multiple fields
   (suggested by Phillip)
 * Avoid changing behavior for cases not setting unpack_trees_options.reset
   > 0 (even if it may make sense to nuke ignored files when running either
   read-tree -m -u or the various reset flavors run internally by
   rebase/sequencer); we can revisit that later.

SIDENOTE about treating (some) ignored files as precious:

There's another related topic here that came up in the mailing list threads
that is separate even if similar: namely, treating ignored files as precious
instead of deleting them. I do not try to handle that here, but I believe
that would actually be relatively easy to handle. If you leave
unpack_trees_options->dir as NULL, then ignored files are treated as
precious (my original patch 2 made that mistake). There's a few other
locations that already optionally set up unpack_trees_options->dir (a quick
search for "overwrite_ignore" and "overwrite-ignore" will find them), so
we'd just need to implement that option flag in more places corresponding to
the new callsites (and perhaps make a global core.overwrite_ignored config
option to affect all of these). Of course, doing so would globally treat
ignored files as precious rather than allowing them to be configured on a
per-path basis, but honestly I think the idea of configuring ignored files
as precious on a per-path basis sounds like insanity. (We have enough bugs
with untracked and ignored files without adding yet another type. Also,
tla/baz was excessively confusing to me due in part to the number of types
of files and I'd rather not see such ideas ported to git. And, of course,
configuring per-path rules sounds like lots of work for end users to
configure. There may be additional reasons against it.) So, if someone wants
to pursue the precious-ignored concept then I'd much rather see it done as a
global setting. Just my $0.02.

[1] https://lore.kernel.org/git/xmqqv93n7q1v.fsf@gitster.g/ [2]
https://lore.kernel.org/git/C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com/
[3] https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/

Elijah Newren (6):
  t2500: add various tests for nuking untracked files
  Change unpack_trees' 'reset' flag into an enum
  unpack-trees: avoid nuking untracked dir in way of unmerged file
  unpack-trees: avoid nuking untracked dir in way of locally deleted
    file
  Comment important codepaths regarding nuking untracked files/dirs
  Documentation: call out commands that nuke untracked files/directories

 Documentation/git-checkout.txt   |   5 +-
 Documentation/git-read-tree.txt  |   5 +-
 Documentation/git-reset.txt      |   3 +-
 builtin/am.c                     |  13 +-
 builtin/checkout.c               |  18 ++-
 builtin/read-tree.c              |   3 +
 builtin/reset.c                  |  20 ++-
 builtin/stash.c                  |  18 ++-
 builtin/submodule--helper.c      |   4 +
 builtin/worktree.c               |   5 +
 contrib/rerere-train.sh          |   2 +-
 reset.c                          |  13 +-
 submodule.c                      |   1 +
 t/t2500-untracked-overwriting.sh | 244 +++++++++++++++++++++++++++++++
 unpack-trees.c                   |  44 +++++-
 unpack-trees.h                   |  11 +-
 16 files changed, 387 insertions(+), 22 deletions(-)
 create mode 100755 t/t2500-untracked-overwriting.sh


base-commit: c5ead19ea282a288e01d86536349a4ae4a093e4b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1036%2Fnewren%2Funtracked_removal-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1036/newren/untracked_removal-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1036

Range-diff vs v1:

 1:  b634136a74b ! 1:  9460a49c7ed t2500: add various tests for nuking untracked files
     @@ t/t2500-untracked-overwriting.sh (new)
      +. ./test-lib.sh
      +
      +test_setup_reset () {
     -+	test_create_repo reset_$1 &&
     ++	git init reset_$1 &&
      +	(
      +		cd reset_$1 &&
      +		test_commit init &&
     @@ t/t2500-untracked-overwriting.sh (new)
      +
      +		test_must_fail git reset --merge work 2>error &&
      +		test_cmp expect foo.t/file &&
     -+		grep "Updating.*foo.t.*would lose untracked files" error
     ++		grep "Updating .foo.t. would lose untracked files" error
      +	)
      +'
      +
     @@ t/t2500-untracked-overwriting.sh (new)
      +'
      +
      +test_setup_checkout_m () {
     -+	test_create_repo checkout &&
     ++	git init checkout &&
      +	(
      +		cd checkout &&
      +		test_commit init &&
     @@ t/t2500-untracked-overwriting.sh (new)
      +'
      +
      +test_setup_sequencing () {
     -+	test_create_repo sequencing_$1 &&
     ++	git init sequencing_$1 &&
      +	(
      +		cd sequencing_$1 &&
      +		test_commit init &&
 2:  45bd05a945f ! 2:  b77692b8f49 Split unpack_trees 'reset' flag into two for untracked handling
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    Split unpack_trees 'reset' flag into two for untracked handling
     +    Change unpack_trees' 'reset' flag into an enum
      
          Traditionally, unpack_trees_options->reset was used to signal that it
          was okay to delete any untracked files in the way.  This was used by
          `git read-tree --reset`, but then started appearing in other places as
          well.  However, many of the other uses should not be deleting untracked
     -    files in the way.  Split this into two separate fields:
     -       reset_nuke_untracked
     -       reset_keep_untracked
     -    and, since many code paths in unpack_trees need to be followed for both
     -    of these flags, introduce a third one for convenience:
     -       reset_either
     -    which is simply an or-ing of the other two.
     +    files in the way.  Change this value to an enum so that a value of 1
     +    (i.e. "true") can be split into two:
     +       UNPACK_RESET_PROTECT_UNTRACKED,
     +       UNPACK_RESET_OVERWRITE_UNTRACKED
     +    In order to catch accidental misuses, define with the enum a special
     +    value of
     +       UNPACK_RESET_INVALID = 1
     +    which will trigger a BUG().
      
          Modify existing callers so that
             read-tree --reset
             reset --hard
             checkout --force
     -    continue using reset_nuke_untracked, but so that other callers,
     -    including
     +    continue using the UNPACK_RESET_OVERWRITE_UNTRACKED logic, while other
     +    callers, including
             am
             checkout without --force
             stash  (though currently dead code; reset always had a value of 0)
             numerous callers from rebase/sequencer to reset_head()
     -    will use the new reset_keep_untracked field.
     +    will use the new UNPACK_RESET_PROTECT_UNTRACKED value.
     +
     +    In order to protect untracked files but still allow deleting of ignored
     +    files, we also have to setup unpack_trees_opt.dir.  It may make sense to
     +    set up unpack_trees_opt.dir in more cases, but here I tried to only do
     +    so in cases where we switched from deleting all untracked files to
     +    avoiding doing so (i.e. where we now use
     +    UNPACK_RESET_PROTECT_UNTRACKED).
     +
     +    Also, note that 'git checkout <pathspec>' currently also allows
     +    overwriting untracked files.  That case should also be fixed, but it
     +    does not use unpack_trees() and thus is outside the scope of the current
     +    changes.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote,
       	opts.update = 1;
       	opts.merge = 1;
      -	opts.reset = reset;
     -+	opts.reset_keep_untracked = reset;
     ++	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
       	opts.fn = twoway_merge;
     -+	/* Setup opts.dir so that ignored files in the way get overwritten */
     -+	opts.dir = xcalloc(1, sizeof(*opts.dir));
     -+	opts.dir->flags |= DIR_SHOW_IGNORED;
     -+	setup_standard_excludes(opts.dir);
     ++	if (opts.reset) {
     ++		/* Allow ignored files in the way to get overwritten */
     ++		opts.dir = xcalloc(1, sizeof(*opts.dir));
     ++		opts.dir->flags |= DIR_SHOW_IGNORED;
     ++		setup_standard_excludes(opts.dir);
     ++	}
       	init_tree_desc(&t[0], head->buffer, head->size);
       	init_tree_desc(&t[1], remote->buffer, remote->size);
       
     +@@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
     + 		return -1;
     + 	}
     + 
     ++	if (opts.reset) {
     ++		dir_clear(opts.dir);
     ++		FREE_AND_NULL(opts.dir);
     ++	}
     ++
     + 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
     + 		die(_("unable to write new index file"));
     + 
      
       ## builtin/checkout.c ##
      @@ builtin/checkout.c: static int reset_tree(struct tree *tree, const struct checkout_opts *o,
     + {
     + 	struct unpack_trees_options opts;
     + 	struct tree_desc tree_desc;
     ++	int unpack_trees_ret;
     + 
     + 	memset(&opts, 0, sizeof(opts));
       	opts.head_idx = -1;
       	opts.update = worktree;
       	opts.skip_unmerged = !worktree;
      -	opts.reset = 1;
     -+	if (o->force)
     -+		opts.reset_nuke_untracked = 1;
     -+	else
     -+		opts.reset_keep_untracked = 1;
     ++	opts.reset = o->force ? UNPACK_RESET_OVERWRITE_UNTRACKED :
     ++				UNPACK_RESET_PROTECT_UNTRACKED;
       	opts.merge = 1;
       	opts.fn = oneway_merge;
       	opts.verbose_update = o->show_progress;
     @@ builtin/checkout.c: static int reset_tree(struct tree *tree, const struct checko
       	init_checkout_metadata(&opts.meta, info->refname,
       			       info->commit ? &info->commit->object.oid : null_oid(),
       			       NULL);
     + 	parse_tree(tree);
     + 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
     +-	switch (unpack_trees(1, &tree_desc, &opts)) {
     ++	unpack_trees_ret = unpack_trees(1, &tree_desc, &opts);
     ++
     ++	if (o->overwrite_ignore) {
     ++		dir_clear(opts.dir);
     ++		FREE_AND_NULL(opts.dir);
     ++	}
     ++
     ++	switch (unpack_trees_ret) {
     + 	case -2:
     + 		*writeout_error = 1;
     + 		/*
      
       ## builtin/read-tree.c ##
      @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
     - 			 N_("3-way merge if no file level merging required")),
     - 		OPT_BOOL(0, "aggressive", &opts.aggressive,
     - 			 N_("3-way merge in presence of adds and removes")),
     --		OPT_BOOL(0, "reset", &opts.reset,
     -+		OPT_BOOL(0, "reset", &opts.reset_keep_untracked,
     - 			 N_("same as -m, but discard unmerged entries")),
     - 		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
     - 		  N_("read the tree into the index under <subdirectory>/"),
     -@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
     - 	opts.head_idx = -1;
     - 	opts.src_index = &the_index;
     - 	opts.dst_index = &the_index;
     -+	if (opts.reset_keep_untracked) {
     -+		opts.dir = xcalloc(1, sizeof(*opts.dir));
     -+		opts.dir->flags |= DIR_SHOW_IGNORED;
     -+		setup_standard_excludes(opts.dir);
     -+	}
     - 
     - 	git_config(git_read_tree_config, NULL);
     - 
     -@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
     - 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
     - 
     - 	prefix_set = opts.prefix ? 1 : 0;
     --	if (1 < opts.merge + opts.reset + prefix_set)
     -+	if (1 < opts.merge + opts.reset_keep_untracked + prefix_set)
     + 	if (1 < opts.merge + opts.reset + prefix_set)
       		die("Which one? -m, --reset, or --prefix?");
       
     ++	if (opts.reset)
     ++		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
     ++
       	/*
     -@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
     - 	 * mode.
     - 	 */
     - 
     --	if (opts.reset || opts.merge || opts.prefix) {
     -+	if (opts.reset_keep_untracked || opts.merge || opts.prefix) {
     - 		if (read_cache_unmerged() && (opts.prefix || opts.merge))
     - 			die(_("You need to resolve your current index first"));
     - 		stage = opts.merge = 1;
     + 	 * NEEDSWORK
     + 	 *
      
       ## builtin/reset.c ##
      @@
     @@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id
       	case HARD:
       		opts.update = 1;
      -		/* fallthrough */
     -+		opts.reset_nuke_untracked = 1;
     ++		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
      +		break;
      +	case MIXED:
     -+		opts.reset_keep_untracked = 1; /* but opts.update=0, so untracked left alone */
     ++		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
     ++		/* but opts.update=0, so working tree not updated */
      +		break;
       	default:
      -		opts.reset = 1;
      +		BUG("invalid reset_type passed to reset_index");
      +	}
     -+	if (opts.reset_keep_untracked) {
     ++	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
      +		/* Setup opts.dir so we can overwrite ignored files */
      +		opts.dir = xcalloc(1, sizeof(*opts.dir));
      +		opts.dir->flags |= DIR_SHOW_IGNORED;
     @@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id
       	}
       
       	read_cache_unmerged();
     +@@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id *oid, int reset_t
     + 	ret = 0;
     + 
     + out:
     ++	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
     ++		dir_clear(opts.dir);
     ++		FREE_AND_NULL(opts.dir);
     ++	}
     + 	for (i = 0; i < nr; i++)
     + 		free((void *)desc[i].buffer);
     + 	return ret;
      
       ## builtin/stash.c ##
     +@@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int reset)
     + 	struct tree_desc t[MAX_UNPACK_TREES];
     + 	struct tree *tree;
     + 	struct lock_file lock_file = LOCK_INIT;
     ++	int unpack_trees_ret;
     + 
     + 	read_cache_preload(NULL);
     + 	if (refresh_cache(REFRESH_QUIET))
      @@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int reset)
       	opts.src_index = &the_index;
       	opts.dst_index = &the_index;
       	opts.merge = 1;
      -	opts.reset = reset;
     -+	opts.reset_keep_untracked = reset;
     ++	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
     ++	if (opts.reset) {
     ++		opts.dir = xcalloc(1, sizeof(*opts.dir));
     ++		opts.dir->flags |= DIR_SHOW_IGNORED;
     ++		setup_standard_excludes(opts.dir);
     ++	}
       	opts.update = update;
       	opts.fn = oneway_merge;
       
     +-	if (unpack_trees(nr_trees, t, &opts))
     ++	unpack_trees_ret = unpack_trees(nr_trees, t, &opts);
     ++
     ++	if (opts.reset) {
     ++		dir_clear(opts.dir);
     ++		FREE_AND_NULL(opts.dir);
     ++	}
     ++
     ++	if (unpack_trees_ret)
     + 		return -1;
     + 
     + 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
      
       ## reset.c ##
      @@
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char
      -	if (!detach_head)
      -		unpack_tree_opts.reset = 1;
      +	if (!detach_head) {
     -+		unpack_tree_opts.reset_keep_untracked = 1;
     ++		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
      +		unpack_tree_opts.dir = xcalloc(1, sizeof(*unpack_tree_opts.dir));
      +		unpack_tree_opts.dir->flags |= DIR_SHOW_IGNORED;
      +		setup_standard_excludes(unpack_tree_opts.dir);
     @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char
       
       	if (repo_read_index_unmerged(r) < 0) {
       		ret = error(_("could not read index"));
     -
     - ## t/t1013-read-tree-submodule.sh ##
     -@@ t/t1013-read-tree-submodule.sh: KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
     - 
     - test_submodule_switch_recursing_with_args "read-tree -u -m"
     - 
     --test_submodule_forced_switch_recursing_with_args "read-tree -u --reset"
     -+test_submodule_switch_recursing_with_args "read-tree -u --reset"
     +@@ reset.c: reset_head_refs:
     + 			    oid_to_hex(oid), "1", NULL);
       
     - test_submodule_switch "read-tree -u -m"
     - 
     --test_submodule_forced_switch "read-tree -u --reset"
     -+test_submodule_switch "read-tree -u --reset"
     - 
     - test_done
     + leave_reset_head:
     ++	if (unpack_tree_opts.dir) {
     ++		dir_clear(unpack_tree_opts.dir);
     ++		FREE_AND_NULL(unpack_tree_opts.dir);
     ++	}
     + 	strbuf_release(&msg);
     + 	rollback_lock_file(&lock);
     + 	clear_unpack_trees_porcelain(&unpack_tree_opts);
      
       ## t/t2500-untracked-overwriting.sh ##
      @@ t/t2500-untracked-overwriting.sh: test_setup_checkout_m () {
     @@ t/t2500-untracked-overwriting.sh: test_expect_failure 'git rebase --abort and un
       		cd sequencing_rebase_fast_forward_and_untracked &&
      
       ## unpack-trees.c ##
     -@@ unpack-trees.c: static int check_submodule_move_head(const struct cache_entry *ce,
     - 	if (!sub)
     - 		return 0;
     - 
     --	if (o->reset)
     -+	if (o->reset_nuke_untracked)
     - 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
     - 
     - 	if (submodule_move_head(ce->name, old_id, new_id, flags))
      @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
     - 	if (len > MAX_UNPACK_TREES)
     - 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
     + 	struct pattern_list pl;
     + 	int free_pattern_list = 0;
       
     -+	if (o->reset_nuke_untracked && o->reset_keep_untracked)
     -+		BUG("reset_nuke_untracked and reset_keep_untracked are incompatible");
     ++	if (o->reset == UNPACK_RESET_INVALID)
     ++		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
      +
     -+	o->reset_either = 0;
     -+	if (o->reset_nuke_untracked || o->reset_keep_untracked)
     -+		o->reset_either = 1;
     -+
     - 	trace_performance_enter();
     - 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
     - 
     -@@ unpack-trees.c: static int verify_uptodate_1(const struct cache_entry *ce,
     - 	 */
     - 	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
     - 		; /* keep checking */
     --	else if (o->reset || ce_uptodate(ce))
     -+	else if (o->reset_either || ce_uptodate(ce))
     - 		return 0;
     + 	if (len > MAX_UNPACK_TREES)
     + 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
       
     - 	if (!lstat(ce->name, &st)) {
      @@ unpack-trees.c: static int verify_absent_1(const struct cache_entry *ce,
       	int len;
       	struct stat st;
       
      -	if (o->index_only || o->reset || !o->update)
     -+	if (o->index_only || o->reset_nuke_untracked || !o->update)
     ++	if (o->index_only || !o->update ||
     ++	    o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
       		return 0;
       
       	len = check_leading_path(ce->name, ce_namelen(ce), 0);
     -@@ unpack-trees.c: int twoway_merge(const struct cache_entry * const *src,
     - 
     - 	if (current) {
     - 		if (current->ce_flags & CE_CONFLICTED) {
     --			if (same(oldtree, newtree) || o->reset) {
     -+			if (same(oldtree, newtree) || o->reset_either) {
     - 				if (!newtree)
     - 					return deleted_entry(current, current, o);
     - 				else
     -@@ unpack-trees.c: int oneway_merge(const struct cache_entry * const *src,
     - 
     - 	if (old && same(old, a)) {
     - 		int update = 0;
     --		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
     -+		if (o->reset_either && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
     - 			!(old->ce_flags & CE_FSMONITOR_VALID)) {
     - 			struct stat st;
     - 			if (lstat(old->name, &st) ||
      
       ## unpack-trees.h ##
      @@ unpack-trees.h: void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
     +  */
       void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
       
     ++enum unpack_trees_reset_type {
     ++	UNPACK_RESET_NONE = 0,    /* traditional "false" value; still valid */
     ++	UNPACK_RESET_INVALID = 1, /* "true" no longer valid; use below values */
     ++	UNPACK_RESET_PROTECT_UNTRACKED,
     ++	UNPACK_RESET_OVERWRITE_UNTRACKED
     ++};
     ++
       struct unpack_trees_options {
      -	unsigned int reset,
     -+	unsigned int reset_nuke_untracked,
     -+		     reset_keep_untracked,
     -+		     reset_either, /* internal use only */
     - 		     merge,
     +-		     merge,
     ++	unsigned int merge,
       		     update,
       		     clone,
     + 		     index_only,
     +@@ unpack-trees.h: struct unpack_trees_options {
     + 		     exiting_early,
     + 		     show_all_errors,
     + 		     dry_run;
     ++	enum unpack_trees_reset_type reset;
     + 	const char *prefix;
     + 	int cache_bottom;
     + 	struct dir_struct *dir;
 3:  a69117a1c9e = 3:  208f3b3ebe5 unpack-trees: avoid nuking untracked dir in way of unmerged file
 4:  01bf850bb0f ! 4:  0a0997d081b unpack-trees: avoid nuking untracked dir in way of locally deleted file
     @@ unpack-trees.c: static int deleted_entry(const struct cache_entry *ce,
       		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
       			return -1;
       		return 0;
     -+	} else {
     -+		if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
     -+			return -1;
     ++	} else if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o)) {
     ++		return -1;
       	}
      +
       	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
 5:  60c5d6b4615 = 5:  4b78a526d2a Comment important codepaths regarding nuking untracked files/dirs
 6:  6ea23d165cf = 6:  993451a8036 Documentation: call out commands that nuke untracked files/directories

-- 
gitgitgadget
