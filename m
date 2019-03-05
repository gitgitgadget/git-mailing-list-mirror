Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F157720248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCETSl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36209 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETSk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so10750813wrw.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKk2MGWJuZijX6ry7a0d8dbSenD6MD2q4zzvegAbLus=;
        b=AQ/Yzh+PfLLr77qaCgyocofLjXIRNkPucleTel30csRr0it0Rz0clKJ2n9gCG4rWML
         IrbUUPC8Sfttd05YPKA571vfhng/FVJT72mpnazrdQmzZpasN4Tc2P6cub69iTYmkxHX
         ZFhNijQqnvjhev8dClbMwMXrtoCFFQRWbHupSaQKaXIFHTX+rqJfn8+oYGKbaRJgOf6Y
         JqyQ1U02Ab0rAQsXh3HDhleW66ySBx+eYcCbctg6Dw54OHqmdxPymUW0jJ8v7d+uHwv+
         7uDiEpZmmyFs2G7qChjVp34RO+4spXt+GdmvbZgmbH7UGoZvnsVonK2l4ezvEEt4/qEQ
         8vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKk2MGWJuZijX6ry7a0d8dbSenD6MD2q4zzvegAbLus=;
        b=HYyjKq1fDcNcDLbkfzag5j0uqDciizS44S+NqzPwuMJUfYRHs8Ny9yoxLWcRgdfIeQ
         GaXOXrEiqSg2sD7XNqNwVC9Caw1q7C3sDl0MPIBKnq0zL25qy6ApDKHlqyuWobVGncNE
         /nTGHrr1nb/z9gsiYYGXDoMYLOQtM1k0gzSOeXymQv63pcoy9lXKYx3tB37hyCq9yEWj
         Kc9SPDQ/vjq7YLYO9zTJup77DtT11vUHM4zhMkEH/DMZWQIt/6qp7XJhMnCiToxy30sU
         JJl6K9CWs8kHbBjgstdlCqFmDopO5YPafYorSKOprO9K6oiLjq5688mb11Cb+Hx6ecVC
         xKTQ==
X-Gm-Message-State: APjAAAUmXXsknIJlEqAM46ldbfmViqXUSahPnA8Y6r7lgafUjCF73EIe
        qgsHo5fTBPKR8UWrhAkoHB0B/vgk
X-Google-Smtp-Source: APXvYqzKMVTPiOUdeFTTk9x8w6wCyD79TpT3b6IPfB7YUjU3WA7daUDHpttB4kJdughnLnqtuPnI6w==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr290660wrn.191.1551813518293;
        Tue, 05 Mar 2019 11:18:38 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:37 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 08/18] sequencer: refactor rearrange_squash() to work on a todo_list
Date:   Tue,  5 Mar 2019 20:17:55 +0100
Message-Id: <20190305191805.13561-9-alban.gruin@gmail.com>
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

This refactors rearrange_squash() to work on a todo_list to avoid
redundant reads and writes.  The function is renamed
todo_list_rearrange_squash().

The old version created a new buffer, which was directly written to the
disk.  This new version creates a new item list by just copying items
from the old item list, without creating a new buffer.  This eliminates
the need to reparse the todo list, but this also means its buffer cannot
be directly written to the disk.

As rebase -p still need to check the todo list from the disk, a new
function is introduced, rearrange_squash_in_todo_file().

complete_action() still uses rearrange_squash_in_todo_file() for now.
This will be changed in a future commit.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 builtin/rebase--interactive.c |  2 +-
 sequencer.c                   | 92 ++++++++++++++++++-----------------
 sequencer.h                   |  2 +-
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 813bc34140..60b15f9693 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -268,7 +268,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = check_todo_list_from_file(the_repository);
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash(the_repository);
+		ret = rearrange_squash_in_todo_file(the_repository);
 		break;
 	case ADD_EXEC:
 		ret = sequencer_add_exec_commands(the_repository, &commands);
diff --git a/sequencer.c b/sequencer.c
index 4c076bd183..7798f93b23 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4840,7 +4840,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	    write_message("noop\n", 5, todo_file, 0))
 		return -1;
 
-	if (autosquash && rearrange_squash(r))
+	if (autosquash && rearrange_squash_in_todo_file(r))
 		return -1;
 
 	if (commands->nr)
@@ -4946,21 +4946,13 @@ define_commit_slab(commit_todo_item, struct todo_item *);
  * message will have to be retrieved from the commit (as the oneline in the
  * script cannot be trusted) in order to normalize the autosquash arrangement.
  */
-int rearrange_squash(struct repository *r)
+static int todo_list_rearrange_squash(struct todo_list *todo_list)
 {
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
 	struct hashmap subject2item;
-	int res = 0, rearranged = 0, *next, *tail, i;
+	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
 	char **subjects;
 	struct commit_todo_item commit_todo;
-
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
-		return -1;
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	struct todo_item *items = NULL;
 
 	init_commit_todo_item(&commit_todo);
 	/*
@@ -4973,13 +4965,13 @@ int rearrange_squash(struct repository *r)
 	 * be moved to appear after the i'th.
 	 */
 	hashmap_init(&subject2item, (hashmap_cmp_fn) subject2item_cmp,
-		     NULL, todo_list.nr);
-	ALLOC_ARRAY(next, todo_list.nr);
-	ALLOC_ARRAY(tail, todo_list.nr);
-	ALLOC_ARRAY(subjects, todo_list.nr);
-	for (i = 0; i < todo_list.nr; i++) {
+		     NULL, todo_list->nr);
+	ALLOC_ARRAY(next, todo_list->nr);
+	ALLOC_ARRAY(tail, todo_list->nr);
+	ALLOC_ARRAY(subjects, todo_list->nr);
+	for (i = 0; i < todo_list->nr; i++) {
 		struct strbuf buf = STRBUF_INIT;
-		struct todo_item *item = todo_list.items + i;
+		struct todo_item *item = todo_list->items + i;
 		const char *commit_buffer, *subject, *p;
 		size_t subject_len;
 		int i2 = -1;
@@ -4992,7 +4984,6 @@ int rearrange_squash(struct repository *r)
 		}
 
 		if (is_fixup(item->command)) {
-			todo_list_release(&todo_list);
 			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
@@ -5027,7 +5018,7 @@ int rearrange_squash(struct repository *r)
 				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
 				i2 = *commit_todo_item_at(&commit_todo, commit2)
-					- todo_list.items;
+					- todo_list->items;
 			else {
 				/* copy can be a prefix of the commit subject */
 				for (i2 = 0; i2 < i; i2++)
@@ -5040,7 +5031,7 @@ int rearrange_squash(struct repository *r)
 		}
 		if (i2 >= 0) {
 			rearranged = 1;
-			todo_list.items[i].command =
+			todo_list->items[i].command =
 				starts_with(subject, "fixup!") ?
 				TODO_FIXUP : TODO_SQUASH;
 			if (next[i2] < 0)
@@ -5058,10 +5049,8 @@ int rearrange_squash(struct repository *r)
 	}
 
 	if (rearranged) {
-		struct strbuf buf = STRBUF_INIT;
-
-		for (i = 0; i < todo_list.nr; i++) {
-			enum todo_command command = todo_list.items[i].command;
+		for (i = 0; i < todo_list->nr; i++) {
+			enum todo_command command = todo_list->items[i].command;
 			int cur = i;
 
 			/*
@@ -5072,37 +5061,50 @@ int rearrange_squash(struct repository *r)
 				continue;
 
 			while (cur >= 0) {
-				const char *bol =
-					get_item_line(&todo_list, cur);
-				const char *eol =
-					get_item_line(&todo_list, cur + 1);
-
-				/* replace 'pick', by 'fixup' or 'squash' */
-				command = todo_list.items[cur].command;
-				if (is_fixup(command)) {
-					strbuf_addstr(&buf,
-						todo_command_info[command].str);
-					bol += strcspn(bol, " \t");
-				}
-
-				strbuf_add(&buf, bol, eol - bol);
-
+				ALLOC_GROW(items, nr + 1, alloc);
+				items[nr++] = todo_list->items[cur];
 				cur = next[cur];
 			}
 		}
 
-		res = rewrite_file(todo_file, buf.buf, buf.len);
-		strbuf_release(&buf);
+		FREE_AND_NULL(todo_list->items);
+		todo_list->items = items;
+		todo_list->nr = nr;
+		todo_list->alloc = alloc;
 	}
 
 	free(next);
 	free(tail);
-	for (i = 0; i < todo_list.nr; i++)
+	for (i = 0; i < todo_list->nr; i++)
 		free(subjects[i]);
 	free(subjects);
 	hashmap_free(&subject2item, 1);
-	todo_list_release(&todo_list);
 
 	clear_commit_todo_item(&commit_todo);
-	return res;
+
+	return 0;
+}
+
+int rearrange_squash_in_todo_file(struct repository *r)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
+		return -1;
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
+		todo_list_release(&todo_list);
+		return -1;
+	}
+
+	res = todo_list_rearrange_squash(&todo_list);
+	if (!res)
+		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
+
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index 87d04a3b9b..add50f04f1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -154,7 +154,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash);
-int rearrange_squash(struct repository *r);
+int rearrange_squash_in_todo_file(struct repository *r);
 
 extern const char sign_off_header[];
 
-- 
2.20.1

