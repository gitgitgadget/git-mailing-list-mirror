Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFC720248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfCETS7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so10725681wrw.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+k2k6dyHx+mQMgK7Z6pt53Z/j2FRrCpJkbib3TzE3A=;
        b=fInne1BVLsb/4BsdeQX6hIW0MRZtK0/QDH3FgZHNs17p1wNkl6tvNlQJpguWTMRH6u
         OYAmuHlTHRL4NMRW19t/9t0u30iw/tTFXyXx0jm1z5tnvaXhGSLNFdMQl+aq3hioBluz
         D7BQRxmAs0YWQGeZdmdPs7eiVnb9vqmLlzYZ2K9/wnkimnm8xiCSIKVDOkQJEtM8uLlN
         XN7NBZQs5ZPBzjnLR7kXHf/VLOYNmYE8eZf3TGAD6sQv2OFlGEAnG0QQJcVZ+iOUDtHC
         wJLolkUfF+LyqokuNJ+8acM37BGlRSgmJl0hsFK2ArvGbjfx/jyFXn3YfF3nYWX/Wg3b
         ituA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+k2k6dyHx+mQMgK7Z6pt53Z/j2FRrCpJkbib3TzE3A=;
        b=CKTH4jI0vnwJ1+JipyCWjRpD4imtRX6oFiLea+UenjkPWXgr6hxDJqf0/vt3rMzOFW
         tx17orN9ig38OQrCzqpgvM1RF6SvMts1NAAKeu0jDlKnIHsgsJOdA7M3KUd3SJ4+tJid
         Sqi/z2h4erI/8/YyCXI3VYtwVedFeA5e3dNT6dR8W2k5QMEQAeVop1VdnQyzNgLCKoNH
         cGHUQffGL5OawzQTiVcBtDU8ZBUDH0vOEQhSQwy+YE9ogrANz/Y/JUC+VmkcDXk/6Rd/
         YO+REwNy23IAOT+UWcs8404G69H2g6v6uyC609o+XDKMZ49daIxjFRpHFidE/Wdog1i4
         OsIA==
X-Gm-Message-State: APjAAAVrydw0iLP3fzIqSX/XSMkE3641t4TBDWLho2ApSjqUVOSscpoV
        VKsgPJuV9+5HegUG6lfjg21VZVKj
X-Google-Smtp-Source: APXvYqwZ7kh/O9wn4r+Xqwidbyd8OHydkzopCSCpjpW4tWLzulpEK+Xbo6ziV37KDoHM8HwqdfWJLA==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr343777wrq.178.1551813536298;
        Tue, 05 Mar 2019 11:18:56 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:55 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 17/18] sequencer: use edit_todo_list() in complete_action()
Date:   Tue,  5 Mar 2019 20:18:04 +0100
Message-Id: <20190305191805.13561-18-alban.gruin@gmail.com>
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

This changes complete_action() to use edit_todo_list(), now that it can
handle the initial edit of the todo list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 sequencer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7d46f76a8b..c56c3add1a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4746,6 +4746,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
+	int res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4770,24 +4771,16 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("nothing to do"));
 	}
 
-	if (todo_list_write_to_file(r, todo_list, todo_file,
-				    shortrevisions, shortonto, -1,
-				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
-		return error_errno(_("could not write '%s'"), todo_file);
-
-	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
-
-	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
+	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
+			     shortonto, flags);
+	if (res == -1)
+		return -1;
+	else if (res == -2) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 
 		return -1;
-	}
-
-	strbuf_stripspace(&new_todo.buf, 1);
-	if (new_todo.buf.len == 0) {
+	} else if (res == -3) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
-- 
2.20.1

