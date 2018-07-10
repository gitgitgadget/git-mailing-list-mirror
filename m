Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10F91F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeGJMR1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32939 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbeGJMRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so13437070wma.0
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMtAqT1gLyOwGVItuB6bdnldl1P9+vl0CoH3fghVBOQ=;
        b=VE+J0NpD8Ry8xQweRhXVFAUDDPAZG9duKP27gP/CHjvsgsKvm6PyjYAp9hrItIpDGR
         9sb9WTV77xoLN8YJRIkP+nVb6Aj4Ptf8kKqFPnIg4HBOdOgeKAGwJY7soD32hocoNRJ1
         bjalvbUerldYij7ZDR+O0+I/wVl/n11XwAk3Lngww/MYF3I57eZ65KufB6dq80jWjaw6
         /Lwpko5rsozTUbmMO6j0cmRKojOlkEpbkBRq9vf6h0+lK1Jt3ycRSGvhILlABaGDrLL+
         17Sh9y4lKHYuCDNB/ITHqxMZs18jCGFfH7BtogI5TxWATHgXYNdYPpr4mjCKJV/i4yr7
         SbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMtAqT1gLyOwGVItuB6bdnldl1P9+vl0CoH3fghVBOQ=;
        b=bU5Zit1psJ38PpCLVSoijthnvig5liOPJiJ0uF1IufWTAWwSAvKVoSckwjXBZMx51N
         nHYyw956saOEt712PJMd8NF24GWC5MEniCr+FwthwJM5fin4TDd2BAG/9AodW1o4Y87J
         GOuET/TBNTmJRrjhTFUM2giSU7YYgW4PUzMpY9wgBmcviiVtQzAoixsa+1CogI/kbTjU
         +qQvTxkfg7sFyNfa7DtAIb8G+yBOJjM4hCiKasJ3qalA+uuMYa3euBe+3sjU3OkuTiwF
         y8reA0IU9mjMHEhQEn8KDtdeSx9ibVvSDCl39NCnlbmV0woTwZttNq0w+R1IHxHCyOD3
         G4tg==
X-Gm-Message-State: APt69E3Y9fkLvV4Hy3V6V75P7Cc3y7TZXMi+eAbgt2vYnuQ2EuVSSv7d
        xz8F0XaxkPItCKIeUXoSpgdu8Ebi
X-Google-Smtp-Source: AAOMgpecVZaWMmaZh8eaO1cn/mbiPNlR5n6nB5UArjG9+0WVle6VicG1cnRKehMnLVTQJt9QqG5jwA==
X-Received: by 2002:a1c:e708:: with SMTP id e8-v6mr8308826wmh.134.1531225044203;
        Tue, 10 Jul 2018 05:17:24 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:23 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 08/13] sequencer: refactor append_todo_help() to write its message to a buffer
Date:   Tue, 10 Jul 2018 14:15:52 +0200
Message-Id: <20180710121557.6698-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
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
 rebase-interactive.c     | 45 ++++++++++++++++++++++++++++------------
 rebase-interactive.h     |  7 ++++++-
 3 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 1d9595bdb..b9af96af7 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -98,7 +98,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
 	if (command == APPEND_TODO_HELP && argc == 1)
-		return !!append_todo_help(0, keep_empty);
+		return !!append_todo_help_to_file(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 403ecbf3c..d8b946559 100644
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
+		return 1;
+
+	append_todo_help(edit_todo, keep_empty, &buf);
 
 	ret = fputs(buf.buf, todo);
 	if (ret < 0)
@@ -88,7 +95,19 @@ int edit_todo_list(unsigned flags)
 	strbuf_release(&buf);
 
 	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
-	append_todo_help(1, 0);
+
+	strbuf_read_file(&buf, todo_file, 0);
+	append_todo_help(1, 0, &buf);
+
+	todo = fopen_or_warn(todo_file, "w");
+	if (!todo) {
+		strbuf_release(&buf);
+		return 1;
+	}
+
+	strbuf_write(&buf, todo);
+	fclose(todo);
+	strbuf_release(&buf);
 
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return 1;
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 155219e74..c0ba83be3 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -1,7 +1,12 @@
 #ifndef REBASE_INTERACTIVE_H
 #define REBASE_INTERACTIVE_H
 
-int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+#include <cache.h>
+#include <strbuf.h>
+
+void append_todo_help(unsigned edit_todo, unsigned keep_empty,
+		      struct strbuf *buf);
+int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty);
 int edit_todo_list(unsigned flags);
 
 #endif
-- 
2.18.0

