Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644291F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 09:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfJGJ1D (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 05:27:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41245 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGJ1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 05:27:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id q9so14352323wrm.8
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 02:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1lssAzVcjOIZYcG9Rqnrhi4wYG8jrz4Ugyueneq7B8=;
        b=sLxqcTdMH4sfrw6eJULleV0HWu92zzXBH0ue0EaIypoNRzFYz7Zoo4kbaeLJ8j39UN
         isL1y1r5Xit4UXRpK+2MKdSqR9lqL0WGhQYzBSLIypKg1WWiPK8Q+JNKJOk/EyO3pFtq
         GISv8OPY7fKnRpiSswY7Dte9KyfOs+FV8/dlgzzBOgBU7fmg6tCaUArd7gJY7GUCE2my
         DOtBtpevGkoWQnGp0C3RsbzVvdrK011lHcQ/vZ9Wh3J8K/VyymQMGWDO3NS2beB9yLgv
         j9mNSBfdsDBrR7Ha0rPJ9CroRX57De5WIo9aXo+iXSjHihPJg8z/E082ytL+azKp45O0
         rG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1lssAzVcjOIZYcG9Rqnrhi4wYG8jrz4Ugyueneq7B8=;
        b=kGeZIndkNJ+k58tKnD54XVJulrto/P4BdOWkmnNN0MdRlN5lm0VlGywD4dAKLviu1r
         9aTiesaRIMWreu7DVDk4uEZXyTOXA0PMNP6EU79FOq0BmVgkYXM0haSM8+gK1OuzvK1h
         VyL/bBsCvvznOTIxxrKRTcQC2n6buyIVIXP8QgTCs6ktyajWPSGZGFTTMxXZcoYarSL5
         pLrsz0R1DN9WD0UmUXFlfFRT2ZYxEEjx96OrS1JQcfVLcC4ZvK8dW3Xdz6FuwmQudUZA
         Dxoms/caBd0K75jD5RNC/a9oydTGLJ+UXl25GW85micuXN7kVbgIfzZZn2zpRwvwWq8Y
         lLFA==
X-Gm-Message-State: APjAAAUdCi0+uLtYYl1owgSzyMZMyHwqzhm2qWYeXSGdh7ZC4yq8mVm/
        eyi0lwJU5/e0j7mkN9gx7nbzKi/o
X-Google-Smtp-Source: APXvYqyaAj/ZWCL0tem+QhexCMWdl1b3xgaiSvfgszITOiIKTIhBNKtjD9i6GU/fjxYf+mxzqWDLlw==
X-Received: by 2002:a5d:428d:: with SMTP id k13mr21613903wrq.305.1570440419606;
        Mon, 07 Oct 2019 02:26:59 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.googlemail.com with ESMTPSA id w125sm25250914wmg.32.2019.10.07.02.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:26:59 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 2/5] sequencer: update `done_nr' when skipping commands in a todo list
Date:   Mon,  7 Oct 2019 11:26:38 +0200
Message-Id: <20191007092641.12661-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20191007092641.12661-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a todo list, `done_nr' is the amount of commands that were executed
or skipped, but skip_unnecessary_picks() did not update it.

This variable is mostly used by command prompts (ie. git-prompt.sh and
the like).  As in the previous commit, this inconsistent behaviour is
not a problem yet, but it would start to matter at the end of this
series the same reason.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Reworded commit.

sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index 575b852a5a..42313f8de6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5054,6 +5054,7 @@ static int skip_unnecessary_picks(struct repository *r,
 		MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
 		todo_list->nr -= i;
 		todo_list->current = 0;
+		todo_list->done_nr += i;
 
 		if (is_fixup(peek_command(todo_list, 0)))
 			record_in_rewritten(base_oid, peek_command(todo_list, 0));
-- 
2.23.0

