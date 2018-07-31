Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B1E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeGaTmA (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53711 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeGaTmA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so4066758wmh.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cJjA3k3BcElMWFRBSnekQC+c1WskwEWpqdxMdX3KMd8=;
        b=gAIY3x3iIHmBn3Nl6uusGZlY45E8Cnh0uXESxebasDUk4hJtVWL34b92PUmUsxN9Se
         6sKLTG6g1e6YwKoqNY8RFIuJhv7wHkKURLAjckUAYC90dVVJuj/IaTwoWIs5CLPfJE7s
         ZGmwKUeUFJToXRi33Hs1s6St4hPgzTvl2FBDvcJd6XMvjzvHetTQJ3h7mw9cSN2UTPbm
         U3ypHT5nS1FgMQUB6v8TOCNE+ycAXPQpa4bzoQbmmAvQYS1zZK7zuXweeXJ3ogwuyHPH
         5QXuZRBFU2WSrvQdsZvSIEXNTS5rthkQ4t1FVQnSEWCRsjCVhr+Ww/0azvE30VlVcPFx
         iT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cJjA3k3BcElMWFRBSnekQC+c1WskwEWpqdxMdX3KMd8=;
        b=hNZKd5aT1pTjKclaB3MjuMMOrN5L+8sPOFRbQ1PFSIhS2vO6DkM8wpGNUPkFFv/mkT
         04adFS+Vl2AhXvhSKIRF4DXxxTKQXTsq8ZHIbdP3U0qY6AjrSFxwjhpS3arSlKFlQUBH
         ltY6lhMyc0yw+p7dJH5NxFf7yGmn1dN4KjNRaU0jKq0Op69LOHPg/dUcSsralS2GmSKF
         pVxJg3GIo3/dgiisTR+ofAkYxifjD8rouo8tg65zIlJLYkS5hRcNmHsdhs0K5ElHHV2J
         ZjmF1Y8hC6BvIBpPBSyOOlue5I9iIaDRd1arSAU98IuM6VX17WWuN5bdaLmjAsqQJaT7
         VSfw==
X-Gm-Message-State: AOUpUlFxpdOIuUFZcLA/SHpmaMx2UnNxJ5SaEn3Hv2pbcoJoXCWiDk0J
        rXjnd0Q8GoHwBYPUrdISmafiomJe
X-Google-Smtp-Source: AAOMgpfMIoBJ6c7RCb/POVDsIF5+OZXGvaq4EmggAI/QNKfP9qoq9Ie/n4HZ4NzBmFpU/Qjb2rADoQ==
X-Received: by 2002:a1c:7d47:: with SMTP id y68-v6mr470124wmc.62.1533060031383;
        Tue, 31 Jul 2018 11:00:31 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:30 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 08/20] sequencer: refactor append_todo_help() to write its message to a buffer
Date:   Tue, 31 Jul 2018 19:59:51 +0200
Message-Id: <20180731180003.5421-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
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
No changes since v4.

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

