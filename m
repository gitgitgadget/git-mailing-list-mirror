Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD4A1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeJ1GMa (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37320 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJ1GM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so4414600wmc.2
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiTVaqhHfnTlT931VePo4pnccI7cy+hFNPddHioYj/I=;
        b=j/ybay8pAMT3HW2xTrUWlPW7T+Mh4kTH4bSEl3taJ6fnrsv2Cs+MtydMCuZVUM+CMO
         wg+Jw5tKagcR5wG8HtYqDXbOL7kVesUT5P/2WUuoGYNCMnZyxVOVeURs1nGwBReX827L
         gFMFbKNcauujgQ67mf6yY/ifrG9D3lY0a3PKetQ1GlfsdKYeUVMyzPoczG1CDTkWHzEN
         6Vizv/1AafhbtBpHTVfU36Yq+PEOkI6uqv6C/4kjZ6cpSrixJ7CR+79+iFz/ipSmuztm
         pMnGbn9eteEmR9RSYKFoyBvSdHjcuPzLGMOIrNAQrjWMm78FIAW4MKUBK+0Phlt4uWTz
         pBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiTVaqhHfnTlT931VePo4pnccI7cy+hFNPddHioYj/I=;
        b=udveatjJN4cCKhyyZGfaNtljyHuoyuNF6nLcPIZdqvD4yXUP4+Hw4BhUzUy/hSvvx8
         HUPAjlTHQSf3s+fb8s/78/JuwB8WmgSnmk/HOl8oGq51VAAQbpgFuDDQOihahpNzSTp1
         XRY/VTI40SiB+yGVULUoBihq5oLoYt6908rZoJa57yuyicdEpvCrfntByFLRtXZvVXyt
         xClqv8g80n/XCH5AMCCL7naNrtGQ0JSuH503sE1JoCC3GSaZ+4/0FrKSMALEdED6ucs5
         OOQJHCkhI4MupC5JzZcR5ktBZ9vRm6z7OZpQU+H7SOrpxu3W8Gh4fy/OkDGJBEU8n8CQ
         LYnA==
X-Gm-Message-State: AGRZ1gIR+A4NeoBFWE9/ekG7JCINyey1eIa0Ixj7rCaAN5Aml8K64iTJ
        tYANdBH/o6tt7jIGxJtKsZ7HFEJh
X-Google-Smtp-Source: AJdET5cPpJnyROn5BnTbdA4/kCKtXAr82APT1bHKoxeKTEsjVAFRF3Jazoyiu9dmR8vEghIiYyaaSQ==
X-Received: by 2002:a1c:f313:: with SMTP id q19-v6mr9035569wmq.87.1540675809046;
        Sat, 27 Oct 2018 14:30:09 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 13/16] rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Date:   Sat, 27 Oct 2018 23:29:27 +0200
Message-Id: <20181027212930.9303-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
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
 builtin/rebase--interactive.c | 23 ++++++++++++++++-
 rebase-interactive.c          | 48 ++++++++++++++++++-----------------
 rebase-interactive.h          |  4 ++-
 sequencer.c                   |  3 +--
 sequencer.h                   |  1 +
 5 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index c07330bdff..0f83422aa0 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -13,6 +13,27 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
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
+	    todo_list_write_to_file(&new_todo, todo_file, NULL, NULL, 0, 0, -1,
+				    flags & ~(TODO_LIST_SHORTEN_IDS)) < 0)
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
@@ -234,7 +255,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	case EDIT_TODO:
-		ret = edit_todo_list(flags);
+		ret = edit_todo_file(flags);
 		break;
 	case SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 0643d54b1b..d7a0818ac9 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -86,35 +86,37 @@ void append_todo_help(unsigned keep_empty, int command_count,
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
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	strbuf_stripspace(&todo_list.buf, 1);
-	todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
-	if (todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, 0, 1, -1,
-				    flags | TODO_LIST_SHORTEN_IDS)) {
-		todo_list_release(&todo_list);
-		return -1;
+	unsigned initial = shortrevisions && shortonto;
+
+	if (initial) {
+		todo_list_write_to_file(todo_list, todo_file, shortrevisions, shortonto,
+					0, 1, -1, flags | TODO_LIST_SHORTEN_IDS);
+
+		if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
+			return error(_("could not copy '%s' to '%s'."), todo_file,
+				     rebase_path_todo_backup());
+	} else {
+		todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list);
+		todo_list_write_to_file(todo_list, todo_file, NULL, NULL, 0, 1, -1,
+					flags | TODO_LIST_SHORTEN_IDS);
 	}
 
-	strbuf_reset(&todo_list.buf);
-	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
+		return -2;
 
-	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
-		res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, 0, 0, -1,
-					      flags & ~(TODO_LIST_SHORTEN_IDS));
+	strbuf_stripspace(&new_todo->buf, 1);
+	if (initial && new_todo->buf.len == 0)
+		return -3;
 
-	todo_list_release(&todo_list);
-	return res;
+	if (!initial)
+		todo_list_parse_insn_buffer(new_todo->buf.buf, new_todo);
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
index 4c664d6388..a03505f582 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -54,8 +54,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * file and written to the tail of 'done'.
  */
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
-static GIT_PATH_FUNC(rebase_path_todo_backup,
-		     "rebase-merge/git-rebase-todo.backup")
+GIT_PATH_FUNC(rebase_path_todo_backup, "rebase-merge/git-rebase-todo.backup")
 
 /*
  * The rebase command lines that have already been processed. A line
diff --git a/sequencer.h b/sequencer.h
index 4a051e5dc9..6a1a23541f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -4,6 +4,7 @@
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
 const char *rebase_path_todo(void);
+const char *rebase_path_todo_backup(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
2.19.1

