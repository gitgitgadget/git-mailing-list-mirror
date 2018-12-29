Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAC21F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeL2QF2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38674 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeL2QFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so19692264ede.5
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gq8q/7K89NThzWFJhncTUYcgZZ3KSvsBWlToZsBZ1Q4=;
        b=XhQN9NGYxxxIgH6PfLi5/E7eKlFHA4QLMHcd1nLvSDyv7ZpUEM6JdrDM1aJtiaPtD7
         KlwLpiVKjow0mN3o30xJCA+F9itiRQtm2aA/7t3vwnEKdwzG7D1v+WN/rgdHHH5LArD8
         hzao1AE7ZwTSF7LOTmPzb9f1tkQ/pXJQmP0/rcM2p7ZdnDm4O4mqSvctVw4XMpPCzX8e
         5tkMUafgTro0EulmXfqB2lPabxS7brRku1L8ffD7mP9Smy46/BV1ezUcudgmPdwNViLF
         j/a211Ah7QrpvyMqQnVPPBmHf/4HK/PKr6BY6vO30gV/TgY6v4JWN4HOogCiURNoR9AU
         SAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gq8q/7K89NThzWFJhncTUYcgZZ3KSvsBWlToZsBZ1Q4=;
        b=oLY8Xnsb1boj8Kk9G0LQVNLR+TiZQlnbMELSR57PaqCVlRmYZI4pP3s+fLno8s8vCp
         7etFse+xbHqqmpTy5NLkyBclebxcRj4IvkbsoWzmIPFCeu4zojoqmsLxcAYiZWry46TT
         JpAWR825VUIFvxOo4PQesdHBj5bW9te1rxBRnXLXOv+CJLWY99Wa25Y1R+c5dKd/LDoq
         UhSWY8Cqa1qsiOj4laCP0DxyT2UeZ2QEZtUCWL2gnlhZsvYUJbSdgbTMxfOguuiOwWDl
         INzQcS0asuABTNSb8NcQ+NMgPkxEporHkvSSrPDKphgsKMHaR5NC81fXeadZuovsGqx9
         TNwQ==
X-Gm-Message-State: AA+aEWbg5j/iSEI1wvc1QZ3eaXIsxA+FNCgMd/fIDbPsMqk232cUDhoE
        UdvdfINHs0DL89mb+E1YzzbPFeXr
X-Google-Smtp-Source: AFSGD/XVnegrPwst9HBk71Yv9RcA0QoyEWN4ChWg8dCgKVfzthPjr6pvCBdXBbqum3GtVNiMQm7TYg==
X-Received: by 2002:a50:c8c9:: with SMTP id k9mr25912596edh.6.1546099520513;
        Sat, 29 Dec 2018 08:05:20 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:19 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 15/16] sequencer: use edit_todo_list() in complete_action()
Date:   Sat, 29 Dec 2018 17:04:12 +0100
Message-Id: <20181229160413.19333-16-alban.gruin@gmail.com>
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

This changes complete_action() to use edit_todo_list(), now that it can
handle the initial edit of the todo list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Changes due to conflicts with nd/the-index.

 sequencer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0500a32e80..127bb0b68e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4703,6 +4703,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
+	int res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4727,24 +4728,16 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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

