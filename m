Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4AB1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfGQOl7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:41:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45280 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfGQOl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:41:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so25087128wre.12
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYY/tozECmNEaY4vtGtG3KGzMn49VSt0IcZC55WD/Qo=;
        b=iT9rvt310Vyo65N6A8xNuVTF+5nbLGM+UcVTV/JAFUgE+FwRRhnvtakH821EmxhnJb
         wQaRw61TygpvQ0y0ZpwPeZ7i+43dHUwtTbnuA3ghk/ZFsXI2n1DvZzejsOh1/TN09NvU
         r6Y3mX+ULUjNNLIBOqwtLaiW7CLjPHbLOA9Vpy+5WgVT11hvsas30inWimDbjiMsY4Gy
         rRDqMMj9H0QAIbmXuJ2pDxoaQx6VrzZjFcVjtlp6oVqy0rlbRQte++9RtTlK9mSjkotE
         6iK1ELOcaK1zIvQKIgZhkzOVLNEOLfcyUQdzyrZqZoQrz7SAKqts372r13IqKz7z7JEz
         sfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYY/tozECmNEaY4vtGtG3KGzMn49VSt0IcZC55WD/Qo=;
        b=RjWysX2QcjGT4x4L16v/eVzEB6xgg3u7U/Qhu++5K1ipujnlq0Y5fSmJA1ZiMfUV3G
         BuvnoAB7eusye3Po/X+Wsz/WvipJYHbCwJnPilSZ9HgzXga57WOSbLcayfLtYZUL4JpE
         4zmh+i1ny1P7GpRCLNUS1kdIcdofTAqOgltRHHG0B5JsqPtkM8nMmUKQ+AuNxdNcXf0S
         81yAQEQVxESqv754A+4zo1yiduBUh2CT26Ahmcf45EyxEAQFHr6HqaebhOcHJsoHfK02
         EItQGWV3BrAolDOYH6x5iUE7K8ZzghP4e+1uv3++xa3VOjijNusd+wsyxD6hVGEDeV8g
         YtXQ==
X-Gm-Message-State: APjAAAVu5aBmTziw+MTFlVIurDeiM3fJHRdUukjU/T+iywX27gpvLnEP
        P8Bo8abdIDAVrIkHMOoFMx6yF9MM
X-Google-Smtp-Source: APXvYqyQrCdX6KyevOICVw8r0InsDUg4iBAzXO/KjX4S8izwr9pZQPO0y5tpdOGqJqWDGP2pVfuMLw==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr42798002wrv.247.1563374516916;
        Wed, 17 Jul 2019 07:41:56 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:41:56 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 3/9] sequencer: update `total_nr' when adding an item to a todo list
Date:   Wed, 17 Jul 2019 16:39:12 +0200
Message-Id: <20190717143918.7406-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`total_nr' is the total amount of items, done and toto, that are in a
todo list.  But unlike `nr', it was not updated when an item was
appended to the list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index cf262701e8..e61ae75451 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_list)
 static struct todo_item *append_new_todo(struct todo_list *todo_list)
 {
 	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
+	++todo_list->total_nr;
 	return todo_list->items + todo_list->nr++;
 }
 
-- 
2.22.0

