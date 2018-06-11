Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4488E1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 13:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933231AbeFKN6R (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 09:58:17 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36806 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933007AbeFKN6P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 09:58:15 -0400
Received: by mail-wm0-f45.google.com with SMTP id v131-v6so16737702wma.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HpWRWQNYUtvBDyBGUIDGJrALpKfOQDJ61tpyK8jZT6g=;
        b=qwhS5CqFafDNk5SX6Yge1vvQkipSyw6gkEJDEBWF0Fclm2D4Szy4Na1ik2blcT26Ut
         nVHIjiVLS5i5PDpqqYOzkqeUhTPVCLnem2DwvJQXBMgekz+aFJTHMWV+LA/QfoUyog+w
         +ou0JVPZ9j43rG1NSBGxiTFqF54RYGGi0LbTruvurPNOtYDNjjons/bqaIHboAPY/MnU
         NpVg/B0k3666KH4Vf8SJmZhFqGFhOPy9U6c/ZRLnw7XLVVFd1hIum8/248XsjHbBkiwu
         Ldwae1NkrwZGvT0hcDwyQtAuUuW+F9J9RGuqEG+xukopwzALpbO4EGZu9ccLfoSX5Jwo
         cPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HpWRWQNYUtvBDyBGUIDGJrALpKfOQDJ61tpyK8jZT6g=;
        b=F/ygT/Mhr/gBwlDtqsV6M5z7+CFhR52Ql4c22Iq+ob7lwkO3muMQke7DnHxWbBWXvA
         +pZiglKpwGMw+lWW3Dwy764sn9qJhJavWfBeVlsnYKkjFD+kzd2LaPKXa+IdRFGs4aNt
         prZRfbCcV0To5efxunTNyXWA/noGm+3lwIdIJU4NEC6Uv2EOyT8mfjehfnIUpmJza3ok
         TSrnB2c7BLkBvdM7jYAo/TGV0VuHkKv34Hp7SaNAHJjZzPS0Ipt3x7/88GdK45Km5Dfm
         VJtm1TBJBqrqyCh8UVlL/cEGvVshTnlsTGpnFfE8zY6/A+vAqI6E1rVmEbvUrq++hfDC
         4ztw==
X-Gm-Message-State: APt69E2zxfQRd7u5vr1AV94WhJwZT3A+7WaIYAmVoBrSjBZsh8dLUqQV
        JQcldirgGq5Wre/dOCE8oiD2gpYj
X-Google-Smtp-Source: ADUXVKKZPbh/nc4TnNoevz3EsmnmjJoBoirvLUwQMJqCZTVH77MduQpJXMjYJ6iS0jWoBApCr/EtSw==
X-Received: by 2002:a1c:5c93:: with SMTP id q141-v6mr7975656wmb.77.1528725494347;
        Mon, 11 Jun 2018 06:58:14 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-147.w86-222.abo.wanadoo.fr. [86.222.24.147])
        by smtp.googlemail.com with ESMTPSA id g11-v6sm10522944wrr.46.2018.06.11.06.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:58:13 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 1/1] rebase--interactive: rewrite the edit-todo functionality in C
Date:   Mon, 11 Jun 2018 15:57:14 +0200
Message-Id: <20180611135714.29378-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180611135714.29378-1-alban.gruin@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the edit-todo functionality from shell to C.

To achieve that, a new command mode, `edit-todo`, is added, and the
`write-edit-todo` flag is removed, as the shell script does not need to
write the edit todo help message to the todo list anymore.

The shell version is then stripped in favour of a call to the helper.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 13 ++++++++-----
 git-rebase--interactive.sh | 11 +----------
 sequencer.c                | 31 +++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index ded5e291d..d2990b210 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -27,8 +27,6 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "write-edit-todo", &write_edit_todo,
-			 N_("append the edit-todo message to the todo-list")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -49,6 +47,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_CMDMODE(0, "append-todo-help", &command,
 			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
+		OPT_CMDMODE(0, "edit-todo", &command,
+			    N_("edit the todo list during an interactive rebase"),
+			    EDIT_TODO),
 		OPT_END()
 	};
 
@@ -89,6 +90,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
 	if (command == APPEND_TODO_HELP && argc == 1)
-		return !!append_todo_help(write_edit_todo, keep_empty);
+		return !!append_todo_help(0, keep_empty);
+	if (command == EDIT_TODO && argc == 1)
+		return !!edit_todo_list(flags);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 94c23a7af..2defe607f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -108,16 +108,7 @@ initiate_action () {
 		     --continue
 		;;
 	edit-todo)
-		git stripspace --strip-comments <"$todo" >"$todo".new
-		mv -f "$todo".new "$todo"
-		collapse_todo_ids
-		git rebase--helper --append-todo-help --write-edit-todo
-
-		git_sequence_editor "$todo" ||
-			die "$(gettext "Could not execute editor")"
-		expand_todo_ids
-
-		exit
+		exec git rebase--helper --edit-todo
 		;;
 	show-current-patch)
 		exec git show REBASE_HEAD --
diff --git a/sequencer.c b/sequencer.c
index 1ffd990f7..1c1799c91 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4386,6 +4386,37 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 	return ret;
 }
 
+int edit_todo_list(unsigned flags)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *todo_file = rebase_path_todo();
+	FILE *todo;
+
+	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	strbuf_stripspace(&buf, 1);
+	todo = fopen_or_warn(todo_file, "w");
+	if (!todo) {
+		strbuf_release(&buf);
+		return 1;
+	}
+
+	strbuf_write(&buf, todo);
+	fclose(todo);
+	strbuf_release(&buf);
+
+	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	append_todo_help(1, 0);
+
+	if (launch_editor(todo_file, NULL, NULL))
+		return 1;
+
+	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	return 0;
+}
+
 static int rewrite_file(const char *path, const char *buf, size_t len)
 {
 	int rc = 0;
diff --git a/sequencer.h b/sequencer.h
index e14f6590e..35730b13e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -81,6 +81,7 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 int check_todo_list(void);
 int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+int edit_todo_list(unsigned flags);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
 
-- 
2.16.4

