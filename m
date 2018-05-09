Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1FC31F424
	for <e@80x24.org>; Wed,  9 May 2018 20:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965367AbeEIU4Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 16:56:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52073 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935200AbeEIU4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 16:56:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4-v6so690568wme.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZu/jm03aE65GyX3GXAM+Kxl3hCFbsl7ClxeLGiJkNY=;
        b=BPmISkRM263CGzet29ybcOz7lU1Y2AZvOuQABvfkDEPi41kgQ+BoJqOAIxf2dmzS2T
         UV62MVgh0kdHcIThPAgEve9A99Mgrg4V9lsQOmpnZ3Mvip+RgBNnFRvNuY6VzXXRh0Zo
         Mtvg0mRWyBMj6EtcG2Vv00emT7Drb9mCP/6zsq+q0smG5ftrMCxLsq/vCgcojS6KH/pT
         hquB1hy8hCQ17VR+V83dYij/F8ths7LqTLyc1nT6+5FDUsAopjRIa54Us2BOMa4AGvwV
         esR5GucSvQIdkNi0JvNrVNY2k6XVhuD2V9fARfSmmCCFC2fIlEp+0jeSlzp9iimqqhBz
         kRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZu/jm03aE65GyX3GXAM+Kxl3hCFbsl7ClxeLGiJkNY=;
        b=j/37d+IfXd/zXYbnGMfol66WcsNaW9ep9sA5jO9cerwaIF5dv6AWRLJGXlMeyIGhWB
         ZlsDewtoGUNrBRAoDmKYAmVpOZeHQogOTe8wS5EX5F6WM0LkcXn03+Yu5//rxZeXPVsF
         H+nttreULucjWyigzB3eTh9PdsyR8bOJmTMqxj40NgPi6TqGE/ivMu0u2QAaHhn5WeXh
         4JKmNePg6mpOyeELX4oI6TCOXDh/xkNKX8rs6uFMVLUXuMqaQ0g1V5VakEHbkTwlIzl2
         g0ZzpGMc+JY/Od5P06u5etAXn+TL5ILCqWUnBsZdLG16SMecPH3JallrWQqOgch3U7mJ
         vNwQ==
X-Gm-Message-State: ALKqPwfkXy+TNl8h3V6bjCjQnFUNp2OsoLMZWk14nnpe7IeR44KUA0F8
        hGRkBAkQKqJOaBVHqwJzx1M=
X-Google-Smtp-Source: AB8JxZqhfVvXOpzxCHOCY+RBIbS8YyrvOHjNCGf7gI5EZuAfThdNnDYyiEVXqIdnQKsnab6G4jxOnw==
X-Received: by 10.28.136.149 with SMTP id k143mr7433673wmd.17.1525899381416;
        Wed, 09 May 2018 13:56:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id r14-v6sm40073008wra.41.2018.05.09.13.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 May 2018 13:56:20 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/5] t/helper/test-write-cache: clean up lock-handling
Date:   Wed,  9 May 2018 22:55:35 +0200
Message-Id: <2832937c476ed4c53d934274caee3ec6c8c384dc.1525898125.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
In-Reply-To: <cover.1525898125.git.martin.agren@gmail.com>
References: <20180508182548.GD7210@sigill.intra.peff.net> <cover.1525898125.git.martin.agren@gmail.com>
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
`struct lock_file` into the function and drop the staticness. (Placing
`struct lock_file`s on the stack used to be a bad idea, because the
temp- and lockfile-machinery would keep a pointer into the struct. But
after 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05),
we can safely have lockfiles on the stack.)

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

