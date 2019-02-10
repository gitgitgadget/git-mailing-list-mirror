Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24AB1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBJN12 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40016 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfBJN1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so11785968wmc.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVRrBEJxojslbzgeM5QC9mzWNArR0LW8Q4OeDlon1Ls=;
        b=ihFMdUlpFaB8eQxLz19mqZXX0gLlEf+Ul0I5A1o/Qk1efDENfhg1/9oqm05VKBuPVD
         ARu2GOO+NrWQ3DNkUZ1vTSt74PkYliAlhD9jWlzqN17ydQDwx+vu1j7B3GLlla91cRCx
         7uDa00JC55rQ3pkvwSa3sXyRRcgvy0zLj85SIMttA00IuiEjmzSgmTCp2M21RLOmlfJw
         7W9yKmCRG6fuewwV2ZyFd3Ri4LWT1VHKubfu7DaEPg69mIID757yoKm9UfKvsaKCYywZ
         jly3ktUtCPlpOP/c664+c3oPySRkNC9lXvpviYPywKVLUzc60ZN9HOh54fP0z5mPuHZd
         0O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVRrBEJxojslbzgeM5QC9mzWNArR0LW8Q4OeDlon1Ls=;
        b=uHkSj+l+Sj2duHred2m6NN2xMBT2Jls7PM1cPD770orMbd3MxVE9TGTv6FJWFyt4Vf
         cUnwJeWYPV962xKPjNVbsD1bAix3gbKZo5C2SOn1V0uwFKDIOarDNYtLueQcJIHhWCCP
         5J18jPEVlDzDFp4y1R5xkzhKfO+Dkec31nuJKrqm1xiHf6UFdQuhbjJLTI8It3P/y5BU
         5tRZw2d4DbBQgCOlqnqeTMrSRjB765Z3rFTWwLhp31VH2Ma+yjeK3fYJyDvdEiwHIKVO
         5kGovKusGLmnK8F/PGHvWJweRhkJ+FfpZiRtCjpodCDLx7+Ao3DV3RppkRLREpiOPpBT
         0F7g==
X-Gm-Message-State: AHQUAuaqdVo9oD/etFrzQjhOcvrAidECLWqs9DfIJLBCshVZSK/inCIr
        6WAjiHUBbCAmRa2BvbzDSobRMNZn
X-Google-Smtp-Source: AHgI3Iaynonw2u6jbKce8B9F9iyPuBJJnhwa2T+TGWJ80n1shA0+3QG7uzOsNxzNerl1KEhcAxQxKw==
X-Received: by 2002:adf:c704:: with SMTP id k4mr1197835wrg.142.1549805243227;
        Sun, 10 Feb 2019 05:27:23 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:22 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 14/16] rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Date:   Sun, 10 Feb 2019 14:26:46 +0100
Message-Id: <20190210132648.12821-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
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
 builtin/rebase--interactive.c | 24 +++++++++++++++++-
 rebase-interactive.c          | 48 +++++++++++++++++------------------
 rebase-interactive.h          |  4 ++-
 sequencer.c                   |  3 +--
 sequencer.h                   |  1 +
 5 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 4f2949922f..370d584683 100644
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
+	int res = 0;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	strbuf_stripspace(&todo_list.buf, 1);
+	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
+	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
+					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
+		res = error_errno(_("could not write '%s'"), todo_file);
+
+	todo_list_release(&todo_list);
+	todo_list_release(&new_todo);
+
+	return res;
+}
+
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
@@ -241,7 +263,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	case EDIT_TODO:
-		ret = edit_todo_list(the_repository, flags);
+		ret = edit_todo_file(flags);
 		break;
 	case SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 807f8370db..96c70d1959 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -87,35 +87,35 @@ void append_todo_help(unsigned keep_empty, int command_count,
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
-	}
+	unsigned initial = shortrevisions && shortonto;
 
-	strbuf_reset(&todo_list.buf);
-	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (!initial)
+		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
 
-	if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list))
-		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
-					      flags & ~(TODO_LIST_SHORTEN_IDS));
+	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
+				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
+		return error_errno(_("could not write '%s'"), todo_file);
 
-	todo_list_release(&todo_list);
-	return res;
+	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
+		return error(_("could not copy '%s' to '%s'."), todo_file,
+			     rebase_path_todo_backup());
+
+	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
+		return -2;
+
+	strbuf_stripspace(&new_todo->buf, 1);
+	if (initial && new_todo->buf.len == 0)
+		return -3;
+
+	if (!initial)
+		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
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
index 64d698032c..f6ed4e21e9 100644
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
index c80990659c..b0688ba2a1 100644
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

