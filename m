Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BC71F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeJHDIj (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeJHDIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so1848218wmd.4
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OawRcaVEt+HB/RITtSmrsE6bDe9yb4eTQWkMwXEuTSk=;
        b=JK9qPiiEbALU/6ERbX8ZaOB7PxwD6r1Np7M/wBhQXBC7u0AWCNQDez55xxdT/5w7RU
         SnxrTvJWOYCEO5qcIHxtr7Zq5aJ6aGMnPqbdLbhi4RHyXMwenK/dGG5ZUkV9FnfrpOvn
         AdkpY5mRn8GYP9aYlroz4E+b2NRnnKVIllmIwHt+uvJQekBC8S+b0WGmJ/Z5lXiddpL1
         wAN+vuBLZYvK1nOKSTOTxz0FKuitiQWfQ8MOIVrrK/1St1movVNpP4pVqCbAV0Ju6tfv
         vHyL19NUSsWAxOBFTVy9jC/kPU0nS23SOXHSgyA955IZ6O7InqJ7dsbKRUxKmxpypGwO
         Cj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OawRcaVEt+HB/RITtSmrsE6bDe9yb4eTQWkMwXEuTSk=;
        b=bJW0pdYHUptw8cWII3z6/YSaSbw22Rkx4l5VydIzRkPMbr9uBnetrG17i+pqO9zw3c
         A+NQuv1J9V9fJ0OLNAbC3/hGDvILJtaMUpmYA1pTwXgNTcJ6mgzIlm/IS+CtIOg91CFr
         ukynAB3UH5mEAdDI2nXYCeHcGYnnTh74ejKUqTk/6pSID32MI2CFAbX0Ka1OpUmqwS6e
         og94kZ7KztQD18QW6gNpnlSu1XjDvQFhPtq4UoXOJhSWJpjaulvkJl6ZcpxojDMXyFhb
         MA67/nbVhwKcmoN/SbeJsmKbcw/Jy8Pu3EpSMRwWrPFyCoss7/bFNOAQ68UJ+7f+ZSlM
         lu7A==
X-Gm-Message-State: ABuFfojfiYaXmcfloeES26RmaxKodyQCotNUbJupd9YJRRSOwq/GMb3m
        nULwUGVXLJ6JTrajP7TcTtP/7Wvz
X-Google-Smtp-Source: ACcGV60CI3HjDabq+W4Bd0JyFupksJIeZm4EYjIjbRiLl1A1tAfemA0v43ZSdvF//WtDH4e6qYkjbQ==
X-Received: by 2002:a1c:a851:: with SMTP id r78-v6mr13168973wme.97.1538942414366;
        Sun, 07 Oct 2018 13:00:14 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:13 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 06/15] sequencer: refactor transform_todos() to work on a todo_list
Date:   Sun,  7 Oct 2018 21:54:09 +0200
Message-Id: <20181007195418.25752-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors transform_todos() to work on a todo_list.  The function
is renamed todo_list_transform().

As rebase -p still need to check the todo list from the disk, a new
function is introduced, transform_todo_file().

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
index 8deef126d1..f827e53f05 100644
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
 		ret = check_todo_list_from_file();
diff --git a/rebase-interactive.c b/rebase-interactive.c
index ef8540245d..7c7f720a3d 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -92,7 +92,7 @@ int edit_todo_list(unsigned flags)
 
 	strbuf_release(&buf);
 
-	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	transform_todo_file(flags | TODO_LIST_SHORTEN_IDS);
 
 	if (strbuf_read_file(&buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
@@ -108,7 +108,7 @@ int edit_todo_list(unsigned flags)
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
 
-	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+	transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS));
 
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 8a6176b3d0..30a7fe3958 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4440,23 +4440,13 @@ int sequencer_add_exec_commands(const char *commands)
 	return res;
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
@@ -4492,9 +4482,33 @@ int transform_todos(unsigned flags)
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
 
 int check_todo_list_from_file(void)
@@ -4670,7 +4684,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todos(flags | TODO_LIST_SHORTEN_IDS))
+	if (transform_todo_file(flags | TODO_LIST_SHORTEN_IDS))
 		return error(_("could not transform the todo list"));
 
 	strbuf_reset(buf);
@@ -4699,7 +4713,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return -1;
 	}
 
-	if (transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS)))
+	if (transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS)))
 		return error(_("could not transform the todo list"));
 
 	if (opts->allow_ff && skip_unnecessary_picks(&oid))
diff --git a/sequencer.h b/sequencer.h
index 7f5668500f..e1faca7884 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -112,6 +112,7 @@ struct todo_list {
 #define TODO_LIST_INIT { STRBUF_INIT }
 
 int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
+void todo_list_transform(struct todo_list *todo_list, unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 
 /* Call this to setup defaults before parsing command line options */
@@ -135,7 +136,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(const char *command);
-int transform_todos(unsigned flags);
+int transform_todo_file(unsigned flags);
 int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-- 
2.19.1

