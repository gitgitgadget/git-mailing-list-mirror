Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E06A20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeLIUFI (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:08 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36381 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLIUFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:08 -0500
Received: by mail-wm1-f42.google.com with SMTP id a18so9200793wmj.1
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkfU/TST0+geI2UyE/TLePkOtM0QnqXboBVUDlASKTc=;
        b=Iq/VxzNeAZJZ4gKDjEgXcmUw8hQruzr6/isJ/q8a+gFqken31uMCKKivpS+j2KSqAi
         3XqAkg9QDiH3iYLupDWlX8UbLbc4pTbEvDXvIZgfOHMPrBNMJpjxUDUi3XKB/awkuj++
         w/A4Iy1ABbwoTVwW4uuyaNSmTuHf575z0enPngX5VifFbXH7QOsjplj/lrAfNFzKrm2F
         09w/whfFyr+gmwNYefBNBA4fVTG+I5ro2PqfPhIE6KwjCFGOm92lV7KYo6czoDG9gy1a
         JcYMKcumMRNhmHghk2DfTb28dyjLujqNiag8d6CkuHG2izVISUVeHBMIhvj8XijM5Xjr
         f7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkfU/TST0+geI2UyE/TLePkOtM0QnqXboBVUDlASKTc=;
        b=DCtPHxyTfcsrWNqArjlFs4yppAHgklIeEx41Gg/t97LNqj/Yjl2Fx8M7KrXIkvwUfr
         Yi3svuhhwTQ0nexhsbHpYe+fhQEgDDhIp2D0O+2Qo0aIY8jMis8vxt3ANQOACi4LbNGK
         Xvm4oafjdbuAw2KGFA8zwJQVbUeq1xDBv212/Q+kFaJtotXpcXiPK91yu0qUXCnZB/OL
         uWLUPc13TC+eCWOBpUeJtfesLrXMlCFem2N1ysXLDRZWMWJdKmQdzkCCu+P0QdZHdT3M
         m+96DaYhGF4je6UbymLwnqaHU0u/qqQ42eWYUChSmoF4vR/73zoRRzRrTck54sLdCutV
         wM7A==
X-Gm-Message-State: AA+aEWbmjuiB4WA+2KxGzL74HzBR6OaoXrbQ720W34hpFO3KMxIKYryo
        Ilco46a6Te51JBAqr6gDWIXOMFeH
X-Google-Smtp-Source: AFSGD/Xr+0byi4GyV7iv/RPzNshw7E/GxKvqpAbbvlQb30BMlHFuvud8/hR3wLbcJ9PMSSKsLXVCGw==
X-Received: by 2002:a1c:3ed0:: with SMTP id l199mr7721379wma.34.1544385904367;
        Sun, 09 Dec 2018 12:05:04 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id e12sm21227851wmf.22.2018.12.09.12.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:05:03 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 5/8] checkout: introduce --{,no-}overlay option
Date:   Sun,  9 Dec 2018 20:04:46 +0000
Message-Id: <20181209200449.16342-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git checkout' is defined as an overlay operation, which
means that if in 'git checkout <tree-ish> -- [<pathspec>]' we have an
entry in the index that matches <pathspec>, but that doesn't exist in
<tree-ish>, that entry will not be removed from the index or the
working tree.

Introduce a new --{,no-}overlay option, which allows using 'git
checkout' in non-overlay mode, thus removing files from the working
tree if they do not exist in <tree-ish> but match <pathspec>.

Note that 'git checkout -p <tree-ish> -- [<pathspec>]' already works
this way, so no changes are needed for the patch mode.  We disallow
'git checkout --overlay -p' to avoid confusing users who would expect
to be able to force overlay mode in 'git checkout -p' this way.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/checkout.c             | 64 +++++++++++++++++++++++++++-------
 t/t2025-checkout-no-overlay.sh | 47 +++++++++++++++++++++++++
 t/t9902-completion.sh          |  1 +
 3 files changed, 99 insertions(+), 13 deletions(-)
 create mode 100755 t/t2025-checkout-no-overlay.sh

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..0aef35bbc4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -44,6 +44,7 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	int overlay_mode;
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -132,7 +133,8 @@ static int skip_same_name(const struct cache_entry *ce, int pos)
 	return pos;
 }
 
-static int check_stage(int stage, const struct cache_entry *ce, int pos)
+static int check_stage(int stage, const struct cache_entry *ce, int pos,
+		       int overlay_mode)
 {
 	while (pos < active_nr &&
 	       !strcmp(active_cache[pos]->name, ce->name)) {
@@ -140,6 +142,8 @@ static int check_stage(int stage, const struct cache_entry *ce, int pos)
 			return 0;
 		pos++;
 	}
+	if (!overlay_mode)
+		return 0;
 	if (stage == 2)
 		return error(_("path '%s' does not have our version"), ce->name);
 	else
@@ -165,7 +169,7 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 }
 
 static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
-			  const struct checkout *state)
+			  const struct checkout *state, int overlay_mode)
 {
 	while (pos < active_nr &&
 	       !strcmp(active_cache[pos]->name, ce->name)) {
@@ -173,6 +177,10 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 			return checkout_entry(active_cache[pos], state, NULL);
 		pos++;
 	}
+	if (!overlay_mode) {
+		unlink_entry(ce);
+		return 0;
+	}
 	if (stage == 2)
 		return error(_("path '%s' does not have our version"), ce->name);
 	else
@@ -302,15 +310,29 @@ static int checkout_paths(const struct checkout_opts *opts,
 		ce->ce_flags &= ~CE_MATCHED;
 		if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
 			continue;
-		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
-			/*
-			 * "git checkout tree-ish -- path", but this entry
-			 * is in the original index; it will not be checked
-			 * out to the working tree and it does not matter
-			 * if pathspec matched this entry.  We will not do
-			 * anything to this entry at all.
-			 */
-			continue;
+		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE)) {
+			if (!opts->overlay_mode &&
+			    ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
+				/*
+				 * "git checkout --no-overlay <tree-ish> -- path",
+				 * and the path is not in tree-ish, but is in
+				 * the current index, which means that it should 
+				 * be removed.
+				 */
+				ce->ce_flags |= CE_MATCHED | CE_REMOVE | CE_WT_REMOVE;
+				continue;
+			} else {
+				/*
+				 * "git checkout tree-ish -- path", but this
+				 * entry is in the original index; it will not
+				 * be checked out to the working tree and it
+				 * does not matter if pathspec matched this
+				 * entry.  We will not do anything to this entry
+				 * at all.
+				 */
+				continue;
+			}
+		}
 		/*
 		 * Either this entry came from the tree-ish we are
 		 * checking the paths out of, or we are checking out
@@ -348,7 +370,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			if (opts->force) {
 				warning(_("path '%s' is unmerged"), ce->name);
 			} else if (opts->writeout_stage) {
-				errs |= check_stage(opts->writeout_stage, ce, pos);
+				errs |= check_stage(opts->writeout_stage, ce, pos, opts->overlay_mode);
 			} else if (opts->merge) {
 				errs |= check_stages((1<<2) | (1<<3), ce, pos);
 			} else {
@@ -375,12 +397,14 @@ static int checkout_paths(const struct checkout_opts *opts,
 				continue;
 			}
 			if (opts->writeout_stage)
-				errs |= checkout_stage(opts->writeout_stage, ce, pos, &state);
+				errs |= checkout_stage(opts->writeout_stage, ce, pos, &state, opts->overlay_mode);
 			else if (opts->merge)
 				errs |= checkout_merged(pos, &state);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+	remove_marked_cache_entries(&the_index, 1);
+	remove_scheduled_dirs();
 	errs |= finish_delayed_checkout(&state);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
@@ -542,6 +566,11 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 * opts->show_progress only impacts output so doesn't require a merge
 	 */
 
+	/*
+	 * opts->overlay_mode cannot be used with switching branches so is
+	 * not tested here
+	 */
+
 	/*
 	 * If we aren't creating a new branch any changes or updates will
 	 * happen in the existing branch.  Since that could only be updating
@@ -1178,6 +1207,10 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("'%s' cannot be used with switching branches"),
 		    "--patch");
 
+	if (!opts->overlay_mode)
+		die(_("'%s' cannot be used with switching branches"),
+		    "--no-overlay");
+
 	if (opts->writeout_stage)
 		die(_("'%s' cannot be used with switching branches"),
 		    "--ours/--theirs");
@@ -1266,6 +1299,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END(),
 	};
 
@@ -1274,6 +1308,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
 	opts.show_progress = -1;
+	opts.overlay_mode = -1;
 
 	git_config(git_checkout_config, &opts);
 
@@ -1297,6 +1332,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
+	if (opts.overlay_mode == 1 && opts.patch_mode)
+		die(_("-p and --overlay are mutually exclusive"));
+
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
 	 * and new_branch_force and new_orphan_branch will tell us which one of
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
new file mode 100755
index 0000000000..3575321382
--- /dev/null
+++ b/t/t2025-checkout-no-overlay.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='checkout --no-overlay <tree-ish> -- <pathspec>'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m "initial"
+'
+
+test_expect_success 'checkout --no-overlay deletes files not in <tree>' '
+	>file &&
+	mkdir dir &&
+	>dir/file1 &&
+	git add file dir/file1 &&
+	git checkout --no-overlay HEAD -- file &&
+	test_path_is_missing file &&
+	test_path_is_file dir/file1
+'
+
+test_expect_success 'checkout --no-overlay removing last file from directory' '
+	git checkout --no-overlay HEAD -- dir/file1 &&
+	test_path_is_missing dir
+'
+
+test_expect_success 'checkout -p --overlay is disallowed' '
+	test_must_fail git checkout -p --overlay HEAD 2>actual &&
+	test_i18ngrep "fatal: -p and --overlay are mutually exclusive" actual
+'
+
+test_expect_success '--no-overlay --theirs with M/D conflict deletes file' '
+	test_commit file1 file1 &&
+	test_commit file2 file2 &&
+	git rm --cached file1 &&
+	echo 1234 >file1 &&
+	F1=$(git rev-parse HEAD:file1) &&
+	F2=$(git rev-parse HEAD:file2) &&
+	{
+		echo "100644 $F1 1	file1" &&
+		echo "100644 $F2 2	file1"
+	} | git update-index --index-info &&
+	test_path_is_file file1 &&
+	git checkout --theirs --no-overlay -- file1 &&
+	test_path_is_missing file1
+'
+
+test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 175f83d704..a3fd9a9630 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1436,6 +1436,7 @@ test_expect_success 'double dash "git checkout"' '
 	--progress Z
 	--no-quiet Z
 	--no-... Z
+	--overlay Z
 	EOF
 '
 
-- 
2.20.0.405.gbc1bbc6f85

