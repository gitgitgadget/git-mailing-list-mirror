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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6727C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7DE64EBE
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhBIHbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhBIHag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:30:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19442C0617A7
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d13so9269226plg.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REnViNvTDqX6po4FJ2W8C049KBED9Iv0K3XEnhuO300=;
        b=FK8nyThILkC8GWW8wXIlmt/yJrGy5dehxINXOFaQY2HRP/c41WHbT6MYY5x0CNpV+C
         /xNo68p0evR5QPh17wl1gYKqEsQqFSYNyY8+mGEJJHUlctqieW5evBy+WNdRkHXsv0+Y
         8EVCwkC8N7trGHUhkGukp9SrgatoaBQJmVX2HtmtnNAIV5Xve5ueBb7yq+Vy/bOFFYB4
         ukeeJAmfWSSVkCS2Hlo9jNEXTuHSySfqA5/QEOnGVDi3mqSk4fKTYxvwDnFdCTh5KU4w
         lOQWFq+o2q1MSUsM2Nay9Vu+DRjhiUmy4FcZXelvLTXlju6dw/UMVFxg9b6G5C2Sq+g2
         nXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REnViNvTDqX6po4FJ2W8C049KBED9Iv0K3XEnhuO300=;
        b=f/EQ7nuM2sTr87ODSOM94Yp9ejvLSxEiqmRrGxDoPxj/zHFb6W14xR3w2eoskcNcgC
         UgiViHo3FDO7sfxVdxq1O+LW8+nRSS5ImqmEK7jspyLajk4PluNtLJO6l4u21cZXZbQh
         dIizIO0smiYOJqy5vNDnCJuPGum9IrRYeVVAGAfS8IUpc/L4wmTLoT0QnRsM+Owzga+b
         3JQS5TJKuNv+UOIeofgo+hEoOxnCCkSi/Sgfae6Qy1ubLf1UpWRU3tSW8Mzl+FMWnUgK
         wFiOqhdltWuAsI1LwlDX491TbkY1nIh7UpSVFEE24j9ysizvZLCRvCuLF4jz7bE9x2FF
         rgqQ==
X-Gm-Message-State: AOAM532kWF4pMYR2nY4jjErjdj8mcyGgcu3Q+6LwgWG3BfD4acqKdJzW
        xlklD1Qzeo5hG+GKDteO3/os/lQPlEE=
X-Google-Smtp-Source: ABdhPJx3n+lVRr/RpgT5m7dmEPV4B6G0IWreR+lTkU2d3xGbcsjnaynJeDvZ/aNohNU/c1GVGdd+jg==
X-Received: by 2002:a17:902:b190:b029:df:fff2:c345 with SMTP id s16-20020a170902b190b02900dffff2c345mr19471772plr.17.1612855760188;
        Mon, 08 Feb 2021 23:29:20 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:19 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 8/9] stash show: teach --include-untracked and --only-untracked
Date:   Mon,  8 Feb 2021 23:28:54 -0800
Message-Id: <88d47912595b5650fbca595a6dd5b7b943a93301.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
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

Teach stash the --include-untracked option, which also displays the
untracked files in a stash entry from the third parent (if it exists).
Do this via something like

	GIT_INDEX_FILE=... git read-tree stash stash^3

and diffing the resulting tree object against the stash base.

One improvement that this could use for the future is performing the
action without writing anything to disk as one would expect this to be a
read-only operation. This can be fixed in the future, however.

Another limitation of this is that it would be possible to manually
craft a stash entry where duplicate untracked files in the stash entry
will mask tracked files. This seems like an instance of "Doctor, it
hurts when I do this! So don't do that!" so this can be written off.

Also, teach stash the --only-untracked option which only shows the
untracked files of a stash entry. This is similar to `git show stash^3`
but it is nice to provide a convenient abstraction for it so that users
do not have to think about the underlying implementation.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-stash.txt            | 16 +++--
 builtin/stash.c                        | 77 ++++++++++++++++++++++-
 contrib/completion/git-completion.bash |  2 +-
 t/t3905-stash-include-untracked.sh     | 84 ++++++++++++++++++++++++++
 4 files changed, 173 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 04e55eb826..9d4b9f0b5c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
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
index 6f2b58f6ab..f7220fad56 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -787,6 +787,47 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 	return git_diff_basic_config(var, value, cb);
 }
 
+static int merge_track_untracked(struct object_id *result, const struct stash_info *info)
+{
+	int ret = 0;
+	struct index_state istate = { NULL };
+	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
+
+	if (!info->has_u) {
+		oidcpy(result, &info->w_commit);
+		return 0;
+	}
+
+	/*
+	 * TODO: is there a way of doing this all in-memory without writing
+	 * anything to disk?
+	 */
+	remove_path(stash_index_path.buf);
+
+	cp_read_tree.git_cmd = 1;
+	strvec_push(&cp_read_tree.args, "read-tree");
+	strvec_push(&cp_read_tree.args, oid_to_hex(&info->w_commit));
+	strvec_push(&cp_read_tree.args, oid_to_hex(&info->u_tree));
+	strvec_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
+		     stash_index_path.buf);
+
+	if (run_command(&cp_read_tree)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (write_index_as_tree(result, &istate, stash_index_path.buf, 0,
+				NULL)) {
+		ret = -1;
+		goto done;
+	}
+
+done:
+	discard_index(&istate);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
 static int show_stash(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -795,7 +836,21 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct strvec stash_args = STRVEC_INIT;
 	struct strvec revision_args = STRVEC_INIT;
+	struct object_id *before = NULL;
+	struct object_id *after = NULL;
+	struct object_id untracked_merged_tree;
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
 
@@ -803,6 +858,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	init_revisions(&rev, prefix);
 
+	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
+
 	strvec_push(&revision_args, argv[0]);
 	for (i = 1; i < argc; i++) {
 		if (argv[i][0] != '-')
@@ -845,7 +904,23 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
 	rev.diffopt.flags.recursive = 1;
 	setup_diff_pager(&rev.diffopt);
-	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+	switch (show_untracked) {
+	case UNTRACKED_NONE:
+		before = &info.b_commit;
+		after = &info.w_commit;
+		break;
+	case UNTRACKED_ONLY:
+		before = NULL;
+		after = &info.u_tree;
+		break;
+	case UNTRACKED_INCLUDE:
+		if (merge_track_untracked(&untracked_merged_tree, &info) < 0)
+			die(_("unable merge stash index with untracked files index"));
+		before = &info.b_commit;
+		after = &untracked_merged_tree;
+		break;
+	}
+	diff_tree_oid(before, after, "", &rev.diffopt);
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

