Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5F51F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBJN1Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfBJN1W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so12210069wml.2
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkjQlhoRMRJdt5YQicAHVb7qFbWTiWUunKNcdxo6elk=;
        b=Ov/Jmay6PtvdKKaa934crkMpJx0XX8Y3dioFb4fH/DxNyUvVdkb7Z6NdcWJ7DpzTWe
         FIDVzwL44bz6tzUSCoClqCL6siyTG1A4/V1NEgbTGgTIbmdeAUBk4ga4s8Ps0bqvcEzt
         o7bLm73AQA4ba4/H7KRhGnNYlInwhWa4S/LKuD1DwwbDgpWbXbyQUOFZ4AZOu6vhS0C2
         PbD5zTNEIWYXxbtcEqbkCoBlZMf07sxeTCJSzcRUk+PzwG3PVatLedR9pONoWbPM6Myy
         urcsiA4za92a6pw3UxAsYmI+of026fAnD6zkjw1JBlSUpdKLwfs6Hc5N2VkpEyV8zc6H
         cmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkjQlhoRMRJdt5YQicAHVb7qFbWTiWUunKNcdxo6elk=;
        b=Pf7hICM2WZHEzszLKXd+5R+t38lPRgqBSV842Ij45bRRg39NM8uCGKglkZVz/ANSgf
         vOGWU/35nJR+U3nD0SPF1UQPD+3Hh2xDVkHpdBXyZOJAZExb8eubM74bEPth8ouvCRlb
         W3sRhQGQd9zOIhlKt6GdKv7EcQSBN6cXctIIcSUVV3pA5tqgiwO87v5knvDGhJ25w9Ib
         s2+M70psNJk8THUDkQcGxB7Z+WmoBrrc9V6NNWMS2wMWANQV1M84p8TKtR8lKtiLkJ3A
         dXSEgcZjyyKyoC12fzQKgOq4S6/J3Z4W+4VsKfoHFa3Kibc3wgvELXg+XTa9d7PDP+Ee
         BrrA==
X-Gm-Message-State: AHQUAuYb0IpXMZWJsDF/unaQ1+24R/2UlHCuK+aSvwNCQOFaumf8rhvn
        jbAqqU20IlhgdLqKdCcNbNCvJOPw
X-Google-Smtp-Source: AHgI3IasnrgBhyU2+hs5TklckLeqWDMg2jQccYJbRSjj/HsR0Sxpyl1+/zFvPw5NXkAwnNWrjb3sRQ==
X-Received: by 2002:adf:df08:: with SMTP id y8mr22748723wrl.23.1549805240731;
        Sun, 10 Feb 2019 05:27:20 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:20 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 12/16] rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
Date:   Sun, 10 Feb 2019 14:26:44 +0100
Message-Id: <20190210132648.12821-13-alban.gruin@gmail.com>
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

Just like complete_action(), edit_todo_list() used a
function (transform_todo_file()) that read the todo list from the disk
and wrote it back, resulting in useless disk accesses.

This changes edit_todo_list() to call directly todo_list_write_to_file()
instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v6.

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
index eacaf52250..74fbb14153 100644
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
index 7029b39cd6..c80990659c 100644
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

