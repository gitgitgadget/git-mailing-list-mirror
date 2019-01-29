Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF931F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfA2PDV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42419 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbfA2PDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so22420974wrx.9
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4xxT6heuc25OusdekF4UaHK/2N7e+Ea8XZpnmikPRw=;
        b=WX/7ELyWqCMtpAgW2dnaOir7WdzTTFRB5RWov+YSx/zqShgG7dSOojakirdKOdd8XB
         az6MONpIGXLckLojbfrvhYm0CVg/qLKG9wTWS+EFsIkemg0tyRDOivjKF81ax2YcNh54
         VCDjj9QvnURTOSWGNtteEH1MzdCSUMfql3dBDudt4XUDrCwqXBBxslSRyPvC4Pd+zbKp
         nfvcez6joJYPfeRQXQkVbYi/TuLy9as0pU7OqmgB0pRGWBbDpVfuHj+hhSlc1Q49sYk2
         kQTRPLNpZS7LQNHOPDAIwTJXxh4pP1AT4FdpQEsAY0JQoEV4M1KAz+zog6F0SM+wlZsq
         rIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4xxT6heuc25OusdekF4UaHK/2N7e+Ea8XZpnmikPRw=;
        b=RSAkMHLsB7ClVgHqqdJ40skcKxkJiKlU47OpV+4oIP72yhjbGk7RzqQCvtj+ptbVk/
         hnDsXG86k6gE8Vgyy3n3HA1ovl6oq9asUTIofl1h94Y0OzjS6JDKmC7YCeCR9VGU+7iW
         gRNRa05hmHoZOdHkbXOuqqwt7dyggdKeew/wLj6xHH5jwhu33FL0L6aWBDTgw2x+i2jZ
         KYbiHcddAHfUlgGuQbUDwbj3vWXtNibwi2ekLaEbFhT1rI5/GCa0IldPvpwsSEP061zl
         r4gCwTJnYggbsKOF3eOfMINNRlbRgF84td+mcAmAcECCqI1kUIoh5S/dehmlU8fv4mm3
         mFgA==
X-Gm-Message-State: AJcUukcwFmeXfoP4vw0ILdeLPgubHiace0z8Otj5cenIxR4iKb7GdBK+
        vuCL/N925I1Pp/zVOrh9sdnwPpdm
X-Google-Smtp-Source: ALg8bN6V40+TV7/RuE7O6OtAjyX8GbAJsS5edwqMjdycd6OqglABM9dR8c4rOoWLQZvLHT6Jgshepg==
X-Received: by 2002:adf:82f1:: with SMTP id 104mr27455958wrc.131.1548774193607;
        Tue, 29 Jan 2019 07:03:13 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:13 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 12/16] rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
Date:   Tue, 29 Jan 2019 16:01:55 +0100
Message-Id: <20190129150159.10588-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
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
index a817afffa9..d8d045067c 100644
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
index 0c30e43f0a..c5bee8124c 100644
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

