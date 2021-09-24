Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C786C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3470B610C7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbhIXGis (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbhIXGiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:38:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDBEC061757
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d21so23938637wra.12
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=56AvOCIEYWVpq1dC03dIBhpGuXw6GMfLaFcouXu4KeU=;
        b=ADMuOqkwUDOYv3WGFtaRY+0xCCRxjl6YbnOQehVbF6mynbOzP198iCLRIMnAWJB4d/
         P8L3d9LBldD1uLi2dgq8iTRhDuYEqt89KqK50z2o3e/ne4Mvxa/8HgvTI32y4byLILbv
         f3uOu2+7c2rA8kJHKjPDXEZ9cXaEAho9K5C6scheG+eDtz7VYeDaqrE9jEVZIRJQYexL
         g3loUE606ItxWcvWJ/rDXqt7vuq/eBsKQYVCpsylH7OkjrKPUsXlGyx2A3Wbs8PLKrpW
         ouWs0pYRue077RATquOswPVo3rerC3mc4VLcfbFQipjQmuGHdbH/fl8NABJR1nflxRR9
         k1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=56AvOCIEYWVpq1dC03dIBhpGuXw6GMfLaFcouXu4KeU=;
        b=hdrPtJukhPxRYXjV6hwJz9IraIeBI/+gc3cI7azNLKX36+UyFIRgmId3qAqfFYmjH0
         lDVW6K40il9WiAWxgbUN08zc/3CSxItYa4XzTM42J+vfkaWj/Lds9AQS5o7aKoF0EEuQ
         XvyOFE+QuZsyvozaruAo4FxfJlQ1VVSIGVMVQO+IIwOdWVAJwRHFjs8vpEKB5pYrG/LA
         YR0TJhIRqmoXikcwTbISlmTFDhxrkD8W5vTmrsSCmJWvPJwksK100DVYY0DNsn6Z+ujS
         eW6f2nwPeE5we3cMuc4Wd1c3WORS2YSgLcZj/Jrf82y9x1wcV/4IvYHpBnw8FLfD7wdX
         6ymw==
X-Gm-Message-State: AOAM531F3TSMgEwpZXS/ha8poPdLKQ+j2baoJ5Mzw9QuNp8PVYrnjsZu
        eLF9Pa/gJknuOVNPa1LEQyc8ilkj194=
X-Google-Smtp-Source: ABdhPJyS4mgLEA+ro2Wb05CKpSkZlebqO2zcKBmxHzB++1E4OOvgXH8MsFkyBlmw/E3ChPbWbJlPrA==
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr279013wmk.21.1632465432303;
        Thu, 23 Sep 2021 23:37:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm7090975wrc.86.2021.09.23.23.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:37:12 -0700 (PDT)
Message-Id: <b77692b8f49e6551de201104d0e3527f3379b017.1632465429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
        <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 06:37:05 +0000
Subject: [PATCH v2 2/6] Change unpack_trees' 'reset' flag into an enum
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
files in the way.  Change this value to an enum so that a value of 1
(i.e. "true") can be split into two:
   UNPACK_RESET_PROTECT_UNTRACKED,
   UNPACK_RESET_OVERWRITE_UNTRACKED
In order to catch accidental misuses, define with the enum a special
value of
   UNPACK_RESET_INVALID = 1
which will trigger a BUG().

Modify existing callers so that
   read-tree --reset
   reset --hard
   checkout --force
continue using the UNPACK_RESET_OVERWRITE_UNTRACKED logic, while other
callers, including
   am
   checkout without --force
   stash  (though currently dead code; reset always had a value of 0)
   numerous callers from rebase/sequencer to reset_head()
will use the new UNPACK_RESET_PROTECT_UNTRACKED value.

In order to protect untracked files but still allow deleting of ignored
files, we also have to setup unpack_trees_opt.dir.  It may make sense to
set up unpack_trees_opt.dir in more cases, but here I tried to only do
so in cases where we switched from deleting all untracked files to
avoiding doing so (i.e. where we now use
UNPACK_RESET_PROTECT_UNTRACKED).

Also, note that 'git checkout <pathspec>' currently also allows
overwriting untracked files.  That case should also be fixed, but it
does not use unpack_trees() and thus is outside the scope of the current
changes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c                     | 13 ++++++++++++-
 builtin/checkout.c               | 18 ++++++++++++++++--
 builtin/read-tree.c              |  3 +++
 builtin/reset.c                  | 20 ++++++++++++++++++--
 builtin/stash.c                  | 17 +++++++++++++++--
 reset.c                          | 13 +++++++++++--
 t/t2500-untracked-overwriting.sh |  6 +++---
 unpack-trees.c                   |  6 +++++-
 unpack-trees.h                   | 11 +++++++++--
 9 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c79e0167e98..b17baa67ad8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1918,8 +1918,14 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.dst_index = &the_index;
 	opts.update = 1;
 	opts.merge = 1;
-	opts.reset = reset;
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.fn = twoway_merge;
+	if (opts.reset) {
+		/* Allow ignored files in the way to get overwritten */
+		opts.dir = xcalloc(1, sizeof(*opts.dir));
+		opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opts.dir);
+	}
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
 
@@ -1928,6 +1934,11 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 		return -1;
 	}
 
+	if (opts.reset) {
+		dir_clear(opts.dir);
+		FREE_AND_NULL(opts.dir);
+	}
+
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a7..52826e0d145 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -641,23 +641,37 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
+	int unpack_trees_ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.update = worktree;
 	opts.skip_unmerged = !worktree;
-	opts.reset = 1;
+	opts.reset = o->force ? UNPACK_RESET_OVERWRITE_UNTRACKED :
+				UNPACK_RESET_PROTECT_UNTRACKED;
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
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
-	switch (unpack_trees(1, &tree_desc, &opts)) {
+	unpack_trees_ret = unpack_trees(1, &tree_desc, &opts);
+
+	if (o->overwrite_ignore) {
+		dir_clear(opts.dir);
+		FREE_AND_NULL(opts.dir);
+	}
+
+	switch (unpack_trees_ret) {
 	case -2:
 		*writeout_error = 1;
 		/*
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 485e7b04794..740fc0335af 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -174,6 +174,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
 
+	if (opts.reset)
+		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+
 	/*
 	 * NEEDSWORK
 	 *
diff --git a/builtin/reset.c b/builtin/reset.c
index 43e855cb887..a12ee986e9f 100644
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
@@ -70,9 +71,20 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 		break;
 	case HARD:
 		opts.update = 1;
-		/* fallthrough */
+		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+		break;
+	case MIXED:
+		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+		/* but opts.update=0, so working tree not updated */
+		break;
 	default:
-		opts.reset = 1;
+		BUG("invalid reset_type passed to reset_index");
+	}
+	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
+		/* Setup opts.dir so we can overwrite ignored files */
+		opts.dir = xcalloc(1, sizeof(*opts.dir));
+		opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opts.dir);
 	}
 
 	read_cache_unmerged();
@@ -104,6 +116,10 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	ret = 0;
 
 out:
+	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
+		dir_clear(opts.dir);
+		FREE_AND_NULL(opts.dir);
+	}
 	for (i = 0; i < nr; i++)
 		free((void *)desc[i].buffer);
 	return ret;
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..563f590afbd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -237,6 +237,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct tree *tree;
 	struct lock_file lock_file = LOCK_INIT;
+	int unpack_trees_ret;
 
 	read_cache_preload(NULL);
 	if (refresh_cache(REFRESH_QUIET))
@@ -256,11 +257,23 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	opts.merge = 1;
-	opts.reset = reset;
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
+	if (opts.reset) {
+		opts.dir = xcalloc(1, sizeof(*opts.dir));
+		opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opts.dir);
+	}
 	opts.update = update;
 	opts.fn = oneway_merge;
 
-	if (unpack_trees(nr_trees, t, &opts))
+	unpack_trees_ret = unpack_trees(nr_trees, t, &opts);
+
+	if (opts.reset) {
+		dir_clear(opts.dir);
+		FREE_AND_NULL(opts.dir);
+	}
+
+	if (unpack_trees_ret)
 		return -1;
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
diff --git a/reset.c b/reset.c
index 79310ae071b..1695f3828c5 100644
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
+		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+		unpack_tree_opts.dir = xcalloc(1, sizeof(*unpack_tree_opts.dir));
+		unpack_tree_opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(unpack_tree_opts.dir);
+	}
 
 	if (repo_read_index_unmerged(r) < 0) {
 		ret = error(_("could not read index"));
@@ -131,6 +136,10 @@ reset_head_refs:
 			    oid_to_hex(oid), "1", NULL);
 
 leave_reset_head:
+	if (unpack_tree_opts.dir) {
+		dir_clear(unpack_tree_opts.dir);
+		FREE_AND_NULL(unpack_tree_opts.dir);
+	}
 	strbuf_release(&msg);
 	rollback_lock_file(&lock);
 	clear_unpack_trees_porcelain(&unpack_tree_opts);
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 2412d121ea8..18604360df8 100755
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
index 5786645f315..fcbe63bbed9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1693,6 +1693,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	struct pattern_list pl;
 	int free_pattern_list = 0;
 
+	if (o->reset == UNPACK_RESET_INVALID)
+		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
+
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
@@ -2218,7 +2221,8 @@ static int verify_absent_1(const struct cache_entry *ce,
 	int len;
 	struct stat st;
 
-	if (o->index_only || o->reset || !o->update)
+	if (o->index_only || !o->update ||
+	    o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
 		return 0;
 
 	len = check_leading_path(ce->name, ce_namelen(ce), 0);
diff --git a/unpack-trees.h b/unpack-trees.h
index 2d88b19dca7..1f386fb16cc 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -45,9 +45,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
  */
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
 
+enum unpack_trees_reset_type {
+	UNPACK_RESET_NONE = 0,    /* traditional "false" value; still valid */
+	UNPACK_RESET_INVALID = 1, /* "true" no longer valid; use below values */
+	UNPACK_RESET_PROTECT_UNTRACKED,
+	UNPACK_RESET_OVERWRITE_UNTRACKED
+};
+
 struct unpack_trees_options {
-	unsigned int reset,
-		     merge,
+	unsigned int merge,
 		     update,
 		     clone,
 		     index_only,
@@ -64,6 +70,7 @@ struct unpack_trees_options {
 		     exiting_early,
 		     show_all_errors,
 		     dry_run;
+	enum unpack_trees_reset_type reset;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
gitgitgadget

