Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93F020248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfCETSd (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:33 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39218 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCETSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:32 -0500
Received: by mail-wr1-f51.google.com with SMTP id l5so10724439wrw.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S49Q0Ijx+JrGQcCBc9kV3RDyBRzsMyck4B6xQ08KOog=;
        b=q3bAom56vRfIDRbFRfmYqhJzzBggujGwG2hNnB90NmuupXaXErLzP63rT6u+++5K/K
         cbw+vpzS7yuVYHtZmtE/qDoKcXQSY4L7YrwzUlrWulzv2oOsxx75QrHMr3hF2hUuMhKa
         IEkWhYJGmSxvZFgraPQtU3CRaQCewQZRFaSKuMFVy0KX0gZKB23bATp8mdaQrlATfSOl
         ly6TT5wsbVNhGIL8LUjtGZYsZTkRkd/PJW6CKkGnpKqWaJSwYPX6C5vbRwef59ZhnRuM
         92WxpN7EOrUn1MJOl6a+4MSIxBqRoqFrwtslNpL+Uw3mYG8Ypy3UNi/KxCNn1hK+3IFZ
         D1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S49Q0Ijx+JrGQcCBc9kV3RDyBRzsMyck4B6xQ08KOog=;
        b=S9itGBsiLGtbTfNFfLOStp4bb4p3bvUdJa+cq19B2WAPisFo3hz5doh8CgPqmKYdAd
         0c9V9uK9qrBUh8T8viaKC4nMtK4MYyrw7WHXg3HT0yXx6YfpAa4rXVk4pJFBb4jEAjsK
         YsNnS7ND8AkmDvl5NGzBEedVM0q/zg4dFLBGc0iAd4bsXjFY0wZuAfxKE3nv3ubITtO5
         MVT4/DlDcLqdzGoCmZ3gw4CuWEFsf6IwFKcqCNT/6n4xC+dr5Jo2KtWXaT2sQHflKlKR
         mZ54hPLHqNhO2VrPeQJLIzs4EgewxyjGlNRQJXUTUC/KbOALVqL6ka0cXC0cWlnTVPgd
         Q4wQ==
X-Gm-Message-State: APjAAAXMO8/WmXqsfd0GZRVvrLzozRGtj/gNehUSt2WoxJXhmRcU30uH
        2N0nezOmRKur3Q3l9HNpGzHQ1R3O
X-Google-Smtp-Source: APXvYqxdV75LZnNSkewxd3BfGJ63Aem9+JgZ6PHGlTnuWdl/IKC2goKS4qSenv+LtSvexNV1bw95cA==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr266759wrs.307.1551813509897;
        Tue, 05 Mar 2019 11:18:29 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:29 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 04/18] sequencer: refactor transform_todos() to work on a todo_list
Date:   Tue,  5 Mar 2019 20:17:51 +0100
Message-Id: <20190305191805.13561-5-alban.gruin@gmail.com>
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

This refactors transform_todos() to work on a todo_list.  The function
is renamed todo_list_transform().

As rebase -p still need to check the todo list from the disk, a new
function is introduced, transform_todo_file().  It is still used by
complete_action() and edit_todo_list() for now, but they will be
replaced in a future commit.

todo_list_transform() is not a static function, because it will be used
by edit_todo_list() from rebase-interactive.c in a future commit.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 builtin/rebase--interactive.c |  2 +-
 rebase-interactive.c          |  4 +--
 sequencer.c                   | 54 +++++++++++++++++++++++------------
 sequencer.h                   |  4 ++-
 4 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index dd2a55ab1d..0898eb4c59 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -253,7 +253,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	}
 	case SHORTEN_OIDS:
 	case EXPAND_OIDS:
-		ret = transform_todos(the_repository, flags);
+		ret = transform_todo_file(the_repository, flags);
 		break;
 	case CHECK_TODO_LIST:
 		ret = check_todo_list(the_repository);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 68aff1dac2..842fa07e7e 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -69,7 +69,7 @@ int edit_todo_list(struct repository *r, unsigned flags)
 
 	strbuf_release(&buf);
 
-	transform_todos(r, flags | TODO_LIST_SHORTEN_IDS);
+	transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS);
 
 	if (strbuf_read_file(&buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
@@ -85,7 +85,7 @@ int edit_todo_list(struct repository *r, unsigned flags)
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
 
-	transform_todos(r, flags & ~(TODO_LIST_SHORTEN_IDS));
+	transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS));
 
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index c844a9b7f3..346706029c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4562,27 +4562,18 @@ int sequencer_add_exec_commands(struct repository *r,
 	return i;
 }
 
-int transform_todos(struct repository *r, unsigned flags)
+void todo_list_transform(struct repository *r, struct todo_list *todo_list,
+			 unsigned flags)
 {
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct todo_item *item;
 	int i;
 
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
+	for (item = todo_list->items, i = 0; i < todo_list->nr; i++, item++) {
 		/* if the item is not a command write it and continue */
 		if (item->command >= TODO_COMMENT) {
 			strbuf_addf(&buf, "%.*s\n", item->arg_len,
-				    todo_item_get_arg(&todo_list, item));
+				    todo_item_get_arg(todo_list, item));
 			continue;
 		}
 
@@ -4613,12 +4604,39 @@ int transform_todos(struct repository *r, unsigned flags)
 			strbuf_addch(&buf, '\n');
 		else
 			strbuf_addf(&buf, " %.*s\n", item->arg_len,
-				    todo_item_get_arg(&todo_list, item));
+				    todo_item_get_arg(todo_list, item));
 	}
 
-	i = write_message(buf.buf, buf.len, todo_file, 0);
+	strbuf_reset(&todo_list->buf);
+	strbuf_add(&todo_list->buf, buf.buf, buf.len);
+	strbuf_release(&buf);
+
+	if (todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list))
+		BUG("unusable todo list");
+}
+
+int transform_todo_file(struct repository *r, unsigned flags)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_transform(r, &todo_list, flags);
+
+	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
 	todo_list_release(&todo_list);
-	return i;
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
 }
 
 enum missing_commit_check_level get_missing_commit_check_level(void)
@@ -4880,7 +4898,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todos(r, flags | TODO_LIST_SHORTEN_IDS))
+	if (transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS))
 		return error(_("could not transform the todo list"));
 
 	strbuf_reset(buf);
@@ -4909,7 +4927,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
-	if (transform_todos(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
+	if (transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
 		return error(_("could not transform the todo list"));
 
 	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
diff --git a/sequencer.h b/sequencer.h
index 50d552429c..2ddb20cbc1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -121,6 +121,8 @@ struct todo_list {
 
 int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 				struct todo_list *todo_list);
+void todo_list_transform(struct repository *r, struct todo_list *todo_list,
+			 unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 const char *todo_item_get_arg(struct todo_list *todo_list,
 			      struct todo_item *item);
@@ -148,7 +150,7 @@ int sequencer_make_script(struct repository *repo, FILE *out,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(struct repository *r, const char *command);
-int transform_todos(struct repository *r, unsigned flags);
+int transform_todo_file(struct repository *r, unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
-- 
2.20.1

