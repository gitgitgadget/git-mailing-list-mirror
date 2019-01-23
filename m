Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16341F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAWU7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51129 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfAWU7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so873692wmd.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ec+4XY7X6i30+0/IQAiO1Pthz6dwVBzHaW22a8WH2Jg=;
        b=s/MKWltUzWgrzJj1G3/AS3yeBUY5Ekq436oIaVFiDzNIllHCyc4KojRjOd2/2CUD+u
         WnLQ8PJfuzAFBErOYEU55xQrax/IfgzfhbKWQNvlNJzSdMap7GtuEmoGNMXsvTaE8pRQ
         p8p4akeSpWL9x7876VtiJ62XqvHzZwUEoBgv5IRsaU9bo7yoOvnx0zPJduqeSEqjyrj8
         HREmoux4sxd1UWX1tK8QT9YK9RBqn9rbFUV+ezhYkEJWpkRS4xDkszmHsnYvVb9wIahw
         M9Fl9d5lxOTa0WAUJIfpGEFIYHRrgUe5I153jX4iOLDfz7Up0ONhAw5k1VVQ0d7GfY+Q
         LjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ec+4XY7X6i30+0/IQAiO1Pthz6dwVBzHaW22a8WH2Jg=;
        b=n+UWPaBqWtL5pGwfVFo7JguWHMZiQBWV1Mp+W1HsJl9IArbMYkouOcLbVBdE9CnB2P
         qemLNv9mWPgAl8quRRfP1IC2kvd/MWOZltj1BVtHdcPB1b1o9QFXYSHWoJ8RlxkuCZKL
         iqVGhsLgr1+IGoxQe+hwDp2uAEBx9hRj+P7fuC2L1Oa7gs9RkSf7J7uUu/DmA5ecX8vZ
         tmeyPXRJcNa881JUVANd3DcDkNpp1U3z8tSQmzGW7mJ+0iJhS0flRBuScj2z5ZltAD6+
         pUV5gk8zVJaaQIAKyWy0MUlsjkFNE+Y/miUs1admIfcUALgVjGVXu8nivAq5uakp3CP8
         ovFg==
X-Gm-Message-State: AJcUukd+5BeO670bI+ycRPaeyA88UqHSHrSyBmzaOlNneviJhw09ZPbG
        PeK6cUj8wUR1twldrci9fgY3VtRr
X-Google-Smtp-Source: ALg8bN4WppVbC/AfgvlqOj1hLzF8Uc4m5TG6GwK1qQJxiGQ8HecJSf03uYaghQmaAkX9SvVrI8813A==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr4339705wmf.115.1548277171872;
        Wed, 23 Jan 2019 12:59:31 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:31 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 08/16] sequencer: refactor rearrange_squash() to work on a todo_list
Date:   Wed, 23 Jan 2019 21:58:13 +0100
Message-Id: <20190123205821.27459-9-alban.gruin@gmail.com>
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
Unchanged since v4.

 builtin/rebase--interactive.c |  2 +-
 sequencer.c                   | 92 ++++++++++++++++++-----------------
 sequencer.h                   |  2 +-
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 53056ee713..4f0eae9239 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -266,7 +266,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = check_todo_list_from_file(the_repository);
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash(the_repository);
+		ret = rearrange_squash_in_todo_file(the_repository);
 		break;
 	case ADD_EXEC:
 		ret = sequencer_add_exec_commands(the_repository, &commands);
diff --git a/sequencer.c b/sequencer.c
index 3a90b419d7..11456be5cc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4777,7 +4777,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	    write_message("noop\n", 5, todo_file, 0))
 		return -1;
 
-	if (autosquash && rearrange_squash(r))
+	if (autosquash && rearrange_squash_in_todo_file(r))
 		return -1;
 
 	if (commands->nr)
@@ -4883,21 +4883,13 @@ define_commit_slab(commit_todo_item, struct todo_item *);
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
@@ -4910,13 +4902,13 @@ int rearrange_squash(struct repository *r)
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
@@ -4929,7 +4921,6 @@ int rearrange_squash(struct repository *r)
 		}
 
 		if (is_fixup(item->command)) {
-			todo_list_release(&todo_list);
 			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
@@ -4964,7 +4955,7 @@ int rearrange_squash(struct repository *r)
 				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
 				i2 = *commit_todo_item_at(&commit_todo, commit2)
-					- todo_list.items;
+					- todo_list->items;
 			else {
 				/* copy can be a prefix of the commit subject */
 				for (i2 = 0; i2 < i; i2++)
@@ -4977,7 +4968,7 @@ int rearrange_squash(struct repository *r)
 		}
 		if (i2 >= 0) {
 			rearranged = 1;
-			todo_list.items[i].command =
+			todo_list->items[i].command =
 				starts_with(subject, "fixup!") ?
 				TODO_FIXUP : TODO_SQUASH;
 			if (next[i2] < 0)
@@ -4995,10 +4986,8 @@ int rearrange_squash(struct repository *r)
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
@@ -5009,37 +4998,50 @@ int rearrange_squash(struct repository *r)
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
index e79f03e213..c7bb38d6df 100644
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

