Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A541F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeJHDIj (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:39 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33343 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJHDIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:37 -0400
Received: by mail-wr1-f54.google.com with SMTP id e4-v6so18606113wrs.0
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CoMAJ3h9dibVxw8fTunbxyleFNwCcDRBf3d2CWRekrk=;
        b=hoqM8pN6Klmjk6rEoKjliQhpFrtr0i3mhwu2rS2vSQShAr/jDNEaXq46fICyyH4SdY
         kubuzOZ+fCJhIQDlUwlmyWoU3k+lR3OriL+UU2HscZJRX3ukqCkYfJ9E3s6+HGLE1Ckw
         Onr8ScNFJjcF33jq1knQSW+amp1wkjF8tITA0sFHQiCHtwhH9tGm1ml9SynRc45U7rIJ
         /Ueq4OYSbTkig8/JCeyDNi9/NfFYTIE7j9vtPh0/QiuNJQoBhbSL8POkJ5n1rAVT5tDk
         KZKaE09UPwhwOgFs7V02WrAXbGHyBaTScBFnLBKRk6j3KSuRKruMv+uiiSboe1MUfqZ1
         sg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoMAJ3h9dibVxw8fTunbxyleFNwCcDRBf3d2CWRekrk=;
        b=laB8tq4Li8D2cQ3mhd7spGe0Ka5lIYvdMXgbOa+gKNHVbHPjG4iHbA/AfAB8W63U5Q
         8Jm+ctWi+Tin/uxSIEDSI07fR8ogp5QyiAcrn9ZsHGFQZn1AuY3OrT8fiRSXhV2NkSX2
         hLzBwuf02b5tBqSENX8ePOR57WJ8CsL7XBTV5zNENQiTOoTf7JaLQU7oNrYya/SCZdki
         ayHUnXpwDK+LDNlGXQc77j87+023Njn6QONi3D8bX+yccBu+Rd7yxeoh+oDYbwXBLSnh
         2rcrqH+UDwzOdNQ3j44xJUPiwpOdyX9yA/om8R6CZDsT8qJDtCchCUFtes4dlF6h4QFl
         tRUA==
X-Gm-Message-State: ABuFfog5dZagFYsFWRe4yKK5FUzuYpjSeQR/Vm9lLFRPNyzQGY8wq6Nu
        uWHkjBcq4ixbL5q+ajUFAC3IbP6H
X-Google-Smtp-Source: ACcGV62DQATcUBiZckm1AwbRUiMEF505P4Ki1AJFb0xevxz0HkAO+jtxS71Dugq/vBLvk/VPJXfNew==
X-Received: by 2002:adf:94c2:: with SMTP id 60-v6mr13887546wrr.247.1538942413344;
        Sun, 07 Oct 2018 13:00:13 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:12 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 05/15] sequencer: refactor rearrange_squash() to work on a todo_list
Date:   Sun,  7 Oct 2018 21:54:08 +0200
Message-Id: <20181007195418.25752-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors rearrange_squash() to work on a todo_list to avoid
redundant reads and writes.  The function is renamed
todo_list_rearrange_squash().

As rebase -p still need to check the todo list from the disk, a new
function is introduced, rearrange_squash_in_todo_file().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c |  2 +-
 sequencer.c                   | 73 +++++++++++++++++++++--------------
 sequencer.h                   |  2 +-
 3 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index ea1f93ccb6..8deef126d1 100644
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
index 6d998f21a4..8a6176b3d0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4632,7 +4632,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	    write_message("noop\n", 5, todo_file, 0))
 		return -1;
 
-	if (autosquash && rearrange_squash())
+	if (autosquash && rearrange_squash_in_todo_file())
 		return -1;
 
 	if (cmd && *cmd)
@@ -4738,22 +4738,13 @@ define_commit_slab(commit_todo_item, struct todo_item *);
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
+	int rearranged = 0, *next, *tail, i;
 	char **subjects;
 	struct commit_todo_item commit_todo;
 
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
-		return -1;
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
-
 	init_commit_todo_item(&commit_todo);
 	/*
 	 * The hashmap maps onelines to the respective todo list index.
@@ -4765,13 +4756,13 @@ int rearrange_squash(void)
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
@@ -4784,7 +4775,6 @@ int rearrange_squash(void)
 		}
 
 		if (is_fixup(item->command)) {
-			todo_list_release(&todo_list);
 			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
@@ -4819,7 +4809,7 @@ int rearrange_squash(void)
 				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
 				i2 = *commit_todo_item_at(&commit_todo, commit2)
-					- todo_list.items;
+					- todo_list->items;
 			else {
 				/* copy can be a prefix of the commit subject */
 				for (i2 = 0; i2 < i; i2++)
@@ -4832,7 +4822,7 @@ int rearrange_squash(void)
 		}
 		if (i2 >= 0) {
 			rearranged = 1;
-			todo_list.items[i].command =
+			todo_list->items[i].command =
 				starts_with(subject, "fixup!") ?
 				TODO_FIXUP : TODO_SQUASH;
 			if (next[i2] < 0)
@@ -4852,8 +4842,8 @@ int rearrange_squash(void)
 	if (rearranged) {
 		struct strbuf buf = STRBUF_INIT;
 
-		for (i = 0; i < todo_list.nr; i++) {
-			enum todo_command command = todo_list.items[i].command;
+		for (i = 0; i < todo_list->nr; i++) {
+			enum todo_command command = todo_list->items[i].command;
 			int cur = i;
 
 			/*
@@ -4865,12 +4855,12 @@ int rearrange_squash(void)
 
 			while (cur >= 0) {
 				const char *bol =
-					get_item_line(&todo_list, cur);
+					get_item_line(todo_list, cur);
 				const char *eol =
-					get_item_line(&todo_list, cur + 1);
+					get_item_line(todo_list, cur + 1);
 
 				/* replace 'pick', by 'fixup' or 'squash' */
-				command = todo_list.items[cur].command;
+				command = todo_list->items[cur].command;
 				if (is_fixup(command)) {
 					strbuf_addstr(&buf,
 						todo_command_info[command].str);
@@ -4883,18 +4873,43 @@ int rearrange_squash(void)
 			}
 		}
 
-		res = rewrite_file(todo_file, buf.buf, buf.len);
+		strbuf_reset(&todo_list->buf);
+		strbuf_add(&todo_list->buf, buf.buf, buf.len);
 		strbuf_release(&buf);
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
+	if (todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list))
+		BUG("unusable todo list");
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
+		res = rewrite_file(todo_file, todo_list.buf.buf, todo_list.buf.len);
+
+	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/sequencer.h b/sequencer.h
index fb8b85bf9e..7f5668500f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -141,7 +141,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
 		    unsigned autosquash);
-int rearrange_squash(void);
+int rearrange_squash_in_todo_file(void);
 
 extern const char sign_off_header[];
 
-- 
2.19.1

