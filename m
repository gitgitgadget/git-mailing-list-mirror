Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AF11F406
	for <e@80x24.org>; Wed, 16 May 2018 22:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEPWVq (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:46 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:39883 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeEPWVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:43 -0400
Received: by mail-pl0-f43.google.com with SMTP id c19-v6so1236742pls.6
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axK9Ny1LhsFNSWDBVOHul3B1pwUQ9S4NVAd3EXycuBc=;
        b=gMRb/lUT1bZ+jejZYUamig+Z9PLFpqlPKuw5YpF15IRXQKCp9EiZTgvWgPRKxVI1jO
         1/1vhEXDPGhEhoYzneQvS6xL4NCwLVyQCSG8qMaVPqlXsa4u00MqpbHKO+V6m5ryQEok
         m8g9EGWF0IW0O2PKxRB5bfeQLfhU6c8eS5GPiLnCKV27Xn+84vAcdoxTL2j4n+ir9yDZ
         h2oO4XytJOmf8ZDTQK6pUx6liRX0Hey4i/jviSicukI8EUUjkZVPw1+3C5DJQae5v/8R
         isukx5suj+rKrCwCb9CS0W+G+xqpiFQqP+gsEjX0rtfdNUQxarLaOHdmGBw1vqaIT4LQ
         DbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=axK9Ny1LhsFNSWDBVOHul3B1pwUQ9S4NVAd3EXycuBc=;
        b=tv00tI/uDdQQw3aJ3U1cySe6Yd78jNrhHjJ6qAwq5xYiB9bFiWHcXHTkb11214YiU+
         ZEDcXdCJibnHkuh7IayDlr5DDNgcN66RZkSjn+BWU3WmOKeZzlBIUBV+cg4IEnGsgF0s
         KgwA+H8i9mQHOcMfszbJnE6RbPux61VZ3TAJifCoWnpVuRwZe5tLmacJrLYMr7UnnwyT
         DfXxZMuTWuJJUOWPDW/HgEYlZ7ju4byrWfK7H64QT4T4UCw9hC+hT/vZ8mxvruAs+sID
         5JGq4uJewNtKgcRI21Drb6+XtUbNEQSI/mmpBchIhUMyYK0kXlMUh6A9GhFhQqdfykJm
         o8QA==
X-Gm-Message-State: ALKqPwfmGNrQF1vu3avRzo7LSmGGa/NYn9u9opVw+z9RxLcgVqZVadoc
        UPixrUmmiPntlrGxniPYiPqgfg==
X-Google-Smtp-Source: AB8JxZp1wUmYt7UQtfEwWorc2Idf84EJMRSmpuDOZdWa32vL4qQIQgoSCDWWrYVqGf4C3ajQua7mRA==
X-Received: by 2002:a17:902:321:: with SMTP id 30-v6mr2716588pld.122.1526509302455;
        Wed, 16 May 2018 15:21:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id c83-v6sm6523745pfc.111.2018.05.16.15.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 08/11] check-attr: switch to repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:15 -0700
Message-Id: <20180516222118.233868-9-sbeller@google.com>
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
 builtin/check-attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 91444dc0448..bf05e7e93ca 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -4,6 +4,7 @@
 #include "attr.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "repository.h"
 
 static int all_attrs;
 static int cached_attrs;
@@ -115,9 +116,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
-	if (read_cache() < 0) {
-		die("invalid cache");
-	}
+	repo_read_index_or_die(the_repository);
 
 	if (cached_attrs)
 		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
-- 
2.17.0.582.gccdcbd54c44.dirty

