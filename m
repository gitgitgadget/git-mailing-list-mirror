Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545711F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJ1GMN (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53790 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbeJ1GMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id l26-v6so4576168wmh.3
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/ssTr4aLgYbH7jRP5liAXvKE89eNqNceAM1hSSFoEw=;
        b=DpSyRQpKtIxCW1SIcfMx+Xe+69UK/V2cCWf2AJGQFzrNM0WIMmyhYyKjP2rc7YX6Th
         eR5fgUMI+d5M+6VK/PHwD6tgDY4M3h7SjLoNZm//KBNCB+ypd8gVf4G5HeC4sVO5F2RZ
         AuUtpMUDMltbkM/rCeDfotioEqGBQzb9I2yjR6VkK0Dk4gysNhqx1D7L8ndi64BItC9/
         w2qRe4BWToNimmKRR72A1G5MueeaksD/qn73xPGSPUSKxBoxSoELniJI9skdbLtfU8nL
         jE5+X6BWrux48XlYP2/Sle2NduNoPdTqxt9h/YSj4VXeFEQGYvuKxMsAlD9+d8tnBlom
         86NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/ssTr4aLgYbH7jRP5liAXvKE89eNqNceAM1hSSFoEw=;
        b=athW/VRx6KMNufSxagwy3S4Bih+d9xl2bYCwmcsrWhjhV1RYeqKFbkoLpkeL9S2aHy
         /59fE6GgDp//eN6Xgs3VIgj4z5zk2YXCx4jEdosGxqdgjm6SXuSPqql9cREB1u18vLtq
         NK1hBGj4nFVQM8C9sr4YuWD5zyGWZc00YN6/yiTWsgNIW72ib9caII9tHpYasLJchc4Y
         g9QJNyREbWV/c7QwwiWsfXP1ESG7zwgDT8PIXly2052MGVc2taFl9N1CRGSDP9F7qGqR
         3mLJ+ISfE3F8/6OnZJts5wuIOqvowZrVlZRktg/QbAuVP5SVyOazXBLDv2+wKyreOlJQ
         WIcQ==
X-Gm-Message-State: AGRZ1gJDZ82w+yziruoAnI8XgFwX1GWwQd7XQeuGU5NumKKXc8apZthv
        TtK5dA+xUmPDMElCOaewey06PYOf
X-Google-Smtp-Source: AJdET5c4HCwLIks0e0liAvyUQAxyxLeB7UWZRlgK4tmSg79Q8gVcxS+9CRaeBEiXjMntnBRgp3QiXA==
X-Received: by 2002:a1c:5a86:: with SMTP id o128-v6mr9094715wmb.138.1540675791866;
        Sat, 27 Oct 2018 14:29:51 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:29:51 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 01/16] sequencer: changes in parse_insn_buffer()
Date:   Sat, 27 Oct 2018 23:29:15 +0200
Message-Id: <20181027212930.9303-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
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
index 8dd6db5a01..9c8bd3f632 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2023,6 +2023,8 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
@@ -2036,7 +2038,10 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		if (parse_insn_line(item, p, eol)) {
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
2.19.1

