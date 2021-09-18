Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB673C43217
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF64610A6
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbhIRXQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbhIRXQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:16:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193B6C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 70so7229284wme.5
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rWTixTNpeXmUaMnWhtjF/TFEXVOP6u+T23+R/wTJFWQ=;
        b=QktkJ8TxBkX2Zh6NCnBZPUJZ7iY+4LKq6DC2LrGHDKXM4xvNfYLdwr5k7TBV+Nsisg
         2eYOzvHwILiNDQfy/mXwbKYyiC9mD5IgeNbRD3VP5eYpIS7YPVTo48QNLRaUJeUahKAv
         2bzRokHOv57RioRBYFcV5TG3ZO6RiSjl/h2eW6qyzPADfb/dFQrcWjViN6+OxBSWsuxC
         Ymgd+EzVZy9QV2yatJP1gRx0kj1PhKaCHFgnSotNx/eITndJOxwRLQwrU7RzQ8iuYkfp
         19Os/fvby2V0XRW9AXk8xW45nrJOFRUfIi1jPzi+nZL/YdzCyXH5EcMniIXyoM1Okl+z
         pXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rWTixTNpeXmUaMnWhtjF/TFEXVOP6u+T23+R/wTJFWQ=;
        b=sbxjU94fqunhTHRLEKgmh/Pm+LcjJHH4Q5VOqrg3nqfUS1mEeYDgKBZWaJIas8dCPP
         3DZZADej7wMEwMtS/mOoY/79Lxwi/sttglq40tUqrCM/44tQY9jkbJ56jPQcgoNz0WuV
         ufuZHHx9br31xco/oSovlN9/CSWO6V3NkrugaOpBHaSumtAYyXOZ1TKPSUZR8iWr32yF
         Du6NfJxpr3fiXT+OBLeNEZJPYZUiWJgG+u1GNEZGy6DrpEMIEhamUDdkUHXsKf79TDZ5
         0yIrLHtENTV9S/8wnXCv+IHg6YdGb/1U8gP++58QHOhWWzymYtx/vjd1oaRjx5C/Sv8+
         NGjg==
X-Gm-Message-State: AOAM533fig8vv0pFCnPNEjvEEPLYXhVaMknp64iDhLDK/jl+/T6OPLJM
        Z0sUX5hKRqiQXlqhrHM8n9mdX/X+g84=
X-Google-Smtp-Source: ABdhPJzn1a4N9vK/KBky6Q4D/QvKile3AMRHI+/O7tNb34pqmJHGdym/Vt3LcGU5pSueRNFtnIQj1A==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr9746947wms.171.1632006926614;
        Sat, 18 Sep 2021 16:15:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25sm14764046wmj.10.2021.09.18.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:15:26 -0700 (PDT)
Message-Id: <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:15:19 +0000
Subject: [PATCH 2/6] Split unpack_trees 'reset' flag into two for untracked
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Traditionally, unpack_trees_options->reset was used to signal that it
was okay to delete any untracked files in the way.  This was used by
`git read-tree --reset`, but then started appearing in other places as
well.  However, many of the other uses should not be deleting untracked
files in the way.  Split this into two separate fields:
   reset_nuke_untracked
   reset_keep_untracked
and, since many code paths in unpack_trees need to be followed for both
of these flags, introduce a third one for convenience:
   reset_either
which is simply an or-ing of the other two.

Modify existing callers so that
   read-tree --reset
   reset --hard
   checkout --force
continue using reset_nuke_untracked, but so that other callers,
including
   am
   checkout without --force
   stash  (though currently dead code; reset always had a value of 0)
   numerous callers from rebase/sequencer to reset_head()
will use the new reset_keep_untracked field.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c                     |  6 +++++-
 builtin/checkout.c               | 10 +++++++++-
 builtin/read-tree.c              | 11 ++++++++---
 builtin/reset.c                  | 15 +++++++++++++--
 builtin/stash.c                  |  2 +-
 reset.c                          |  9 +++++++--
 t/t1013-read-tree-submodule.sh   |  4 ++--
 t/t2500-untracked-overwriting.sh |  6 +++---
 unpack-trees.c                   | 17 ++++++++++++-----
 unpack-trees.h                   |  4 +++-
 10 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c79e0167e98..dbe6cbe6a33 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1918,8 +1918,12 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.dst_index = &the_index;
 	opts.update = 1;
 	opts.merge = 1;
-	opts.reset = reset;
+	opts.reset_keep_untracked = reset;
 	opts.fn = twoway_merge;
+	/* Setup opts.dir so that ignored files in the way get overwritten */
+	opts.dir = xcalloc(1, sizeof(*opts.dir));
+	opts.dir->flags |= DIR_SHOW_IGNORED;
+	setup_standard_excludes(opts.dir);
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a7..ab0bb4d94f0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -646,12 +646,20 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.head_idx = -1;
 	opts.update = worktree;
 	opts.skip_unmerged = !worktree;
-	opts.reset = 1;
+	if (o->force)
+		opts.reset_nuke_untracked = 1;
+	else
+		opts.reset_keep_untracked = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	if (o->overwrite_ignore) {
+		opts.dir = xcalloc(1, sizeof(*opts.dir));
+		opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opts.dir);
+	}
 	init_checkout_metadata(&opts.meta, info->refname,
 			       info->commit ? &info->commit->object.oid : null_oid(),
 			       NULL);
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 485e7b04794..8b94e1aa261 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			 N_("3-way merge if no file level merging required")),
 		OPT_BOOL(0, "aggressive", &opts.aggressive,
 			 N_("3-way merge in presence of adds and removes")),
-		OPT_BOOL(0, "reset", &opts.reset,
+		OPT_BOOL(0, "reset", &opts.reset_keep_untracked,
 			 N_("same as -m, but discard unmerged entries")),
 		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
 		  N_("read the tree into the index under <subdirectory>/"),
@@ -162,6 +162,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	opts.head_idx = -1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	if (opts.reset_keep_untracked) {
+		opts.dir = xcalloc(1, sizeof(*opts.dir));
+		opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opts.dir);
+	}
 
 	git_config(git_read_tree_config, NULL);
 
@@ -171,7 +176,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	prefix_set = opts.prefix ? 1 : 0;
-	if (1 < opts.merge + opts.reset + prefix_set)
+	if (1 < opts.merge + opts.reset_keep_untracked + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
 
 	/*
@@ -183,7 +188,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	 * mode.
 	 */
 
-	if (opts.reset || opts.merge || opts.prefix) {
+	if (opts.reset_keep_untracked || opts.merge || opts.prefix) {
 		if (read_cache_unmerged() && (opts.prefix || opts.merge))
 			die(_("You need to resolve your current index first"));
 		stage = opts.merge = 1;
diff --git a/builtin/reset.c b/builtin/reset.c
index 43e855cb887..ba39c4882a6 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -10,6 +10,7 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
+#include "dir.h"
 #include "lockfile.h"
 #include "tag.h"
 #include "object.h"
@@ -70,9 +71,19 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 		break;
 	case HARD:
 		opts.update = 1;
-		/* fallthrough */
+		opts.reset_nuke_untracked = 1;
+		break;
+	case MIXED:
+		opts.reset_keep_untracked = 1; /* but opts.update=0, so untracked left alone */
+		break;
 	default:
-		opts.reset = 1;
+		BUG("invalid reset_type passed to reset_index");
+	}
+	if (opts.reset_keep_untracked) {
+		/* Setup opts.dir so we can overwrite ignored files */
+		opts.dir = xcalloc(1, sizeof(*opts.dir));
+		opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opts.dir);
 	}
 
 	read_cache_unmerged();
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..4ceb3581b47 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -256,7 +256,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	opts.merge = 1;
-	opts.reset = reset;
+	opts.reset_keep_untracked = reset;
 	opts.update = update;
 	opts.fn = oneway_merge;
 
diff --git a/reset.c b/reset.c
index 79310ae071b..0880c76aef9 100644
--- a/reset.c
+++ b/reset.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "cache-tree.h"
+#include "dir.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "reset.h"
@@ -57,8 +58,12 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (!detach_head)
-		unpack_tree_opts.reset = 1;
+	if (!detach_head) {
+		unpack_tree_opts.reset_keep_untracked = 1;
+		unpack_tree_opts.dir = xcalloc(1, sizeof(*unpack_tree_opts.dir));
+		unpack_tree_opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(unpack_tree_opts.dir);
+	}
 
 	if (repo_read_index_unmerged(r) < 0) {
 		ret = error(_("could not read index"));
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index b6df7444c05..4e485c223ad 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -10,10 +10,10 @@ KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
 test_submodule_switch_recursing_with_args "read-tree -u -m"
 
-test_submodule_forced_switch_recursing_with_args "read-tree -u --reset"
+test_submodule_switch_recursing_with_args "read-tree -u --reset"
 
 test_submodule_switch "read-tree -u -m"
 
-test_submodule_forced_switch "read-tree -u --reset"
+test_submodule_switch "read-tree -u --reset"
 
 test_done
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index a1a6dfa671e..786ec33d63a 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -92,7 +92,7 @@ test_setup_checkout_m () {
 	)
 }
 
-test_expect_failure 'checkout -m does not nuke untracked file' '
+test_expect_success 'checkout -m does not nuke untracked file' '
 	test_setup_checkout_m &&
 	(
 		cd checkout &&
@@ -138,7 +138,7 @@ test_setup_sequencing () {
 	)
 }
 
-test_expect_failure 'git rebase --abort and untracked files' '
+test_expect_success 'git rebase --abort and untracked files' '
 	test_setup_sequencing rebase_abort_and_untracked &&
 	(
 		cd sequencing_rebase_abort_and_untracked &&
@@ -155,7 +155,7 @@ test_expect_failure 'git rebase --abort and untracked files' '
 	)
 '
 
-test_expect_failure 'git rebase fast forwarding and untracked files' '
+test_expect_success 'git rebase fast forwarding and untracked files' '
 	test_setup_sequencing rebase_fast_forward_and_untracked &&
 	(
 		cd sequencing_rebase_fast_forward_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 5786645f315..d952eebe96a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -301,7 +301,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 	if (!sub)
 		return 0;
 
-	if (o->reset)
+	if (o->reset_nuke_untracked)
 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
 
 	if (submodule_move_head(ce->name, old_id, new_id, flags))
@@ -1696,6 +1696,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
+	if (o->reset_nuke_untracked && o->reset_keep_untracked)
+		BUG("reset_nuke_untracked and reset_keep_untracked are incompatible");
+
+	o->reset_either = 0;
+	if (o->reset_nuke_untracked || o->reset_keep_untracked)
+		o->reset_either = 1;
+
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
 
@@ -1989,7 +1996,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	 */
 	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
 		; /* keep checking */
-	else if (o->reset || ce_uptodate(ce))
+	else if (o->reset_either || ce_uptodate(ce))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
@@ -2218,7 +2225,7 @@ static int verify_absent_1(const struct cache_entry *ce,
 	int len;
 	struct stat st;
 
-	if (o->index_only || o->reset || !o->update)
+	if (o->index_only || o->reset_nuke_untracked || !o->update)
 		return 0;
 
 	len = check_leading_path(ce->name, ce_namelen(ce), 0);
@@ -2585,7 +2592,7 @@ int twoway_merge(const struct cache_entry * const *src,
 
 	if (current) {
 		if (current->ce_flags & CE_CONFLICTED) {
-			if (same(oldtree, newtree) || o->reset) {
+			if (same(oldtree, newtree) || o->reset_either) {
 				if (!newtree)
 					return deleted_entry(current, current, o);
 				else
@@ -2683,7 +2690,7 @@ int oneway_merge(const struct cache_entry * const *src,
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
+		if (o->reset_either && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
 			!(old->ce_flags & CE_FSMONITOR_VALID)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
diff --git a/unpack-trees.h b/unpack-trees.h
index 2d88b19dca7..c419bf8b1f9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -46,7 +46,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
 
 struct unpack_trees_options {
-	unsigned int reset,
+	unsigned int reset_nuke_untracked,
+		     reset_keep_untracked,
+		     reset_either, /* internal use only */
 		     merge,
 		     update,
 		     clone,
-- 
gitgitgadget

