Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AEA20248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCETS5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41123 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so10732026wrw.8
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8aAcVQNO1BYKCTCDXDbVgYWPwRSoEYEhI/6YPCSQmh0=;
        b=n6qKdbM8JPp7h2FUkm14iz9PiQ+1Znw2NGUakd2PdnZbmBDZU5AqT5GeQUA2THTOUq
         4C8VjHxbSt9QOABJpxIZ2/XWhKC6deykRGqRE6bCyeHDYpTyUOYr9Q61/ET1mR6pxDL8
         grk8ahi6prWR1N5Fsn5ix7/3jq/bge6azMWTrlqrL+XLXomR6WTr7hEh2VhK3SBfeayq
         NKFjElgEvI1PWJ5VGKqON9z7ImeGwALX5tU6RUgXx5yLcf4ptsX/0NlLofC0UvQHrstE
         HIFq8uvB+Dxklhe2mQMci4JXY2BV+gXId8eJhU4qnMwz5eznzLeGY95Hq0dirfmSM+G1
         0lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aAcVQNO1BYKCTCDXDbVgYWPwRSoEYEhI/6YPCSQmh0=;
        b=G26pJkwWjCeWrfcTUPYBCX3efY70shDwJqdtEaEaoI3qaWW4VstIdD8iukUOphZIPH
         7OGGg8JuABCbHVlPe0bANdpWFhzbjx6mGDpdNjUWDjLrrJX2JI4B+hzBXLfUU46+dApN
         0JlLEjs1ES9qnxhnPE6vygvyR4GSkvW2jMMEWEEt8Zz9bM6thEB0TvaMuXtpcplra2Jb
         Rw2iNMGhTLDFQmBD31ptMn0PNqI8R03R1UIx5DdGUujorovwg+rPgP6DVIaVuEDfM9Xa
         RHaA+NeFuLg5CRTZp86Qia1AlA1PWBcRH9DldMKVj/arRf1BtIqLgbv9Y36uPdqhKhQc
         EqcA==
X-Gm-Message-State: APjAAAX2Qs27t3Ncicm5E46Ot/WAUiP9I8Acjam39TrtAeL9tb5K/4S0
        YURyzvPGgmxh+go24WoS1GJb/kKG
X-Google-Smtp-Source: APXvYqw+BNJM86YoCv8CuiASqt3YF5sVuMm7TymWGdJHEql38k1OW86dT0ldl09nvBd9ExeLBa6CNA==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr305304wrv.242.1551813534570;
        Tue, 05 Mar 2019 11:18:54 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:54 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 16/18] rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Date:   Tue,  5 Mar 2019 20:18:03 +0100
Message-Id: <20190305191805.13561-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
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
 builtin/rebase--interactive.c | 24 +++++++++++++++-
 rebase-interactive.c          | 53 +++++++++++++++++++----------------
 rebase-interactive.h          |  4 ++-
 sequencer.c                   |  3 +-
 sequencer.h                   |  1 +
 5 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index ab2c6fcd99..b277239f21 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -64,6 +64,28 @@ static int rearrange_squash_in_todo_file(void)
 	return 0;
 }
 
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
@@ -295,7 +317,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	case EDIT_TODO:
-		ret = edit_todo_list(the_repository, flags);
+		ret = edit_todo_file(flags);
 		break;
 	case SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 807f8370db..aa18ae82b7 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -87,35 +87,40 @@ void append_todo_help(unsigned keep_empty, int command_count,
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
+	/* If the user is editing the todo list, we first try to parse
+	 * it.  If there is an error, we do not return, because the user
+	 * might want to fix it in the first place. */
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
+	/* For the initial edit, the todo list gets parsed in
+	 * complete_action(). */
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
index 8f3836c479..7d46f76a8b 100644
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
index fb31a30d15..195891a267 100644
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

