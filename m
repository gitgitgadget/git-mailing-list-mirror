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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0F41F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392947AbfIYUNv (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:13:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732902AbfIYUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:13:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so132388wru.7
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcYwitYhFTlZOqLOXsigrZlJZar7IrCKMThEaxaGIb4=;
        b=Fz+q4IC6WHZX6p31yQyl0+eo3hc3724+BalNelIh2Ho48vdMxyRDviuCMUe14AP2K1
         N6FIEkKVbueDP7vW0wtTRT3AP+Y6DNwUDqkTHB0zjdKcrglOC1fgbvdgg3oRgyNm9Vkp
         6FzCAc9ktQx4lIqs7jm7rL4S8m8bjpfqQnrTysWzS1uBx1p55d7bBq5OaM0yu0N0yCS7
         Vou33u31mbY1JcAPyIOxQBi2xSb7Kxknfc7568kFEDo23VZGJ9b8gSlWxegVr9DI33IM
         w1BM2OzzSHGos43tmlsWBKRpfSU3u591jms2iRND0wUIMcKO3KHdTLu5wqnFpmYjOf4E
         b8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcYwitYhFTlZOqLOXsigrZlJZar7IrCKMThEaxaGIb4=;
        b=exYLmTMd/TecMNrJK0JDS6cGnIVpTgPEKxwcMm4fPgBkZFYqYIImJ4cT/xNW2JOJuX
         xwkMYuwGA2w1X3arUEkINma4HzSsOmLl9nFT+OxJNYhB5SzwKf5pQVFe5EJZLNprkBoP
         buYAr/BdabVRlJnYb+azqDhG7WmayqNBo94KQAwFFSr3u1v1MLrVvQOTZh5DKZaFa5Qr
         XkRmf5yE50MDZoiEJyK39pGjb0zgaTDUNw66xA7Uk8YaTFbwHw6EZu0AaCO1wlgKnk7w
         YQE2lfkUxXrUI4zP9+vwPg2vjAMXqU9q29cO5jeUkcMQntpKSp1FohfhUHyoFOQ1bo4m
         6Gnw==
X-Gm-Message-State: APjAAAXmjVVsniXM3n9lE+4kKBT3SvdXzo/tHiTmk0KMoXq27W86iPIk
        CPot3nv0Xm3TwxQkOrJiVGF0oEvj
X-Google-Smtp-Source: APXvYqwD1Xr11Oqi8UVSlvfZpHfFlmsImJ4SxlQMFMpFTTdZpdZriKKtJXlp7GsSZk8500Wi8dAMug==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr105685wrr.334.1569442429205;
        Wed, 25 Sep 2019 13:13:49 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-81-250.w90-5.abo.wanadoo.fr. [90.5.214.250])
        by smtp.googlemail.com with ESMTPSA id d193sm138022wmd.0.2019.09.25.13.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:13:48 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 1/5] sequencer: update `total_nr' when adding an item to a todo list
Date:   Wed, 25 Sep 2019 22:13:11 +0200
Message-Id: <20190925201315.19722-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`total_nr' is the total amount of items, done and toto, that are in a
todo list.  But unlike `nr', it was not updated when an item was
appended to the list.

This variable is mostly used by command prompts (ie. git-prompt.sh and
the like).

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index d648aaf416..575b852a5a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_list)
 static struct todo_item *append_new_todo(struct todo_list *todo_list)
 {
 	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
+	todo_list->total_nr++;
 	return todo_list->items + todo_list->nr++;
 }
 
-- 
2.23.0

