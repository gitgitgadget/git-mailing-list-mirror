Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBCE1FD09
	for <e@80x24.org>; Sun, 28 May 2017 17:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdE1RM0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 13:12:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33996 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdE1RMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 13:12:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so12370846wmf.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uVhrEqkDt+st3HyEBhcVi5OZhtr/Rzt4svTQAXZcYZo=;
        b=foJieO8StXJlR3d9WT5KvxmEvu63Ms6AIw9MMHBxB/9+rY0b6/DWBYwU/oNSkyYNrM
         VgoOT9mHa3lcU9oBX3ZmMoueiuB/nfxuqC2UPFMgrI9mJvb7hXveJZpUamVTGGZMcogu
         RzK7cwy2IiwNEXMCf7vqGm2RcurYtUOZigDR72D+WPaLdNVDlxB7q4LreIYYYFLNtrNq
         +VFAUZsNSh6uircAHrZy173HXK0qC5lrcE2HntycAseBqQ9Ow8RM7SyaLgbXVVJihNCm
         tZQz4Ot/WXDFI4al4lPDtBBD//bNV1wFekqbzwsj4qIrol2OOCfaPoVgHrLQfxngQjIT
         pCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uVhrEqkDt+st3HyEBhcVi5OZhtr/Rzt4svTQAXZcYZo=;
        b=bYnVIt0PvZdOlkNFTFs11L7M5Za5M0V5FDZD/JtncIY4OZY627P1kLlwAtrxt10eRK
         sOvCkI35YZFf/7+PUOqZlK9kW51/acXUOQ2ur+f5UUf/E3cvL2tAUqIObn5PF2KcWc8W
         itKu05Sd+addk5v2ESaOVMQVw/pdEY6DPnHDuvknlAl6n6gK+rGpzTpiu6E+YTNzhqRK
         DGrt0HL2c8X3e4USGnGfRmYZA6F5A+yTd2wx27HP1ieR4PZ3z9gyiPVWse7JqI39s4fg
         HOo2Ex7ZoR6QF3uYtdAc3kmfvwoGNXyh1kewVV+Tcekd5Px2HCog+SNLVqRgStQdVnAM
         2hug==
X-Gm-Message-State: AODbwcDOc9sY9Q8qIEZ9TWc8c1I5vc1Il1EH9958AT0ZMQnaKq/ArDsq
        V2l6lPwupHi9G44d
X-Received: by 10.80.152.194 with SMTP id j60mr9675988edb.98.1495991544152;
        Sun, 28 May 2017 10:12:24 -0700 (PDT)
Received: from localhost.localdomain (ip-213-127-29-57.ip.prioritytelecom.net. [213.127.29.57])
        by smtp.gmail.com with ESMTPSA id t57sm4811324edb.28.2017.05.28.10.12.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 10:12:23 -0700 (PDT)
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Cc:     Sahil Dua <sahildua2305@gmail.com>, avarab@gmail.com
Subject: [PATCH] branch test: fix invalid config key access
Date:   Sun, 28 May 2017 19:12:16 +0200
Message-Id: <1495991536-71204-1-git-send-email-sahildua2305@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes the test by changing "branch.s/s/dummy" to "branch.s/s.dummy" which is
the right way of accessing config key "branch.s/s.dummy". Purpose of
this test is to confirm that this key doesn't exist after the branch
"s/s" has been renamed to "s".

Earlier it was trying to access invalid config key and hence was getting
an error. However, this wasn't caught because we were expecting the
command to fail for other reason as mentioned above.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fe62e7c..10f8f02 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -338,7 +338,7 @@ test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
 
 test_expect_success 'config information was renamed, too' '
 	test $(git config branch.s.dummy) = Hello &&
-	test_must_fail git config branch.s/s/dummy
+	test_must_fail git config branch.s/s.dummy
 '
 
 test_expect_success 'deleting a symref' '
-- 
2.7.4 (Apple Git-66)

