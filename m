Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE971F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbeLTNsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33489 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733301AbeLTNsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so11989650wmh.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/5Ib34ZjsPPVw4A2+2wsnGBAkRh1hGbhpky49QPZbs=;
        b=WN4kdj6Oi9+Ur8m3ddrYp6T71AoqBDsvfZlUcbQ5sGIVTOurqBxQglYkJlMg/XmFoa
         B76EDaJnlp1nrTtTnsD2Bbm08jMP5Bt/WU4/bc3KH9Ses5cMu5qv99FvbTeiYkuY6bm4
         Q0MHuEHe9mh7Xel5wFp/Pv2Y7WpScxj+tdYl2C2df2KSzmCSLNO4qkxQcmlSF0G0Ocbw
         yAgmbYXIm4aTS/FUwlGqWpqKJE7X7eJwscUvzIRm9CSHkf2fix1wlNCNUfg03olOenOE
         IMnTar14ucpfKDzL3JgBxZeRDFQIMo6iCzSDtWCOcQ09wIIm3GVsYGm+fSMIr7jMW3MH
         yUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/5Ib34ZjsPPVw4A2+2wsnGBAkRh1hGbhpky49QPZbs=;
        b=UMop7uMeDuiiWqesVZ1Bv0vg2EWT1t5R+CzWpDBi+5d+X0gz7zNTOikQy9zOJVyYTL
         LRJCU3hayE+rsWh094cDjJAE+u7ahXUe5LicBZNxj2UDn6RKFQeCmDYKa4giS4BXXigg
         ycmqgK8FysnttcExaC4LMgfFMmdGnVHOIn2AmlkiYEQsjB0xE5qSNkfx1/FfO5Pn42Pn
         YzERWME4GEUMGSxYZXloM7OIoRUbkOK4HTlj7PBzvSCP1TXkOSUI22NEbsdA9uriehAb
         +NLKwBJgahq81IWr79dV2OfYSNCrrZg3RU1BttqINqoSU0HsldTaC52vDCrFOzQLog9K
         rDMg==
X-Gm-Message-State: AA+aEWawD18oolayMO9jcFzccjgGibUrSTX0euoE7YXfwEHdCT72CDFO
        j192Vci6s0lzs51U+DaaGYoN0odz3YU=
X-Google-Smtp-Source: AFSGD/XJzs2S9rJ9oXAtklSpIWwpMHS+JBmkcxO/gv2gD3V/g+WIWeMXC4mwCX6nTlzDnXRNOXpP8w==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr11648117wmu.81.1545313728027;
        Thu, 20 Dec 2018 05:48:48 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id v6sm7813577wro.57.2018.12.20.05.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:47 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 7/8] checkout: introduce --{,no-}overlay option
Date:   Thu, 20 Dec 2018 13:48:19 +0000
Message-Id: <20181220134820.21810-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
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

Untracked files are not affected by this change, so 'git checkout
--no-overlay HEAD -- untracked' will not remove untracked from the
working tree.  This is so e.g. 'git checkout --no-overlay HEAD -- dir/'
doesn't delete all untracked files in dir/, but rather just resets the
state of files that are known to git.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-checkout.txt | 10 ++++++
 builtin/checkout.c             | 66 +++++++++++++++++++++++++++++-----
 t/t2025-checkout-no-overlay.sh | 47 ++++++++++++++++++++++++
 t/t9902-completion.sh          |  1 +
 4 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100755 t/t2025-checkout-no-overlay.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 801de2f764..4ac8c55865 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -260,6 +260,9 @@ the conflicted merge in the specified paths.
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
++
+Note that this option uses the no overlay mode by default (see also
+-`--[no-]overlay`), and currently doesn't support overlay mode.
 
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted ref is already checked
@@ -276,6 +279,13 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	Just like linkgit:git-submodule[1], this will detach the
 	submodules HEAD.
 
+--[no-]overlay::
+	In the default overlay mode files `git checkout` never
+	removes files from the index or the working tree.  When
+	specifying --no-overlay, files that appear in the index and
+	working tree, but not in <tree-ish> are removed, to make them
+	match <tree-ish> exactly.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 32c4b7f897..0c5fe948ef 100644
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
@@ -247,9 +255,9 @@ static int checkout_merged(int pos, const struct checkout *state)
 	return status;
 }
 
-static void mark_ce_for_checkout(struct cache_entry *ce,
-				 char *ps_matched,
-				 const struct checkout_opts *opts)
+static void mark_ce_for_checkout_overlay(struct cache_entry *ce,
+					 char *ps_matched,
+					 const struct checkout_opts *opts)
 {
 	ce->ce_flags &= ~CE_MATCHED;
 	if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
@@ -281,6 +289,25 @@ static void mark_ce_for_checkout(struct cache_entry *ce,
 		ce->ce_flags |= CE_MATCHED;
 }
 
+static void mark_ce_for_checkout_no_overlay(struct cache_entry *ce,
+					    char *ps_matched,
+					    const struct checkout_opts *opts)
+{
+	ce->ce_flags &= ~CE_MATCHED;
+	if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
+		return;
+	if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
+		ce->ce_flags |= CE_MATCHED;
+		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
+			/*
+			 * In overlay mode, but the path is not in
+			 * tree-ish, which means we should remove it
+			 * from the index and the working tree.
+			 */
+			ce->ce_flags |= CE_REMOVE | CE_WT_REMOVE;
+	}
+}
+
 static int checkout_paths(const struct checkout_opts *opts,
 			  const char *revision)
 {
@@ -332,7 +359,14 @@ static int checkout_paths(const struct checkout_opts *opts,
 	 * to be checked out.
 	 */
 	for (pos = 0; pos < active_nr; pos++)
-		mark_ce_for_checkout(active_cache[pos], ps_matched, opts);
+		if (opts->overlay_mode)
+			mark_ce_for_checkout_overlay(active_cache[pos],
+						     ps_matched,
+						     opts);
+		else
+			mark_ce_for_checkout_no_overlay(active_cache[pos],
+							ps_matched,
+							opts);
 
 	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
 		free(ps_matched);
@@ -353,7 +387,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			if (opts->force) {
 				warning(_("path '%s' is unmerged"), ce->name);
 			} else if (opts->writeout_stage) {
-				errs |= check_stage(opts->writeout_stage, ce, pos);
+				errs |= check_stage(opts->writeout_stage, ce, pos, opts->overlay_mode);
 			} else if (opts->merge) {
 				errs |= check_stages((1<<2) | (1<<3), ce, pos);
 			} else {
@@ -380,12 +414,14 @@ static int checkout_paths(const struct checkout_opts *opts,
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
@@ -547,6 +583,11 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
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
@@ -1183,6 +1224,10 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("'%s' cannot be used with switching branches"),
 		    "--patch");
 
+	if (!opts->overlay_mode)
+		die(_("'%s' cannot be used with switching branches"),
+		    "--no-overlay");
+
 	if (opts->writeout_stage)
 		die(_("'%s' cannot be used with switching branches"),
 		    "--ours/--theirs");
@@ -1271,6 +1316,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_END(),
 	};
 
@@ -1279,6 +1325,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
 	opts.show_progress = -1;
+	opts.overlay_mode = -1;
 
 	git_config(git_checkout_config, &opts);
 
@@ -1302,6 +1349,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
index 0000000000..76330cb5ab
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
+test_expect_success 'checkout --no-overlay deletes files not in <tree-ish>' '
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
+test_expect_success '--no-overlay --theirs with D/F conflict deletes file' '
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
index d01ad8eb25..5758fffa0d 100755
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
2.20.1.415.g653613c723

