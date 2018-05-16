Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA321F406
	for <e@80x24.org>; Wed, 16 May 2018 22:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEPWVr (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:47 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36736 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeEPWVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:44 -0400
Received: by mail-pf0-f173.google.com with SMTP id w129-v6so1047029pfd.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rLQi2TkVaCeacRv9V9RnVe0Mk/CDWCAgeJB5fs+94PQ=;
        b=VTj81T9epvvVlCqbwVXXNpiNeaGJfYoJKSYM/McNxt6c6HP/Y5hlMqvveTGI/RXMp0
         jYe4vaQn/tco0PD65uSqOt6yRX7r1PAq5UKxIk0FJxbLHklSr63rCqUX2PBTKBatKfSl
         4rogfZDHS3c+P7NmBVAxVZN3PGRab/cGNvRhNO53C8IxzyM+1a1QMwlTvcZA1xzeLZAG
         gjjANBlfU44h+NC4u+3UmNRwo71yElmv1MEiq8HUwMx6EtFq4EviR5czJhxwQE/fq8A9
         KXStEkZiw7dvgiEEh9qXmNv6AQfnav93ImM7vqi+QSqJS0jaAEvL6bVUvYSYMa1hRUva
         2Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rLQi2TkVaCeacRv9V9RnVe0Mk/CDWCAgeJB5fs+94PQ=;
        b=HeqNxYitmTnyELD4djbYQqqH+ZtdFvtjZ/oBKJEv23ffHfXbap8O3Bj95YPUHjd5MN
         0PXL4yYelqJFiomSEV0fQdnnvDDhWThNmBM43Q5JquI9U0PCUPy2UM/r90EDQt7gwsY4
         FglT0+PnkdjZVIb3gOb6ofBRwjph/qFbM/nWYvyYviwd1O2f5qMovSxhErMWkcBY1MzS
         jD0ZeAdpWJaZX1RkxkdzrCM3ig2Axn/rWQ3h3zFQnvQIRAB1xdSo54EivFI+YusyLWiR
         KQ2m0HY+C82wFKu21/NyxWk8HclY01nCfInmIVMXvM6UR+woqczDnG7hf46okD6+I/uF
         0mpA==
X-Gm-Message-State: ALKqPwf0IDF+CyaGlAO5W3PvG2Ul5WWoSvl3aQc/1S/MRjqZciXhmifH
        CePyQhyUBP/9AdKytusj15bClQ==
X-Google-Smtp-Source: AB8JxZo1yGopJLgWUjP5IxSQXePJBkiQ9mIN4VmzmUuIKa+WsZsIS+89ENd5vqWljAwcNnVX0mM5MA==
X-Received: by 2002:a63:7c04:: with SMTP id x4-v6mr2103977pgc.67.1526509303728;
        Wed, 16 May 2018 15:21:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m22-v6sm5798625pfg.20.2018.05.16.15.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 09/11] checkout-index: switch to repo_read_index
Date:   Wed, 16 May 2018 15:21:16 -0700
Message-Id: <20180516222118.233868-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout-index.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a730f6a1aa4..aaba99d36c0 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "cache-tree.h"
 #include "parse-options.h"
+#include "repository.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
@@ -184,9 +185,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
-	if (read_cache() < 0) {
-		die("invalid cache");
-	}
+	repo_read_index_or_die(the_repository);
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
-- 
2.17.0.582.gccdcbd54c44.dirty

