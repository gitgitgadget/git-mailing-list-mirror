Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD561F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeJ1GMR (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJ1GMR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id g9-v6so4667373wrq.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBV2JpiHvaPR+5ZOnotFn6Wzr0I12rKofRwIPiIKid0=;
        b=b8g26mrjDaxmXYCGF/wR9InIRF1eXQAjXBU+TH/eTbCr1EPYoDzVw/wyNRj5jQSrO7
         ce3O8u5WnMZ+yQDoMdGo1eGKTy6PnbP0SATTfqfW7FVN64hKXjQVUJ5HbbTqa4VlkkSQ
         W3zcmF2ht/TdwM7OsJOR6dp6D5NV7s3nuWKPOMGbFywX7l2tXXeAwiZxb4AFTZr584jC
         tjMih42CZ2VY+03hcd/CgWRmTW/eCdoz763X4AmzyWnoFoIFM6G/f8ke1YSoMuREL9M6
         AtdFsQJ7gm403C2MBUZwpVW7V6np43CCPzDTGUQhbVDiHpi/QZZYjmQt/DNNbD+985Oa
         cI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBV2JpiHvaPR+5ZOnotFn6Wzr0I12rKofRwIPiIKid0=;
        b=IbARATdV5mSge/3sMp+/jzyL70kpZyMFl8CpnHhW5vOt1OKoL8896+oVVV9HO267Pz
         5dq235KVYmK/wY76NtFLYLrP3PnZL5tWdtLDG+Z1SgBeGBw/gU1exJ+VWi42of5ibb9e
         b+oRQT6P4G63G5BaP1s4kWQwIRY0jHKQLQlzEObSHqrhxz960iHzfVd5E2bb4TYfyyTQ
         sSSZMe3cyfSs2K6LPglWbHEAKxQ2M0ZblJKw7T59LAPvPuRrz1hG80DhRj8C3BzgWkmZ
         AV51DHN+d+m78eLSw7+NFLEQNF7X4Wc8pUw2jYPQsgrKLjjwzkhHYbbmb1+SuwPejX7u
         zKeg==
X-Gm-Message-State: AGRZ1gLfikJVbuKfzv+0dooz52w+EkNdyqIbkh5YNs9MB7EpSMnWfHm/
        U7MaaqUqsbpMJ/1825Sq/IJDZTKr
X-Google-Smtp-Source: AJdET5dJnSprCR/u05SmSPi3X9aHMflOvj0LoqhfmcciZ4OFzQ5fjb2u42QlGK9rN5202XSleFv9ew==
X-Received: by 2002:adf:ae41:: with SMTP id u1-v6mr9328986wrd.43.1540675796746;
        Sat, 27 Oct 2018 14:29:56 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:29:56 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 04/16] sequencer: introduce todo_list_write_to_file()
Date:   Sat, 27 Oct 2018 23:29:18 +0200
Message-Id: <20181027212930.9303-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This introduce a new function to recreate the text of a todo list from
its commands, and then to write it to the disk.  This will be useful in
the future, the buffer of a todo list won’t be treated as a strict
mirror of the todo file by some of its functions once they will be
refactored.

This functionnality can already be found in todo_list_transform(), but
it is specifically made to replace the buffer of a todo list, which is
not the desired behaviour.  Thus, the part of todo_list_transform() that
actually creates the buffer is moved to a new function,
todo_list_to_strbuf().  The rest is unused, and so is dropped.

todo_list_write_to_file() can also take care to append the help text to
the buffer before writing it to the disk, or to write only the first n
items of the list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 59 ++++++++++++++++++++++++++++++++++++-----------------
 sequencer.h |  4 +++-
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 07296f1f57..0dd45677b1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4256,24 +4256,27 @@ int sequencer_add_exec_commands(const char *commands)
 	return i;
 }
 
-void todo_list_transform(struct todo_list *todo_list, unsigned flags)
+static void todo_list_to_strbuf(struct todo_list *todo_list, struct strbuf *buf,
+				int num, unsigned flags)
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
-			strbuf_addf(&buf, "%.*s\n", item->arg_len, item->arg);
+			strbuf_addf(buf, "%.*s\n", item->arg_len, item->arg);
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
@@ -4283,27 +4286,46 @@ void todo_list_transform(struct todo_list *todo_list, unsigned flags)
 
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
-			strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
+			strbuf_addf(buf, " %.*s\n", item->arg_len, item->arg);
 	}
+}
 
-	strbuf_reset(&todo_list->buf);
-	strbuf_add(&todo_list->buf, buf.buf, buf.len);
+int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
+			    const char *shortrevisions, const char *shortonto,
+			    int command_count, int append_help, int num, unsigned flags)
+{
+	int edit_todo = !(shortrevisions && shortonto), res;
+	struct strbuf buf = STRBUF_INIT;
+
+	todo_list_to_strbuf(todo_list, &buf, num, flags);
+
+	if (append_help) {
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
 
-	if (todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list))
-		BUG("unusable todo list");
+	return res;
 }
 
 int transform_todo_file(unsigned flags)
@@ -4320,9 +4342,8 @@ int transform_todo_file(unsigned flags)
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
 
-	todo_list_transform(&todo_list, flags);
-
-	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
+	res = todo_list_write_to_file(&todo_list, todo_file,
+				      NULL, NULL, 0, 0, -1, flags);
 	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/sequencer.h b/sequencer.h
index 029d842ac5..a299c977fe 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -113,7 +113,9 @@ struct todo_list {
 #define TODO_LIST_INIT { STRBUF_INIT }
 
 int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
-void todo_list_transform(struct todo_list *todo_list, unsigned flags);
+int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
+			    const char *shortrevisions, const char *shortonto,
+			    int command_count, int append_help, int num, unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 
 /* Call this to setup defaults before parsing command line options */
-- 
2.19.1

