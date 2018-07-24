Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CE61F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbeGXRlm (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51824 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388546AbeGXRlm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so2562445wma.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3Zhwt1jCKJRmlnzP70gBTbRaw9yzLAy3cRrjzFOCY0=;
        b=Nph74m9PtAou+cIlYxapYeZACuUbqWIAQOIIZ0/U7kQ1V6xUDto0FuabfUsos7jdPn
         /pb7swHpusl5ejLgKe5nUM+B9e5IF1L2Wv3w4MjKiI2ltwfymSiD3noIggkUuiMPhU8k
         cTfwQWTzQuk/5WnWyaSbc9fx7/bmDo0JuNz1tY4B66pYjFJwhtbJ3IIIubJz4vnVL1rr
         mEZaGRsMSrqX1mpRJCoFvG7ksZX1xFbmd2jIypvbD3qnkD+yqtnSt8GRdxFoWimHFG0i
         l5NjxIekeVMQAYQi8gSDfbFtwZKmvGEei2NzrqolSbrMe2fVSw81I7dpsH4ox3aov9O3
         IDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3Zhwt1jCKJRmlnzP70gBTbRaw9yzLAy3cRrjzFOCY0=;
        b=Q0CJ4Bt64qWKvirvQGLVHK/D2kN2OEdm0c648LkkSNWEQI6QXj8avPxn5l9iFxOJ6/
         Jv1WlA4jBeBk/I8YXEKJLEcRAJci4tHrqBSH8jXMUu5BlLCptjON8xmZ7ZDe4mWYhPWw
         OVzV4JZEWH37ApVUsbZ6WuFQ/mVBLcbhEATegTwK/63eb/jUXekBAczitGQeNOJBV9ZI
         fWVqoy9LQXlxseRcmdZYMqzDcQjRwu8xAVS8FLWQfqd1unlfTYMjk7uzFpy6ilfAzlSQ
         glPPWKe05k1uBF7g/w6lJ9AjhN8s5xeVa+g2azLbts0Xm1zcIGYz01Ntm2J7Ncq16QSD
         eX+g==
X-Gm-Message-State: AOUpUlFaXYTEmPozzAJkawlFPXlwKEgkMn4l/oBXMNuEF0o8fOV13xOO
        /PJH0/2PalMu5keJUSOsa4yOGkqH
X-Google-Smtp-Source: AAOMgpeE1McjrPAujdZd9j5JAr54hH+f5djw/vbehHUVDmEeyiR3OuWWZDbR5YJq1BIKvXXTohbFDg==
X-Received: by 2002:a1c:d543:: with SMTP id m64-v6mr2299485wmg.12.1532450062977;
        Tue, 24 Jul 2018 09:34:22 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:22 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 08/20] sequencer: refactor append_todo_help() to write its message to a buffer
Date:   Tue, 24 Jul 2018 18:32:09 +0200
Message-Id: <20180724163221.15201-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
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
Dropped the `include` in rebase-interactive.h.

 builtin/rebase--helper.c |  2 +-
 rebase-interactive.c     | 45 ++++++++++++++++++++++++++++------------
 rebase-interactive.h     |  4 +++-
 3 files changed, 36 insertions(+), 15 deletions(-)

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
index 403ecbf3c9..d8b9465597 100644
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

