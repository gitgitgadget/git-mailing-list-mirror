Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0D81F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeJHDIq (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:46 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37842 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeJHDIq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:46 -0400
Received: by mail-wr1-f49.google.com with SMTP id y11-v6so7831026wrd.4
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DvgTeq10F6UWuq8bSIDOGvI0h8opb0/Aja1C2ZWICI=;
        b=n8Zgkn6WPpuLQ2LUvKqYNbPHFpRIIDEVKHM10/5KORVTTxE3s5iYmjNWac4z125IFE
         KG10yUc1/akPx5RJZQm/g7LvAqLAZpl6O7SODJpvmLotyTJ+lJGQU0YKUROSCj64BWNC
         QCBhOZJrwKtr96LbJjcKxLda0ysUmOXSmowuTNMqGLFwAor6YkbZ0YjO7DOZm6esL1mi
         nxHo948B0gt6kCWU5d0TBrmU+ZMmitgkZhIF9CXdK2R4XPCVANgy4X7AbVKzRwXznptF
         PxMC54pgoVnvfmFDr+/IUjyfWa8E1OcqcGqV3oFzDhW560LD0yitGXAvYpRjpAQbs3YC
         xxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DvgTeq10F6UWuq8bSIDOGvI0h8opb0/Aja1C2ZWICI=;
        b=tuyFuhXblkhm6KTg25WnJqES7HFpNETveyLt4/XKsZ06kVK0BuT7oULzjyxRlG3Rz0
         9llMi+LClaoYduRMnC4Vqkt2t5/mBOXkVnyz1TMAkjLPoAKgtxCaYMNNYWj2HgQf5phH
         wg2oeyUCiKNK1S0qAdG6d8JbfwEjI9KNylX0HOmhzrU7wrQDY5a/j9TINy5ZHVaTpWQH
         F56gKqY0a2I4LVacLbJFMsTwF28katcaAkoeTs+vngfQonsBjFjloC4azvdtOYbgKpfd
         bC+Hd4iatb5nbIJwvwweeXGHLvb9YFBo4Fn7R/iyspVBaxAAsV6q7O6j7luRepE01pNA
         X5Tw==
X-Gm-Message-State: ABuFfoj9k/Ptc9u3XPhXCLNgbgOzxJJSA9ixU/lmzNLUpjTD8JXpoQbI
        8hLjCL91WI0ap1T3gh2dtEVUoKtx
X-Google-Smtp-Source: ACcGV63NXJIHEYrXgPVipM61wUW6kknHhCMxl6Fh6PPcbuJT+eFj1GWbh0+FRCXn5icTpuzWbgUQ1Q==
X-Received: by 2002:adf:ad65:: with SMTP id p92-v6mr15023929wrc.7.1538942421924;
        Sun, 07 Oct 2018 13:00:21 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:21 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 12/15] rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Date:   Sun,  7 Oct 2018 21:54:15 +0200
Message-Id: <20181007195418.25752-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

edit_todo_list() is changed to work on a todo_list, and to handle the
initial edition of the todo list (ie. making a backup of the todo
list).

It does not check for dropped commits yet, as todo_list_check() does not
work if the old todo list has invalid commands.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c | 22 +++++++++++++++-
 rebase-interactive.c          | 49 ++++++++++++++++++-----------------
 rebase-interactive.h          |  4 ++-
 sequencer.c                   |  3 +--
 sequencer.h                   |  1 +
 5 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 0700339f90..264e940b47 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -13,6 +13,26 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 
+static int edit_todo_file(unsigned flags)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT,
+		new_todo = TODO_LIST_INIT;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	strbuf_stripspace(&todo_list.buf, 1);
+	if (!edit_todo_list(&todo_list, &new_todo, flags, 0, NULL, NULL) &&
+	    write_message(new_todo.buf.buf, new_todo.buf.len, todo_file, 0) < 0)
+		return error_errno(_("could not write '%s'"), todo_file);
+
+	todo_list_release(&todo_list);
+	todo_list_release(&new_todo);
+
+	return 0;
+}
+
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
@@ -231,7 +251,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	case EDIT_TODO:
-		ret = edit_todo_list(flags);
+		ret = edit_todo_file(flags);
 		break;
 	case SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 7168d56d17..6ee60ac03f 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -86,39 +86,40 @@ void append_todo_help(unsigned keep_empty, int command_count,
 	}
 }
 
-int edit_todo_list(unsigned flags)
+int edit_todo_list(struct todo_list *todo_list, struct todo_list *new_todo,
+		   unsigned flags, int command_count,
+		   const char *shortrevisions, const char *shortonto)
 {
 	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res = 0;
+	unsigned initial = shortrevisions && shortonto;
 
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
+	if (initial || !todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list))
+		todo_list_transform(todo_list, flags | TODO_LIST_SHORTEN_IDS);
 
-	strbuf_stripspace(&todo_list.buf, 1);
-	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
-		todo_list_transform(&todo_list, flags | TODO_LIST_SHORTEN_IDS);
+	if (initial)
+		append_todo_help(flags & TODO_LIST_KEEP_EMPTY, command_count,
+				 shortrevisions, shortonto, &todo_list->buf);
+	else
+		append_todo_help(flags, 0, NULL, NULL, &todo_list->buf);
 
-	append_todo_help(flags, 0, NULL, NULL, &todo_list.buf);
+	if (write_message(todo_list->buf.buf, todo_list->buf.len, todo_file, 0))
+		return error_errno(_("could not write '%s''"), todo_file);
 
-	if (write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
+		return error(_("could not copy '%s' to '%s'."), todo_file,
+			     rebase_path_todo_backup());
 
-	strbuf_reset(&todo_list.buf);
-	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
+		return -2;
 
-	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
-		todo_list_transform(&todo_list, flags & ~(TODO_LIST_SHORTEN_IDS));
-		res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
-	}
+	strbuf_stripspace(&new_todo->buf, 1);
+	if (initial && new_todo->buf.len == 0)
+		return -3;
 
-	todo_list_release(&todo_list);
-	return res;
+	if (!initial && !todo_list_parse_insn_buffer(new_todo->buf.buf, new_todo))
+		todo_list_transform(new_todo, flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	return 0;
 }
 
 define_commit_slab(commit_seen, unsigned char);
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 61858f3a02..83cde455e6 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -4,7 +4,9 @@
 void append_todo_help(unsigned keep_empty, int command_count,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
-int edit_todo_list(unsigned flags);
+int edit_todo_list(struct todo_list *todo_list, struct todo_list *new_todo,
+		   unsigned flags, int command_count,
+		   const char *shortrevisions, const char *shortonto);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 94d3058359..bfcbe8239b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -55,8 +55,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * file and written to the tail of 'done'.
  */
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
-static GIT_PATH_FUNC(rebase_path_todo_backup,
-		     "rebase-merge/git-rebase-todo.backup")
+GIT_PATH_FUNC(rebase_path_todo_backup, "rebase-merge/git-rebase-todo.backup")
 
 /*
  * The rebase command lines that have already been processed. A line
diff --git a/sequencer.h b/sequencer.h
index 5bd3b79282..fa84918c55 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -9,6 +9,7 @@ struct commit;
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
 const char *rebase_path_todo(void);
+const char *rebase_path_todo_backup(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
2.19.1

