Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C341F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeL2QFJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44491 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeL2QFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so19630571edd.11
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucSB2n5Q4oBgeNSLQHRQtP1i/Fss0FuiI3xP8BPttFI=;
        b=fHh2VRog23wjRLh3lfpMBX3Q1qi/6OiIxNTSKaFMuyP2+69nUDgfugPDZIA3EkoEVR
         kzk79EjBkU7OlUvSfmO71sp8K8L45tmcOtR2Qq4IhT9751Q9Qwr3/EoXW9JEGXc4VvoH
         o3jPZxDk+XINqzzuc+eBPhf0qS8o39972f+DMIkqejAUNzRQZDpsU99ubjMuNeGuGsQS
         zkeTgWqfQXvfoqI63aomttChzWK5XIFnXcQLzrRuA32RfmYl/sgHPWEUFewmvJUZzzgx
         VSPq5WO7g+Rn8+eEWK5y6/VGlsVHCtcI6NRXmGFt5uAoiYs5bpNmGL2vIqIPHdUFJkbI
         +IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucSB2n5Q4oBgeNSLQHRQtP1i/Fss0FuiI3xP8BPttFI=;
        b=Qt1rj7w4wBFMRKG2t++nppNynuS0eTA5d5JFe6GgdlcNVLnGmGgT7xfp+1cBMmBO14
         lG8WlbyP47Vcdp+AtT8DtjdESMkU0TXFntrMH+gZShDiesbs+bcqPCOQ5gt/V/bh8FSM
         4su7HI5Y0gsDleB94PlxigwPkRTdqSHLJU0gRTAV0JtTaV/ZmSoWxlQbNBROMFHv86dg
         Ubh3mTp7m1wHGLRqEC89LdtQ1gOtJmnUKpSa7pAWxOkKtGChRqmgD43SFEZrg1bJq7BO
         sjJbEp6sHLGLEysogeSGLdw2/PCaTNZMw2Y/v9KszOl0/F8hxrNdAi2mYlclvflN60ek
         Vdog==
X-Gm-Message-State: AA+aEWbjw2MkY0h+PpkesLoOW4JnwGUOtk17mFfGKS5Z/712ASpzCY7H
        Rb1vkrqUI7tLKDqdJDnhfNJ7RIXS
X-Google-Smtp-Source: AFSGD/WuAVZlW6OsFZz+7cqsqLwUXXD+S9xpMrWInndI3heL2h2PAU+02dYSbA/6K3zFoU9S7KzYIg==
X-Received: by 2002:a50:af43:: with SMTP id g61mr24900252edd.286.1546099505664;
        Sat, 29 Dec 2018 08:05:05 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:04 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 04/16] sequencer: refactor transform_todos() to work on a todo_list
Date:   Sat, 29 Dec 2018 17:04:01 +0100
Message-Id: <20181229160413.19333-5-alban.gruin@gmail.com>
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
index 61be04ccc5..6b4eb7a9ba 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4501,27 +4501,18 @@ int sequencer_add_exec_commands(struct repository *r,
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
-				    todo_list.buf.buf + item->arg_offset);
+				    todo_list->buf.buf + item->arg_offset);
 			continue;
 		}
 
@@ -4552,12 +4543,39 @@ int transform_todos(struct repository *r, unsigned flags)
 			strbuf_addch(&buf, '\n');
 		else
 			strbuf_addf(&buf, " %.*s\n", item->arg_len,
-				    todo_list.buf.buf + item->arg_offset);
+				    todo_list->buf.buf + item->arg_offset);
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
@@ -4819,7 +4837,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todos(r, flags | TODO_LIST_SHORTEN_IDS))
+	if (transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS))
 		return error(_("could not transform the todo list"));
 
 	strbuf_reset(buf);
@@ -4848,7 +4866,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
-	if (transform_todos(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
+	if (transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
 		return error(_("could not transform the todo list"));
 
 	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
diff --git a/sequencer.h b/sequencer.h
index 70a896e756..53ffe7371c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -121,6 +121,8 @@ struct todo_list {
 
 int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 				struct todo_list *todo_list);
+void todo_list_transform(struct repository *r, struct todo_list *todo_list,
+			 unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 
 /* Call this to setup defaults before parsing command line options */
@@ -146,7 +148,7 @@ int sequencer_make_script(struct repository *repo, FILE *out,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(struct repository *r, const char *command);
-int transform_todos(struct repository *r, unsigned flags);
+int transform_todo_file(struct repository *r, unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
-- 
2.20.1

