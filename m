Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13FE1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeGaTmU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50982 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGaTmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so4093501wmc.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsKWoskNU/aKOFhShPX8rXqwGufI0MSQDfblSz3KegE=;
        b=QQtWizpYVBUJ0xKzuwPZa3XtZ/bvr8on6ZkzEg997d9+SWNUVnsqcR+NW3sx0yQdva
         6cwdpl0GHLAdmVzWX9L0zLZSYj72sXaIjJNEm0qTRz9kg6arME2v4rG1HlEKEGbIUNQ7
         93EUsYGQonXyVwnrb157fyT7XZK2pmJsobYX1ZTpQHq+9ZF4lZy0D5j2T8Wx7Huox6+0
         NGvszFzSa3LyFyZqHEr/2koeIRzmGQgjGJBoMzBbiCIB4qYHb46XvVW/Z1KtEt1lUmQT
         SgDg6tYNMK0+AmqqEY0XvN+kmIAH+mjVx/1cj1PPDXxaPupAuGmBxq75Qbbi2tgYjzK9
         W+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsKWoskNU/aKOFhShPX8rXqwGufI0MSQDfblSz3KegE=;
        b=pbFWNm6rXeAG1exKVTdPX8YulzOHlQP9stJ8wVfeOOaCoYRW7Q7rDGLdWnIokveZ0/
         ifrQVt5dIuijHYNFiljjYkkG3OXs9gyh2pYrWAiQBrn85L83iK1OmeU+XJHggAskEjk9
         p15YaSjkolQs2mUobHynOD0iuym+I/SGYUkLBRrINmz4K2B4p0uCuvKiu1Y/WMAxIjaG
         RNsHXPclYUR8ypAzg7fUJhx4bXr4SB4Bh3eVdyUPeo2lm5hXm2I0VukXIOZZUgAwFRRC
         LR+wDaVjO/s1owOvMS7UaJkYhNusfA2NAaCOUycyZ3HYmTwQgl2ulKOIMh+tbjDdXLzZ
         zq4Q==
X-Gm-Message-State: AOUpUlG+MOhDvI289DdNqTHXK/ySxgDzpKCkVIO+Utr80x8GfncpGNJo
        Voh8cgstt9pN2U1wsj9TKXYlD5EL
X-Google-Smtp-Source: AAOMgpcgPjD0rXOX97F0rb/LwIPlvxarqmRV8QUH/ySQGLBKqDsQRBmzq4L7+/L8sxRNReqvbp8CeA==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr481983wmb.29.1533060048799;
        Tue, 31 Jul 2018 11:00:48 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:47 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 18/20] rebase--interactive2: rewrite the submodes of interactive rebase in C
Date:   Tue, 31 Jul 2018 20:00:01 +0200
Message-Id: <20180731180003.5421-19-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the submodes of interactive rebase (`--continue`,
`--skip`, `--edit-todo`, and `--show-current-patch`) in C.

git-rebase.sh is then modified to call directly git-rebase--interactive2
instead of git-rebase--interactive.sh.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v4.

 builtin/rebase--interactive2.c | 47 +++++++++++++++++++++++++++++++---
 git-rebase.sh                  | 45 +++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase--interactive2.c b/builtin/rebase--interactive2.c
index e89ef71499..53b4f7483d 100644
--- a/builtin/rebase--interactive2.c
+++ b/builtin/rebase--interactive2.c
@@ -134,11 +134,14 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
 	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
 		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
 		*switch_to = NULL, *cmd = NULL;
 	char *raw_strategies = NULL;
+	enum {
+		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH
+	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
 		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
@@ -151,6 +154,13 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			 N_("move commits that begin with squash!/fixup!")),
 		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
 		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
+		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
+			    CONTINUE),
+		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
+		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
+			    EDIT_TODO),
+		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
+			    SHOW_CURRENT_PATCH),
 		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
 		OPT_STRING(0, "restrict-revision", &restrict_revision,
 			   N_("restrict-revision"), N_("restrict revision")),
@@ -194,7 +204,36 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	return !!do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
-				       onto_name, squash_onto, head_name, restrict_revision,
-				       raw_strategies, cmd, autosquash);
+	switch (command) {
+	case NONE:
+		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
+					    onto_name, squash_onto, head_name, restrict_revision,
+					    raw_strategies, cmd, autosquash);
+		break;
+	case SKIP: {
+		struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+		rerere_clear(&merge_rr);
+		/* fallthrough */
+	case CONTINUE:
+		ret = sequencer_continue(&opts);
+		break;
+	}
+	case EDIT_TODO:
+		ret = edit_todo_list(flags);
+		break;
+	case SHOW_CURRENT_PATCH: {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		cmd.git_cmd = 1;
+		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
+		ret = run_command(&cmd);
+
+		break;
+	}
+	default:
+		BUG("invalid command '%d'", command);
+	}
+
+	return !!ret;
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 51a6db7daa..d5950a3012 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -200,19 +200,56 @@ finish_rebase () {
 	rm -rf "$state_dir"
 }
 
+run_interactive () {
+	GIT_CHERRY_PICK_HELP="$resolvemsg"
+	export GIT_CHERRY_PICK_HELP
+
+	test -n "$keep_empty" && keep_empty="--keep-empty"
+	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
+	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
+	test -n "$autosquash" && autosquash="--autosquash"
+	test -n "$verbose" && verbose="--verbose"
+	test -n "$force_rebase" && force_rebase="--no-ff"
+	test -n "$restrict_revisions" && \
+		restrict_revisions="--restrict-revisions=^$restrict_revisions"
+	test -n "$upstream" && upstream="--upstream=$upstream"
+	test -n "$onto" && onto="--onto=$onto"
+	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
+	test -n "$onto_name" && onto_name="--onto-name=$onto_name"
+	test -n "$head_name" && head_name="--head-name=$head_name"
+	test -n "$strategy" && strategy="--strategy=$strategy"
+	test -n "$strategy_opts" && strategy_opts="--strategy-opts=$strategy_opts"
+	test -n "$switch_to" && switch_to="--switch-to=$switch_to"
+	test -n "$cmd" && cmd="--cmd=$cmd"
+	test -n "$action" && action="--$action"
+
+	exec git rebase--interactive2 "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
+		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
+		"$allow_empty_message" "$autosquash" "$verbose" \
+		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
+		"$strategy_opts" "$cmd" "$switch_to" \
+		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff"
+}
+
 run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
 
-	if test -z "$preserve_merges"
+	if test -n "$interactive_rebase" -a -z "$preserve_merges"
 	then
-		git_rebase__$type
+		run_interactive
 	else
-		git_rebase__preserve_merges
+		. git-rebase--$type
+
+		if test -z "$preserve_merges"
+		then
+			git_rebase__$type
+		else
+			git_rebase__preserve_merges
+		fi
 	fi
 
 	ret=$?
-- 
2.18.0

