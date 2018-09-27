Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34871F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeI1EU7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:20:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44388 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeI1EU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:20:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so4206472wro.11
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDoipsp6KOSBDuF0q6Z1pwkchqti1jzkZ5zR40QuFFM=;
        b=HOnbPMRWgI40vjdbKxXN4+z566c+7Mia2NZr1I/CWUMdHZVprDj8eTCJjikDloOadO
         JWXdz/g6L+Nsn0QjJUyR3e9iBvy4CCTy5bBJ2ER7fmge89Sy0nsQlGsB35I5O2AV7nk6
         eipC21aiWsgTGygzVezN3CRALfC6bGCVj3lj8oyYqVX3HiPmE6JnOrpDayR4ZSn9rdfx
         suoRU+EWLlBBdtjfHQvJbkK83vZooRImkPCR7/FuJEHlcmD4rSRiuGy52fVvRDA3mw2a
         qCWCUUA3junRhsIGF3E8p7mS140SL79cmvsM7PANtpKmec6r9w2IXgR/rEYq+6l3LF1U
         5AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDoipsp6KOSBDuF0q6Z1pwkchqti1jzkZ5zR40QuFFM=;
        b=iE5P8BJ4+0mFnfV+jytZewmfksfQWqsVXDTZT/JLmrhdgY7/xyBnK3dgMX45K7GRsL
         fLx49COAHjUOcB+8hbcRi9DMRelPxJ7w6ny+AvyLnLse3FVW3qvZLxF10P8F2vCg3nRK
         O7ahAiEkCpk8UFlKaLGijKNNPZBtjuEDzhy85c98NWQf/wpe9nQhStQk3/16mXEcdN11
         bpSdB67FLCVy86opyHmYgCYet2udG55xVbsfnI3JFlOr/JZbVtyw+S4C69rdiykvNEEU
         bIW2p2ZAqxg/g7NrNixmKjzpgjYZs6wIqru0iIxTKTPCEwr0S6G3up2kAGMCODLH2Iv1
         1Udg==
X-Gm-Message-State: ABuFfohTpyPijY1SfzHdF0GNL8zmOJl+/2un3SEsGqH2q3cxBORDCHhS
        nObMRf3nKVPe2xKHCaJI4GFHzx7L
X-Google-Smtp-Source: ACcGV62aiewLKwkVzFZXdyj1ozvAQOCHTwZNTzoNb44OL/1oZb3FJyFPSAstbH3zekLoelfUKGl1RQ==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr10320020wrd.273.1538085632601;
        Thu, 27 Sep 2018 15:00:32 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:32 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 04/20] rebase -i: rewrite the edit-todo functionality in C
Date:   Thu, 27 Sep 2018 23:55:54 +0200
Message-Id: <20180927215610.32210-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
No changes since v7.

 builtin/rebase--helper.c   | 13 ++++++++-----
 git-rebase--interactive.sh | 11 +----------
 rebase-interactive.c       | 27 +++++++++++++++++++++++++++
 rebase-interactive.h       |  1 +
 4 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 05e73e71d4..731a64971d 100644
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
index 94c23a7af2..2defe607f4 100644
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
index d7996bc8d9..3f9468fc69 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -66,3 +66,30 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 
 	return ret;
 }
+
+int edit_todo_list(unsigned flags)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *todo_file = rebase_path_todo();
+
+	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	strbuf_stripspace(&buf, 1);
+	if (write_message(buf.buf, buf.len, todo_file, 0)) {
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_release(&buf);
+
+	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	append_todo_help(1, 0);
+
+	if (launch_sequence_editor(todo_file, NULL, NULL))
+		return -1;
+
+	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	return 0;
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 47372624e0..155219e742 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -2,5 +2,6 @@
 #define REBASE_INTERACTIVE_H
 
 int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+int edit_todo_list(unsigned flags);
 
 #endif
-- 
2.19.0

