Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392F21F403
	for <e@80x24.org>; Tue,  5 Jun 2018 12:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeFEMxw (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 08:53:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32921 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFEMxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 08:53:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so17693693wma.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lR1kMpHm1s+vfb7g9rmlu8yVzqUn7VQYLl03PwOkNQw=;
        b=kJkP/L7D7imedDjbhCN2MPhm7df58yx6PgsCELqay+dTrPGV2cJAfanoNT78Z4kuru
         IzdXWzoHu981/2YGtbxTxIeaNDdwXPyEBOJHXH+mSQ7g5G3Lpt9EfFz8xk1tfqs3fEfq
         RgH6uvphXtm9rzAiqwfaotyzrbffXpZdnLBIVHintt4ep94zUkj5Dgj5Nocf6Tj8JmbD
         HP8qQELrizeZb/L6/CC1rOYdJMYSXSog4Ezki4BF9D/vkVIN9nmwiHhoFi9sAUMxEAzU
         tUXIkW4YRYQBnL0ZuAEfrsn2poStLIQrqPfW/SPmaXUnaA4Z9VFlCFIBDGB6JukLBndN
         ydPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lR1kMpHm1s+vfb7g9rmlu8yVzqUn7VQYLl03PwOkNQw=;
        b=cYF1GhA6vemLsRXnww85q8lQSHT5ZOOG7msGfm2EB5Y1mpDzU4Bq2oIP4EVSBzeXsn
         /G+fyA3LU+EyA1YW75GlZyOuhrs6QRbtOPhT4s9ea771PsfnAks7TTqAw4sVLfpXQ9ek
         TbXBuxE3Qp7MsqrBDoHeEADFuG4n311ABXAyJFDfYIySUjVP3wVyudOWNJu4Clbxe3Jz
         8SmLufITZ4mh171p7r3dj5MekV7lHK2EXqE1FOLzIPSdRkNjXv0xUH39+hV2YilNrPzb
         21kBdum9H2OkVZjgXcT/U/eLr0FT0zONcBRVsGYI4i8MzCzDjQwUACQqxuBYWXGCp3X5
         NShg==
X-Gm-Message-State: ALKqPwccYE/LXzO3HFk3d8q4s1VI/TOxhnX7NlSTL1YtAm1fG0GkB+iw
        D6QcVzCOGNUHhEJ2UUKI6iKQnprJ
X-Google-Smtp-Source: ADUXVKLowksVsSSEHMf5/1GJsozTd2vd4rnDns8fSMj5cjIf60/CiTdf0MVSmq3V+xaYd3KUh4nd+g==
X-Received: by 2002:a50:aada:: with SMTP id r26-v6mr28672659edc.124.1528203227696;
        Tue, 05 Jun 2018 05:53:47 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.googlemail.com with ESMTPSA id i38-v6sm4439480ede.41.2018.06.05.05.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 05:53:46 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 1/1] rebase--interactive: rewrite append_todo_help() in C
Date:   Tue,  5 Jun 2018 14:53:34 +0200
Message-Id: <20180605125334.14082-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180605125334.14082-1-alban.gruin@gmail.com>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
 <20180605125334.14082-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites append_todo_help() from shell to C. It also incorporates
some parts of initiate_action() and complete_action() that also write
help texts to the todo file.

Two flags are added to rebase--helper.c: one to call
append_todo_help() (`--append-todo-help`), and another one to tell
append_todo_help() to write the help text suited for the edit-todo
mode (`--write-edit-todo`).

Finally, append_todo_help() is removed from git-rebase--interactive.sh
to use `rebase--helper --append-todo-help` instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 10 ++++++--
 git-rebase--interactive.sh | 52 ++--------------------------------------
 sequencer.c                | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f7c2a5fdc..7ef92fbb6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, edit_todo = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC
+		ADD_EXEC, APPEND_TODO_HELP
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -27,6 +27,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "write-edit-todo", &edit_todo,
+			 N_("append the edit-todo message to the todo-list")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -45,6 +47,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_CMDMODE(0, "add-exec-commands", &command,
 			N_("insert exec commands in todo list"), ADD_EXEC),
+		OPT_CMDMODE(0, "append-todo-help", &command,
+			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
 		OPT_END()
 	};
 
@@ -84,5 +88,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
+	if (command == APPEND_TODO_HELP && argc == 1)
+		return !!append_todo_help(edit_todo, keep_empty);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 299ded213..94c23a7af 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -39,38 +39,6 @@ comment_for_reflog () {
 	esac
 }
 
-append_todo_help () {
-	gettext "
-Commands:
-p, pick <commit> = use commit
-r, reword <commit> = use commit, but edit the commit message
-e, edit <commit> = use commit, but stop for amending
-s, squash <commit> = use commit, but meld into previous commit
-f, fixup <commit> = like \"squash\", but discard this commit's log message
-x, exec <command> = run command (the rest of the line) using shell
-d, drop <commit> = remove commit
-l, label <label> = label current HEAD with a name
-t, reset <label> = reset HEAD to a label
-m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
-.       create a merge commit using the original merge commit's
-.       message (or the oneline, if no original merge commit was
-.       specified). Use -c <commit> to reword the commit message.
-
-These lines can be re-ordered; they are executed from top to bottom.
-" | git stripspace --comment-lines >>"$todo"
-
-	if test $(get_missing_commit_check_level) = error
-	then
-		gettext "
-Do not remove any line. Use 'drop' explicitly to remove a commit.
-" | git stripspace --comment-lines >>"$todo"
-	else
-		gettext "
-If you remove a line here THAT COMMIT WILL BE LOST.
-" | git stripspace --comment-lines >>"$todo"
-	fi
-}
-
 die_abort () {
 	apply_autostash
 	rm -rf "$state_dir"
@@ -143,13 +111,7 @@ initiate_action () {
 		git stripspace --strip-comments <"$todo" >"$todo".new
 		mv -f "$todo".new "$todo"
 		collapse_todo_ids
-		append_todo_help
-		gettext "
-You are editing the todo file of an ongoing interactive rebase.
-To continue rebase after editing, run:
-    git rebase --continue
-
-" | git stripspace --comment-lines >>"$todo"
+		git rebase--helper --append-todo-help --write-edit-todo
 
 		git_sequence_editor "$todo" ||
 			die "$(gettext "Could not execute editor")"
@@ -220,17 +182,7 @@ $comment_char $(eval_ngettext \
 	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
 	"$todocount")
 EOF
-	append_todo_help
-	gettext "
-	However, if you remove everything, the rebase will be aborted.
-
-	" | git stripspace --comment-lines >>"$todo"
-
-	if test -z "$keep_empty"
-	then
-		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
-	fi
-
+	git rebase--helper --append-todo-help ${keep_empty:+--keep-empty}
 
 	has_action "$todo" ||
 		return 2
diff --git a/sequencer.c b/sequencer.c
index b522523d4..c9d488b11 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4336,6 +4336,66 @@ int check_todo_list(void)
 	return res;
 }
 
+int append_todo_help(unsigned edit_todo, unsigned keep_empty)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *todo;
+	int ret;
+	const char *msg = _("\nCommands:\n"
+"p, pick <commit> = use commit\n"
+"r, reword <commit> = use commit, but edit the commit message\n"
+"e, edit <commit> = use commit, but stop for amending\n"
+"s, squash <commit> = use commit, but meld into previous commit\n"
+"f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
+"x, exec <command> = run command (the rest of the line) using shell\n"
+"d, drop <commit> = remove commit\n"
+"l, label <label> = label current HEAD with a name\n"
+"t, reset <label> = reset HEAD to a label\n"
+"m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
+".       create a merge commit using the original merge commit's\n"
+".       message (or the oneline, if no original merge commit was\n"
+".       specified). Use -c <commit> to reword the commit message.\n"
+"\n"
+"These lines can be re-ordered; they are executed from top to bottom.\n");
+
+	todo = fopen_or_warn(rebase_path_todo(), "a");
+	if (!todo)
+		return 1;
+
+	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+
+	if (get_missing_commit_check_level() == CHECK_ERROR)
+		msg = _("\nDo not remove any line. Use 'drop' "
+			 "explicitly to remove a commit.\n");
+	else
+		msg = _("\nIf you remove a line here "
+			 "THAT COMMIT WILL BE LOST.\n");
+
+	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+
+	if (edit_todo)
+		msg = _("\nYou are editing the todo file "
+			"of an ongoing interactive rebase.\n"
+			"To continue rebase after editing, run:\n"
+			"    git rebase --continue\n\n");
+	else
+		msg = _("\nHowever, if you remove everything, "
+			"the rebase will be aborted.\n\n");
+
+	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+
+	if (!keep_empty) {
+		msg = _("Note that empty commits are commented out");
+		strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	}
+
+	ret = fputs(buf.buf, todo);
+	fclose(todo);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
 static int rewrite_file(const char *path, const char *buf, size_t len)
 {
 	int rc = 0;
diff --git a/sequencer.h b/sequencer.h
index c5787c6b5..e14f6590e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -80,6 +80,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 int check_todo_list(void);
+int append_todo_help(unsigned edit_todo, unsigned keep_empty);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
 
-- 
2.16.4

