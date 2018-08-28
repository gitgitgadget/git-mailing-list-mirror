Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792BB1F451
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeH1QCi (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:38 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:50953 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeH1QCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:37 -0400
Received: by mail-wm0-f44.google.com with SMTP id s12-v6so1683706wmc.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqBhypkTubl5/V9wcn8v8BqltZe4066sTAEXuKXZZW4=;
        b=dIR6LI/j6o0GRkm4aU5Nfs4XKRo1850zfeiX+tLJdv3qZ5VPAWtz9q5M7PaWiAHc1w
         WfxLf4k2b8pLlXZXJ4Q8r7zqfxZerNEfNV9wsdBn8pe5WSstqdNJnJJXvLfpxDfOT+1n
         NQHjbRzRLHUmLaBWjt4LSC1Ocaj0sQjpgTrzYOXBxiw7Uo7+VVpDoKfVvNHQEYaDXTum
         LpYqhzYtBwiE7EVc9vxBiS0yhiLMsKmb7W9X1JjFl2jhoD2MNrDElb8sk9TSTSsh3W+r
         mJWOZPRckKrf0ECiFWEm0OgDRs2ljKCufwm357C02K3rHASX2slSHkn4CVdAd0+gKq4k
         G+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqBhypkTubl5/V9wcn8v8BqltZe4066sTAEXuKXZZW4=;
        b=m3D6+nVJBIM6R6ksSQlOqIH4+jZbj4Xz5PtWnbL97QGhbOb0+to5RhqGv3CXytkbeQ
         EiWeDOk9eG+VTBQd5C4YuOV850I1AYb9rmZLYMcpwqh4pjFN1mvvwYezY5BBwttLDj70
         tiUX8G3IcCA4+nIcQctYfrTHDDtSZyKKCF1MtVzFTUYTvdMVj8BX5GTvvgjhdwPUs1mq
         ZvAbsB1VzLudbUV4DIg1yiv9+W0WRNizYpByP4DyoOprf7/mRtoUoWlED1QWSCWkGgdF
         B0gdmPdYnLuLzZ8JVp4hBWI3Q8a0G7gIiHPPC2PQGJWTTucU+YbBriSlIrxO8XOiFDCY
         O3og==
X-Gm-Message-State: APzg51Av52It1i9PasfgyD+cusoON4d6qFNGqfv86ZaZtwZsuc0N85Hd
        iowCu2ejQLrBV7Uk8tt69n7zpZbl
X-Google-Smtp-Source: ANB0VdZ/MDXl/7YuvMxurDimn/4kNtACF9SNJwVPPPCLowTed2/nrxiTd8CpdMc2xQlJjMBecJ1COw==
X-Received: by 2002:a1c:7dc7:: with SMTP id y190-v6mr1119259wmc.62.1535458274350;
        Tue, 28 Aug 2018 05:11:14 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:13 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 08/20] sequencer: refactor append_todo_help() to write its message to a buffer
Date:   Tue, 28 Aug 2018 14:10:33 +0200
Message-Id: <20180828121045.14933-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
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
No changes since v6.

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

