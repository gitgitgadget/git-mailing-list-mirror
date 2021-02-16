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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA7C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31EF64DFF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBPHM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 02:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBPHM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 02:12:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A58C061756
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 23:12:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id kr16so480442pjb.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 23:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmDIkfImfLkzNa4DPlC184YUWcC3H/0YIUkBrTmKBUs=;
        b=ZspmKrbsAM7tIw1dgJTHrQSd6Jmcx8Alehtc/JiUngXCKZU4rivctIAgGPKbLZtpkO
         QdpMKuu2fVjm97K+9CylDeyD0gSMiTcsPBGcP5a4LlRk423hgpYuktmKWiCJ0Vaqzeak
         isOPE9NEBcvnaY4Pmc2DBbmTgF0NrQAiTkNRZgdCToRreteti+eLhh3r9ij6M2qNM7di
         SIc/oNBGXCEV0nUjkbjVkuDhSPRnt7viJizW6ICMXPHnnVWvB+iOu78Vw+9skk7A/36X
         GSew2hEak3jT4ojgN9D0Mm3Edqf0GAKyUXR+XGKkTexd8YNH5UYuBeUTcq+umN72d1GC
         zE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmDIkfImfLkzNa4DPlC184YUWcC3H/0YIUkBrTmKBUs=;
        b=twNk1yoR0g8iqOzxItugyTPWjPIcH7he62qxqm8dnZZxA43tHVqaPwvYYv0Ow7k9L1
         3N2WjmgFIwM1VKtX9jt+CyVYAGGtv/Dp2gc7oGQrrujijK56sfkXkoFJcDsEigrH3PuM
         c4his96QiVb+gBc77RkjM/GRTAssyLXQUGeuzxjxD3EH0Asf6MbKy/LrUnh6r3pyIn+J
         /xWI3z+Z+euJ7lxygqSIjE1KDJjIIbFS2q/XEGFdzxvUB+IlBF5z8bMERzA6I+k0G0Ed
         yEDB1DhRJA6HmtBEiQxCFG6qBe7onJVapCMCHFQwF4EbU+aSMb/kxrOPcMA/dURntYvv
         oMjQ==
X-Gm-Message-State: AOAM533LsH6iGJepP5T1e6bbGjkYefS9Tsjbjy569Sy9HUljTqTmgC6Y
        bRJohnCnQE9ppnvStN7niJGWgEqP8wk=
X-Google-Smtp-Source: ABdhPJxGy8XbxRX/m3ibciU66OkGAs7B6fPgmQXGtAYyX3Iszx96epR5gSYPNehVPTWaaOYsw6G7Bg==
X-Received: by 2002:a17:90b:4a8c:: with SMTP id lp12mr2852746pjb.214.1613459535673;
        Mon, 15 Feb 2021 23:12:15 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id d133sm20025278pfd.6.2021.02.15.23.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 23:12:15 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/2] stash show: teach --include-untracked and --only-untracked
Date:   Mon, 15 Feb 2021 23:11:56 -0800
Message-Id: <85b81f2f06bd1b40ee2de220cc84dd74b425daf3.1613459475.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1613459474.git.liu.denton@gmail.com>
References: <cover.1612855690.git.liu.denton@gmail.com> <cover.1613459474.git.liu.denton@gmail.com>
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

One limitation of this is that it would be possible to manually craft a
stash entry where duplicate untracked files in the stash entry will mask
tracked files. This seems like an instance of "Doctor, it hurts when I
do this! So don't do that!" so this can be written off.

Also, teach stash the --only-untracked option which only shows the
untracked files of a stash entry. This is similar to `git show stash^3`
but it is nice to provide a convenient abstraction for it so that users
do not have to think about the underlying implementation.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    I am not familiar with the read-tree code so this attempt at replicating
    the read-tree code may in diff_include_untracked() may be incorrect
    (particularly the use of the_index?).
    
    Also, I could not figure out how to make unpack_trees() error out in the
    case where untracked tree entry contains duplicate entries with the
    worktree entry.

 Documentation/git-stash.txt            | 18 ++++--
 builtin/stash.c                        | 53 +++++++++++++++-
 contrib/completion/git-completion.bash |  2 +-
 t/t3905-stash-include-untracked.sh     | 84 ++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 7 deletions(-)

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
index 6f2b58f6ab..417ed2b4a1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -787,6 +787,32 @@ static int git_stash_config(const char *var, const char *value, void *cb)
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
+	unpack_tree_opt.fn = twoway_merge;
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
@@ -795,7 +821,18 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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
 
@@ -803,6 +840,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	init_revisions(&rev, prefix);
 
+	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
+
 	strvec_push(&revision_args, argv[0]);
 	for (i = 1; i < argc; i++) {
 		if (argv[i][0] != '-')
@@ -845,7 +886,17 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
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
index b26a97aef4..978bc97baf 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -297,4 +297,88 @@ test_expect_success 'stash -u with globs' '
 	test_path_is_missing untracked.txt
 '
 
+test_expect_success 'stash show --include-untracked shows untracked files' '
+	git reset --hard &&
+	git clean -xf &&
+	>untracked &&
+	>tracked &&
+	git add tracked &&
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
+	index 0000000..e69de29
+	diff --git a/untracked b/untracked
+	new file mode 100644
+	index 0000000..e69de29
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
+	index 0000000..e69de29
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
 test_done
-- 
2.30.0.478.g8a0d178c01

