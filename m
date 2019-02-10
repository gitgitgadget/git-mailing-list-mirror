Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6191D1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfBJN1O (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBJN1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so11761413wmc.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RmveoYqh5IyIZIv6ifYtPLwFuHxBd5ZqU/8w7NqSMo=;
        b=SFDPElAXSeNqjrsFLcXKwiPQtUZpjl0yXG7cTLwdBds7IIBtVLK9LhZLttVpWT0qEg
         E7FDyOm7STy1KiYXrSM1ad3em+EV4yr2cK6zixSLshR8JmGJJ+ezxCUQ9RurcC9tkSEd
         gxdX+Dt7C2jkNnh8vc8SVPZbjR6tur8TCaQLsvsBCoUV+RmfODB63QmwSCW2XeDLSaDL
         bNsmJHAk6dQRF2KKCfkaD0aqq4HNb2Vj63Hz2ERqDBVQxyLzuGyHzRbBdZYBV8V+Wx70
         J96aVDgFWhHl5dSASVlwAvff7SFg6D/cJkN173QV4v4PxU1H5v7B/D+8BFKilUQURt61
         EtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RmveoYqh5IyIZIv6ifYtPLwFuHxBd5ZqU/8w7NqSMo=;
        b=tWP2wlu750DvDuuR2iRphdSdXeltE5IQ6UueJQ0ksjDVy3x7hh/zG7piHJbKZe/7BF
         7h4euFPSibw1GkgIuosPYUZVsjm45tABkFh82DFMGdb6mW/qdOmFS2infyKBdj4lCJ3Z
         HKrG9JmeyYmf3LdDVN7Km/aCcbzNRyzukAM0t33whu1/UZAXK8Cxl0kSxGfjoIdp1pk9
         lT5rl8aaWXkRiSSer7W0/6kmcUQv09m96YhdQEp3bHW/6mzuc75KSOes418tA2EIlq4F
         MGfN3jxzMCoEPTIU04fPBvcC0Jz5aW3FjaM0XJOC4XYlTaZEO4cCyMG9G7LdXNCdhAKa
         Cjrw==
X-Gm-Message-State: AHQUAuZ9/zn3XqLRkrWxWBZy+pV4mqDajqTsG9FjhKf2v93mrCIrFua7
        kv556rlJSuo87CfHcZ2sqBBmZx+g
X-Google-Smtp-Source: AHgI3IYjAfP7OdKDAaDPPcdCNGmOSZTvZb3uc99TS/5cjcIn0nckx1M0RNy1CcqQRKmXoxpTUzqWaQ==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr5704694wmf.8.1549805231017;
        Sun, 10 Feb 2019 05:27:11 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:10 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 04/16] sequencer: refactor transform_todos() to work on a todo_list
Date:   Sun, 10 Feb 2019 14:26:36 +0100
Message-Id: <20190210132648.12821-5-alban.gruin@gmail.com>
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
No changes since v6.

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

