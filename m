Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA141F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933248AbeGJMRY (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGJMRT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so14374339wrn.7
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pIOmWDvAo22plY/8Lr7TqUngO7nXpVqOjmlCIbPnLFw=;
        b=iTjgpUEkzEJC4cFnRNSFmOwfy+fc4+ESZSe6XledpMriEZE1gdg0KRFDn/eNI6ZDG5
         slp/FbVUfG1awlZHLnVSg/N75aGMTZALzDJM119bolLxipRCSMOc4LsHYlOOb9uTD8ea
         UDuqbP//vhCf/xEusgzHGlwu9oMyWSgObQGXZpwl+rz68SXlPh6sLfyuTgfI0hQUqmJZ
         sKaC00DH7wrhja2k8J/mEx2RQGNH1QFOzpdjt7icr53yOReB2rLYF7aBD+aGbBENVkla
         JgD5xHnt3oJ+p3L0Qs38n4AaMSNbEU8dsCfj7S54WuQyFdpWk1MaQ10SgQzbJh1tx3Bz
         IC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pIOmWDvAo22plY/8Lr7TqUngO7nXpVqOjmlCIbPnLFw=;
        b=CcvaG3lsCzvXn5qCGGVvhzQAOPggDykDASKpX5/xCim3zmLAiWbPSM8U+KWSpddzaX
         NFPamLC/tNpfxBEJre0QUq13iYRi/9TP4p2Ou+5QTxwOGEalKpBSQfPNDma69rP1VlYk
         ImkoWkkEfS/UF+2aCeaSBAlKqeeVt4510L4DxmLDCysnrE6rtaOa6yHt6Ip4UyALln7H
         uiy4XGW6pBTvRY7NymtK3YWPocYcp1AVXPTyQ9AQtzx4hGKsQLq1z/GHjQMbMVI+xgHY
         /1Ygwm9ucqUxf6eoZ/h1tYQ2ITm2CY45CSiCzi08fAzpapGd2wWf20nVXD6Gsy2oLUqt
         Ovaw==
X-Gm-Message-State: APt69E3vC5J32PZS4dmvfr4GcGHzQtiUKSzBHI/D0w+6n7F8HGltew0w
        iSwyWXH14gIAnNZneQfggPV8VszT
X-Google-Smtp-Source: AAOMgpc7P2DFCSitxOxr7oEpSUQjpzj69agb7PSE02958MwgZLTyMSDcNdslISJ6JmMa4BslPTCKFw==
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr16847495wrs.276.1531225037962;
        Tue, 10 Jul 2018 05:17:17 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 04/13] rebase-interactive: rewrite the edit-todo functionality in C
Date:   Tue, 10 Jul 2018 14:15:48 +0200
Message-Id: <20180710121557.6698-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
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
Unchanged from v2.

builtin/rebase--helper.c   | 13 ++++++++-----
 git-rebase--interactive.sh | 11 +----------
 rebase-interactive.c       | 31 +++++++++++++++++++++++++++++++
 rebase-interactive.h       |  1 +
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 05e73e71d..731a64971 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,12 +13,12 @@ static const char * const builtin_rebase_helper_usage[] = {
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
@@ -28,8 +28,6 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "write-edit-todo", &write_edit_todo,
-			 N_("append the edit-todo message to the todo-list")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -50,6 +48,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_CMDMODE(0, "append-todo-help", &command,
 			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
+		OPT_CMDMODE(0, "edit-todo", &command,
+			    N_("edit the todo list during an interactive rebase"),
+			    EDIT_TODO),
 		OPT_END()
 	};
 
@@ -90,6 +91,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
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
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d7996bc8d..403ecbf3c 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -66,3 +66,34 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 
 	return ret;
 }
+
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
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 47372624e..155219e74 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -2,5 +2,6 @@
 #define REBASE_INTERACTIVE_H
 
 int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+int edit_todo_list(unsigned flags);
 
 #endif
-- 
2.18.0

