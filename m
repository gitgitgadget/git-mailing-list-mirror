Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756681F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeKIRsD (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43830 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeKIRsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id y3-v6so863270wrh.10
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ku71qVJ4yxIlk/6G/410hieRxMM2wBBBShfL/msCgo=;
        b=Gjh1o68RJnmZ433gjJCCVt0d+0hsCOPRuQ2FluJCIoXDbY/MSO56+N8DPctTNjdOyh
         6v90gQz3RlgRJogsMaPyB0ULGxibCKs3xdif1nzVTStazUFEPKqQFCxs7hv+rnTnFF11
         XDhcZEaJxdzScpxZHi7jyTYeNLNs1tK+mIupSkbOZSVq2qVO36CTcF0P2oh1eRqPVlq1
         /OQJBV7putdwnqUKDf2ntdkZ0KW6vkvtXmMCBHFKKVK79uixVkssWrXykxrR5Rf34Edw
         rFRSBbhs0VLioP8dP5uIbkeIl+rdyiuF3cchcb1QUAd6X1Yk3lvSURv7GrHoNt9iXHKT
         oYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ku71qVJ4yxIlk/6G/410hieRxMM2wBBBShfL/msCgo=;
        b=jwgtsMuzJVJrxOHpsP+oEZTOeA+EP7V46PyvS7cPWX5r+1xEPKCsYlRbxl6/HdJ0K2
         quccjJ3CyN/FKzLrlUMAcO2qyYTrYFxO8ARAzybDKUqzl1zI28Q44qc3dJry0qbPb7VB
         qGnVFmDwrxlcAPbBIpDMoRZgUv86vPLQIZ8rx2jd2CfPIWVjMZIH/dbPB82uPFa0poZd
         4n8s6pH1TqLrLf7akKkQfc8NgAH2hd7HmZx4pCByGi6S2/U8/tyy73l37mpwEZ9MziU/
         yBZ9BppiOSxWOGbj7pCokhy3q4mwc2W4hp/jYgLakC97BlWpKt8r1/qHm26mZmuwoI3K
         RomQ==
X-Gm-Message-State: AGRZ1gJc2j0APUbMSbAAgl3FB+7e6Rs9gl/hDmeSlu87K4CPuRF19lY8
        lk1BQ76dW+bNNkKwFa0hluwYRHys
X-Google-Smtp-Source: AJdET5c34VFPgvpv7BPPfPk11HvZLBilRq8NLRtpaDsTwUkDoPgsXdLVjo6dCsaM6TraZpebh+YT4Q==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2-v6mr7463460wru.45.1541750914784;
        Fri, 09 Nov 2018 00:08:34 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:34 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 04/16] sequencer: introduce todo_list_write_to_file()
Date:   Fri,  9 Nov 2018 09:07:53 +0100
Message-Id: <20181109080805.6350-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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

This functionality can already be found in todo_list_transform(), but it
is specifically made to replace the buffer of a todo list, which is not
the desired behaviour.  Thus, the part of todo_list_transform() that
actually creates the buffer is moved to a new function,
todo_list_to_strbuf().  The rest is unused, and so is dropped.

todo_list_write_to_file() can also take care of appending the help text
to the buffer before writing it to the disk, or to write only the first
n items of the list.  This feature will be used by
skip_unnecessary_picks(), which has to write done commands in a file.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 60 ++++++++++++++++++++++++++++++++++++-----------------
 sequencer.h |  6 +++++-
 2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e1097660ed..19f24825d4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4454,24 +4454,27 @@ int sequencer_add_exec_commands(const char *commands)
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
@@ -4481,27 +4484,47 @@ void todo_list_transform(struct todo_list *todo_list, unsigned flags)
 
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
+			    int num, unsigned flags)
+{
+	int edit_todo = !(shortrevisions && shortonto), res;
+	struct strbuf buf = STRBUF_INIT;
+
+	todo_list_to_strbuf(todo_list, &buf, num, flags);
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
 
-	if (todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list))
-		BUG("unusable todo list");
+	return res;
 }
 
 int transform_todo_file(unsigned flags)
@@ -4518,9 +4541,8 @@ int transform_todo_file(unsigned flags)
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
 
-	todo_list_transform(&todo_list, flags);
-
-	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
+	res = todo_list_write_to_file(&todo_list, todo_file,
+				      NULL, NULL, -1, flags);
 	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/sequencer.h b/sequencer.h
index 708d042f0e..e69357c95b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -119,7 +119,9 @@ struct todo_list {
 #define TODO_LIST_INIT { STRBUF_INIT }
 
 int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
-void todo_list_transform(struct todo_list *todo_list, unsigned flags);
+int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
+			    const char *shortrevisions, const char *shortonto,
+			    int num, unsigned flags);
 void todo_list_release(struct todo_list *todo_list);
 
 /* Call this to setup defaults before parsing command line options */
@@ -139,6 +141,8 @@ int sequencer_remove_state(struct replay_opts *opts);
  * commits should be rebased onto the new base, this flag needs to be passed.
  */
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
+#define TODO_LIST_APPEND_TODO_HELP (1U << 5)
+
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
-- 
2.19.1.872.ga867da739e

