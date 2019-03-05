Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8211120248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCETSe (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:34 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35217 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:33 -0500
Received: by mail-wr1-f54.google.com with SMTP id t18so10747804wrx.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwScf/Gx2UUVMMffUOswX4Xxaq0z6DKW9asgk6rhohg=;
        b=H7VcWw3IqlKw0glE7zefS798C1GeRtXc3pHtefbsnRflblyh4W24OJTs5aA1UxRhlg
         Jud7q1RrJHR4+iHJMbSNLRBdmCRauH3G1AiizTR+jFcs+FaffpEZNPjEYSEYKzmrQBpf
         +kki1KiIq0nXStJMkeykRWzqLy2GRMDESbHR2PvsafFEZHpGmPaPkAmS9nsWi7goi8f+
         9vIPpFeNMXqJ+XCGu5j8kS2MQseSzHmfMtmzg70sCJnUblOzt7v4R+dnX39y8m8Fvey5
         2WbmiSuZZPamZ1CqnvGndIuN5i2Sf/iyxk2bWg3rv4JpiQj0swk2Nyzl9iLCOI7NrrLg
         PoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwScf/Gx2UUVMMffUOswX4Xxaq0z6DKW9asgk6rhohg=;
        b=grWsCb6Q0OOsnhXFgWfcYX3LsYQhB6w9klakf/IZ9xjJv7Z11IG/FIQ4nWbrnBr4fg
         heLS9tj5Kg1fn/R1nIbgI6/eRBue6P7qu/U1h3r495aZfAKyQt+kGwgHMhIQESOVNoZ4
         QHVLe225fNxiAPa8XIR0mbJZ3FCpiimlWa9bZzyr0Brr+lDtyR7vO+/e9PFtpfBj8cY8
         ODXMeDktat6z5Kto/gYZElWNxPVlKesldFEW1huifQ7CTT/hYzEpPETfqqJiIy3Hnegv
         HbyYL4Vi506H31JAp9IKZdpJWEFZ/iPxnMklP3E1/f9lN5p8VqOAis+6s/KSTkvKv9DP
         5WNw==
X-Gm-Message-State: APjAAAU8GLajfAx6mj45qoppVRgW/Grxdkz0YhAn6fZnHGRabFKlkSAB
        FU3LH6QplLxg4dCdjbJM+Toohs4P
X-Google-Smtp-Source: APXvYqxgBZTiMhvKj4PdtUu0xL5ZhdbmcWDPxOgVWmfAUrUrSz8S8RGrM2JsWqDuS9yL2Bl1fmJ3/Q==
X-Received: by 2002:adf:e949:: with SMTP id m9mr322562wrn.1.1551813511745;
        Tue, 05 Mar 2019 11:18:31 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:31 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 05/18] sequencer: introduce todo_list_write_to_file()
Date:   Tue,  5 Mar 2019 20:17:52 +0100
Message-Id: <20190305191805.13561-6-alban.gruin@gmail.com>
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
No changes since v7.

 sequencer.c | 61 +++++++++++++++++++++++++++++++++++------------------
 sequencer.h | 11 ++++++----
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 346706029c..4809b22ce4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4562,26 +4562,28 @@ int sequencer_add_exec_commands(struct repository *r,
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
@@ -4591,28 +4593,48 @@ void todo_list_transform(struct repository *r, struct todo_list *todo_list,
 
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
@@ -4629,9 +4651,8 @@ int transform_todo_file(struct repository *r, unsigned flags)
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
index 2ddb20cbc1..7278f9675b 100644
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

