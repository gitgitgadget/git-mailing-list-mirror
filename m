Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F8F1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBJN1T (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39734 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBJN1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id f16so11803071wmh.4
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ypvarG23z6LsE+bVjri92/lC3x2Q8MHCustBK1rP8kk=;
        b=tzaiAigMNUqflIhzpxhmEtzCrF5shFTHdCatHde/SE/i+ICvbgtOZcWDzq3i09zxHn
         lnxxiwTK9CjCTMT+5FuabiH9wpT43m/MEvAK+vUFzlkBPIpTyUX4fPu3ZshR/ZjIEjCI
         CJG1vawuxBOH2RwPqZIg2pGB6dMfT80HWD65hBGcgZ7fM+Mql08889maU9wuBU42KiA9
         EIxlLIl0xcXAwVJqaTZxj/lDJ9MgMEs/0bqypMxQzE02NaLtmepqLSzrRpZXE9wpwflN
         o82yU7F1B0zCJYudgjYE7b+h8TMyn09AbjdZJasHY++NkS9ah4fwZy8vxUtnVH9wtptZ
         dCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypvarG23z6LsE+bVjri92/lC3x2Q8MHCustBK1rP8kk=;
        b=PPVVGlrjyjCsyvb6p/QrBV/2/QeX3NEffF9uUathn2tDEqE+tkpBfWwRI1mg58sow2
         qQDpbFUUmHhXKj+Sx+MT3jtWhvaA69LlDZZLXvUDmtPVF5oEbHMO0BWrqd7N+J3ES88N
         rLACZzkGQuT0am5LJX7QWNmhkR8t42jnYs6QAq8zqKn61gtdoe45G1gEIkYDufUw70NM
         GR9mNrdhg+9XBSe0M0tBpg3OPC292tApzUYjtxCb0QI9NE1W5kOS7qaOyTKHdWT3Oe48
         rriEYhbKy/c7lyLrnthMlBiiVd+CHUpm83AUZjY7e++6aQlBHls8KQAepXfn+EUQfonp
         FyGA==
X-Gm-Message-State: AHQUAuaTLxAqaS4Tf1BlMJ2lfYMfKU2u3H9KTLiLhq08OGnuOe9Z9jSC
        dyCFaFFaCTykqaVFniYGuG6sfl2m
X-Google-Smtp-Source: AHgI3IZsR6gnr2qG2v9myv8TsOpUQAgst6WLbphSgUf52xmNL8djlBJUNTAGRIDPLrI/lK55GylSGw==
X-Received: by 2002:a1c:f919:: with SMTP id x25mr5847225wmh.61.1549805232339;
        Sun, 10 Feb 2019 05:27:12 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:11 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 05/16] sequencer: introduce todo_list_write_to_file()
Date:   Sun, 10 Feb 2019 14:26:37 +0100
Message-Id: <20190210132648.12821-6-alban.gruin@gmail.com>
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
No changes since v6.

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

