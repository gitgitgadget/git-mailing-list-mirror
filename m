Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A763F1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfBJN1W (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36004 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBJN1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so11761622wmc.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmySRFzqSA2TlNGJUsvn+SuA2Sf+KVeqMGpgq3KXvS8=;
        b=FrLWljzlRbRmkANX4XG+y54GX9oMW2LOvUkIPkD1klmFt6BPwjQ5jZqHdYb5Kk3cys
         zCH3nvPGogl2qIUVTNrxfDnbdh6RjAu/1PC5inBRHUCqhQrhnkesldhufaP7UDC1y9FI
         tHtXos7E/en7PeS3wjpUOW4Uybl3jD8ZTICZwKtdExLhJOYL1Lh9XEWk/GKLMN+3xx3+
         E2Z6CwM6GSjhQVIzxex3QR2q5niL/Cou4xB98GEperZ7RfJKxVOoIL1hLap9B2B17bRP
         TUDIzlwzKdRPvnvL11tQvdAiKFCcnSU8BEyUELFhdc1jnDCAlu4/Mk0K/ZGyBj/jiPAX
         fUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmySRFzqSA2TlNGJUsvn+SuA2Sf+KVeqMGpgq3KXvS8=;
        b=ZBdDuEc8DhN9QiBaN3h4CIv/0S0oDZhFdc/zBJF0s/Y0cEVSVNt7y+jg9KOzKz3CZ3
         IM4m5+JgJw91XEejmvcEVMdBskWOsQb0ecwY0CEh+5ZQO0eTsM69IUDEEHzTSkokKgSL
         6pDz2mAMG4V71gSOmf4eFjPVYX3WYCCZdTbwgvEYSHwZ2VP1AncMkBjnHsJmNX/NGlno
         tGoADKN6R5G/N3uwq16Q0nFTVA1jsEaC3Zwk7n+De2VFw2JXGUGv85l84iSL3UqLW3UF
         2GMva9ZCHJLbYbjGcFLlo9koj4iyGx20F5Q8B5bdRHjIdnjKEwehJhTRAd2x4kmAXs6R
         Wmow==
X-Gm-Message-State: AHQUAuYpNUwfVy2KLuNqan5lfFiWeUOawHuLxiFCfdmfGqL8SOLBL9HF
        qxdRhOT7uYKukGx+LNDiEPU/EZYD
X-Google-Smtp-Source: AHgI3IbuBqOQgXzOQm0X7Q7F/PWuOXGXaX+mBIy6RmflXsfzZ+EjnZ5QrYbRI18+eYFIzoFts9fbiA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr23408150wrs.268.1549805235900;
        Sun, 10 Feb 2019 05:27:15 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:15 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 08/16] sequencer: refactor rearrange_squash() to work on a todo_list
Date:   Sun, 10 Feb 2019 14:26:40 +0100
Message-Id: <20190210132648.12821-9-alban.gruin@gmail.com>
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
No changes since v6.

 builtin/rebase--interactive.c |  2 +-
 sequencer.c                   | 92 ++++++++++++++++++-----------------
 sequencer.h                   |  2 +-
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index c131fd4a27..74ebe7a10e 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -265,7 +265,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = check_todo_list_from_file(the_repository);
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash(the_repository);
+		ret = rearrange_squash_in_todo_file(the_repository);
 		break;
 	case ADD_EXEC:
 		ret = sequencer_add_exec_commands(the_repository, &commands);
diff --git a/sequencer.c b/sequencer.c
index 82ca3432cd..ffa4c4da1a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4833,7 +4833,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	    write_message("noop\n", 5, todo_file, 0))
 		return -1;
 
-	if (autosquash && rearrange_squash(r))
+	if (autosquash && rearrange_squash_in_todo_file(r))
 		return -1;
 
 	if (commands->nr)
@@ -4939,21 +4939,13 @@ define_commit_slab(commit_todo_item, struct todo_item *);
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
@@ -4966,13 +4958,13 @@ int rearrange_squash(struct repository *r)
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
@@ -4985,7 +4977,6 @@ int rearrange_squash(struct repository *r)
 		}
 
 		if (is_fixup(item->command)) {
-			todo_list_release(&todo_list);
 			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
@@ -5020,7 +5011,7 @@ int rearrange_squash(struct repository *r)
 				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
 				i2 = *commit_todo_item_at(&commit_todo, commit2)
-					- todo_list.items;
+					- todo_list->items;
 			else {
 				/* copy can be a prefix of the commit subject */
 				for (i2 = 0; i2 < i; i2++)
@@ -5033,7 +5024,7 @@ int rearrange_squash(struct repository *r)
 		}
 		if (i2 >= 0) {
 			rearranged = 1;
-			todo_list.items[i].command =
+			todo_list->items[i].command =
 				starts_with(subject, "fixup!") ?
 				TODO_FIXUP : TODO_SQUASH;
 			if (next[i2] < 0)
@@ -5051,10 +5042,8 @@ int rearrange_squash(struct repository *r)
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
@@ -5065,37 +5054,50 @@ int rearrange_squash(struct repository *r)
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

