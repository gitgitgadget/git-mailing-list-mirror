Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189C31F454
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKIRsN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38694 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRsN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id e3-v6so882687wrs.5
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWNvQR+TlZqPo1plbUE80Sb49glXDC5sRo9oaSiI9+I=;
        b=L46jE0n+grvTGBNOBSnokxv3uPK9BRhXUn9bKKUK7ka+Ji2NY5SDmaB/Dwhd1P5Ew3
         sobgt1dXQJQ6E7wOz1tCFksu8Vrw4FGHO3sdiwq/7TgqUbLU5cSHWTZCKZVFFCWWvHk1
         koAgg+p9Bx9JnksT/Y+IyMY0ZV7CkaSEYpW6mMh+nZLcfw/HSEU3kC1aK0iQRsj1Q0bd
         hnVc4dY/3vBbgfSIPfR89e0YLtUePSDusDzOI51nITiQrl8aXjl2LMsU6nnnx+Sl/Q5Q
         LmF1ZptW/rAbtlbcOv4ete19aUtPp0cQGNYt9uMFWE6fbPDXi1lBsRCoxUIX/2/37JAN
         S7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWNvQR+TlZqPo1plbUE80Sb49glXDC5sRo9oaSiI9+I=;
        b=Ypzdfe1AlEvcOcgRs4mkmt++yIFDNSuRrvW//IAIT9qNOqdthw8sR8+IIl3UqCBPxz
         +iKF8zA2uGe6fv66xDLk6g5zYM6Z8thKat0McqGqwEVi+bqZ4xjiGyJhHCfvV571+yJ0
         tSp8QnsR6PDmMwDYJuw+VY4VrGSWcVY2Np/b7hlbMJ4JKhvIG786G8l6dxDoQoUa9uwa
         UGVHx0TLsbOg1vBBX/Nm8FiBTC5kl7Mw9KJsW8r+ZPMabu2HXIuSugv11EHgvoRdpBL6
         AGK3tIe+04dl+ZzKfg6PJ8F1ODbfoxtPY8iH1wUp9Fsk75kW1jm9ijLCf5NScgVH8V3C
         hJZA==
X-Gm-Message-State: AGRZ1gI1auqrPrl8oVe9hGx30rMqIpMXlySdd6wia8RwV+Jb2cOGBkgM
        i7GTbXstpI65Ud7UTcvzoP27PsWF
X-Google-Smtp-Source: AJdET5cMHQfHcArsqEeBU8H8nhUzolFKmt8J7rK0TXiZG4A3ls3ZmUUodew5sL+y8lEcUaNd05x9gQ==
X-Received: by 2002:adf:ded1:: with SMTP id i17-v6mr7105153wrn.307.1541750925782;
        Fri, 09 Nov 2018 00:08:45 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:45 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 13/16] rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Date:   Fri,  9 Nov 2018 09:08:02 +0100
Message-Id: <20181109080805.6350-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
index 99cbd1e8e3..6871990544 100644
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
+	if (!edit_todo_list(&todo_list, &new_todo, NULL, NULL, flags) &&
+	    todo_list_write_to_file(&new_todo, todo_file, NULL, NULL, -1,
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
@@ -241,7 +262,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	case EDIT_TODO:
-		ret = edit_todo_list(flags);
+		ret = edit_todo_file(flags);
 		break;
 	case SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3b7b5e3382..e0fa88b90e 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -87,35 +87,37 @@ void append_todo_help(unsigned keep_empty, int command_count,
 	}
 }
 
-int edit_todo_list(unsigned flags)
+int edit_todo_list(struct todo_list *todo_list, struct todo_list *new_todo,
+		   const char *shortrevisions, const char *shortonto,
+		   unsigned flags)
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
-	if (todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, -1,
-				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
-		todo_list_release(&todo_list);
-		return -1;
+	unsigned initial = shortrevisions && shortonto;
+
+	if (initial) {
+		todo_list_write_to_file(todo_list, todo_file, shortrevisions, shortonto, -1,
+					flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
+
+		if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
+			return error(_("could not copy '%s' to '%s'."), todo_file,
+				     rebase_path_todo_backup());
+	} else {
+		todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list);
+		todo_list_write_to_file(todo_list, todo_file, NULL, NULL, -1,
+					flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
 	}
 
-	strbuf_reset(&todo_list.buf);
-	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
+		return -2;
 
-	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
-		res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, -1,
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
index 61858f3a02..8d5c04521e 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -4,7 +4,9 @@
 void append_todo_help(unsigned keep_empty, int command_count,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
-int edit_todo_list(unsigned flags);
+int edit_todo_list(struct todo_list *todo_list, struct todo_list *new_todo,
+		   const char *shortrevisions, const char *shortonto,
+		   unsigned flags);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index cf6f69c93e..f04b002e37 100644
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
index 996e8ea2a6..f6751d53b9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -9,6 +9,7 @@ struct commit;
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
 const char *rebase_path_todo(void);
+const char *rebase_path_todo_backup(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
2.19.1.872.ga867da739e

