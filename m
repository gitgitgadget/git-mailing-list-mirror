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
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9841F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfGQOmB (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:42:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36306 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfGQOmA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:42:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so25167344wrs.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sr8TIFH8S4UqiZBovoK4G12GCMc+iWn85+nmFOqx1Ys=;
        b=VqxBi0M6taQ/yDF3U+kWRZ2ry2KR5OGoMDYP1dy5isjUrMnbL/nEtK4S9QFNYy0Acw
         JRbmZbYJ5Np+46bxwWy5xZKx+XThuHgbOH9WYcaZ+BADhwAo554CNJW50DerfVXK37BE
         tIceafqyOv2EURyvOaeehcXFT0bJbAdlQxsg9ZhSUByfJHD9Rf5cOduynpzrXoktjF9R
         xSLCnYFYa23eTT6dXdG+kbnkWQp9Iss2jO1Dfo/6pp5gRkKd5ZtmlJc/JBzNfNlVpJvO
         SAU9+6c9YnTHOyZ4snRkk+PaxBJM1mylYlhUwrXFOCgk/BXQ4S9KXV/XaTGlFgRtrCO8
         A7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sr8TIFH8S4UqiZBovoK4G12GCMc+iWn85+nmFOqx1Ys=;
        b=WqfglYGoR3iYkhnqMHrHooAlAF3vSJB8e+3EUhoqxMu3hJ4lhh+TPQ7HPmuSMoS04T
         7it7SiH4SMB0BBM+JFGDmPUjKBvV6iKBsTvDayVKtr/mO22FyCPYG99SublYYqRmtFQP
         HD61jIAMY/LxS56q9dlxbA+/NjYiz6/J9TGynUBmHd7tzW3xdljzeYFl0x8nKhhyJrKf
         AfLe0ruQiuU2/ZcjBRq8t+RSzxMWK9jJ066r5a9zJNxPaywbmhCQrtAXMW0aYBcIIXOS
         AcaJhPu/5hmGnZ9sQ0J54ciPv22BLH94tyu6EMxX81NdHEUGGmtiIy3dQYsIOemAXd7H
         OHVw==
X-Gm-Message-State: APjAAAUFpqqq8v9rn33V2GcymGJjrHK8gg2cH0wsqaA9DhWui9vEPmwB
        7hBZOzUm6DeQ0oL5ayr6rtdOaM/i
X-Google-Smtp-Source: APXvYqzy+M/vePVxlfyFGTZPypTKqqx0ukqjsodL41nGMj/zB72C3ST5BSwBvhPBQuroKun6iqFfTg==
X-Received: by 2002:adf:f6d2:: with SMTP id y18mr42711838wrp.102.1563374518567;
        Wed, 17 Jul 2019 07:41:58 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:41:58 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 4/9] sequencer: update `done_nr' when skipping commands in a todo list
Date:   Wed, 17 Jul 2019 16:39:13 +0200
Message-Id: <20190717143918.7406-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a todo list, `done_nr' is the amount of commands that were executed
or skipped, but skip_unnecessary_picks() did not update it.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index e61ae75451..ec9c3d4dc5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4939,6 +4939,7 @@ static int skip_unnecessary_picks(struct repository *r,
 		MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
 		todo_list->nr -= i;
 		todo_list->current = 0;
+		todo_list->done_nr += i;
 
 		if (is_fixup(peek_command(todo_list, 0)))
 			record_in_rewritten(base_oid, peek_command(todo_list, 0));
-- 
2.22.0

