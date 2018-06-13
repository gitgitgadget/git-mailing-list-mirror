Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026101F403
	for <e@80x24.org>; Wed, 13 Jun 2018 15:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936017AbeFMPXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 11:23:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38266 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935936AbeFMPXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 11:23:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so6180650wmf.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H21EfxC4tdrDQ6wx6xkrOKqcjV6wbdy/9+h5RIg8vk4=;
        b=OaP2/JkAdAVhGNadRfHT9XGqEKmu48/A0zf1Wf2jue7WSt6IgI/pUrWTWhCmPWHhVL
         H7xxqI2/aip2s6ZVh/QX3etnU79wBq/AJUz/gQ13fZ7A+kJYg8Mj13JMacUICnH4Hdzo
         dNqxDL2gHtRO+ornKhoKi2IYoz9vbzXKRJqzCkQ9vJxwcCcWTYHpOQQq78fQ8cV/MnTf
         l1fZV1bqoRoZIU7f0U77pFAdiZsTkk8n4VljKcdIXlEKodL2bmgwUTxV2/jwh610GLtL
         zefp3wfrn6spC9Naf3wlLpSVySpNuenH/I1m7RXkoSS6K0shFrBwg6lxeIH7qtPFr6Xh
         3Xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H21EfxC4tdrDQ6wx6xkrOKqcjV6wbdy/9+h5RIg8vk4=;
        b=VMDAQfVdefCyRDS2QS/FTOuWydqhFIty4g9rquQDsBPQCMNzKeDZu1eQ1zZZVTOtY/
         Yi1jTOB2TsEKYaMjzG2ma4CAfkJTVN/bSh57gZZuS7w/13BDkhY4oVn6IMhZr5rx26Pj
         YtXs0dMcSVohAsfGjBfNTaUt9E1klBJCVO4hf0k07L1NslLs5pL2WpGS1srhrrq6fkKu
         ARycX95P1MLbdf0YE5pYuvkCT2Yh2HzBKAyFBljrvLHnYANN/RACMKGwP498rOOQPA4V
         GWx/m1PBcvzuGfcpzSPc6zYLOh12liJx8ekC/zvL6rjDupgQyCyjmShPh7ARKSsrFTmK
         UykQ==
X-Gm-Message-State: APt69E0gbwBqVHLpA6YFko8L8wmwrIYs9+o5oveyzNlujgCXmp26aLFY
        j/gwBM28NltGnG9in3FbrUUwr3p3
X-Google-Smtp-Source: ADUXVKKhkThofid0WdlWcVFj2/WZNC28efytFH3PzhMwFt2Sp+KXU0I3Z66TFk+XRqJfIwf7K9Aa6Q==
X-Received: by 2002:a1c:ee06:: with SMTP id m6-v6mr2646349wmh.70.1528903401824;
        Wed, 13 Jun 2018 08:23:21 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id f2-v6sm4526388wre.16.2018.06.13.08.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:23:20 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 2/2] rebase--interactive: rewrite the edit-todo functionality in C
Date:   Wed, 13 Jun 2018 17:22:11 +0200
Message-Id: <20180613152211.12580-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180613152211.12580-1-alban.gruin@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180613152211.12580-1-alban.gruin@gmail.com>
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
index 1ffd990f7..7cc76332e 100644
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
+	if (launch_sequence_editor(todo_file, NULL, NULL))
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

