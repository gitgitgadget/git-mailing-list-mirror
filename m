Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9F91F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfA2PDC (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfA2PDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so22524942wrp.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+yKH6VM4q5qUus3LzuScahf+GB+fYPnO3K/Ha3S4+o=;
        b=MS5sBvbFk3zwQzTlcj4/0gL3ZvH7aaai8YvwxtxrCI8zlbSoaMn3FLfjQHx+hyF+3T
         dqXJyTT/unpLlNuan0fA8tcn/JJ0rMqVlu3TVyIXuPLD9vgrDrT8CKAAzpF+zxlz+hqr
         xdhMwy6KF4ql3K/v34Fh3QOMDDi1wHpdcWMPWwTezVhcnf55C1wtAmnsnwmEiWDyMoMu
         d0wnF/90KbTJ0tRTPE3m95Q35W/NqirqbSsCAehPI+We0AjhxCua3nhV9KFVI0WIWQUs
         F6vNzR4awMrH1+TtY5L/C+OxnglTfpA51jRluwubPYZvG9rG84UB5CK4QXJJmUuxk6Li
         +V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+yKH6VM4q5qUus3LzuScahf+GB+fYPnO3K/Ha3S4+o=;
        b=hakj5sCbL4JhNT/WuOfYYqeFjZQQhZ715Qj7nlHe6c0DmLuQLMKx/MIJCxQaRU9pr3
         vS/AJB+2uOn8dtwMEJGq1PTBiVN3l2JU0DQsnEzgqxZGdN2r224Mwd/2qOiQcdP6epwB
         ZZR4dmxyQUVSFMrraHxYbwRwEM4P+t0l8EiZQ62aEEvl+lOiTVFDSvhVphzgDWDVb/n0
         Row8ApTJu8kr70SpbgQBSM8EKDkiyQgiP2yMu0kFZxF++9RObv52jmnUlBk9WRmPs9a4
         lysfX9K4dvGyBJwNBlctK4CllvIy4hX9ynhx2xjwDILkjLw9Ts89quMh/3KyzH4qOoQU
         AQ8g==
X-Gm-Message-State: AHQUAuaHQ4bfIZCuX+OBxoNez9kViqsdATy9k9/So1rRzuOnuCrMmmlH
        gqXV5rYM9BbAEPj1GAMBvs9TqLom
X-Google-Smtp-Source: AHgI3IY+zvWTX+KVIY33PgN5CpfPzHUnwEh5IuI29QHdUU282ZcTSWn5ElBCe6o4msVbWziUT1unyA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr5556998wro.103.1548774179494;
        Tue, 29 Jan 2019 07:02:59 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:02:58 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 01/16] sequencer: changes in parse_insn_buffer()
Date:   Tue, 29 Jan 2019 16:01:44 +0100
Message-Id: <20190129150159.10588-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This clears the number of items of a todo_list before parsing it to
allow to parse the same list multiple times without issues.  As its
items are not dynamically allocated, or don’t need to allocate memory,
no additionnal memory management is required here.

Furthermore, if a line is invalid, the type of the corresponding
command is set to a garbage value, and its argument is defined properly.
This will allow to recreate the text of a todo list from its commands,
even if one of them is incorrect.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d726f77e11..a7afaf6882 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2091,6 +2091,8 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
@@ -2104,7 +2106,10 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 		if (parse_insn_line(r, item, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
-			item->command = TODO_NOOP;
+			item->command = TODO_COMMENT + 1;
+			item->arg = p;
+			item->arg_len = (int)(eol - p);
+			item->commit = NULL;
 		}
 
 		if (fixup_okay)
-- 
2.20.1

