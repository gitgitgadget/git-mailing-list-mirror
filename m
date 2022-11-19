Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83855C43217
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiKSNH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiKSNHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB48FE4E
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i29so3076113edj.11
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6fxyQEXlq0xC3XN/OFbM3FyVrbG08hZ7+vr+gmOGmA=;
        b=BO/q7F3x5Ptx8wyIDI0ZZEWInp7o3p2wXa81IOofZKRBnG5Y4VbI0fevSDypVGO2dn
         Q4rk/U72N7wbWShGOv34+CINiBEE8TekVhDgwoSxvE1mIeH23Dc0EbSauuqctc7AX9Pt
         DoIyMMFCWNfw9rZ2nweBshPJJjlSB1GdJ70M0gY6xtoba9jdsEtNPieWVTCRyXTExsqJ
         vEnRhGznrxGoj8PDT45E+4A4RXN5GQHP9qj+zn4pNay0wJRW2gG5d6vGB2sHjRLRPwOP
         5CTJv1vo90b6kr46zGBZoXxTONwf1f/+mdfTIndQiU3LuAyI1jh2uAvBisDQal1+ZhpB
         Txnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6fxyQEXlq0xC3XN/OFbM3FyVrbG08hZ7+vr+gmOGmA=;
        b=HnDr5hwnwSzc42ULpnd0IoilixQFoF/JNinbioD/F+fpK/b/W9cMWRPvDZCF8k2zfy
         1HxQQ9ldKKFn+a7Od2ri46WXHO3uzrjjv9ohm3TmX5NixZ7BhNb3U0EJ3lS2qryV+f78
         uQCe2Vr1b/qu717tDkBZjixg1boJ+hTupSkBcQjgckHB2lB6Und0oSTsYNit+ApbiAPF
         jttHN9PoZFXO19kVFxF3X/k3E4mtKF/AIkAM4c/tLHN+x+oXKY7yIaRU4EIy61lcHkf+
         m5Ff9RbV7Qgoo7VWKhARlU5e92a/aMx54qE54G7EY+aTPBEaAlCMY9xRNvB+r2p2DNDE
         +Atg==
X-Gm-Message-State: ANoB5plulvRf7DoGlLNBDZK54/Um5suKVSH9YhR7ZTfi37LNbKbjjj9b
        WrxaBjRFCeo2WiEbCv3hvJDlZrjcl/iCRw==
X-Google-Smtp-Source: AA0mqf6XIOVw+jnqA3J7X/rwlFiZ+DLy6bLf8jNn/tL3zL2i+x8BBfDG3W5Mz5UH3x8Uj5iX5HD9cw==
X-Received: by 2002:aa7:d4cf:0:b0:461:a9ce:5408 with SMTP id t15-20020aa7d4cf000000b00461a9ce5408mr9807555edr.201.1668863266807;
        Sat, 19 Nov 2022 05:07:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] tree-wide: chip away at USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Sat, 19 Nov 2022 14:07:27 +0100
Message-Id: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll that should address feedback on v1[1]. Change since v1:

* Since "vd/skip-cache-tree-update" has landed on "master" the
  "test-tool.h" can stop providing
  "USE_THE_INDEX_COMPATIBILITY_MACROS" to the test tools, which we're
  unlikely to have a semantic conflict for while this graduates.

  A change in 7/12 is due to rebasing on that topic, ditto applying
  the transformation in 8/12 to code it added.

* The 11/12 is now quite a bit larger, and now does the
  transformations that don't conflict with anything in-flight.
  I.e. (aside from needing to eject v1 of this topic) it'll merge
  cleanly with "seen"

  Hopfully that expanded scope isn't stepping too much outside the
  bounds here. But once "vd/skip-cache-tree-update" had landed just
  applying it to the rest that didn't conflict didn't seem too
  bad. It's a relatively large diffstat, but not that much on top of
  the v1, and it's almost entirely a change coccinelle is making".

1. https://lore.kernel.org/git/cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com/

Branch & passing CI at:
https://github.com/avar/git/tree/avar/narrow-down-the-index-compatibilty-macros-2

Ævar Arnfjörð Bjarmason (11):
  cache.h: remove unused "the_index" compat macros
  builtin/{grep,log}.: don't define "USE_THE_INDEX_COMPATIBILITY_MACROS"
  cocci & cache.h: remove rarely used "the_index" compat macros
  read-cache API & users: make discard_index() return void
  cocci: add a index-compatibility.pending.cocci
  cocci & cache.h: apply a selection of "pending" index-compatibility
  cocci & cache.h: apply variable section of "pending"
    index-compatibility
  cocci: apply "pending" index-compatibility to "t/helper/*.c"
  {builtin/*,repository}.c: add & use "USE_THE_INDEX_VARIABLE"
  cache.h & test-tool.h: add & use "USE_THE_INDEX_VARIABLE"
  cocci: apply "pending" index-compatibility to some "builtin/*.c"

 add-interactive.c                             |   8 +-
 add-patch.c                                   |   3 +-
 builtin/add.c                                 |  21 +--
 builtin/am.c                                  |  25 ++--
 builtin/cat-file.c                            |   2 +-
 builtin/check-attr.c                          |   4 +-
 builtin/check-ignore.c                        |   4 +-
 builtin/checkout-index.c                      |  19 +--
 builtin/checkout.c                            |  67 ++++-----
 builtin/clean.c                               |   6 +-
 builtin/clone.c                               |   4 +-
 builtin/commit.c                              |  60 ++++----
 builtin/describe.c                            |   7 +-
 builtin/diff-files.c                          |   5 +-
 builtin/diff-index.c                          |   9 +-
 builtin/diff-tree.c                           |   4 +-
 builtin/diff.c                                |  25 ++--
 builtin/difftool.c                            |   2 +-
 builtin/fsck.c                                |  16 +--
 builtin/grep.c                                |   1 -
 builtin/log.c                                 |   1 -
 builtin/merge-index.c                         |  16 +--
 builtin/merge-ours.c                          |   3 +-
 builtin/merge-tree.c                          |   2 +-
 builtin/merge.c                               |  32 +++--
 builtin/mv.c                                  |  41 +++---
 builtin/pull.c                                |   6 +-
 builtin/read-tree.c                           |  12 +-
 builtin/rebase.c                              |   6 +-
 builtin/reset.c                               |  20 +--
 builtin/rev-parse.c                           |   4 +-
 builtin/rm.c                                  |  26 ++--
 builtin/stash.c                               |  43 +++---
 builtin/submodule--helper.c                   |  28 ++--
 builtin/update-index.c                        |  91 ++++++------
 cache.h                                       |  36 +----
 contrib/coccinelle/index-compatibility.cocci  | 135 ++++++++++++++++++
 .../index-compatibility.pending.cocci         |  24 ++++
 read-cache.c                                  |   4 +-
 repository.c                                  |   2 +-
 sequencer.c                                   |  15 +-
 t/helper/test-cache-tree.c                    |   3 +-
 t/helper/test-dump-cache-tree.c               |   5 +-
 t/helper/test-dump-split-index.c              |   1 +
 t/helper/test-dump-untracked-cache.c          |   4 +-
 t/helper/test-fast-rebase.c                   |   4 +-
 t/helper/test-lazy-init-name-hash.c           |  21 +--
 t/helper/test-read-cache.c                    |   5 +-
 t/helper/test-scrap-cache-tree.c              |   9 +-
 t/helper/test-tool.h                          |   1 -
 t/helper/test-write-cache.c                   |   6 +-
 51 files changed, 532 insertions(+), 366 deletions(-)
 create mode 100644 contrib/coccinelle/index-compatibility.cocci
 create mode 100644 contrib/coccinelle/index-compatibility.pending.cocci

Range-diff against v1:
 1:  760b4ddf06a =  1:  3ddae1f5886 cache.h: remove unused "the_index" compat macros
 2:  9789509a902 =  2:  3dd3af7b7bb builtin/{grep,log}.: don't define "USE_THE_INDEX_COMPATIBILITY_MACROS"
 3:  faa7757cb32 =  3:  5c2776a28f7 cocci & cache.h: remove rarely used "the_index" compat macros
 4:  362a14a0539 =  4:  b4d6685585a read-cache API & users: make discard_index() return void
 5:  14bf6e7188c =  5:  ec740a81d9f cocci: add a index-compatibility.pending.cocci
 6:  dbf14ed23e6 =  6:  6849233bf2b cocci & cache.h: apply a selection of "pending" index-compatibility
 7:  bf507c79d07 !  7:  fff2d0459a0 cocci & cache.h: apply variable section of "pending" index-compatibility
    @@ Commit message
         In doing so move more of "index-compatibility.pending.cocci" to
         "index-compatibility.cocci".
     
    -    In the case of "active_cache_tree" we'd have a textual conflict with
    -    "vd/skip-cache-tree-update" in "next"[1], and in the case of
    -    "active_nr" with "ab/various-leak-fixes" in "seen". Let's exclude
    -    those specific cases while moving the rule over from "pending".
    +    In the case of "active_nr" we'd have a textual conflict with
    +    "ab/various-leak-fixes" in "next"[1]. Let's exclude that specific case
    +    while moving the rule over from "pending".
     
    -    1. dc5d40f5bc4 (read-tree: use 'skip_cache_tree_update' option,
    -       2022-11-10)
    +    1. 407b94280f8 (commit: discard partial cache before (re-)reading it,
    +       2022-11-08)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      				/*
      				 * if src is clean, it will suffice to remove it
     
    + ## builtin/read-tree.c ##
    +@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
    + 	if (nr_trees == 1 && !opts.prefix)
    + 		opts.skip_cache_tree_update = 1;
    + 
    +-	cache_tree_free(&active_cache_tree);
    ++	cache_tree_free(&the_index.cache_tree);
    + 	for (i = 0; i < nr_trees; i++) {
    + 		struct tree *tree = trees[i];
    + 		parse_tree(tree);
    +
      ## builtin/reset.c ##
     @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
      		 * to properly construct the reset sparse directory.
    @@ cache.h: void prefetch_cache_entries(const struct index_state *istate,
     -#define active_cache (the_index.cache)
      #define active_nr (the_index.cache_nr)
     -#define active_cache_changed (the_index.cache_changed)
    - #define active_cache_tree (the_index.cache_tree)
    +-#define active_cache_tree (the_index.cache_tree)
      
      #define read_cache() repo_read_index(the_repository)
    + #define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
     
      ## contrib/coccinelle/index-compatibility.cocci ##
     @@
    @@ contrib/coccinelle/index-compatibility.cocci
     +|
     +- active_cache_changed
     ++ the_index.cache_changed
    ++|
    ++- active_cache_tree
    +++ the_index.cache_tree
     +)
     +
     +@@
    @@ contrib/coccinelle/index-compatibility.cocci
     +- active_nr
     ++ the_index.cache_nr
     +  ...>}
    -+
    -+@@
    -+identifier f != cmd_read_tree;
    -+@@
    -+  f(...) {<...
    -+- active_cache_tree
    -++ the_index.cache_tree
    -+  ...>}
     +
      // "the_repository" simple cases
      @@
 8:  f3e265e6edb !  8:  6d57a383623 cocci: apply "pending" index-compatibility to "t/helper/*.c"
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## t/helper/test-cache-tree.c ##
    +@@ t/helper/test-cache-tree.c: int cmd__cache_tree(int argc, const char **argv)
    + 
    + 	argc = parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
    + 
    +-	if (read_cache() < 0)
    ++	if (repo_read_index(the_repository) < 0)
    + 		die(_("unable to read index file"));
    + 
    + 	oidcpy(&oid, &the_index.cache_tree->oid);
    +
      ## t/helper/test-dump-cache-tree.c ##
     @@ t/helper/test-dump-cache-tree.c: int cmd__dump_cache_tree(int ac, const char **av)
      	int ret;
 9:  5b69cfa17ad !  9:  429eecc78ec {builtin/*,repository}.c: add & use "USE_THE_INDEX_VARIABLE"
    @@ Commit message
         built-ins we only need "the_index" variable, but not the compatibility
         wrapper for functions we're not using.
     
    +    Let's then have some users of "USE_THE_INDEX_COMPATIBILITY_MACROS" use
    +    this more narrow and descriptive define.
    +
    +    For context: The USE_THE_INDEX_COMPATIBILITY_MACROS macro was added to
    +    test-tool.h in f8adbec9fea (cache.h: flip
    +    NO_THE_INDEX_COMPATIBILITY_MACROS switch, 2019-01-24).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/cat-file.c ##
    @@ cache.h: typedef int (*must_prefetch_predicate)(const struct cache_entry *);
     +#ifndef USE_THE_INDEX_VARIABLE
     +#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
      #define active_nr (the_index.cache_nr)
    - #define active_cache_tree (the_index.cache_tree)
      
    + #define read_cache() repo_read_index(the_repository)
     @@ cache.h: extern struct index_state the_index;
      #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
      #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
10:  9eda7916e75 ! 10:  5456859b244 cache.h & test-tool.h: add & use "USE_THE_INDEX_VARIABLE"
    @@ Commit message
         cache.h & test-tool.h: add & use "USE_THE_INDEX_VARIABLE"
     
         In a preceding commit we fully applied the
    -    "index-compatibility.pending.cocci" rule to "t/helper/*". Let's now
    -    stop defining "USE_THE_INDEX_COMPATIBILITY_MACROS" in test-tool.h
    -    itself, and instead instead move the define to the individual test
    -    helpers that need it. This mirrors how we do the same thing in the
    -    "builtin/" directory.
    +    "index-compatibility.pending.cocci" rule to "t/helper/*".
     
    -    We could start using "USE_THE_INDEX_COMPATIBILITY_MACROS", but let's
    -    instead introduce a narrow version of it named
    -    "USE_THE_INDEX_VARIABLE". As the name suggests this doesn't give us
    -    any of the compatibility macros, but only "the_index" variable.
    -
    -    Eventually we'll move other outstanding users of
    -    "USE_THE_INDEX_COMPATIBILITY_MACROS" over to using this more narrow
    -    and descriptive define.
    -
    -    For context: The USE_THE_INDEX_COMPATIBILITY_MACROS macro was added to
    -    test-tool.h in f8adbec9fea (cache.h: flip
    -    NO_THE_INDEX_COMPATIBILITY_MACROS switch, 2019-01-24).
    +    Let's now stop defining "USE_THE_INDEX_COMPATIBILITY_MACROS" in
    +    test-tool.h itself, and instead instead define
    +    "USE_THE_INDEX_VARIABLE" in the individual test helpers that need
    +    it. This mirrors how we do the same thing in the "builtin/" directory.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## t/helper/test-cache-tree.c ##
    +@@
    ++#define USE_THE_INDEX_VARIABLE
    + #include "test-tool.h"
    + #include "cache.h"
    + #include "tree.h"
    +
      ## t/helper/test-dump-cache-tree.c ##
     @@
     +#define USE_THE_INDEX_VARIABLE
    @@ t/helper/test-scrap-cache-tree.c
      #include "cache.h"
      #include "lockfile.h"
     
    + ## t/helper/test-tool.h ##
    +@@
    + #ifndef TEST_TOOL_H
    + #define TEST_TOOL_H
    + 
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    + #include "git-compat-util.h"
    + 
    + int cmd__advise_if_enabled(int argc, const char **argv);
    +
      ## t/helper/test-write-cache.c ##
     @@
     +#define USE_THE_INDEX_VARIABLE
11:  3cb15ff40f6 ! 11:  b645cec189e cocci: apply "pending" index-compatibility to some "builtin/*.c"
    @@ Metadata
      ## Commit message ##
         cocci: apply "pending" index-compatibility to some "builtin/*.c"
     
    -    Apply "index-compatibility.pending.cocci" rule to those "builtin/*",
    -    and commit the ones that have 3 uses or less of the relevant
    -    macros.
    +    Apply "index-compatibility.pending.cocci" rule to "builtin/*", but
    +    exclude those where we conflict with in-flight changes.
    +
    +    As a result some of them end up using only "the_index", so let's have
    +    them use the more narrow "USE_THE_INDEX_VARIABLE" rather than
    +    "USE_THE_INDEX_COMPATIBILITY_MACROS".
    +
    +    Manual changes not made by coccinelle, that were squashed in:
    +
    +    * Whitespace-wrap argument lists for repo_hold_locked_index(),
    +      repo_read_index_preload() and repo_refresh_and_write_index(), in cases
    +      where the line became too long after the transformation.
    +    * Change "refresh_cache()" to "refresh_index()" in a comment in
    +      "builtin/update-index.c".
    +    * For those whose call was followed by perror("<macro-name>"), change
    +      it to perror("<function-name>"), referring to the new function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/add.c ##
    +@@
    +  *
    +  * Copyright (C) 2006 Linus Torvalds
    +  */
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "cache.h"
    + #include "config.h"
    + #include "builtin.h"
     @@ builtin/add.c: static int edit_patch(int argc, const char **argv, const char *prefix)
      
      	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
    @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
      
      	die_in_unpopulated_submodule(&the_index, prefix);
     
    + ## builtin/am.c ##
    +@@ builtin/am.c: static int run_apply(const struct am_state *state, const char *index_file)
    + 
    + 	if (index_file) {
    + 		/* Reload index as apply_all_patches() will have modified it. */
    +-		discard_cache();
    +-		read_cache_from(index_file);
    ++		discard_index(&the_index);
    ++		read_index_from(&the_index, index_file, get_git_dir());
    + 	}
    + 
    + 	return 0;
    +@@ builtin/am.c: static int fall_back_threeway(const struct am_state *state, const char *index_pa
    + 	if (build_fake_ancestor(state, index_path))
    + 		return error("could not build fake ancestor");
    + 
    +-	discard_cache();
    +-	read_cache_from(index_path);
    ++	discard_index(&the_index);
    ++	read_index_from(&the_index, index_path, get_git_dir());
    + 
    + 	if (write_index_as_tree(&orig_tree, &the_index, index_path, 0, NULL))
    + 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
    +@@ builtin/am.c: static int fall_back_threeway(const struct am_state *state, const char *index_pa
    + 
    + 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
    + 
    +-	discard_cache();
    +-	read_cache();
    ++	discard_index(&the_index);
    ++	repo_read_index(the_repository);
    + 
    + 	/*
    + 	 * This is not so wrong. Depending on which base we picked, orig_tree
    +@@ builtin/am.c: static void am_run(struct am_state *state, int resume)
    + 
    + 	unlink(am_path(state, "dirtyindex"));
    + 
    +-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0)
    ++	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
    ++					 NULL, NULL, NULL) < 0)
    + 		die(_("unable to write index file"));
    + 
    + 	if (repo_index_has_changes(the_repository, NULL, &sb)) {
    +@@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
    + 	if (parse_tree(head) || parse_tree(remote))
    + 		return -1;
    + 
    +-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
    ++	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    + 
    +-	refresh_cache(REFRESH_QUIET);
    ++	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
    + 
    + 	memset(&opts, 0, sizeof(opts));
    + 	opts.head_idx = 1;
    +@@ builtin/am.c: static int merge_tree(struct tree *tree)
    + 	if (parse_tree(tree))
    + 		return -1;
    + 
    +-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
    ++	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    + 
    + 	memset(&opts, 0, sizeof(opts));
    + 	opts.head_idx = 1;
    +
      ## builtin/check-attr.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "cache.h"
    + #include "config.h"
     @@ builtin/check-attr.c: int cmd_check_attr(int argc, const char **argv, const char *prefix)
      	argc = parse_options(argc, argv, prefix, check_attr_options,
      			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
    @@ builtin/check-attr.c: int cmd_check_attr(int argc, const char **argv, const char
      
     
      ## builtin/check-ignore.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "cache.h"
    + #include "config.h"
     @@ builtin/check-ignore.c: int cmd_check_ignore(int argc, const char **argv, const char *prefix)
      		die(_("--non-matching is only valid with --verbose"));
      
    @@ builtin/check-ignore.c: int cmd_check_ignore(int argc, const char **argv, const
      	setup_standard_excludes(&dir);
     
      ## builtin/checkout-index.c ##
    +@@
    +  * Copyright (C) 2005 Linus Torvalds
    +  *
    +  */
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "config.h"
    + #include "dir.h"
     @@ builtin/checkout-index.c: static void write_tempfile_record(const char *name, const char *prefix)
      static int checkout_file(const char *name, const char *prefix)
      {
    @@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, co
      
      	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
     
    + ## builtin/checkout.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "advice.h"
    + #include "blob.h"
    +@@ builtin/checkout.c: static int update_some(const struct object_id *oid, struct strbuf *base,
    + 	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
    + 	 * do the right thing.
    + 	 */
    +-	pos = cache_name_pos(ce->name, ce->ce_namelen);
    ++	pos = index_name_pos(&the_index, ce->name, ce->ce_namelen);
    + 	if (pos >= 0) {
    + 		struct cache_entry *old = the_index.cache[pos];
    + 		if (ce->ce_mode == old->ce_mode &&
    +@@ builtin/checkout.c: static int checkout_paths(const struct checkout_opts *opts,
    + 	}
    + 
    + 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    +-	if (read_cache_preload(&opts->pathspec) < 0)
    ++	if (repo_read_index_preload(the_repository, &opts->pathspec, 0) < 0)
    + 		return error(_("index file corrupt"));
    + 
    + 	if (opts->source_tree)
    +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
    + 	struct lock_file lock_file = LOCK_INIT;
    + 	struct tree *new_tree;
    + 
    +-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
    +-	if (read_cache_preload(NULL) < 0)
    ++	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    ++	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
    + 		return error(_("index file corrupt"));
    + 
    + 	resolve_undo_clear_index(&the_index);
    +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
    + 		struct unpack_trees_options topts;
    + 		const struct object_id *old_commit_oid;
    + 
    +-		refresh_cache(REFRESH_QUIET);
    ++		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
    + 
    + 		if (unmerged_index(&the_index)) {
    + 			error(_("you need to resolve your current index first"));
    +
      ## builtin/clean.c ##
    +@@
    +  * Based on git-clean.sh by Pavel Roskin
    +  */
    + 
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "cache.h"
    + #include "config.h"
     @@ builtin/clean.c: int cmd_clean(int argc, const char **argv, const char *prefix)
      	prepare_repo_settings(the_repository);
      	the_repository->settings.command_requires_full_index = 0;
    @@ builtin/clean.c: int cmd_clean(int argc, const char **argv, const char *prefix)
      	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
     
      ## builtin/clone.c ##
    +@@
    +  * Clone a repository into a different directory that does not yet exist.
    +  */
    + 
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "config.h"
    + #include "lockfile.h"
     @@ builtin/clone.c: static int checkout(int submodule_progress, int filter_submodules)
      	/* We need to be in the new work tree for the checkout */
      	setup_work_tree();
    @@ builtin/clone.c: static int checkout(int submodule_progress, int filter_submodul
      	memset(&opts, 0, sizeof opts);
      	opts.update = 1;
     
    + ## builtin/commit.c ##
    +@@ builtin/commit.c: static void create_base_index(const struct commit *current_head)
    + 	struct tree_desc t;
    + 
    + 	if (!current_head) {
    +-		discard_cache();
    ++		discard_index(&the_index);
    + 		return;
    + 	}
    + 
    +@@ builtin/commit.c: static void refresh_cache_or_die(int refresh_flags)
    + 	 * refresh_flags contains REFRESH_QUIET, so the only errors
    + 	 * are for unmerged entries.
    + 	 */
    +-	if (refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN))
    ++	if (refresh_index(&the_index, refresh_flags | REFRESH_IN_PORCELAIN, NULL, NULL, NULL))
    + 		die_resolve_conflict("commit");
    + }
    + 
    +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
    + 	    (!amend || (fixup_message && strcmp(fixup_prefix, "amend"))))))
    + 		die(_("No paths with --include/--only does not make sense."));
    + 
    +-	if (read_cache_preload(&pathspec) < 0)
    ++	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
    + 		die(_("index file corrupt"));
    + 
    + 	if (interactive) {
    + 		char *old_index_env = NULL, *old_repo_index_file;
    +-		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
    ++		repo_hold_locked_index(the_repository, &index_lock,
    ++				       LOCK_DIE_ON_ERROR);
    + 
    + 		refresh_cache_or_die(refresh_flags);
    + 
    +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
    + 			unsetenv(INDEX_ENVIRONMENT);
    + 		FREE_AND_NULL(old_index_env);
    + 
    +-		discard_cache();
    +-		read_cache_from(get_lock_file_path(&index_lock));
    ++		discard_index(&the_index);
    ++		read_index_from(&the_index, get_lock_file_path(&index_lock),
    ++				get_git_dir());
    + 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
    + 			if (reopen_lock_file(&index_lock) < 0)
    + 				die(_("unable to write index file"));
    +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
    + 	 * (B) on failure, rollback the real index.
    + 	 */
    + 	if (all || (also && pathspec.nr)) {
    +-		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
    ++		repo_hold_locked_index(the_repository, &index_lock,
    ++				       LOCK_DIE_ON_ERROR);
    + 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
    + 		refresh_cache_or_die(refresh_flags);
    + 		update_main_cache_tree(WRITE_TREE_SILENT);
    +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
    + 	 * We still need to refresh the index here.
    + 	 */
    + 	if (!only && !pathspec.nr) {
    +-		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
    ++		repo_hold_locked_index(the_repository, &index_lock,
    ++				       LOCK_DIE_ON_ERROR);
    + 		refresh_cache_or_die(refresh_flags);
    + 		if (the_index.cache_changed
    + 		    || !cache_tree_fully_valid(the_index.cache_tree))
    +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
    + 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
    + 		exit(1);
    + 
    +-	discard_cache();
    +-	if (read_cache() < 0)
    ++	discard_index(&the_index);
    ++	if (repo_read_index(the_repository) < 0)
    + 		die(_("cannot read the index"));
    + 
    +-	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
    ++	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
    + 	add_remove_files(&partial);
    +-	refresh_cache(REFRESH_QUIET);
    ++	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
    + 	update_main_cache_tree(WRITE_TREE_SILENT);
    + 	if (write_locked_index(&the_index, &index_lock, 0))
    + 		die(_("unable to write new_index file"));
    +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
    + 
    + 	create_base_index(current_head);
    + 	add_remove_files(&partial);
    +-	refresh_cache(REFRESH_QUIET);
    ++	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
    + 
    + 	if (write_locked_index(&the_index, &false_lock, 0))
    + 		die(_("unable to write temporary index file"));
    + 
    +-	discard_cache();
    ++	discard_index(&the_index);
    + 	ret = get_lock_file_path(&false_lock);
    +-	read_cache_from(ret);
    ++	read_index_from(&the_index, ret, get_git_dir());
    + out:
    + 	string_list_clear(&partial, 0);
    + 	clear_pathspec(&pathspec);
    +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
    + 		 * and could have updated it. We must do this before we invoke
    + 		 * the editor and after we invoke run_status above.
    + 		 */
    +-		discard_cache();
    ++		discard_index(&the_index);
    + 	}
    +-	read_cache_from(index_file);
    ++	read_index_from(&the_index, index_file, get_git_dir());
    + 
    + 	if (update_main_cache_tree(0)) {
    + 		error(_("Error building trees"));
    +@@ builtin/commit.c: int cmd_status(int argc, const char **argv, const char *prefix)
    + 		      &s.pathspec, NULL, NULL);
    + 
    + 	if (use_optional_locks())
    +-		fd = hold_locked_index(&index_lock, 0);
    ++		fd = repo_hold_locked_index(the_repository, &index_lock, 0);
    + 	else
    + 		fd = -1;
    + 
    +
      ## builtin/describe.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "cache.h"
    + #include "config.h"
    + #include "lockfile.h"
     @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *prefix)
      			int fd, result;
      
    @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
      
     
      ## builtin/diff-files.c ##
    +@@
    +  *
    +  * Copyright (C) Linus Torvalds, 2005
    +  */
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    + #include "cache.h"
    + #include "config.h"
    + #include "diff.h"
     @@ builtin/diff-files.c: int cmd_diff_files(int argc, const char **argv, const char *prefix)
      	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
      		diff_merges_set_dense_combined_if_unset(&rev);
      
     -	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
    +-		perror("read_cache_preload");
     +	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
    - 		perror("read_cache_preload");
    ++		perror("repo_read_index_preload");
      		result = -1;
      		goto cleanup;
    + 	}
     
      ## builtin/diff-index.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    + #include "cache.h"
    + #include "config.h"
    + #include "diff.h"
     @@ builtin/diff-index.c: int cmd_diff_index(int argc, const char **argv, const char *prefix)
      		usage(diff_cache_usage);
      	if (!(option & DIFF_INDEX_CACHED)) {
      		setup_work_tree();
     -		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
    +-			perror("read_cache_preload");
     +		if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
    - 			perror("read_cache_preload");
    ++			perror("repo_read_index_preload");
      			return -1;
      		}
     -	} else if (read_cache() < 0) {
    +-		perror("read_cache");
     +	} else if (repo_read_index(the_repository) < 0) {
    - 		perror("read_cache");
    ++		perror("repo_read_index");
      		return -1;
      	}
    + 	result = run_diff_index(&rev, option);
     
      ## builtin/diff-tree.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "cache.h"
    + #include "config.h"
    + #include "diff.h"
     @@ builtin/diff-tree.c: int cmd_diff_tree(int argc, const char **argv, const char *prefix)
      
      	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
    @@ builtin/diff-tree.c: int cmd_diff_tree(int argc, const char **argv, const char *
      	opt->abbrev = 0;
      	opt->diff = 1;
     
    + ## builtin/diff.c ##
    +@@
    +  *
    +  * Copyright (c) 2006 Junio C Hamano
    +  */
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "cache.h"
    + #include "config.h"
    + #include "ewah/ewok.h"
    +@@ builtin/diff.c: static int builtin_diff_index(struct rev_info *revs,
    + 		usage(builtin_diff_usage);
    + 	if (!(option & DIFF_INDEX_CACHED)) {
    + 		setup_work_tree();
    +-		if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
    +-			perror("read_cache_preload");
    ++		if (repo_read_index_preload(the_repository,
    ++					    &revs->diffopt.pathspec, 0) < 0) {
    ++			perror("repo_read_index_preload");
    + 			return -1;
    + 		}
    +-	} else if (read_cache() < 0) {
    +-		perror("read_cache");
    ++	} else if (repo_read_index(the_repository) < 0) {
    ++		perror("repo_read_cache");
    + 		return -1;
    + 	}
    + 	return run_diff_index(revs, option);
    +@@ builtin/diff.c: static void refresh_index_quietly(void)
    + 	struct lock_file lock_file = LOCK_INIT;
    + 	int fd;
    + 
    +-	fd = hold_locked_index(&lock_file, 0);
    ++	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
    + 	if (fd < 0)
    + 		return;
    +-	discard_cache();
    +-	read_cache();
    +-	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
    ++	discard_index(&the_index);
    ++	repo_read_index(the_repository);
    ++	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,
    ++		      NULL);
    + 	repo_update_index_if_able(the_repository, &lock_file);
    + }
    + 
    +@@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
    + 		diff_merges_set_dense_combined_if_unset(revs);
    + 
    + 	setup_work_tree();
    +-	if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
    +-		perror("read_cache_preload");
    ++	if (repo_read_index_preload(the_repository, &revs->diffopt.pathspec,
    ++				    0) < 0) {
    ++		perror("repo_read_index_preload");
    + 		return -1;
    + 	}
    + 	return run_diff_files(revs, options);
    +
      ## builtin/fsck.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "cache.h"
    + #include "repository.h"
     @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
      	if (keep_cache_objects) {
      		verify_index_checksum = 1;
    @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
      		for (i = 0; i < the_index.cache_nr; i++) {
     
      ## builtin/merge-index.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "run-command.h"
    + 
     @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      
      static void merge_one_path(const char *path)
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
      	ensure_full_index(&the_index);
     
      ## builtin/merge-ours.c ##
    +@@
    +  *
    +  * Pretend we resolved the heads, but declare our tree trumps everybody else.
    +  */
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    + #include "git-compat-util.h"
    + #include "builtin.h"
    + #include "diff.h"
     @@ builtin/merge-ours.c: int cmd_merge_ours(int argc, const char **argv, const char *prefix)
      	 * commit.  The index must match HEAD, or this merge cannot go
      	 * through.
    @@ builtin/merge-ours.c: int cmd_merge_ours(int argc, const char **argv, const char
      	if (index_differs_from(the_repository, "HEAD", NULL, 0))
      		return 2;
     
    + ## builtin/merge.c ##
    +@@ builtin/merge.c: static int save_state(struct object_id *stash)
    + 	int rc = -1;
    + 
    + 	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
    +-	refresh_cache(REFRESH_QUIET);
    ++	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
    + 	if (0 <= fd)
    + 		repo_update_index_if_able(the_repository, &lock_file);
    + 	rollback_lock_file(&lock_file);
    +@@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct commit_list *common,
    + {
    + 	const char *head_arg = "HEAD";
    + 
    +-	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
    ++	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
    ++					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
    ++					 NULL) < 0)
    + 		return error(_("Unable to write index."));
    + 
    + 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
    +@@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct commit_list *common,
    + 		for (j = common; j; j = j->next)
    + 			commit_list_insert(j->item, &reversed);
    + 
    +-		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
    ++		repo_hold_locked_index(the_repository, &lock,
    ++				       LOCK_DIE_ON_ERROR);
    + 		if (!strcmp(strategy, "ort"))
    + 			clean = merge_ort_recursive(&o, head, remoteheads->item,
    + 						    reversed, &result);
    +@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
    + 		 * the editor and after we invoke run_status above.
    + 		 */
    + 		if (invoked_hook)
    +-			discard_cache();
    ++			discard_index(&the_index);
    + 	}
    +-	read_cache_from(index_file);
    ++	read_index_from(&the_index, index_file, get_git_dir());
    + 	strbuf_addbuf(&msg, &merge_msg);
    + 	if (squash)
    + 		BUG("the control must not reach here under --squash");
    +@@ builtin/merge.c: static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
    + 	struct object_id result_tree, result_commit;
    + 	struct commit_list *parents, **pptr = &parents;
    + 
    +-	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
    ++	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
    ++					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
    ++					 NULL) < 0)
    + 		return error(_("Unable to write index."));
    + 
    + 	write_tree_trivial(&result_tree);
    +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
    + 		 * We are not doing octopus, not fast-forward, and have
    + 		 * only one common.
    + 		 */
    +-		refresh_cache(REFRESH_QUIET);
    ++		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
    + 		if (allow_trivial && fast_forward != FF_ONLY) {
    + 			/*
    + 			 * Must first ensure that index matches HEAD before
    +
    + ## builtin/mv.c ##
    +@@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
    + 	const char *src_w_slash = add_slash(src);
    + 	int first, last, len_w_slash = length + 1;
    + 
    +-	first = cache_name_pos(src_w_slash, len_w_slash);
    ++	first = index_name_pos(&the_index, src_w_slash, len_w_slash);
    + 	if (first >= 0)
    + 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
    + 
    +@@ builtin/mv.c: static int empty_dir_has_sparse_contents(const char *name)
    + 	const char *with_slash = add_slash(name);
    + 	int length = strlen(with_slash);
    + 
    +-	int pos = cache_name_pos(with_slash, length);
    ++	int pos = index_name_pos(&the_index, with_slash, length);
    + 	const struct cache_entry *ce;
    + 
    + 	if (pos < 0) {
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 	if (--argc < 1)
    + 		usage_with_options(builtin_mv_usage, builtin_mv_options);
    + 
    +-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
    +-	if (read_cache() < 0)
    ++	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    ++	if (repo_read_index(the_repository) < 0)
    + 		die(_("index file corrupt"));
    + 
    + 	source = internal_prefix_pathspec(prefix, argv, argc, 0);
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 			int pos;
    + 			const struct cache_entry *ce;
    + 
    +-			pos = cache_name_pos(src, length);
    ++			pos = index_name_pos(&the_index, src, length);
    + 			if (pos < 0) {
    + 				const char *src_w_slash = add_slash(src);
    + 				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 				goto act_on_entry;
    + 			}
    + 			/* Check if dst exists in index */
    +-			if (cache_name_pos(dst, strlen(dst)) < 0) {
    ++			if (index_name_pos(&the_index, dst, strlen(dst)) < 0) {
    + 				modes[i] |= SPARSE;
    + 				goto act_on_entry;
    + 			}
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + dir_check:
    + 		if (S_ISDIR(st.st_mode)) {
    + 			int j, dst_len, n;
    +-			int first = cache_name_pos(src, length), last;
    ++			int first = index_name_pos(&the_index, src, length), last;
    + 
    + 			if (first >= 0) {
    + 				prepare_move_submodule(src, first,
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
    + 			continue;
    + 
    +-		pos = cache_name_pos(src, strlen(src));
    ++		pos = index_name_pos(&the_index, src, strlen(src));
    + 		assert(pos >= 0);
    + 		if (!(mode & SPARSE) && !lstat(src, &st))
    + 			sparse_and_dirty = ie_modified(&the_index,
    +
    + ## builtin/read-tree.c ##
    +@@
    +  * Copyright (C) Linus Torvalds, 2005
    +  */
    + 
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "cache.h"
    + #include "config.h"
    + #include "lockfile.h"
    +@@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
    + 	prepare_repo_settings(the_repository);
    + 	the_repository->settings.command_requires_full_index = 0;
    + 
    +-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
    ++	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    + 
    + 	/*
    + 	 * NEEDSWORK
    +
      ## builtin/rebase.c ##
    +@@
    +  * Copyright (c) 2018 Pratik Karki
    +  */
    + 
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "run-command.h"
    + #include "exec-cmd.h"
     @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
      	if (ret)
      		error(_("could not generate todo list"));
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL,
     
      ## builtin/reset.c ##
    +@@
    +  *
    +  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
    +  */
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "config.h"
    + #include "lockfile.h"
     @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
      		 * if this entry is outside the sparse cone - this is necessary
      		 * to properly construct the reset sparse directory.
    @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
      			if (read_from_tree(&pathspec, &oid, intent_to_add))
     
      ## builtin/rev-parse.c ##
    +@@
    +  *
    +  * Copyright (C) Linus Torvalds, 2005
    +  */
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "cache.h"
    + #include "config.h"
    + #include "commit.h"
     @@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv, const char *prefix)
      				continue;
      			}
    @@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv, const char *
      					die(_("Could not read the index"));
      				if (the_index.split_index) {
      					const struct object_id *oid = &the_index.split_index->base_oid;
    +
    + ## builtin/rm.c ##
    +@@ builtin/rm.c: static void submodules_absorb_gitdir_if_needed(void)
    + 		int pos;
    + 		const struct cache_entry *ce;
    + 
    +-		pos = cache_name_pos(name, strlen(name));
    ++		pos = index_name_pos(&the_index, name, strlen(name));
    + 		if (pos < 0) {
    + 			pos = get_ours_cache_pos(name, pos);
    + 			if (pos < 0)
    +@@ builtin/rm.c: static int check_local_mod(struct object_id *head, int index_only)
    + 		int local_changes = 0;
    + 		int staged_changes = 0;
    + 
    +-		pos = cache_name_pos(name, strlen(name));
    ++		pos = index_name_pos(&the_index, name, strlen(name));
    + 		if (pos < 0) {
    + 			/*
    + 			 * Skip unmerged entries except for populated submodules
    +@@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
    + 
    + 	prepare_repo_settings(the_repository);
    + 	the_repository->settings.command_requires_full_index = 0;
    +-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
    ++	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    + 
    +-	if (read_cache() < 0)
    ++	if (repo_read_index(the_repository) < 0)
    + 		die(_("index file corrupt"));
    + 
    + 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
    +
    + ## builtin/stash.c ##
    +@@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int reset)
    + 	struct tree *tree;
    + 	struct lock_file lock_file = LOCK_INIT;
    + 
    +-	read_cache_preload(NULL);
    +-	if (refresh_cache(REFRESH_QUIET))
    ++	repo_read_index_preload(the_repository, NULL, 0);
    ++	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
    + 		return -1;
    + 
    +-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
    ++	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
    + 
    + 	memset(&opts, 0, sizeof(opts));
    + 
    +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
    + 	struct tree *head, *merge, *merge_base;
    + 	struct lock_file lock = LOCK_INIT;
    + 
    +-	read_cache_preload(NULL);
    +-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
    ++	repo_read_index_preload(the_repository, NULL, 0);
    ++	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
    ++					 NULL, NULL, NULL))
    + 		return -1;
    + 
    + 	if (write_cache_as_tree(&c_tree, 0, NULL))
    +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
    + 				return error(_("conflicts in index. "
    + 					       "Try without --index."));
    + 
    +-			discard_cache();
    +-			read_cache();
    ++			discard_index(&the_index);
    ++			repo_read_index(the_repository);
    + 			if (write_cache_as_tree(&index_tree, 0, NULL))
    + 				return error(_("could not save index tree"));
    + 
    + 			reset_head();
    +-			discard_cache();
    +-			read_cache();
    ++			discard_index(&the_index);
    ++			repo_read_index(the_repository);
    + 		}
    + 	}
    + 
    +@@ builtin/stash.c: static int check_changes_tracked_files(const struct pathspec *ps)
    + 	if (get_oid("HEAD", &dummy))
    + 		return -1;
    + 
    +-	if (read_cache() < 0)
    ++	if (repo_read_index(the_repository) < 0)
    + 		return -1;
    + 
    + 	init_revisions(&rev, NULL);
    +@@ builtin/stash.c: static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
    + 	rev.diffopt.format_callback = add_diff_to_buf;
    + 	rev.diffopt.format_callback_data = &diff_output;
    + 
    +-	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
    ++	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
    + 		ret = -1;
    + 		goto done;
    + 	}
    +@@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
    + 
    + 	prepare_fallback_ident("git stash", "git@stash");
    + 
    +-	read_cache_preload(NULL);
    +-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0) {
    ++	repo_read_index_preload(the_repository, NULL, 0);
    ++	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
    ++					 NULL, NULL, NULL) < 0) {
    + 		ret = -1;
    + 		goto done;
    + 	}
    +@@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
    + 		goto done;
    + 	}
    + 
    +-	read_cache_preload(NULL);
    ++	repo_read_index_preload(the_repository, NULL, 0);
    + 	if (!include_untracked && ps->nr) {
    + 		int i;
    + 		char *ps_matched = xcalloc(ps->nr, 1);
    +@@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
    + 		free(ps_matched);
    + 	}
    + 
    +-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0)) {
    ++	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
    ++					 NULL, NULL, NULL)) {
    + 		ret = -1;
    + 		goto done;
    + 	}
    +@@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
    + 				goto done;
    + 			}
    + 		}
    +-		discard_cache();
    ++		discard_index(&the_index);
    + 		if (ps->nr) {
    + 			struct child_process cp_add = CHILD_PROCESS_INIT;
    + 			struct child_process cp_diff = CHILD_PROCESS_INIT;
    +
    + ## builtin/submodule--helper.c ##
    +@@
    +-#define USE_THE_INDEX_COMPATIBILITY_MACROS
    ++#define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "repository.h"
    + #include "cache.h"
    +@@ builtin/submodule--helper.c: static int module_list_compute(const char **argv,
    + 	if (pathspec->nr)
    + 		ps_matched = xcalloc(pathspec->nr, 1);
    + 
    +-	if (read_cache() < 0)
    ++	if (repo_read_index(the_repository) < 0)
    + 		die(_("index file corrupt"));
    + 
    + 	for (i = 0; i < the_index.cache_nr; i++) {
    +@@ builtin/submodule--helper.c: static int compute_summary_module_list(struct object_id *head_oid,
    + 	if (!info->cached) {
    + 		if (diff_cmd == DIFF_INDEX)
    + 			setup_work_tree();
    +-		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
    +-			perror("read_cache_preload");
    ++		if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
    ++			perror("repo_read_index_preload");
    + 			ret = -1;
    + 			goto cleanup;
    + 		}
    +-	} else if (read_cache() < 0) {
    +-		perror("read_cache");
    ++	} else if (repo_read_index(the_repository) < 0) {
    ++		perror("repo_read_cache");
    + 		ret = -1;
    + 		goto cleanup;
    + 	}
    +@@ builtin/submodule--helper.c: static void die_on_index_match(const char *path, int force)
    + 	const char *args[] = { path, NULL };
    + 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_CWD, NULL, args);
    + 
    +-	if (read_cache_preload(NULL) < 0)
    ++	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
    + 		die(_("index file corrupt"));
    + 
    + 	if (ps.nr) {
    +
    + ## builtin/update-index.c ##
    +@@ builtin/update-index.c: static int test_if_untracked_cache_is_supported(void)
    + static int mark_ce_flags(const char *path, int flag, int mark)
    + {
    + 	int namelen = strlen(path);
    +-	int pos = cache_name_pos(path, namelen);
    ++	int pos = index_name_pos(&the_index, path, namelen);
    + 	if (0 <= pos) {
    + 		mark_fsmonitor_invalid(&the_index, the_index.cache[pos]);
    + 		if (mark)
    +@@ builtin/update-index.c: static int add_one_path(const struct cache_entry *old, const char *path, int len
    + static int process_directory(const char *path, int len, struct stat *st)
    + {
    + 	struct object_id oid;
    +-	int pos = cache_name_pos(path, len);
    ++	int pos = index_name_pos(&the_index, path, len);
    + 
    + 	/* Exact match: file or existing gitlink */
    + 	if (pos >= 0) {
    +@@ builtin/update-index.c: static void chmod_path(char flip, const char *path)
    + 	int pos;
    + 	struct cache_entry *ce;
    + 
    +-	pos = cache_name_pos(path, strlen(path));
    ++	pos = index_name_pos(&the_index, path, strlen(path));
    + 	if (pos < 0)
    + 		goto fail;
    + 	ce = the_index.cache[pos];
    +@@ builtin/update-index.c: static int unresolve_one(const char *path)
    + 	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
    + 
    + 	/* See if there is such entry in the index. */
    +-	pos = cache_name_pos(path, namelen);
    ++	pos = index_name_pos(&the_index, path, namelen);
    + 	if (0 <= pos) {
    + 		/* already merged */
    + 		pos = unmerge_index_entry_at(&the_index, pos);
    +@@ builtin/update-index.c: struct refresh_params {
    + static int refresh(struct refresh_params *o, unsigned int flag)
    + {
    + 	setup_work_tree();
    +-	read_cache();
    +-	*o->has_errors |= refresh_cache(o->flags | flag);
    ++	repo_read_index(the_repository);
    ++	*o->has_errors |= refresh_index(&the_index, o->flags | flag, NULL,
    ++					NULL, NULL);
    + 	if (has_racy_timestamp(&the_index)) {
    + 		/*
    + 		 * Even if nothing else has changed, updating the file
    + 		 * increases the chance that racy timestamps become
    + 		 * non-racy, helping future run-time performance.
    + 		 * We do that even in case of "errors" returned by
    +-		 * refresh_cache() as these are no actual errors.
    ++		 * refresh_index() as these are no actual errors.
    + 		 * cmd_status() does the same.
    + 		 */
    + 		the_index.cache_changed |= SOMETHING_CHANGED;
    +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    + 	the_repository->settings.command_requires_full_index = 0;
    + 
    + 	/* we will diagnose later if it turns out that we need to update it */
    +-	newfd = hold_locked_index(&lock_file, 0);
    ++	newfd = repo_hold_locked_index(the_repository, &lock_file, 0);
    + 	if (newfd < 0)
    + 		lock_error = errno;
    + 
    +-	entries = read_cache();
    ++	entries = repo_read_index(the_repository);
    + 	if (entries < 0)
    + 		die("cache corrupted");
    + 
    +
    + ## cache.h ##
    +@@ cache.h: extern struct index_state the_index;
    + #define active_nr (the_index.cache_nr)
    + 
    + #define read_cache() repo_read_index(the_repository)
    +-#define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
    +-#define read_cache_preload(pathspec) repo_read_index_preload(the_repository, (pathspec), 0)
    + #define discard_cache() discard_index(&the_index)
    + #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
    +-#define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
    +-#define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
    +-#define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
    + #endif
    + #endif
    + #endif
    +
    + ## contrib/coccinelle/index-compatibility.cocci ##
    +@@ contrib/coccinelle/index-compatibility.cocci: identifier f != prepare_to_commit;
    + (
    + - read_cache_unmerged
    + + repo_read_index_unmerged
    ++|
    ++- hold_locked_index
    +++ repo_hold_locked_index
    + )
    +   (
    + + the_repository,
    +   ...)
    + 
    ++// "the_repository" special-cases
    ++@@
    ++@@
    ++(
    ++- read_cache_preload
    +++ repo_read_index_preload
    ++)
    ++  (
    +++ the_repository,
    ++  ...
    +++ , 0
    ++  )
    ++
    + // "the_index" simple cases
    + @@
    + @@
    +@@ contrib/coccinelle/index-compatibility.cocci: identifier f != prepare_to_commit;
    +   (
    + + &the_index,
    +   ...)
    ++
    ++@@
    ++@@
    ++(
    ++- refresh_and_write_cache
    +++ repo_refresh_and_write_index
    ++)
    ++  (
    +++ the_repository,
    ++  ...
    +++ , NULL, NULL, NULL
    ++  )
    ++
    ++// "the_index" special-cases
    ++@@
    ++@@
    ++(
    ++- read_cache_from
    +++ read_index_from
    ++)
    ++  (
    +++ &the_index,
    ++  ...
    +++ , get_git_dir()
    ++  )
    ++
    ++@@
    ++@@
    ++(
    ++- refresh_cache
    +++ refresh_index
    ++)
    ++  (
    +++ &the_index,
    ++  ...
    +++ , NULL, NULL, NULL
    ++  )
    +
    + ## contrib/coccinelle/index-compatibility.pending.cocci ##
    +@@
    + (
    + - read_cache
    + + repo_read_index
    +-|
    +-- hold_locked_index
    +-+ repo_hold_locked_index
    + )
    +   (
    + + the_repository,
    +@@
    +   (
    + + &the_index,
    +   ...)
    +-
    +-// "the_repository" special-cases
    +-@@
    +-@@
    +-(
    +-- read_cache_preload
    +-+ repo_read_index_preload
    +-)
    +-  (
    +-+ the_repository,
    +-  ...
    +-+ , 0
    +-  )
    +-
    +-@@
    +-@@
    +-(
    +-- refresh_and_write_cache
    +-+ repo_refresh_and_write_index
    +-)
    +-  (
    +-+ the_repository,
    +-  ...
    +-+ , NULL, NULL, NULL
    +-  )
    +-
    +-
    +-// "the_index" special-cases
    +-@@
    +-@@
    +-(
    +-- read_cache_from
    +-+ read_index_from
    +-)
    +-  (
    +-+ &the_index,
    +-  ...
    +-+ , get_git_dir()
    +-  )
    +-
    +-@@
    +-@@
    +-(
    +-- refresh_cache
    +-+ refresh_index
    +-)
    +-  (
    +-+ &the_index,
    +-  ...
    +-+ , NULL, NULL, NULL
    +-  )
12:  b69cf6d7600 <  -:  ----------- builtin/*: remove or amend "USE_THE_INDEX_COMPATIBILITY_MACROS"
-- 
2.38.0.1509.g9445af83948

