Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8679B1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeKIRsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51711 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so1121519wmc.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Exp+mu6XuVwmjhpACiZNnBEtgTwuzf1zzqw7njFsWDI=;
        b=jiPUVH2YMQZD2PAFqDyXzV/OvLGQ7+RKVsn+Maz49FYb51aFDSD3v5bSVWvaeVX+R9
         wj8rDtiXqL33lE9AF1TPq3HNs6HijWRKV3j38kyzOIeK06Qv8ybGY41fdsTJX9gHmJ/o
         Fh5fsEdUBMa/2oV+WXEgT5aYIiUZb/JPk9omqqm+90tfLGOx7c6i+4akNEx/8aqyoaYd
         6GtBirTUYUyJKWLjtSptUq3QjoS2eGL2Gl62BUcXuYHRbvTcb1jDnxrq8BYGp56VdGeT
         X0spqDFSR0mzsvLiJRjWfBofClGdX0zuPR74BNey3mqU2lbt6+iE1WCrDDQe5+AsP5uz
         zdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Exp+mu6XuVwmjhpACiZNnBEtgTwuzf1zzqw7njFsWDI=;
        b=ucuP+svWUO3bwvh7oMC0FG5OIQ82B9tCApDmecjYVoDACSEjwIDkeswI+1Rnuj/4Sl
         wTaf7ygfY1TVwbJ8NanHtF7BRa9IyyoUqk77nRiM4vFoG3QCnx3tFEb5ecl9T5N8ZCTz
         xbPbdpPyYVOG6eom3CgBL8sxWL6p2RmNXAhfvKK+kiAmjk50b9UC+YSDaIEFw2xEEbKD
         uLzt5CU4SK8R/e4qHcUyiCUsUgQLGVEGH5pHj0yxlAVH6aH4g/5lKKYDeT/6Zk7ykDcg
         deJb9arX8/6nylnrwgl515N9U9qinO5S6yI+c9YLm2h3eOm0VApNx3upd4OSZCuEnItZ
         nY9g==
X-Gm-Message-State: AGRZ1gJis9dGWdegbc0J7FiBt7gcrr7fyhsAqrhPLpFA0tSqo2QU9jXc
        9KagzFf32xZx07iv2KASYG/nwQKA
X-Google-Smtp-Source: AJdET5dt0nXYpaM0HYP3RTUK0ZAdrJ6xBxnvWUKWR5a8E+iJXJ2shjHT2O/EZ6ydAb6S4LcTfzkXUw==
X-Received: by 2002:a1c:a4c5:: with SMTP id n188-v6mr3738159wme.149.1541750913460;
        Fri, 09 Nov 2018 00:08:33 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:32 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 03/16] sequencer: refactor transform_todos() to work on a todo_list
Date:   Fri,  9 Nov 2018 09:07:52 +0100
Message-Id: <20181109080805.6350-4-alban.gruin@gmail.com>
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
No changes since v2.

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
index 78f3263fc1..4cd487a450 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -69,7 +69,7 @@ int edit_todo_list(unsigned flags)
 
 	strbuf_release(&buf);
 
-	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	transform_todo_file(flags | TODO_LIST_SHORTEN_IDS);
 
 	if (strbuf_read_file(&buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
@@ -85,7 +85,7 @@ int edit_todo_list(unsigned flags)
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
 
-	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+	transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS));
 
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 7adbeaa27d..e1097660ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4454,23 +4454,13 @@ int sequencer_add_exec_commands(const char *commands)
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
@@ -4506,9 +4496,33 @@ int transform_todos(unsigned flags)
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
@@ -4769,7 +4783,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todos(flags | TODO_LIST_SHORTEN_IDS))
+	if (transform_todo_file(flags | TODO_LIST_SHORTEN_IDS))
 		return error(_("could not transform the todo list"));
 
 	strbuf_reset(buf);
@@ -4798,7 +4812,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return -1;
 	}
 
-	if (transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS)))
+	if (transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS)))
 		return error(_("could not transform the todo list"));
 
 	if (opts->allow_ff && skip_unnecessary_picks(&oid))
diff --git a/sequencer.h b/sequencer.h
index 84f813305f..708d042f0e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -119,6 +119,7 @@ struct todo_list {
 #define TODO_LIST_INIT { STRBUF_INIT }
 
 int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
+void todo_list_transform(struct todo_list *todo_list, unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 
 /* Call this to setup defaults before parsing command line options */
@@ -142,7 +143,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(const char *command);
-int transform_todos(unsigned flags);
+int transform_todo_file(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
-- 
2.19.1.872.ga867da739e

