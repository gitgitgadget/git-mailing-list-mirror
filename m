Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121D41F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAWU7b (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43601 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfAWU73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so4096767wrs.10
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPO5BnIUA32a6E0ynCkbvXilHzFIiepRM9A23Q3dtQs=;
        b=dtep6Thb8XyAAXBcsDF4bPIwrKjxZ3pHCE23LqZzitljwZRp/Fi3gbT3cxIAxy3lDm
         +BgO8Egq+xEgUOtEsD5dYDLL3do7x0F6WH1IcMT14T56N/OCiVYCw9RjLDQnrEKQdjs+
         C4wRd+WkhtRXEjLzon83O+M1G7dgQYqnmSTKqW6hK37MsLVmqIuysPVP6FioneiEJTpe
         O53M0V9bLtFcGyZxAxC8I0ws28Zlcrrqf/1ZkVXRnOGbHeSwfQ5gGZUsN2sGPhYIl25p
         rlMegA7nBsOH8NxOCLZmrqhErxJn6MqPPEx9iOHDDJv5K/sZs85AfiHKHsZ6/VmzA5RN
         H8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPO5BnIUA32a6E0ynCkbvXilHzFIiepRM9A23Q3dtQs=;
        b=qg1tsNxG9FHP/lkCsI1fsUOnbVYaRs/cA75TjyuWcS6epzlHPnihdudSkHMvfkcNCZ
         PeHWvJej9kTF4FKAI5EB9geGFBL8DkgOJu+YfzSsWlpeILyAceb11KHO4DV88E/Fv2of
         aWHmqVK2AtPcPdPQ72ZVVLN4uxi9n0cQRlagfEx4V2eNXTuJyZp2UQFl9gLSrtYpIcc2
         tgN6QIfzRPSpLs5RRjXVCSzev7U/1lPlNL7GKxvsMy8m9Q0idfM7w8nkaWJuQzzmpTgr
         h/W0tm1I5GtZA+CafEKLN/Fd9JzcVmkmbR7ps2D78xvkXF7igFmNG49okvvRgEJDYNel
         pkzg==
X-Gm-Message-State: AJcUukeyVToqPjNt1L9Ni4MBPEDH2daU5IkVMu9PQWbthddITxclnYeW
        I200v2Oy22mgX3FGJhfqC2ort9AA
X-Google-Smtp-Source: ALg8bN5hvuk9MbFZuZoOMAfcRwvdw/r07DdeAl9ew+jM/9nKitsy6Q4/gLuQOnkYj5IIJAIUhL73Fw==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr4306143wrx.134.1548277166803;
        Wed, 23 Jan 2019 12:59:26 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:26 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 05/16] sequencer: introduce todo_list_write_to_file()
Date:   Wed, 23 Jan 2019 21:58:10 +0100
Message-Id: <20190123205821.27459-6-alban.gruin@gmail.com>
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

This introduces a new function to recreate the text of a todo list from
its commands and write it to a file.  This will be useful as the next
few commits will change the use of the buffer in struct todo_list so it
will no longer be a mirror of the file on disk.

This functionality already exists in todo_list_transform(), but this
function was made to replace the buffer of a todo list, which is not
what we want here.  Thus, the part of todo_list_transform() that
replaces the buffer is dropped, and the function is renamed
todo_list_to_strbuf().  It is called by todo_list_write_to_file() to
fill the buffer to write to the disk.

todo_list_write_to_file() can also take care of appending the help text
to the buffer before writing it to the disk, or to write only the first
n items of the list.  This feature will be used by
skip_unnecessary_picks(), which has to write done commands in a file.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 61 +++++++++++++++++++++++++++++++++++------------------
 sequencer.h | 11 ++++++----
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7a295cbd3f..87b43994ff 100644
--- a/sequencer.c

+++ b/sequencer.c
@@ -4507,26 +4507,28 @@ int sequencer_add_exec_commands(struct repository *r,
 	return i;
 }
 
-void todo_list_transform(struct repository *r, struct todo_list *todo_list,
-			 unsigned flags)
+static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
+				struct strbuf *buf, int num, unsigned flags)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct todo_item *item;
-	int i;
+	int i, max = todo_list->nr;
 
-	for (item = todo_list->items, i = 0; i < todo_list->nr; i++, item++) {
+	if (num > 0 && num < max)
+		max = num;
+
+	for (item = todo_list->items, i = 0; i < max; i++, item++) {
 		/* if the item is not a command write it and continue */
 		if (item->command >= TODO_COMMENT) {
-			strbuf_addf(&buf, "%.*s\n", item->arg_len,
+			strbuf_addf(buf, "%.*s\n", item->arg_len,
 				    todo_item_get_arg(todo_list, item));
 			continue;
 		}
 
 		/* add command to the buffer */
 		if (flags & TODO_LIST_ABBREVIATE_CMDS)
-			strbuf_addch(&buf, command_to_char(item->command));
+			strbuf_addch(buf, command_to_char(item->command));
 		else
-			strbuf_addstr(&buf, command_to_string(item->command));
+			strbuf_addstr(buf, command_to_string(item->command));
 
 		/* add commit id */
 		if (item->commit) {
@@ -4536,28 +4538,48 @@ void todo_list_transform(struct repository *r, struct todo_list *todo_list,
 
 			if (item->command == TODO_MERGE) {
 				if (item->flags & TODO_EDIT_MERGE_MSG)
-					strbuf_addstr(&buf, " -c");
+					strbuf_addstr(buf, " -c");
 				else
-					strbuf_addstr(&buf, " -C");
+					strbuf_addstr(buf, " -C");
 			}
 
-			strbuf_addf(&buf, " %s", oid);
+			strbuf_addf(buf, " %s", oid);
 		}
 
 		/* add all the rest */
 		if (!item->arg_len)
-			strbuf_addch(&buf, '\n');
+			strbuf_addch(buf, '\n');
 		else
-			strbuf_addf(&buf, " %.*s\n", item->arg_len,
+			strbuf_addf(buf, " %.*s\n", item->arg_len,
 				    todo_item_get_arg(todo_list, item));
 	}
+}
 
-	strbuf_reset(&todo_list->buf);
-	strbuf_add(&todo_list->buf, buf.buf, buf.len);
+int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
+			    const char *file, const char *shortrevisions,
+			    const char *shortonto, int num, unsigned flags)
+{
+	int edit_todo = !(shortrevisions && shortonto), res;
+	struct strbuf buf = STRBUF_INIT;
+
+	todo_list_to_strbuf(r, todo_list, &buf, num, flags);
+
+	if (flags & TODO_LIST_APPEND_TODO_HELP) {
+		int command_count = count_commands(todo_list);
+		if (!edit_todo) {
+			strbuf_addch(&buf, '\n');
+			strbuf_commented_addf(&buf, Q_("Rebase %s onto %s (%d command)",
+						       "Rebase %s onto %s (%d commands)",
+						       command_count),
+					      shortrevisions, shortonto, command_count);
+		}
+		append_todo_help(edit_todo, flags & TODO_LIST_KEEP_EMPTY, &buf);
+	}
+
+	res = write_message(buf.buf, buf.len, file, 0);
 	strbuf_release(&buf);
 
-	if (todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list))
-		BUG("unusable todo list");
+	return res;
 }
 
 int transform_todo_file(struct repository *r, unsigned flags)
@@ -4574,9 +4596,8 @@ int transform_todo_file(struct repository *r, unsigned flags)
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
 
-	todo_list_transform(r, &todo_list, flags);
-
-	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
+	res = todo_list_write_to_file(r, &todo_list, todo_file,
+				      NULL, NULL, -1, flags);
 	todo_list_release(&todo_list);
 
 	if (res)
diff --git a/sequencer.h b/sequencer.h
index 35472c137b..dc3d8f76f7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -121,8 +121,9 @@ struct todo_list {
 
 int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 				struct todo_list *todo_list);
-void todo_list_transform(struct repository *r, struct todo_list *todo_list,
-			 unsigned flags);
+int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
+			    const char *file, const char *shortrevisions,
+			    const char *shortonto, int num, unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 const char *todo_item_get_arg(struct todo_list *todo_list,
 			      struct todo_item *item);
@@ -145,8 +146,10 @@ int sequencer_remove_state(struct replay_opts *opts);
  * commits should be rebased onto the new base, this flag needs to be passed.
  */
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
-int sequencer_make_script(struct repository *repo, FILE *out,
-			  int argc, const char **argv,
+#define TODO_LIST_APPEND_TODO_HELP (1U << 5)
+
+int sequencer_make_script(struct repository *r, FILE *out, int argc,
+			  const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(struct repository *r, const char *command);
-- 
2.20.1

