Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3DE20248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCETS0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55717 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so3682230wme.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ej9k2e1suOiA6bpSc7S6MPJhu7V7gKqEd9NUhKHcynM=;
        b=lGK3KrV/C1dyRGnMys/6DmSEHD11AmGdPEUrS8PRj2VxjDq/6rwpVR9Y3mClmY8bEj
         lUbeSa7Ya8J0QzrB6MPmx0mUV7+zU3/jHdsTE8VQMBr2ntpMY5DXBVyTCC1F76k6FFq5
         mzqrfCA0USF5FGdTutIImc77Gok5px/sMUlWO3sKdDCfIvKzp9sdaJmBLexnOGzjUbnb
         f7Soz1iUBtUgZIGT2e9XIl8lV7qcdcpznurNrCCGjAkeH1amYRa4vLjqIV0eVhasmxUD
         DGCqE7YpulG8iX01ut6nO3Fo5b1JhiT1LY/9pSoVRQ0sb3UlDvDgsnuB4joDkXf1KHmv
         qV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ej9k2e1suOiA6bpSc7S6MPJhu7V7gKqEd9NUhKHcynM=;
        b=OGS4ZqHdh+d20G8qpSfT1ogOyDI8NHAxTmOK5Xs8Q81OOaUna8em19dA2rnHl+R+yy
         Z3dvWVztJLiiIFZuCSV/wh91LFW05n/IVV3u6yq3bbZ9l9dKr9h/3I2Ee0EzUmMtFA99
         1KxvSpfYM4SuMj761lFihWiczAmLJp2OL71cEuySZv5/FJc4Q7MMty5aXDYdydeAn1sO
         liihiCndL4f5BqEAN8r9SdmUy+6W/UCUdDDqeNQHJexm/qEoLBLhWHuGHQZsil/HCMW7
         0FJBnHnFzV0ZRW56RqjYPBHmisaD67hATpm3lwh1qfz/nLHwLmGoSwHGkDGGkBL08nWv
         omQg==
X-Gm-Message-State: APjAAAXweSSnAk/5DGxIKgLMezjVcSKfM1DxFcZauFWuyr4tHreAlylp
        EH+4HTTGbSD1uNIAwOPXn8zC+wVk
X-Google-Smtp-Source: APXvYqyqSzVsN5ghOcL7TUTpJacZbRHU7y/P+HT0+5tBSPtTOqsQEIX1rLmPtULjVJamtL0fppxNgg==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr97787wmc.8.1551813504157;
        Tue, 05 Mar 2019 11:18:24 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:23 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 01/18] sequencer: changes in parse_insn_buffer()
Date:   Tue,  5 Mar 2019 20:17:48 +0100
Message-Id: <20190305191805.13561-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
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
No changes since v7.

 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b68bca0bef..d605199a54 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2141,6 +2141,8 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
@@ -2154,7 +2156,10 @@ static int parse_insn_buffer(struct repository *r, char *buf,
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

