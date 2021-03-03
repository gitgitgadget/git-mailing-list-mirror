Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE0C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F2C64E60
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhCDAWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhCCL3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 06:29:31 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F56C06178B
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 03:16:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a24so13837067plm.11
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 03:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9zxswZzBrJdw3j+LB/GgdcHXcouKB533JJR+4GsglE=;
        b=t9xFTgbj32Pg3V9GTod8qx3LzLj1QtKDHBxJwR13ZHTazLRNEW/1QTT1pXiyBUpTaz
         k02DrpPK1GhNmy2nw1vIdDDrRRPt/f/by84fpuJ25KtT3n1V7kblehrPhVntt7Cy9r6Y
         VTlv5CLJshXHRcgsyS2Xg8MhzFd6E72T1/I8VdH3dIS8H+o3GNAUJnVpYxogVHZUvyGi
         dsbsXE0dMTtldmrVVV7hiH93FVw2HX2Ls2oS9OnODExc2LOFXh8o2oGQ+Rdtul/10UGN
         Hods3/uO2zppvQwcjAvwUv9yvFIOUJ0eHognIm/887O+R+I4nvm/ZpgZmMpRlI6CW/4Z
         3Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9zxswZzBrJdw3j+LB/GgdcHXcouKB533JJR+4GsglE=;
        b=k6EhO8xYaHL9nMz1oZI5NMOZOMtCOnUWvFXh92KsrcWq1ZKjy97aJpTCl71citKDtq
         wtic7bkZVEv3a0mR6nPIV8isKA3lz2BPMgY5EgM1jV4G9R70g57xbzHH4etb8pQkOf5g
         HSb7DuTHqaE7s8Ci/5iZopvq5D2g+HJBdn3lwTHQBT3TlFoSKZm/BUhFr1JWNVHkxLpq
         nP3d/u+9K9t10G+jj2ZgMB7W7Djd0vM8iRgH+TNRuocctj1WDw11oLM9vCdJ0kNVdtIj
         u2XMczcIvUldP5pQVsdGGgbYh11Wl/GHlb1pc9g/Z8G+TaF2acCzfVYZuEcMoXicEjr4
         8gWw==
X-Gm-Message-State: AOAM531/cZQjoXNcBsgcT8+zh1OAfDmxY0TjTNs67Bj9dYZU8N5SqwjX
        OkLG08ciSnjX9MMq1Rxnbn/Qi0mD+SA=
X-Google-Smtp-Source: ABdhPJyAO8CfaM704lGx3egn6gpETq1odmhy5/hjsm386IHpERKq5rO8ddWR0lWmgAkX/YE8c7+ZEA==
X-Received: by 2002:a17:90a:8a8b:: with SMTP id x11mr9118155pjn.151.1614770214710;
        Wed, 03 Mar 2021 03:16:54 -0800 (PST)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id d7sm13978175pfh.73.2021.03.03.03.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 03:16:53 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/2] stash show: teach --include-untracked and --only-untracked
Date:   Wed,  3 Mar 2021 03:16:42 -0800
Message-Id: <af3757135bd66a75f89cdd559917073f7235da25.1614770171.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.228.gb75b4e4ce2
In-Reply-To: <cover.1614770171.git.liu.denton@gmail.com>
References: <cover.1613459474.git.liu.denton@gmail.com> <cover.1614770171.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stash entries can be made with untracked files via
`git stash push --include-untracked`. However, because the untracked
files are stored in the third parent of the stash entry and not the
stash entry itself, running `git stash show` does not include the
untracked files as part of the diff.

With --include-untracked, untracked paths, which are recorded in the
third-parent if it exists, are shown in addition to the paths that have
modifications between the stash base and the working tree in the stash.

It is possible to manually craft a malformed stash entry where duplicate
untracked files in the stash entry will mask tracked files. We detect
and error out in that case via a custom unpack_trees() callback:
stash_worktree_untracked_merge().

Also, teach stash the --only-untracked option which only shows the
untracked files of a stash entry. This is similar to `git show stash^3`
but it is nice to provide a convenient abstraction for it so that users
do not have to think about the underlying implementation.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-stash.txt            |  18 +++--
 builtin/stash.c                        |  54 ++++++++++++-
 contrib/completion/git-completion.bash |   2 +-
 t/t3905-stash-include-untracked.sh     | 106 +++++++++++++++++++++++++
 unpack-trees.c                         |  22 +++++
 unpack-trees.h                         |   2 +
 6 files changed, 197 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index f1197d641b..8eeb60feb1 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<log-options>]
-'git stash' show [<diff-options>] [<stash>]
+'git stash' show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
@@ -83,7 +83,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<diff-options>] [<stash>]::
+show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
@@ -160,10 +160,18 @@ up with `git clean`.
 
 -u::
 --include-untracked::
-	This option is only valid for `push` and `save` commands.
+--no-include-untracked::
+	When used with the `push` and `save` commands,
+	all untracked files are also stashed and then cleaned up with
+	`git clean`.
 +
-All untracked files are also stashed and then cleaned up with
-`git clean`.
+When used with the `show` command, show the untracked files in the stash
+entry as part of the diff.
+
+--only-untracked::
+	This option is only valid for the `show` command.
++
+Show only the untracked files in the stash entry as part of the diff.
 
 --index::
 	This option is only valid for `pop` and `apply` commands.
diff --git a/builtin/stash.c b/builtin/stash.c
index 6f2b58f6ab..9b7a541cd0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -787,6 +787,33 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 	return git_diff_basic_config(var, value, cb);
 }
 
+static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
+{
+	const struct object_id *oid[] = { &info->w_commit, &info->u_tree };
+	struct tree *tree[ARRAY_SIZE(oid)];
+	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
+	struct unpack_trees_options unpack_tree_opt = { 0 };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(oid); i++) {
+		tree[i] = parse_tree_indirect(oid[i]);
+		if (parse_tree(tree[i]) < 0)
+			die(_("failed to parse tree"));
+		init_tree_desc(&tree_desc[i], tree[i]->buffer, tree[i]->size);
+	}
+
+	unpack_tree_opt.head_idx = -1;
+	unpack_tree_opt.src_index = &the_index;
+	unpack_tree_opt.dst_index = &the_index;
+	unpack_tree_opt.merge = 1;
+	unpack_tree_opt.fn = stash_worktree_untracked_merge;
+
+	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
+		die(_("failed to unpack trees"));
+
+	do_diff_cache(&info->b_commit, diff_opt);
+}
+
 static int show_stash(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -795,7 +822,18 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct strvec stash_args = STRVEC_INIT;
 	struct strvec revision_args = STRVEC_INIT;
+	enum {
+		UNTRACKED_NONE,
+		UNTRACKED_INCLUDE,
+		UNTRACKED_ONLY
+	} show_untracked = UNTRACKED_NONE;
 	struct option options[] = {
+		OPT_SET_INT('u', "include-untracked", &show_untracked,
+			    N_("include untracked files in the stash"),
+			    UNTRACKED_INCLUDE),
+		OPT_SET_INT_F(0, "only-untracked", &show_untracked,
+			      N_("only show untracked files in the stash"),
+			      UNTRACKED_ONLY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -803,6 +841,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	init_revisions(&rev, prefix);
 
+	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
+
 	strvec_push(&revision_args, argv[0]);
 	for (i = 1; i < argc; i++) {
 		if (argv[i][0] != '-')
@@ -845,7 +887,17 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
 	rev.diffopt.flags.recursive = 1;
 	setup_diff_pager(&rev.diffopt);
-	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+	switch (show_untracked) {
+	case UNTRACKED_NONE:
+		diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+		break;
+	case UNTRACKED_ONLY:
+		diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
+		break;
+	case UNTRACKED_INCLUDE:
+		diff_include_untracked(&info, &rev.diffopt);
+		break;
+	}
 	log_tree_diff_flush(&rev);
 
 	free_stash_info(&info);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4b1f4264a6..64ef6ffa21 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3051,7 +3051,7 @@ _git_stash ()
 			__gitcomp "--name-status --oneline --patch-with-stat"
 			;;
 		show,--*)
-			__gitcomp "$__git_diff_common_options"
+			__gitcomp "--include-untracked --only-untracked $__git_diff_common_options"
 			;;
 		branch,--*)
 			;;
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index b26a97aef4..08ceef6411 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -297,4 +297,110 @@ test_expect_success 'stash -u with globs' '
 	test_path_is_missing untracked.txt
 '
 
+test_expect_success 'stash show --include-untracked shows untracked files' '
+	git reset --hard &&
+	git clean -xf &&
+	>untracked &&
+	>tracked &&
+	git add tracked &&
+	empty_blob_oid=$(git rev-parse --short :tracked) &&
+	git stash -u &&
+
+	cat >expect <<-EOF &&
+	 tracked   | 0
+	 untracked | 0
+	 2 files changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git stash show --include-untracked >actual &&
+	test_cmp expect actual &&
+	git stash show -u >actual &&
+	test_cmp expect actual &&
+	git stash show --no-include-untracked --include-untracked >actual &&
+	test_cmp expect actual &&
+	git stash show --only-untracked --include-untracked >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+	diff --git a/tracked b/tracked
+	new file mode 100644
+	index 0000000..$empty_blob_oid
+	diff --git a/untracked b/untracked
+	new file mode 100644
+	index 0000000..$empty_blob_oid
+	EOF
+	git stash show -p --include-untracked >actual &&
+	test_cmp expect actual &&
+	git stash show --include-untracked -p >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash show --only-untracked only shows untracked files' '
+	git reset --hard &&
+	git clean -xf &&
+	>untracked &&
+	>tracked &&
+	git add tracked &&
+	empty_blob_oid=$(git rev-parse --short :tracked) &&
+	git stash -u &&
+
+	cat >expect <<-EOF &&
+	 untracked | 0
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git stash show --only-untracked >actual &&
+	test_cmp expect actual &&
+	git stash show --no-include-untracked --only-untracked >actual &&
+	test_cmp expect actual &&
+	git stash show --include-untracked --only-untracked >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+	diff --git a/untracked b/untracked
+	new file mode 100644
+	index 0000000..$empty_blob_oid
+	EOF
+	git stash show -p --only-untracked >actual &&
+	test_cmp expect actual &&
+	git stash show --only-untracked -p >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash show --no-include-untracked cancels --{include,show}-untracked' '
+	git reset --hard &&
+	git clean -xf &&
+	>untracked &&
+	>tracked &&
+	git add tracked &&
+	git stash -u &&
+
+	cat >expect <<-EOF &&
+	 tracked | 0
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git stash show --only-untracked --no-include-untracked >actual &&
+	test_cmp expect actual &&
+	git stash show --include-untracked --no-include-untracked >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash show --include-untracked errors on duplicate files' '
+	git reset --hard &&
+	git clean -xf &&
+	>tracked &&
+	git add tracked &&
+	tree=$(git write-tree) &&
+	i_commit=$(git commit-tree -p HEAD -m "index on any-branch" "$tree") &&
+	test_when_finished "rm -f untracked_index" &&
+	u_commit=$(
+		GIT_INDEX_FILE="untracked_index" &&
+		export GIT_INDEX_FILE &&
+		git update-index --add tracked &&
+		u_tree=$(git write-tree) &&
+		git commit-tree -m "untracked files on any-branch" "$u_tree"
+	) &&
+	w_commit=$(git commit-tree -p HEAD -p "$i_commit" -p "$u_commit" -m "WIP on any-branch" "$tree") &&
+	test_must_fail git stash show --include-untracked "$w_commit" 2>err &&
+	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index af6e9b9c2f..dde8c320c5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2566,3 +2566,25 @@ int oneway_merge(const struct cache_entry * const *src,
 	}
 	return merged_entry(a, old, o);
 }
+
+/*
+ * Merge worktree and untracked entries in a stash entry.
+ *
+ * Ignore all index entries. Collapse remaining trees but make sure that they
+ * don't have any conflicting files.
+ */
+int stash_worktree_untracked_merge(const struct cache_entry * const *src,
+				   struct unpack_trees_options *o)
+{
+	const struct cache_entry *worktree = src[1];
+	const struct cache_entry *untracked = src[2];
+
+	if (o->merge_size != 2)
+		BUG("invalid merge_size: %d", o->merge_size);
+
+	if (worktree && untracked)
+		return error(_("worktree and untracked commit have duplicate entries: %s"),
+			     super_prefixed(worktree->name));
+
+	return merged_entry(worktree ? worktree : untracked, NULL, o);
+}
diff --git a/unpack-trees.h b/unpack-trees.h
index 2e87875b15..2d88b19dca 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -114,5 +114,7 @@ int bind_merge(const struct cache_entry * const *src,
 	       struct unpack_trees_options *o);
 int oneway_merge(const struct cache_entry * const *src,
 		 struct unpack_trees_options *o);
+int stash_worktree_untracked_merge(const struct cache_entry * const *src,
+				   struct unpack_trees_options *o);
 
 #endif
-- 
2.31.0.rc1.228.gb75b4e4ce2

