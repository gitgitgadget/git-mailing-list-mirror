Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817821F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeL2QFL (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37666 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeL2QFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so19681159edb.4
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1KJNYhT9hAbgTb3omB40rWuU7i05a6gLawPk2vuk6k=;
        b=AaV4mAefnJ8utJ1Eiw58DJz3nNKqYYbYeDtITGaVSrAWZHZzFMhqPD22Mgsdll0W+z
         MU/u0J0aTJdmdoSFiJHB0JKlQAwQCOEH4HCYias5smfmBoPRK5rZoLQ7osBWdxyP7e8v
         wHPUqZ4dgI22ZaxIkoQ0mGMa9IeL02A8dW1SxPlLAagWuh6cmhg31f7YUuRkIE7C6LYp
         0E3d80zqnTwvWPITa8OeXhoflFs44h89EhpqYncqu7N8BLkeC8j7DmGpQOvGNxk6xMEv
         lBb46dA7GOrGiuqxLO7tHhdyM9ZmOQcJ/hCmLTET19O773FuUtpJq63H+T/qmYqhsECB
         A83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1KJNYhT9hAbgTb3omB40rWuU7i05a6gLawPk2vuk6k=;
        b=RzGsMSF+nNcqnUGyMFjAl8K/7D8fN17xjRn/eH36EbHj/XdiH15KWlRmqyY8+Tg+P1
         UuUlm1ACLPJCkt+9q1TgS2ubwKjUH4jcLecp+JLCsWOkQKP3nMpa0rOQphi9x7W1n0XK
         6CFiH3CZ5x0nG46VB44DJjMFKxHHrJnS/vXzwvRUA2Lyu4rDLNaGEmlRwerEo1vY2WEN
         4CSoho4gjHPHgH+gnuTrGxv1AfNLgjyfzP9Fmtw5vJqQ6mAW+XTJy1uJ+VjG0o7OAojh
         I1aPkKzCbFE6xq7Xl7W8nZgAQnwp8Z/sF80qUo81zEAa/H/jtAyW1NXD20lEOEvGdnk/
         kCgg==
X-Gm-Message-State: AA+aEWZiCxHLqJ//5opM0rDNA0w01z4roMEhBeM2f6cjVcaWO+GUui0D
        EIn/dUdnJJ3RSeiKBfstAAJW5U69
X-Google-Smtp-Source: AFSGD/UCkRP0wGqvI1fsOBjN/7VARBAohsZbGDLGvhwS353RzmLf4B9LjlcA9XgzuAcUwUU+dHLAXQ==
X-Received: by 2002:a50:c299:: with SMTP id o25mr26786078edf.281.1546099507232;
        Sat, 29 Dec 2018 08:05:07 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:06 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 05/16] sequencer: introduce todo_list_write_to_file()
Date:   Sat, 29 Dec 2018 17:04:02 +0100
Message-Id: <20181229160413.19333-6-alban.gruin@gmail.com>
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
index 6b4eb7a9ba..b932ca34f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4501,26 +4501,28 @@ int sequencer_add_exec_commands(struct repository *r,
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
 				    todo_list->buf.buf + item->arg_offset);
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
@@ -4530,28 +4532,48 @@ void todo_list_transform(struct repository *r, struct todo_list *todo_list,
 
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
 				    todo_list->buf.buf + item->arg_offset);
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
@@ -4568,9 +4590,8 @@ int transform_todo_file(struct repository *r, unsigned flags)
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
index 53ffe7371c..4643fb3b69 100644
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
 
 /* Call this to setup defaults before parsing command line options */
@@ -143,8 +144,10 @@ int sequencer_remove_state(struct replay_opts *opts);
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

