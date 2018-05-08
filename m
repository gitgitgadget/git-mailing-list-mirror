Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47038200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755569AbeEHTh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:37:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33145 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755519AbeEHTh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id w12-v6so2816915plp.0
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QuGFuJ0XTEXfegPe/lBmVfP4RqRVeOk1DCr7U0s5yic=;
        b=hWd5jILf5ld3CEIOgRdNoXF5otbj3KH/auJBXCw43UZEI/oTtb6zJcVBUh7UxrcRzD
         yze9cD58LzxJAQLzLwoJtbwoDooHwC/sw5wpb5VeFurUH78C2VwYzv8AoDR0OUBj3BWk
         Ai3pTrFnTiDuGIXHyLAEkvSzU9eBxpigJTm94wieaClwyj2VP0HW26KVxjca9NwgJvYc
         S6ft6cDphWr48+aXLV8SZUa7X3sZDjoWwx9l5tUvJH/BkYsxlUSjNrzLtTJQuv6/McmO
         XbqPadEKh2HzBtBUM6oAtYwScpHSDlN+fRLfBl7lE/8oPNa861NBdf3bMaHR5hU4hCJV
         sP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QuGFuJ0XTEXfegPe/lBmVfP4RqRVeOk1DCr7U0s5yic=;
        b=aejvIA6bHO4gYz6bjDYomwizRP18hSbfGE/KjvcdZTV0H3dj2jVxvelPNAgEBpiukp
         +XjBsPbEhYTBT7LgXqJvaW0ixpvicAlemHSjUVFMXEBX9F1EddrpYDa/zjsXfrP9ezlm
         ReWsWRBuZAiSZHuQLzBAWfsBTkFNmWRsRDiztc6BuZSj5sN8yxzQuoawR31m6rqJvhxF
         spYGse38m6K1/+CeNkIIYx64IAeXvQjAyg0Aj9sIGY8PyRauo3rWQVQf690LqDVaPEeh
         5VMZaejpr0C1lSaPQl/0WJSjJh52oiNVijcNfWWOuLJ7GsiwccFvdLV48dPLi5lCl/tz
         uWYA==
X-Gm-Message-State: ALQs6tDszCRCXkRHCxc2Wu+9YsCgJlF7QeBzsN6E6BJUQDUpjVqB5f4O
        QKTQRyAD8mqK66Fim7xOqALlOA==
X-Google-Smtp-Source: AB8JxZovty6DQytgMQMAD489PnHgGUesHzaJHlxkiiaUtYaTXwj1QRkIdE9aParMwog1S6E9qhTj2g==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3-v6mr43413431plb.317.1525808276147;
        Tue, 08 May 2018 12:37:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v186sm44641611pfb.45.2018.05.08.12.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 09/13] alloc: add repository argument to alloc_report
Date:   Tue,  8 May 2018 12:37:32 -0700
Message-Id: <20180508193736.14883-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180508193736.14883-1-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
 <20180508193736.14883-1-sbeller@google.com>
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

