Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAB11F424
	for <e@80x24.org>; Thu, 10 May 2018 00:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965833AbeEJAlD (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:41:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36207 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935643AbeEJAko (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:44 -0400
Received: by mail-pg0-f68.google.com with SMTP id z70-v6so174143pgz.3
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QuGFuJ0XTEXfegPe/lBmVfP4RqRVeOk1DCr7U0s5yic=;
        b=CCCeGwG5ZGdXJwnylCPYyE8tRcRt75G80Jpp3zyseGZYWC8aWgSotflq7yW8I7SdeT
         9RqdVNjhuy0tnZiX6S9ATMvkRWDCsXDHXmq+wCnR14wQNpG6+TnCdWGQn7TYrj5wW0X8
         REalEkvLW0BSuNKsCRwc9y1MNfT5OKz61Ou5nBBTK9dcbeWpRDIWjZbjEgHv/ouI/BM2
         7nPq9Tz6h0dEjh5qtMB3ZPD5Kq/6N/BOqIEhOLbPHtaVKxunBrOW53Aw+fGN4waprvGX
         n1Yrc0jYpmRmtRjb+YscBKWfRLAI7vox3Nmtbo6Zgaa5WYky6Cf4P4N/DSfygdgzxqWi
         kobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QuGFuJ0XTEXfegPe/lBmVfP4RqRVeOk1DCr7U0s5yic=;
        b=mk92ifKQC/V6nWzJp2YOXZi3ajhy2F2ZmFj3mf4kzr7Is9jD5Y8fmFf9V24qhY/uWN
         0Ya5Dtw4eql3T5GsGFnVgdmXWGshnPlEy2IcRiMXJ0W/WguMvtcvztLhmmQ2FFg2xMDu
         vzjDjUYSASp294GWrbT7ZI/20ZyVUCquNfC+MzcFWWG/tCZiuPoeZM6tb3JgCNAm1joY
         XamyQjzYJfdSze1Vbj7ptaMqjHlQ6LQtxnifI0sW8sx5+qVs6omcxsBzpy3jR0dII1CT
         3x2N2urd8QyzIEoeVmlI/X8XKIdvNkbMo/W5uF+yxjE0JXrioxT3WLH65ftKA4EApJFo
         vkoQ==
X-Gm-Message-State: ALKqPwe6THkXe5gG4kBt44ZaIXgIz4TL0vx98R12Occj3Coe2hJ/jcxC
        LNsfYqO45/OtBWdlUw3MDJneGA==
X-Google-Smtp-Source: AB8JxZqSiISNb2kIMXGz21c1/XDcmAOTOzHmSxU8mh8x9uHpTtGywpcf0GYShgaOTZeGtj5LGFe0ww==
X-Received: by 2002:a63:5f95:: with SMTP id t143-v6mr3440854pgb.165.1525912843542;
        Wed, 09 May 2018 17:40:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 23sm97935819pfs.147.2018.05.09.17.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 09/13] alloc: add repository argument to alloc_report
Date:   Wed,  9 May 2018 17:40:20 -0700
Message-Id: <20180510004024.93974-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510004024.93974-1-sbeller@google.com>
References: <20180508193736.14883-1-sbeller@google.com>
 <20180510004024.93974-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small mechanical change; it doesn't change the
implementation to handle repositories other than the_repository yet.
Use a macro to catch callers passing a repository other than
the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 alloc.c | 2 +-
 cache.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index f031ce422d9..28b85b22144 100644
--- a/alloc.c
+++ b/alloc.c
@@ -105,7 +105,7 @@ static void report(const char *name, unsigned int count, size_t size)
 #define REPORT(name, type)	\
     report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
 
-void alloc_report(void)
+void alloc_report_the_repository(void)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
diff --git a/cache.h b/cache.h
index 2d60359a964..01cc207d218 100644
--- a/cache.h
+++ b/cache.h
@@ -1774,7 +1774,8 @@ extern void *alloc_commit_node_the_repository(void);
 extern void *alloc_tag_node_the_repository(void);
 #define alloc_object_node(r) alloc_object_node_##r()
 extern void *alloc_object_node_the_repository(void);
-extern void alloc_report(void);
+#define alloc_report(r) alloc_report_##r()
+extern void alloc_report_the_repository(void);
 extern unsigned int alloc_commit_index(void);
 
 /* pkt-line.c */
-- 
2.17.0.255.g8bfb7c0704

