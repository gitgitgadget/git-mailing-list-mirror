Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF531F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeKIRsK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42909 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeKIRsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so865397wru.9
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDz+erBAWeThbjjOrX4A8cTDjGlt7i774tix1Ggg0WQ=;
        b=rR0drcbtmNMI6ApidU99ZdUjbIoka7Wu3Hnm5vs10Y8SGUJSXvrJcDx3h95jc+kTcW
         aMykYFpmx21GgSkJnt1qpGTgOtuE5aXGGgyM85M7MMmAk9iawswpL2qW9gJ7/tmJHXjp
         I+QXZ6Phn3ycnimCDoM4JDngTmmygoGpukp45n6XUwO+XlBeEzRbZzaJa7N6BLqly46M
         NKGOBGHlOPlbtnvT7PApifBljY0aWSJzIgtjNQG7Nby44PS3D0Lxi8OeXnk3GdlZlZY5
         UeJu6YTZrQ5fFCvq1RGczT1BTKa9X1+EYIbXQbQc2irAtuYSiYnjbe06X9mvcT6keUfw
         RvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDz+erBAWeThbjjOrX4A8cTDjGlt7i774tix1Ggg0WQ=;
        b=Y5HimCXF89sr8HA4IVqnjo6/6GPPuT5c+6f9ZW4Vb0+YvMUK9cTR2U7g8Kw/ctGR8Q
         AN/A6iuk1W7hFR+LDL6+II1KoCvVQ1oXzhXKnDlQ4cIUZ3NbrHzqq98+wj20EFX0wXUV
         3wHLM1DNmZ5hSEZF39CoXhkKFTl9JHFDNmVSy+bZp0cPvNjfB3GJhKRgzOTkiHZlIND3
         LYcYQziC+BwDJgrZng45SjVI80VUMiXgF3YqkL1ngpqqdFGpGl6aKxhh+6KXpttKGEQl
         r+W2ZOi4Hw9q6VC8xAyrsU7bXAs/hcxBYSRJMExbVUbaJZfvpzj6JBfPV3lK8y2T0C8J
         DMGA==
X-Gm-Message-State: AGRZ1gICD5vVmJsWVccSAwRGruMJ9NNNqFUGH8rAtMHZZiMnxJhVb0FA
        xAU/VpLN/kjrOs/uxBGMo/MSyJ1A
X-Google-Smtp-Source: AJdET5eJfOBRXPlG4YzJf1XW3tPGMDUrtfPnl8FWJxOkta0Jz9lUu69SYScQJHwplB0LBq9P0cQMsQ==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr6900981wrt.298.1541750923452;
        Fri, 09 Nov 2018 00:08:43 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:42 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 11/16] rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
Date:   Fri,  9 Nov 2018 09:08:00 +0100
Message-Id: <20181109080805.6350-12-alban.gruin@gmail.com>
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

Just like complete_action(), edit_todo_list() used a
function (transform_todo_file()) that read the todo list from the disk
and wrote it back, resulting in useless disk accesses.

This changes edit_todo_list() to call directly todo_list_write_to_file()
instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3adcf39e07..23569cfa3c 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -79,39 +79,33 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 
 int edit_todo_list(unsigned flags)
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
+	todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	if (todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, -1,
+				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
+		todo_list_release(&todo_list);
 		return -1;
 	}
 
-	strbuf_release(&buf);
-
-	transform_todo_file(flags | TODO_LIST_SHORTEN_IDS);
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
+	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
+		res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, -1,
+					      flags & ~(TODO_LIST_SHORTEN_IDS));
 
-	if (launch_sequence_editor(todo_file, NULL, NULL))
-		return -1;
-
-	transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS));
-
-	return 0;
+	todo_list_release(&todo_list);
+	return res;
 }
 
 define_commit_slab(commit_seen, unsigned char);
-- 
2.19.1.872.ga867da739e

