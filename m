Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7E71F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeJ1GMP (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36579 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJ1GMP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so4666251wrw.3
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr3jhWiAq88YQJ2uHIyUDQyAA9zf1KQSGgZLd7WwOtE=;
        b=cD74CYMJbGPpyPO6zVtQNxezfjhPFjt2oAwGzNjp80hk1g9fQ+B9u4vuOFr4xKN/Uh
         J//uLOvtQU2OMj7b53bZgreQRxbeGqP2eW3B+5DKecKfADjt3GhkT+EJXkB8DcgVQ7RK
         1DHWAxAKnlDHEZKudZqIBqFttPBARXC2FEPIzWpmc/gTE+iTj3294eGiBJhlVd6GCphS
         d4IdLAh1m7rTALVZXOOMT2OuJ+zR4kknZt8fe4VYNJ55E4q2Of7KhFHfKTeVFaCqmC6u
         xv4AUT5LsZkE9d87buKqN+QSqK7l2gHDdjyD2/cOy+QEeYV1dDUSeliThCnsfjMDSaCT
         GqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gr3jhWiAq88YQJ2uHIyUDQyAA9zf1KQSGgZLd7WwOtE=;
        b=iHCneeTRrRcLYkiyRFNN7hQ2+JZO+IO6JH40N+2tmizVq9JL5ifOacrghgOoFqc8Sn
         SpneYE5MhyQEsmjYGbYjznr4z3nWItIwqgy3//0LoiI8y6UkBTi8v6qKszlndmC2IJVR
         sbl8SErpLzwmYJUIy+yHPpKxWwuiYuw6+XyuXhu3Y103y6yMn3Ln0tIh7dLU6PGCifSJ
         89OubQYI4MaQS+ajGpOXa/wfece8P0E6BNGiH0PyCh4y5pgBK6SJncNhqQf2UNaHeNO+
         JmQCtlKSg4QgxEFnnnDqppd69CU4DMk7IF+6Shhj4+aHlq1wLhAs9rG7ewO9VcEJlMY4
         WLXw==
X-Gm-Message-State: AGRZ1gJb33hH0GHX+crz1IiET787pe3bVkosVmVScTbI9AFtb+yu615f
        pJn6tW2xfpQSHNM3f41Tu4gDCUT7
X-Google-Smtp-Source: AJdET5c7btVWO5U6B4gpxyf04+fnm4VBnQiwsJJHIG4fjNxv3/EgxMJdvviS5d73BHhE3L/U0UXPuA==
X-Received: by 2002:adf:e403:: with SMTP id g3-v6mr9284687wrm.96.1540675795255;
        Sat, 27 Oct 2018 14:29:55 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:29:54 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 03/16] sequencer: refactor transform_todos() to work on a todo_list
Date:   Sat, 27 Oct 2018 23:29:17 +0200
Message-Id: <20181027212930.9303-4-alban.gruin@gmail.com>
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
 builtin/rebase--interactive.c |  2 +-
 rebase-interactive.c          |  4 +--
 sequencer.c                   | 46 +++++++++++++++++++++++------------
 sequencer.h                   |  3 ++-
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index a2ab68ed06..abdf6126df 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -252,7 +252,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	}
 	case SHORTEN_OIDS:
 	case EXPAND_OIDS:
-		ret = transform_todos(flags);
+		ret = transform_todo_file(flags);
 		break;
 	case CHECK_TODO_LIST:
 		ret = check_todo_list();
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 0f4119cbae..49f2f549e1 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -68,7 +68,7 @@ int edit_todo_list(unsigned flags)
 
 	strbuf_release(&buf);
 
-	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	transform_todo_file(flags | TODO_LIST_SHORTEN_IDS);
 
 	if (strbuf_read_file(&buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
@@ -84,7 +84,7 @@ int edit_todo_list(unsigned flags)
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
 
-	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+	transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS));
 
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index f791729271..07296f1f57 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4256,23 +4256,13 @@ int sequencer_add_exec_commands(const char *commands)
 	return i;
 }
 
-int transform_todos(unsigned flags)
+void todo_list_transform(struct todo_list *todo_list, unsigned flags)
 {
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct todo_item *item;
 	int i;
 
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
+	for (item = todo_list->items, i = 0; i < todo_list->nr; i++, item++) {
 		/* if the item is not a command write it and continue */
 		if (item->command >= TODO_COMMENT) {
 			strbuf_addf(&buf, "%.*s\n", item->arg_len, item->arg);
@@ -4308,9 +4298,33 @@ int transform_todos(unsigned flags)
 			strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
 	}
 
-	i = write_message(buf.buf, buf.len, todo_file, 0);
+	strbuf_reset(&todo_list->buf);
+	strbuf_add(&todo_list->buf, buf.buf, buf.len);
+	strbuf_release(&buf);
+
+	if (todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list))
+		BUG("unusable todo list");
+}
+
+int transform_todo_file(unsigned flags)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_transform(&todo_list, flags);
+
+	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
 	todo_list_release(&todo_list);
-	return i;
+	return res;
 }
 
 enum missing_commit_check_level get_missing_commit_check_level(void)
@@ -4571,7 +4585,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todos(flags | TODO_LIST_SHORTEN_IDS))
+	if (transform_todo_file(flags | TODO_LIST_SHORTEN_IDS))
 		return error(_("could not transform the todo list"));
 
 	strbuf_reset(buf);
@@ -4600,7 +4614,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return -1;
 	}
 
-	if (transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS)))
+	if (transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS)))
 		return error(_("could not transform the todo list"));
 
 	if (opts->allow_ff && skip_unnecessary_picks(&oid))
diff --git a/sequencer.h b/sequencer.h
index cc69473bc2..029d842ac5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -113,6 +113,7 @@ struct todo_list {
 #define TODO_LIST_INIT { STRBUF_INIT }
 
 int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
+void todo_list_transform(struct todo_list *todo_list, unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 
 /* Call this to setup defaults before parsing command line options */
@@ -136,7 +137,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(const char *command);
-int transform_todos(unsigned flags);
+int transform_todo_file(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
-- 
2.19.1

