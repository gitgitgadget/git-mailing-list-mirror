Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9161F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeL2QF3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34314 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeL2QFV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so19736583ede.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YnBxIJu1VO4278rtGLRn8uxwkLnxxLwMy5RySNP40zY=;
        b=ZUbg+oR/sL9YzAGC37Nfi948G+SzLhZEYMWubMVCZGYr0PFkVI6VqbMeXdasabTJbC
         d9rhfDP9Aao4v8lp5yFbxlUpezGmixdPNGd5cDyA8fLEa6VJiMMQgSldrtC2UAI0q2Ya
         JBUfBL6dKrZzTelflqGSMecAzPwmx/TicKHVYqgOq0/erXaRfHSY4+zFG1qL2AgxEcAL
         1Y614fqe6uc5MW0Asw+j/MSQ1M3f2g4BdSZwPLOZSdQZiU37jFVtizeCaxrw2b1GoUaP
         NwPkc7Uyzzp4Y9GOZjsfevmXyQgLYBejfvyzjGgySXOyEzpAobaVaLg7U+Wt184Yapm3
         MobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YnBxIJu1VO4278rtGLRn8uxwkLnxxLwMy5RySNP40zY=;
        b=ESWrj+XoF9N4aJ8Vy2TFlO2YC839zLIp1zA/eBE6CsSlDxtamVKbYpyXNNz0U79x2M
         sVoCz3t4ywYFN2Sv8SyPM2oyfG2BInDNiJM4C6+Rm5VhaT5hiTNsZUFX+9vaqYlChXtf
         fMSp937rfrmrHB0P7LUy/Eh/lD/sWdpWfOt/rBnY2gtb4lVN1skPQ5TKfMx/EGsG0z3w
         sIYU5xVJUrmI3yu/TMyzyh+2f+Ycc/TuEyc4owXHAVXNN4cgdn/1NW9k4pSkabE3oZTS
         7ZS/LQR1BQu8gsf13BmEMwl4rXYkQpKRfuvviJtxlPx1fVhLtE4OS5PjLyZCqFtxvocR
         BYvA==
X-Gm-Message-State: AA+aEWYD8ypsR7zdz5PcwfyrI0HAeCy5Pr55Nd9bYAg1m2I+vYScafyP
        9ZAvO+TMLuR/JVbTBdIP8SCidKvU
X-Google-Smtp-Source: AFSGD/Wrh0m5eQR3csX5Y2ke6kIlNKwbcmG74HbpLAX4vDys91tBH6amLe4qhuehU5LjPDHO9H4lTQ==
X-Received: by 2002:a50:f5af:: with SMTP id u44mr27179504edm.172.1546099519225;
        Sat, 29 Dec 2018 08:05:19 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:18 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 14/16] rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Date:   Sat, 29 Dec 2018 17:04:11 +0100
Message-Id: <20181229160413.19333-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
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
Changes due to conflicts with nd/the-index.

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
index 32f95002df..7542e70a55 100644
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
index 2f6675eabd..42cc3f865d 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -7,7 +7,9 @@ struct repository;
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
index dfc705291d..0500a32e80 100644
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
index dcbd682e63..7dd85bb399 100644
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

