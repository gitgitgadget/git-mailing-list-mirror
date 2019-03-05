Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1F020248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCETSy (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33380 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCETSx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so10731283wrw.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzzE/SszFP0f61LPcWmECXp+CigyDxDsA3cn1ZgV+9M=;
        b=Pswb2W8mY/UONI75SwMgP2WDEhP0woKvL0kA1qiNdRXqnj/P3ecVlZ2WFHs1HFtmAv
         ZKeVADMBasfUtcwh6+KHCEGtQKM5gUNQLhGnpP0ofDvkOI5d9uN/xM5Me5ZrsF/tzdFk
         rCw/K0W/PIASDB0q4MDXWHjxtDYsjFZ7hSStsncRnSmCjrf9PSvee4VYlZ+favbgzIcd
         U2wbCNPOPKH24sCo2zLWZ7BFLbA5641N7TVAwD4T8kSY5eEEuAvnvPs9N6P45A1WgH0n
         XaD02SdypZszwtHxwM4aVxvWcTH0TfM5KlZ5Zsk71srjyLWsibOjO2LyqGllqmuBS6yr
         2RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzzE/SszFP0f61LPcWmECXp+CigyDxDsA3cn1ZgV+9M=;
        b=svV1YkBpG/eZK8UXV+caabg5NTKMK6gLxqKO/200Knh9bvnCdSX+4CXmgHk6pJ0qLd
         uCvp0RvzcMSNXfekyy0R/Hx9qVbMXy7r0SO3j/EgE+2eBOgbSzY7Dw+acfyLrixEG0dB
         iuqieHvfefp/pDXiqqpj7nxujTPpSJa3LCNGgddfYBua0Qhc6fgovr4xLuCkpVikXJHL
         zSp5fZN33+vjZUOWR41bMntMwlZYpigjZcybhFGRShGN4+97A/lSK4iCOlKnKNiOIWwS
         fW3vUPs6ho24S4/GwtNAvSjLZYZFwKZNUzgJKpd7eaTkuP6Ahi3yKxpM1CqaGidfqa6D
         Tl/w==
X-Gm-Message-State: APjAAAVChkPjgPjyC5OssjKS9M114Ec9gkJRooWOGqXSgHkxY0P9GHnr
        wQCiYEv/cxgjRntHcJw/ABst+mst
X-Google-Smtp-Source: APXvYqz0QeyRbxNdJCeFI+IYdvYE8xtZiRlRlT3z/Unp5i6R5bUeMx09zxdbZ1f716rjeGvxiJnF0g==
X-Received: by 2002:adf:ee0f:: with SMTP id y15mr279651wrn.197.1551813530768;
        Tue, 05 Mar 2019 11:18:50 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:50 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 14/18] rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
Date:   Tue,  5 Mar 2019 20:18:01 +0100
Message-Id: <20190305191805.13561-15-alban.gruin@gmail.com>
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

Just like complete_action(), edit_todo_list() used a
function (transform_todo_file()) that read the todo list from the disk
and wrote it back, resulting in useless disk accesses.

This changes edit_todo_list() to call directly todo_list_write_to_file()
instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 rebase-interactive.c | 38 ++++++++++++++++----------------------
 sequencer.c          |  4 ++--
 sequencer.h          |  3 ---
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index dfa6dd530f..d396ecc599 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -79,39 +79,33 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 
 int edit_todo_list(struct repository *r, unsigned flags)
 {
-	struct strbuf buf = STRBUF_INIT;
 	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
 
-	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	strbuf_stripspace(&buf, 1);
-	if (write_message(buf.buf, buf.len, todo_file, 0)) {
-		strbuf_release(&buf);
+	strbuf_stripspace(&todo_list.buf, 1);
+	todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
+	if (todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
+				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
+		todo_list_release(&todo_list);
 		return -1;
 	}
 
-	strbuf_release(&buf);
-
-	transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS);
-
-	if (strbuf_read_file(&buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	append_todo_help(1, 0, &buf);
-	if (write_message(buf.buf, buf.len, todo_file, 0)) {
-		strbuf_release(&buf);
+	strbuf_reset(&todo_list.buf);
+	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
+		todo_list_release(&todo_list);
 		return -1;
 	}
 
-	strbuf_release(&buf);
+	if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list))
+		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
+					      flags & ~(TODO_LIST_SHORTEN_IDS));
 
-	if (launch_sequence_editor(todo_file, NULL, NULL))
-		return -1;
-
-	transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS));
-
-	return 0;
+	todo_list_release(&todo_list);
+	return res;
 }
 
 define_commit_slab(commit_seen, unsigned char);
diff --git a/sequencer.c b/sequencer.c
index 894c7538d5..b7289c93d4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -383,8 +383,8 @@ static void print_advice(struct repository *r, int show_hint,
 	}
 }
 
-int write_message(const void *buf, size_t len, const char *filename,
-		  int append_eol)
+static int write_message(const void *buf, size_t len, const char *filename,
+			 int append_eol)
 {
 	struct lock_file msg_file = LOCK_INIT;
 
diff --git a/sequencer.h b/sequencer.h
index 13c5676c24..fb31a30d15 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -64,9 +64,6 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
-int write_message(const void *buf, size_t len, const char *filename,
-		  int append_eol);
-
 /*
  * Note that ordering matters in this enum. Not only must it match the mapping
  * of todo_command_info (in sequencer.c), it is also divided into several
-- 
2.20.1

