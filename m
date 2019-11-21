Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA75C43215
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCED8206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1AJzlLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKUWFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35826 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKUWFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so5496840wmo.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qvP7nsMmPV7mOGwJ1al5h9COXtfc1yRa2KCmKVgUN6M=;
        b=X1AJzlLDGL1gv5p2WbfI3EOXi+434MiGt0FjYF0GoLRevtLdOkhIBxojdmeq6LEEDN
         60VMqFA9WtjWAOOhYRsgXCMQpQDcrI8izF13bdaGRupq8ggziJ2PMgyFyfDVtGF+5qyq
         vllAroQnIk7djIroRvH7IXFa1eC8htdpXnEPksJAe6hUQd6DBNexKgayyjs35YU3A6pM
         Or6gYtlbndEzTyKNsibkKzDdqTDO/HTPtYpCTCHgs1Qd0oViLI7luM7sn72b/PcfWcVR
         5tDtDfbPnWaQhpILvPeVDkbQh8YTLHtcaFTmd6QMyvRdLZgQ2q3Qp10vwpdfYwfW1tjF
         /PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qvP7nsMmPV7mOGwJ1al5h9COXtfc1yRa2KCmKVgUN6M=;
        b=A3VXUMh6aN4jWGAlvrE3qg4zZUO7XhwPw975AUy5jUz84lp632KbEFMQStxEB3bC1d
         0xVgm6PTsEFh3nQrUnygf3F8xyO7rX1oscTWmJ+5Bxkn0LXna/YH0j7BMfqpNiTIGEJV
         60Su/6E3h46d9e3x7XEhlkxCsaQ799R+Wl2PuOIZorn1Oz8q4lQn0lqA7WV2Ul+xocgI
         eIB1hEbFmveW4Pws1BY6DMRCDcLN5MsYnpQya1WwmqFHYx2LW8+Le91uUEhH2iJGkjxq
         lcj6+TcdEqmau1je/FfJL1BMwWrD7wJS01hgmjsUzzlIomEG8NcNqnGn4HemDI1CXA8B
         A1RQ==
X-Gm-Message-State: APjAAAVJ8sge6m0TYm2q5PHWh0a1gZGYIYmQ0RX0kaPfipb85FWY/X7l
        aG/OB0y9Uusccpr7h7rhs7di0si1
X-Google-Smtp-Source: APXvYqwRZu1Nq/ohX98bNvqutEPPfqzdK/A26E3RObWPbTI95BlOC/ciymKNb/3urm7gf2TxHI4R8w==
X-Received: by 2002:a1c:e308:: with SMTP id a8mr12946844wmh.55.1574373913056;
        Thu, 21 Nov 2019 14:05:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm4706982wru.32.2019.11.21.14.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:12 -0800 (PST)
Message-Id: <63e01c202162689e5b8c9adff8ce140219a0bebe.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:46 +0000
Subject: [PATCH v6 14/19] sparse-checkout: update working directory in-process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-checkout builtin used 'git read-tree -mu HEAD' to update the
skip-worktree bits in the index and to update the working directory.
This extra process is overly complex, and prone to failure. It also
requires that we write our changes to the sparse-checkout file before
trying to update the index.

Remove this extra process call by creating a direct call to
unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
addition, provide an in-memory list of patterns so we can avoid
reading from the sparse-checkout file. This allows us to test a
proposed change to the file before writing to it.

An earlier version of this patch included a bug when the 'set' command
failed due to the "Sparse checkout leaves no entry on working directory"
error. It would not rollback the index.lock file, so the replay of the
old sparse-checkout specification would fail. A test in t1091 now
covers that scenario.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/read-tree.c                |  2 +-
 builtin/sparse-checkout.c          | 83 +++++++++++++++++++++++++-----
 t/t1091-sparse-checkout-builtin.sh | 28 ++++++++++
 unpack-trees.c                     |  5 +-
 unpack-trees.h                     |  3 +-
 5 files changed, 105 insertions(+), 16 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ca5e655d2f..af7424b94c 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -185,7 +185,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 
 	if (opts.reset || opts.merge || opts.prefix) {
 		if (read_cache_unmerged() && (opts.prefix || opts.merge))
-			die("You need to resolve your current index first");
+			die(_("You need to resolve your current index first"));
 		stage = opts.merge = 1;
 	}
 	resolve_undo_clear();
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 55b337ad8e..a5d32e4702 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -7,6 +7,11 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "cache.h"
+#include "cache-tree.h"
+#include "lockfile.h"
+#include "resolve-undo.h"
+#include "unpack-trees.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout (init|list|set|disable) <options>"),
@@ -60,18 +65,54 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
-static int update_working_directory(void)
+static int update_working_directory(struct pattern_list *pl)
 {
-	struct argv_array argv = ARGV_ARRAY_INIT;
 	int result = 0;
-	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
+	struct unpack_trees_options o;
+	struct lock_file lock_file = LOCK_INIT;
+	struct object_id oid;
+	struct tree *tree;
+	struct tree_desc t;
+	struct repository *r = the_repository;
 
-	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-		error(_("failed to update index with new sparse-checkout patterns"));
-		result = 1;
-	}
+	if (repo_read_index_unmerged(r))
+		die(_("you need to resolve your current index first"));
+
+	if (get_oid("HEAD", &oid))
+		return 0;
+
+	tree = parse_tree_indirect(&oid);
+	parse_tree(tree);
+	init_tree_desc(&t, tree->buffer, tree->size);
+
+	memset(&o, 0, sizeof(o));
+	o.verbose_update = isatty(2);
+	o.merge = 1;
+	o.update = 1;
+	o.fn = oneway_merge;
+	o.head_idx = -1;
+	o.src_index = r->index;
+	o.dst_index = r->index;
+	o.skip_sparse_checkout = 0;
+	o.pl = pl;
+	o.keep_pattern_list = !!pl;
+
+	resolve_undo_clear_index(r->index);
+	setup_work_tree();
+
+	cache_tree_free(&r->index->cache_tree);
+
+	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
+
+	core_apply_sparse_checkout = 1;
+	result = unpack_trees(1, &t, &o);
+
+	if (!result) {
+		prime_cache_tree(r, r->index, tree);
+		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
+	} else
+		rollback_lock_file(&lock_file);
 
-	argv_array_clear(&argv);
 	return result;
 }
 
@@ -129,6 +170,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
+	int result;
+
+	result = update_working_directory(pl);
+
+	if (result) {
+		clear_pattern_list(pl);
+		update_working_directory(NULL);
+		return result;
+	}
 
 	sparse_filename = get_sparse_checkout_filename();
 	fp = fopen(sparse_filename, "w");
@@ -139,9 +189,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		write_patterns_to_file(fp, pl);
 
 	fclose(fp);
+
 	free(sparse_filename);
+	clear_pattern_list(pl);
 
-	return update_working_directory();
+	return 0;
 }
 
 enum sparse_checkout_mode {
@@ -199,7 +251,11 @@ static int sparse_checkout_init(int argc, const char **argv)
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
-	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
+	if (init_opts.cone_mode) {
+		mode = MODE_CONE_PATTERNS;
+		core_sparse_checkout_cone = 1;
+	} else
+		mode = MODE_ALL_PATTERNS;
 
 	if (set_config(mode))
 		return 1;
@@ -230,7 +286,8 @@ static int sparse_checkout_init(int argc, const char **argv)
 	}
 
 reset_dir:
-	return update_working_directory();
+	core_apply_sparse_checkout = 1;
+	return update_working_directory(NULL);
 }
 
 static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
@@ -311,6 +368,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 
 		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+		pl.use_cone_patterns = 1;
 
 		if (set_opts.use_stdin) {
 			while (!strbuf_getline(&line, stdin))
@@ -365,7 +423,8 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	fprintf(fp, "/*\n");
 	fclose(fp);
 
-	if (update_working_directory())
+	core_apply_sparse_checkout = 1;
+	if (update_working_directory(NULL))
 		die(_("error while refreshing working directory"));
 
 	unlink(sparse_filename);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b88d08da98..53aeb5980f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -248,4 +248,32 @@ test_expect_success 'cone mode: set with nested folders' '
 	test_cmp repo/.git/info/sparse-checkout expect
 '
 
+test_expect_success 'revert to old sparse-checkout on bad update' '
+	echo update >repo/deep/deeper2/a &&
+	cp repo/.git/info/sparse-checkout expect &&
+	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
+	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_cmp repo/.git/info/sparse-checkout expect &&
+	ls repo/deep >dir &&
+	cat >expect <<-EOF &&
+		a
+		deeper1
+		deeper2
+	EOF
+	test_cmp dir expect
+'
+
+test_expect_success 'revert to old sparse-checkout on empty update' '
+	git init empty-test &&
+	(
+		echo >file &&
+		git add file &&
+		git commit -m "test" &&
+		test_must_fail git sparse-checkout set nothing 2>err &&
+		test_i18ngrep "Sparse checkout leaves no entry on working directory" err &&
+		test_i18ngrep ! ".git/index.lock" err &&
+		git sparse-checkout set file
+	)
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 8bb684ad62..3789a22cf0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1511,7 +1511,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	memset(&pl, 0, sizeof(pl));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
-	if (!o->skip_sparse_checkout) {
+	if (!o->skip_sparse_checkout && !o->pl) {
 		char *sparse = git_pathdup("info/sparse-checkout");
 		pl.use_cone_patterns = core_sparse_checkout_cone;
 		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
@@ -1684,7 +1684,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 done:
 	trace_performance_leave("unpack_trees");
-	clear_pattern_list(&pl);
+	if (!o->keep_pattern_list)
+		clear_pattern_list(&pl);
 	return ret;
 
 return_failed:
diff --git a/unpack-trees.h b/unpack-trees.h
index f2eee0c7c5..ca94a421a5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -59,7 +59,8 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
-		     dry_run;
+		     dry_run,
+		     keep_pattern_list;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
gitgitgadget

