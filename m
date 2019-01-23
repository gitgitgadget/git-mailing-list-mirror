Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E24E1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfAWU72 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33026 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfAWU72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id p7so4160876wru.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hjRCPf7UvfUreMFOiZvUPxg0dOIxoanS1pp4QLB3so=;
        b=thu+gY2NFJUAWdRagWGYgMW5OuwMQdLD0xZbzt7hlCrZbHqKIDBWY8Bz3TRk3smi0T
         wsC4iRP92WfaVp7GXrozyfB/fOxj4LzxVg2WCo5LAFuymfFKHOqYj6JlUBjTXWZ86Ptf
         WkWaOCV3QqO8i3jiOlvUeq1yGOAcg/iuK09WOX27sF2LxqRavY34c3NXn65Gq5rNmJkS
         ivr90kX9QNoUuBLbOq1TjfUESwTowY1HyfRnJYA9D4AhDTCCV+xXTDQi9r7xc/Hh/7xI
         jCO6WIXJN4Ta4JdVYsoTSwfaTR5HGGrAXDu899V6idl3/A9x4ZRoK0aQxzL6eBurfKLK
         kPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hjRCPf7UvfUreMFOiZvUPxg0dOIxoanS1pp4QLB3so=;
        b=q3KzcGV0LpmZhPJuN3k8HT1/xTbst7w6Hje+K7lLz8hTkTu1NTdnI4l9yj3VdTLxVQ
         97FMKnZvzN3Kn4umoWVD8YTxRGKfKXfD65rE0HWusx54VGhwLskqMWvbx17HdMtbSqp/
         MOzPC04vqHjbNcDS6319Nd0IM3W2rf8Nl61YxYDNHpueH8mzkph1FT+SPSkEd+as6/Va
         KHTZ3kyHUvGD4J7H0X5HMwlILDUhQCfGFrTj/IOZ2nvlmJwLEcfSvbRsoYOcR9/SURKt
         OPkKbOKkbpMdYc+BwAbsDXSYEMkxMOp3PCCfnPVDfIOmCoUgVbAILtBGtZ0fAX4POo/V
         DHpg==
X-Gm-Message-State: AJcUukdX2GVrVWvGHbHI2rYu48W/nuuhAoCwLd7hSTUO5SlH7FbzIjjT
        fZt8QvtIvzS6VWHVLrTpkNjD6FYB
X-Google-Smtp-Source: ALg8bN5pHRmjLYvcMAf/YGuwekK3lyNST3cgRS3c4NAzFGPQ+5PURJUQW4zX+79jh8GxyMxsoqrhHg==
X-Received: by 2002:adf:f401:: with SMTP id g1mr4454091wro.103.1548277164952;
        Wed, 23 Jan 2019 12:59:24 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:24 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 04/16] sequencer: refactor transform_todos() to work on a todo_list
Date:   Wed, 23 Jan 2019 21:58:09 +0100
Message-Id: <20190123205821.27459-5-alban.gruin@gmail.com>
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
index 0e7ab16a05..7a295cbd3f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4507,27 +4507,18 @@ int sequencer_add_exec_commands(struct repository *r,
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
 
@@ -4558,12 +4549,39 @@ int transform_todos(struct repository *r, unsigned flags)
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
@@ -4825,7 +4843,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todos(r, flags | TODO_LIST_SHORTEN_IDS))
+	if (transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS))
 		return error(_("could not transform the todo list"));
 
 	strbuf_reset(buf);
@@ -4854,7 +4872,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
-	if (transform_todos(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
+	if (transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
 		return error(_("could not transform the todo list"));
 
 	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
diff --git a/sequencer.h b/sequencer.h
index cdb9ed7a2d..35472c137b 100644
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

