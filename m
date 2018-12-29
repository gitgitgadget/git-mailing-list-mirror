Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7151F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeL2QFV (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40981 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeL2QFT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id a20so12897737edc.8
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i35YbZIIIOSSwGtgLpNrACYLUVPy6FEMtzaxAy0pNGA=;
        b=ca+YZiGGdUd98Is6DCfs6XEpu6HmPpWinXAnjJAPrW7uW1nRqO4wA9a7dxYv0vC926
         mHN8b26mKR+bsuA4LzffX9m8QGP6+CE05JK+sLEcM67rn5JeAN/sUsE/1XxpQv1iuwuC
         l6Z55tfdSqJNVKnxXW5JctcR9eqbiI2omRI8/rea45udZ+vfuasd/az8uZpTci0x6xGH
         x9U0v8+sPGWol+A2YG8XGLCyhxg6wwhKpQx0gAmEl5N+PJYinJpSFJUcv9/y+WiYZ2Lq
         KV8aAlls4b4e3kCpGWDPmBXDfIuZP0gGySDcbmEgSRAn/QL8FGm6JH/DaM4ygxzqC4IR
         3YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i35YbZIIIOSSwGtgLpNrACYLUVPy6FEMtzaxAy0pNGA=;
        b=q9qOuzRJq7FheT/sOX2LNWM1N7d+5Yh2Wd/na6FZF/HKgeVtYqAKQKzAgKK6vQ1zs2
         J9Mfkih2U0NX3qhp4hefhRS4Z7g1VVYf9x1EET51ItXnoeP2Ide4njwzyk7CsEcRFUef
         MgYdiOuoeIwg7pdmD02J10dCcHWDr8S/Bw3dqZKO8ZSNIdn9NedOA7emL/aPMei1roe7
         IyxSUS1wQtAVcCHX8LHQ1r5rcxYr3tfo1Tq0ZAJJBTAEPX0CPwSJEdn1ifQvx+eW24iZ
         8FalyG2SpY7alggupvkqWRf2VUnK8ZJrOgUXXAgo/k/KMxbKjKWQlSZwTfbYCcyW+g77
         oADQ==
X-Gm-Message-State: AA+aEWZtjXwQy7XR3+tXB7rxsmP3FURAjhaFprl4aBHyvADsHOxIOG4h
        VsEms6Pbc+vmapkuoe0I6y2QkEK3
X-Google-Smtp-Source: AFSGD/VpBQkit9ulMiXvxz3Ww/VtC2M2ZvCmPxkswd3yuRPLp/6lPHhQa+d05MGVuB2pBGKs+rw98A==
X-Received: by 2002:a50:f489:: with SMTP id s9mr25898722edm.101.1546099516840;
        Sat, 29 Dec 2018 08:05:16 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:16 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 12/16] rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
Date:   Sat, 29 Dec 2018 17:04:09 +0100
Message-Id: <20181229160413.19333-13-alban.gruin@gmail.com>
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

Just like complete_action(), edit_todo_list() used a
function (transform_todo_file()) that read the todo list from the disk
and wrote it back, resulting in useless disk accesses.

This changes edit_todo_list() to call directly todo_list_write_to_file()
instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Changes due to conflicts with nd/the-index.

 rebase-interactive.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 6157247e1f..994f0f9753 100644
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
-- 
2.20.1

