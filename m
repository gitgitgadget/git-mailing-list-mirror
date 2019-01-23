Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4397D1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfAWU7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33048 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfAWU7o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id p7so4161593wru.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEBl/SNnHlVmq9uEpJOQrncd6iqVH5b5S5tD8CIMJoA=;
        b=NRJLGlHeTtJXQ7G0b/Y0R0IWQB244MKEuUdLaa5RHgZLleQIgjdG97tcZRMVj6q+l8
         TlhrQ0SFTP7/kfdi5O12ZicEHoZ8SExcbxnyJU0lwQIjb/dRT+ANPwNJnnxYhWJcNNUF
         4dQZY7iwXVXBTf790IymTEl3B7zJCjr1YRGGs2H9EEEJW/lpLdPRbQQ6Yt173FA51pTj
         z7Wi0OgLFXJWe4Tg/HhTR2HRaA10zm1tEzXHo4BhwLFSNVW4teEJoskig06iyNqMRwwF
         ij15Q6C3efyzV4Ewq7dBS+mDBsPkEpZ9JETTNogD3CjapC5JWlMWZZYlmPNBSbR8copK
         w8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEBl/SNnHlVmq9uEpJOQrncd6iqVH5b5S5tD8CIMJoA=;
        b=UUJJ8GNRNSP2E5sVSQaVvEahnvCW4LMC35ggtjF/UM5HH9OKaS3KwBrALPTxwUB2It
         Ke6Kp/j6sFqwUbemws0UORTnp4hZsMcAq4ewZQBZIF2XLFdYfyyq4TZ2o6XcVfvBYLOx
         sCT6ePtaMPjGEtAMmKRqk9j7623TbADH9ZDxXSSjAtDqtAjwHuLoYUh0ycR9r+E4ptOZ
         GPGE33HaGsR5Bq1GopLAzNpgMmWfddH+AX+zPCFip/HtwtpObI8ELBtJ/xVxvVfVs9aU
         xfIc8t5E/23rxEPnk0w7De1RfDiqNQnG95PtNnz1tH/m6HsHgDCnjpKZVU+J8MIYZxp0
         BXWA==
X-Gm-Message-State: AJcUukfYSfC49TuazLbEyMHj7TC54pHEJna6xiY1byM5eDesFhuekL/I
        /eY3ibqGPrBVEXI8wKIhoQbOR+u4
X-Google-Smtp-Source: ALg8bN6nQ69n/DztAXcpAT8eFiUc8t8sm6b4CbXD3u7MNqa0HW2r7YvBOhcqrUdjnKG88O1Vzy25lg==
X-Received: by 2002:adf:8323:: with SMTP id 32mr4185323wrd.176.1548277182474;
        Wed, 23 Jan 2019 12:59:42 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 14/16] rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Date:   Wed, 23 Jan 2019 21:58:19 +0100
Message-Id: <20190123205821.27459-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
 <20190123205821.27459-1-alban.gruin@gmail.com>
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
take the commits that have already been processed by the rebase (ie. the
todo list is edited in the middle of a rebase session).

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Unchanged since v4.

 builtin/rebase--interactive.c | 24 +++++++++++++++++-
 rebase-interactive.c          | 48 ++++++++++++++++++-----------------
 rebase-interactive.h          |  4 ++-
 sequencer.c                   |  3 +--
 sequencer.h                   |  1 +
 5 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 2dbf8fc08b..645ac587f7 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -13,6 +13,28 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
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
+	if (!edit_todo_list(the_repository, &todo_list,
+			    &new_todo, NULL, NULL, flags) &&
+	    todo_list_write_to_file(the_repository, &new_todo, todo_file, NULL, NULL,
+				    -1, flags & ~(TODO_LIST_SHORTEN_IDS)) < 0)
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
@@ -242,7 +264,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	case EDIT_TODO:
-		ret = edit_todo_list(the_repository, flags);
+		ret = edit_todo_file(flags);
 		break;
 	case SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 807f8370db..3301efbe52 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -87,35 +87,37 @@ void append_todo_help(unsigned keep_empty, int command_count,
 	}
 }
 
-int edit_todo_list(struct repository *r, unsigned flags)
+int edit_todo_list(struct repository *r, struct todo_list *todo_list,
+		   struct todo_list *new_todo, const char *shortrevisions,
+		   const char *shortonto, unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	strbuf_stripspace(&todo_list.buf, 1);
-	todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
-	if (todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
-				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
-		todo_list_release(&todo_list);
-		return -1;
+	unsigned initial = shortrevisions && shortonto;
+
+	if (initial) {
+		todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
+					-1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
+
+		if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
+			return error(_("could not copy '%s' to '%s'."), todo_file,
+				     rebase_path_todo_backup());
+	} else {
+		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
+		todo_list_write_to_file(r, todo_list, todo_file, NULL, NULL, -1,
+					flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
 	}
 
-	strbuf_reset(&todo_list.buf);
-	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
+		return -2;
 
-	if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list))
-		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
-					      flags & ~(TODO_LIST_SHORTEN_IDS));
+	strbuf_stripspace(&new_todo->buf, 1);
+	if (initial && new_todo->buf.len == 0)
+		return -3;
 
-	todo_list_release(&todo_list);
-	return res;
+	if (!initial)
+		todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
+
+	return 0;
 }
 
 define_commit_slab(commit_seen, unsigned char);
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 0e5925e3aa..44dbb06311 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -8,7 +8,9 @@ struct todo_list;
 void append_todo_help(unsigned keep_empty, int command_count,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
-int edit_todo_list(struct repository *r, unsigned flags);
+int edit_todo_list(struct repository *r, struct todo_list *todo_list,
+		   struct todo_list *new_todo, const char *shortrevisions,
+		   const char *shortonto, unsigned flags);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 92de982bc4..8f47f0cf39 100644
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
index c5bee8124c..68acab980b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -10,6 +10,7 @@ struct repository;
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
 const char *rebase_path_todo(void);
+const char *rebase_path_todo_backup(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
2.20.1

