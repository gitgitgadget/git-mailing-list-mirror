Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C5A200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeEFOLD (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:11:03 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46249 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeEFOLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:11:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id o2-v6so22458501wrj.13
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Hx6SGLSVuOegVQapi9JKuP7i/eCM+RLtyThETpE6gc=;
        b=CXXYMAI96cpfjB1u5BWaERDuNlBbeuiAx975GW1Pr66j8ODZSP6I6I0G/njvg9/sB6
         9iRVcH7/sxUQL+yruU2kjDyLi/YrLS6cslvjV0XecZ0XoJDlwilhQA1iOdPlo/xWZG5X
         k4Cehy3hgu6/K5ZrPFt+ISuc+rOBAkzFESXnm7n8s7W10rVpwULX4R5d3bpab662mirV
         IvO9j6dCbHNWDA4pQf4wmZh5aHPu2htxu43tAxPsvoZuJvw7d4Ca+zTLW4H89wuWJdhv
         N8fy6c9ipYp96ix8GC+KshOVJjB+vkombiRQCZrqGjXb3hQf3rs7VQHdIBKq//n+chlw
         502w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Hx6SGLSVuOegVQapi9JKuP7i/eCM+RLtyThETpE6gc=;
        b=o4mfQfaJAHH+lXtrjtxbD16MbkivJ5+u4YfhucWP6WqRJjoO/OgROj/RfP/voffaWJ
         eFNT2XBkMWjM/idRsnx8O2u+ZmS9rM/s7OXoKJI+E+j9EVaXMEQnM6Jna3YxeEqNgOsU
         opDm+baYbeNdNC9lTtFmWwQ9KAl13qU6I8ukdDPPwvU2o9jEwHz51vEBJF5T3Jx7R0bh
         BMCzu1cwIXyjjc0P3Xjkp2/bGrSon9kELjhAXmUrnZxQAxFbzlBIqndE88J4rH+eKxcT
         Q5NNGYeLUSJIsQnEkmg000ettwT+a5GsPf1KPdmu4gNNvo9/GXdMSBdWhykd7T+ziJrO
         yaFw==
X-Gm-Message-State: ALQs6tDdJ78hbpi1qq6aKpBXbVd6nNLFZ6+heF56AQIoBV3XJMBKeNlD
        KPL6IrYGLXoKQT6UJdFHLjBgbmsL
X-Google-Smtp-Source: AB8JxZo7fjuLK6bz4Fmg3pXNjwN2BPrCwCNHdnL0EwUJBlo07+em/akUM2TqKONAGQ4FcyI3Hj5ZtA==
X-Received: by 2002:adf:8b85:: with SMTP id o5-v6mr20250997wra.169.1525615860631;
        Sun, 06 May 2018 07:11:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p17sm4914857wmc.17.2018.05.06.07.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 07:10:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 1/5] t/helper/test-write-cache: clean up lock-handling
Date:   Sun,  6 May 2018 16:10:27 +0200
Message-Id: <20180506141031.30204-2-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Die in case writing the index fails, so that the caller can notice
(instead of, say, being impressed by how performant the writing is).

While at it, note that after opening a lock with `LOCK_DIE_ON_ERROR`, we
do not need to worry about whether we succeeded. Also, we can move the
`struct lock_file` into the function and drop the staticness.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/helper/test-write-cache.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index 017dc30380..8837717d36 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -2,22 +2,18 @@
 #include "cache.h"
 #include "lockfile.h"
 
-static struct lock_file index_lock;
-
 int cmd__write_cache(int argc, const char **argv)
 {
-	int i, cnt = 1, lockfd;
+	struct lock_file index_lock = LOCK_INIT;
+	int i, cnt = 1;
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
 	read_cache();
 	for (i = 0; i < cnt; i++) {
-		lockfd = hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-		if (0 <= lockfd) {
-			write_locked_index(&the_index, &index_lock, COMMIT_LOCK);
-		} else {
-			rollback_lock_file(&index_lock);
-		}
+		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
+			die("unable to write index file");
 	}
 
 	return 0;
-- 
2.17.0.411.g9fd64c8e46

