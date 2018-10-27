Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA10D1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeJ1GM1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54326 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeJ1GM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so4574007wma.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCeDv8G+h2RyEYqlIXfSOiKgULZocdWvCmLrn/VQwb8=;
        b=oSkHk0JgEHyxQYVbztI4GLau7qvAR3tnQUejYmmAJZ6Ggiokn+B7VCbi0ijWXOWkBy
         U9+Qf1NRNq/SLWrhuzdPiLNbVHyzxdGW151I82VRrjKZIVX8f9tzTNWvHDoaKeskOurl
         VMfLZnRFJ3XtnBeruEVxbJFvlhayjbQ8J8OuuXMM2GlcYUqMKaP2dCFvE2FbTW7GDU+c
         x6g/NgdGs03K9HmiWBcnhXhBiCyUyXxgQh91RZE+d+4azxQ/cDfF1S3sxQOWCDWdXDH5
         dmhNYHMpuPyGECXuAcmB3GjqvayJgAIemdN5ZKLo30rOIGZJS4r6jIH22ygaKpkYjL+D
         ojKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCeDv8G+h2RyEYqlIXfSOiKgULZocdWvCmLrn/VQwb8=;
        b=RM2uQ7OMsvUVK8ck0Uhkk7X1FpkAzed9rgcFnx1Q6d239Tb3Geg+A9W1HY67V4XK2b
         Uk9V/m+Hbf7oXodRcLsmj9w92VaHrHC9T7yWWCklXxrCbUO/VPA+9zuhwNc73a5AbjC1
         y7Gw6uoiUnWyR/60VC0hNutEmMAD+EJNMLbFXANMdglG93ja8JLP5LWLIcWW11CDkl6u
         fly2ugEEHTf+Abr4xFwkROBLF7u+Xuf7z4eAv9yhuvNCTUbI2UEIDFLun2FuEbWwSci4
         373l3GpfqFaTMZWnbJF63XEjeWPtEwL6bJQFBNtxHF5PFJqN2JLm+MvCQ75/+Np/onGi
         UfPg==
X-Gm-Message-State: AGRZ1gJDTqOLJ1nCWWPI0+qfrMedWa8N/3LWeejtr6MsebLAHD2uaKMO
        l2rw96OzTwRpwfvXNBN5JOMkLMhH
X-Google-Smtp-Source: AJdET5cbRoA+xUaoimm9K15Z07X3KJVEzepL2EwtHxWRmn/ESTFFu2/sIadnAeGBPsxrJdmHZaZKtQ==
X-Received: by 2002:a1c:f53:: with SMTP id 80-v6mr8961789wmp.58.1540675806430;
        Sat, 27 Oct 2018 14:30:06 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:05 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 11/16] rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
Date:   Sat, 27 Oct 2018 23:29:25 +0200
Message-Id: <20181027212930.9303-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
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
index 9e81ecfe9f..b2be99a900 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -78,39 +78,33 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 
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
+	if (todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, 0, 1, -1,
+				    flags | TODO_LIST_SHORTEN_IDS)) {
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
+		res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, 0, 0, -1,
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
2.19.1

