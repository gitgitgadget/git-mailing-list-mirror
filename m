Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F391F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeJ1GMW (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45329 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeJ1GMW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id n5-v6so4624650wrw.12
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4R3hhpNf5tIvJN89OINaBT1z/TklK5zIjw3VyVjsuk=;
        b=G6zSDYdZE2K6CwHViDBa4wLmoEYgU/Rvw2DfSNPqqIlbTKX8i5W0ngKVsBijOtUn/J
         HK/+jBiNRCzWhykQjsQrv5dCJoLw5rEYrBJ3Pr3g+18LdOqmOn+4EQlkzFskchWK3ez+
         Mwbt0L+Bsu6HS1cVO14GP7SDvgscbZKLVYy4P4iNaei9/af5JEA5ZXpKlon+OVAZRN7O
         lx0FIwIjCvP6vGBrrKLPsm+wFEwEuWZaYmb3mmoyyOmnLtXJCKtMM7QrOdK1y1yvUe2m
         aSzkEItRMdxN8jCyJK/FM3N8uGacz3Tu1w8sW9toFtfaTMHoxy+BYI4n3xio9HDVINd8
         PAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4R3hhpNf5tIvJN89OINaBT1z/TklK5zIjw3VyVjsuk=;
        b=EDcyBwH+uBSzPXGFO2Su5UVyWm51J5BRlPoUR41yluDI7fMqEUP64odjv0eKfOJdmE
         nlR57TURb+3M4GJX07+n6LklP9iXlOuMi0wLDg/BhYinEak5w/MhknYc3/GnjHySyTi1
         +t3rqv4Rnn2fLY1xrPSO6VbC9OQsMaVB9TFeL8V0OiCzwtRbsMXxgW5S2aJqFDvssdd/
         NDxLjxpp7HxW0ImHgsCY+lSeKYoz6yYjBrvhz6/kjbtaD3cArrMEvZPiixXGkhvn2TPh
         6CARkuV4k66tH9QvohBrl3dEnwcSMbai9Vo24fLYZ/jw2nmG8UDB2ztZ2rNXd+4tEnzP
         Qm5Q==
X-Gm-Message-State: AGRZ1gJmeM8snWzBZjdhZYskOXIXyBnHmp/fJTKLKlOotqgvWKqx7phS
        BVFoFvlMPlz+hXj6rayN2CDYVuVK
X-Google-Smtp-Source: AJdET5ftfg5zqF3Dih0qxtxB3CW5BhjIEi1CC9oE5EnjGtHMpYQtGZY+A8Ig/odxUH69G1t6KHcZCA==
X-Received: by 2002:adf:ba06:: with SMTP id o6-v6mr9269325wrg.249.1540675801227;
        Sat, 27 Oct 2018 14:30:01 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:00 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 07/16] sequencer: refactor rearrange_squash() to work on a todo_list
Date:   Sat, 27 Oct 2018 23:29:21 +0200
Message-Id: <20181027212930.9303-8-alban.gruin@gmail.com>
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

This refactors rearrange_squash() to work on a todo_list to avoid
redundant reads and writes.  The function is renamed
todo_list_rearrange_squash().

The old version created a new buffer, which was directly written to the
disk.  This new version creates a new item list by just memcpying items
from the old item list, without creating a new buffer.  This eliminates
the need to reparse the todo list, but this also means its buffer cannot
be directly written to the disk.

As rebase -p still need to check the todo list from the disk, a new
function is introduced, rearrange_squash_in_todo_file().

complete_action() still uses rearrange_squash_in_todo_file() for now.
This will be changed in a future commit.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c |  2 +-
 sequencer.c                   | 87 +++++++++++++++++------------------
 sequencer.h                   |  2 +-
 3 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index c1d87c0fe6..f827e53f05 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -258,7 +258,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = check_todo_list_from_file();
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash();
+		ret = rearrange_squash_in_todo_file();
 		break;
 	case ADD_EXEC:
 		ret = sequencer_add_exec_commands(cmd);
diff --git a/sequencer.c b/sequencer.c
index 12a3efeca8..09e32f3e5a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4523,7 +4523,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	    write_message("noop\n", 5, todo_file, 0))
 		return -1;
 
-	if (autosquash && rearrange_squash())
+	if (autosquash && rearrange_squash_in_todo_file())
 		return -1;
 
 	if (cmd && *cmd)
@@ -4629,21 +4629,13 @@ define_commit_slab(commit_todo_item, struct todo_item *);
  * message will have to be retrieved from the commit (as the oneline in the
  * script cannot be trusted) in order to normalize the autosquash arrangement.
  */
-int rearrange_squash(void)
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
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	struct todo_item *items = NULL;
 
 	init_commit_todo_item(&commit_todo);
 	/*
@@ -4656,13 +4648,13 @@ int rearrange_squash(void)
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
@@ -4675,7 +4667,6 @@ int rearrange_squash(void)
 		}
 
 		if (is_fixup(item->command)) {
-			todo_list_release(&todo_list);
 			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
@@ -4710,7 +4701,7 @@ int rearrange_squash(void)
 				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
 				i2 = *commit_todo_item_at(&commit_todo, commit2)
-					- todo_list.items;
+					- todo_list->items;
 			else {
 				/* copy can be a prefix of the commit subject */
 				for (i2 = 0; i2 < i; i2++)
@@ -4723,7 +4714,7 @@ int rearrange_squash(void)
 		}
 		if (i2 >= 0) {
 			rearranged = 1;
-			todo_list.items[i].command =
+			todo_list->items[i].command =
 				starts_with(subject, "fixup!") ?
 				TODO_FIXUP : TODO_SQUASH;
 			if (next[i2] < 0)
@@ -4741,10 +4732,8 @@ int rearrange_squash(void)
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
@@ -4755,37 +4744,47 @@ int rearrange_squash(void)
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
+				memcpy(items + nr++, todo_list->items + cur, sizeof(struct todo_item));
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
+
+	return 0;
+}
+
+int rearrange_squash_in_todo_file(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
+		return -1;
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+		todo_list_release(&todo_list);
+		return -1;
+	}
+
+	res = todo_list_rearrange_squash(&todo_list);
+	if (!res)
+		res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, 0, 0, -1, 0);
+
+	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/sequencer.h b/sequencer.h
index e203930084..0c8074cab0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -139,7 +139,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
 		    unsigned autosquash);
-int rearrange_squash(void);
+int rearrange_squash_in_todo_file(void);
 
 extern const char sign_off_header[];
 
-- 
2.19.1

