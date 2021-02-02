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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E186CC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994CC64D99
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBBJiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhBBJgm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:36:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF1C0611C3
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:34:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e12so2939864pls.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mb24iNs3CH80TkM1vK+07ZCcBQ40LSAJhO9Zt4TM7UA=;
        b=ld6tD1BaJUi+LxzM9SH8sgsQk0IndgxM8mfoehP+nW3OjXtTfrKj9lmnWwwOyRwfA8
         ApHVJcSChotqg7U7TklNRzXhzaHL/RXhdfiPrIiBLLk8wv7tEMOwVbRSJ+hdhRjXHqOz
         iCaSk/eAsQrQGkzTc2UDHGlguYfJOQpRHPCRBgOgK2r3JNMKssXqkissmgCKzgNwSV3z
         SvYPy9sqU69bR8jH+QMDCNFNB/tgTHqJTVKS6Ng+CGOc72LAyRDjVxRBssAhPKYVjtt+
         rfabh+iFVWz11f2UlxiNrMzFqe4UcCcc3w/BL+WMa3+9P7tE4AD5RpdS6tWCCoOUpjfF
         62MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb24iNs3CH80TkM1vK+07ZCcBQ40LSAJhO9Zt4TM7UA=;
        b=sdjw6Pvsoomwn0zGmm0UhChT8IQrPr8lGJSskzXGc12thyG5w8wAkmG+z2/xolrZnK
         /hWD7ndbVy8dQWnwBtnSJ5nIGwh6+Gb/bIqk+a8KYcUHpxh5BEdxBzn2EYK/Ebp6KLuQ
         9D6+KkMxp3ElYX9NIOUgx0olystqgWkDmDtbNVH4U6zl3MUYT/g0d7ti2QDlYixbzwPg
         kijbGV8CZVYs38GLNpyvXP8vzfDO9ntnPa6ydYsySwTBl0pipSWA6JU9vaSMqrZz+RL9
         cWBBpff/bHZpMtk/00vEsBicN7sZfy5mL4wkdVFjfqEM0VgbJw4ul8RM9rVrFdgIbAi6
         8l8g==
X-Gm-Message-State: AOAM530kK0JzHWMJNQXDWW9a1ZB9VMxqN4IOg6eoXibd8Oq6YMcfwcmM
        hlkNgs8RxQPvVOSHl4mY0vko5/JrcGY=
X-Google-Smtp-Source: ABdhPJyFrjNws+gTnIDIrYLjKBMt0i6sxgcxNQYsvFdpZSVm9ikJzN7UFLmq8nYqCAmGgkqF87ZBkQ==
X-Received: by 2002:a17:902:223:b029:da:af1e:b112 with SMTP id 32-20020a1709020223b02900daaf1eb112mr21926512plc.83.1612258469253;
        Tue, 02 Feb 2021 01:34:29 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.34.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:34:25 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 8/9] stash show: teach --include-tracked and --only-untracked
Date:   Tue,  2 Feb 2021 01:33:25 -0800
Message-Id: <c2375d1fc6c5fe7a36d2f868b172e83749d67b45.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
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

Teach stash the --include-tracked option, which also displays the
untracked files in a stash entry from the third parent (if it exists).
Do this by just concatenating the diff of the third parent against an
empty tree. One limitation of this is that it would be possible to
manually craft a stash entry which would present duplicate entries in
the diff by duplicating a file in the stash and in the third parent.
This seems like an instance of "Doctor, it hurts when I do this! So
don't do that!" so this can be written off.

Also, teach stash the --only-untracked option which only shows the
untracked files of a stash entry. This is similar to `git show stash^3`
but it is nice to provide a convenient abstraction for it so that users
do not have to think about the underlying implementation.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-stash.txt            | 16 +++--
 builtin/stash.c                        | 20 +++++-
 contrib/completion/git-completion.bash |  2 +-
 t/t3905-stash-include-untracked.sh     | 84 ++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 46ee37b35a..a9956e5c51 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -83,7 +83,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<diff options>] [<stash>]::
+show [-u|--include-untracked|--only-untracked] [<diff options>] [<stash>]::
 
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
index 6f2b58f6ab..7a8770676b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -795,7 +795,18 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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
 
@@ -803,6 +814,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	init_revisions(&rev, prefix);
 
+	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
+
 	strvec_push(&revision_args, argv[0]);
 	for (i = 1; i < argc; i++) {
 		if (argv[i][0] != '-')
@@ -845,7 +860,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
 	rev.diffopt.flags.recursive = 1;
 	setup_diff_pager(&rev.diffopt);
-	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+	if (show_untracked != UNTRACKED_ONLY)
+		diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+	if (show_untracked != UNTRACKED_NONE && info.has_u)
+		diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
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

