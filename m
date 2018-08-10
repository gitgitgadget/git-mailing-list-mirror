Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EFCA1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbeHJTXI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42708 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeHJTXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so8844044wrs.9
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=By7yMw8o1ri8+JHrfb9f47NI7VIFv/3NqggOMsOM8/k=;
        b=pVNmqock++WDZoBZHeMFBuqt+GB/iLWH8ajt3Lz/QOEeU2KAp35taQRnFAgET9iBmi
         G+a24eJ6T8SR+dOppDcqHBf8XTJXwdOzlbd8cHS4HlFYk+coKf5ZenA+SecMHDDXmp4+
         XWPJhREOKS9KSMqZ6tHae3N+togSv0IdOa821RBt9MG6qaI7PgCUWyg3NUdd/RsR+XHN
         gOiqz6I42VUbdfvJYRh7Jj3lnFfP7a8EJk9nhkdE8Am5p3YrLA/Oue48vuUtiv0tFkLq
         n+h5llebzuTi8LsOoiyEZpXagF464+rBTSli+Uug7FxjNuExD237LLLyxsk+xA7pJsGX
         bLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=By7yMw8o1ri8+JHrfb9f47NI7VIFv/3NqggOMsOM8/k=;
        b=XOo/u/mAYClmGnyK7XAy6oUdjmsbVrxHEr5h+g6T5oAlvdjmA0fW2KzNe5wGAOIGLn
         dqE4sJlufNUQjcMt4NBTWnAU1Sa3HAjJcerZx5QRG5ru5VCPoQTGoUlJ3TtaMCFayPtm
         zN91k+ALIpbqRrQe8N82IF9luLhp2qPspzXuKvebiMgqT1hajuDLXJ0NCc/jFf2yP5Lv
         7vi7REolU2pGt4hR2vYEolqgWh8Ocjhwy9x+XNj84coqg86Ee72CDMc6qFXtHS3Gbf9i
         Fhck6aYwhX8MrUjTTcRHUtsq6z/lj2DDTukjtWmj2+zKYoWcA9HEWI9nluuSt38QV0LI
         6XUA==
X-Gm-Message-State: AOUpUlFtenKyIQ8dzPvOu4w2/JiFSFkumOtq0q26xfRxPMisucy1xHaO
        uUWHcH3qeTRibUTfjwNbbU3rh1TF
X-Google-Smtp-Source: AA+uWPxxRH2h0a9PCYiMz+6j+7p8q9/C0vWMOBs6J5lOwjTqE41yls+vnM74wWHCX3RE5r8FkE6YEA==
X-Received: by 2002:adf:dbc3:: with SMTP id e3-v6mr4554436wrj.217.1533919947227;
        Fri, 10 Aug 2018 09:52:27 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:26 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 08/20] sequencer: refactor append_todo_help() to write its message to a buffer
Date:   Fri, 10 Aug 2018 18:51:35 +0200
Message-Id: <20180810165147.4779-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors append_todo_help() to write its message to a buffer
instead of the todo-list.  This is needed for the rewrite of
complete_action(), which will come after the next commit.

As rebase--helper still needs the file manipulation part of
append_todo_help(), it is extracted to a temporary function,
append_todo_help_to_file().  This function will go away after the
rewrite of complete_action().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c |  2 +-
 rebase-interactive.c     | 43 ++++++++++++++++++++++++++++------------
 rebase-interactive.h     |  4 +++-
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 7d9426d23c..313092c465 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -97,7 +97,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
 	if (command == APPEND_TODO_HELP && argc == 1)
-		return !!append_todo_help(0, keep_empty);
+		return !!append_todo_help_to_file(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3f9468fc69..4a9a10eff4 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -4,11 +4,9 @@
 #include "sequencer.h"
 #include "strbuf.h"
 
-int append_todo_help(unsigned edit_todo, unsigned keep_empty)
+void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+		      struct strbuf *buf)
 {
-	struct strbuf buf = STRBUF_INIT;
-	FILE *todo;
-	int ret;
 	const char *msg = _("\nCommands:\n"
 "p, pick <commit> = use commit\n"
 "r, reword <commit> = use commit, but edit the commit message\n"
@@ -26,11 +24,7 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 
-	todo = fopen_or_warn(rebase_path_todo(), "a");
-	if (!todo)
-		return 1;
-
-	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
 		msg = _("\nDo not remove any line. Use 'drop' "
@@ -39,7 +33,7 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 		msg = _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
 
-	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (edit_todo)
 		msg = _("\nYou are editing the todo file "
@@ -50,12 +44,25 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
 
-	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (!keep_empty) {
 		msg = _("Note that empty commits are commented out");
-		strbuf_add_commented_lines(&buf, msg, strlen(msg));
+		strbuf_add_commented_lines(buf, msg, strlen(msg));
 	}
+}
+
+int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *todo;
+	int ret;
+
+	todo = fopen_or_warn(rebase_path_todo(), "a");
+	if (!todo)
+		return -1;
+
+	append_todo_help(edit_todo, keep_empty, &buf);
 
 	ret = fputs(buf.buf, todo);
 	if (ret < 0)
@@ -84,7 +91,17 @@ int edit_todo_list(unsigned flags)
 	strbuf_release(&buf);
 
 	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
-	append_todo_help(1, 0);
+
+	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	append_todo_help(1, 0, &buf);
+	if (write_message(buf.buf, buf.len, todo_file, 0)) {
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_release(&buf);
 
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 155219e742..d33f3176b7 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -1,7 +1,9 @@
 #ifndef REBASE_INTERACTIVE_H
 #define REBASE_INTERACTIVE_H
 
-int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+		      struct strbuf *buf);
+int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty);
 int edit_todo_list(unsigned flags);
 
 #endif
-- 
2.18.0

