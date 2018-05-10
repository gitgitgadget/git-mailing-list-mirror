Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0DC81F424
	for <e@80x24.org>; Thu, 10 May 2018 00:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965161AbeEJAkp (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37009 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935622AbeEJAkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id e9-v6so196276pfi.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kuJG+7BR482bR6X+M37w/TU1jfvmm+kifwazfRmPZ7I=;
        b=b1Q7BULdOuStUusXfTSL4LuWHAmXA1hN1YqvE5u8UJU1Xn4X4XUQcjy3adC+tPhX0R
         cpE4yYEy26DoYLihrXDAt0EAbLv3fKLoOO07Zv+dMk9XYaViaKKAAuu7g/sCUJbXEBvg
         WmJWO4bB6VW3f9OwqvYse6dIaZ7v6tPbFnJyI8dD+Z31ntgAz8YLtv3SQjMPJD7P1q7t
         uASabi2+vFT9+Dy7rFgtDziBgfnqDbHmX2A5CX4AJJxFUGtf/1jmdZwUho2LKvUwW9Du
         jQjnyiSnMhni9HVnGdEOXTzzePeRxLf2uVPqTtF/RNmZAs2h3P3HBK/ADuXxJO49Gqr0
         MLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuJG+7BR482bR6X+M37w/TU1jfvmm+kifwazfRmPZ7I=;
        b=ROPH2tf11p/tUdUdRmEJt9/caEq0WAaLEeGgXRLLzJrnT6UKcVuPXMbtz2sotmp8SO
         xBEffEGht7tlE7mJsfQdCEedtWcQZ0tgsEustes88g7p0+wvXnrPi6K6hiFIrPMK6JMJ
         pqtnwg8mIkKBaJky0bPGBVadERJpjaRU+4f6LtC7YIwGArXrLtGxq0e135wAkEfpH5GQ
         UZoTIGhAvWFYUzcDZcbGP7hBXc4aXz72cUFgPe8rjrf/dwb2JCd0+PfYIURdG7sgZMl4
         TJHO7SO221Ri5olgjbRTIFr39IWpxk4KXI7EET2ZRp91/IpOzDaGehrl9ZRCEYTdHzNP
         gEgA==
X-Gm-Message-State: ALQs6tCxUwhsEb623cWPnE20DWDbfDDmsIKCqcyHBjopM7S/WN5rrQsd
        rrx4IFNjt7I56XdhYzjlaK+VAw==
X-Google-Smtp-Source: AB8JxZrbMQWb9HnZqnS1893pXUURuCFYk2mtC0r6VRNMbjVwetvGA8Zu02v+i6WyVmWnJEfIbl1YYg==
X-Received: by 2002:a63:8dc1:: with SMTP id z184-v6mr37314353pgd.114.1525912842286;
        Wed, 09 May 2018 17:40:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f29sm57831745pff.169.2018.05.09.17.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 08/13] alloc: add repository argument to alloc_object_node
Date:   Wed,  9 May 2018 17:40:19 -0700
Message-Id: <20180510004024.93974-9-sbeller@google.com>
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
 alloc.c  | 2 +-
 cache.h  | 3 ++-
 object.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 290250e3595..f031ce422d9 100644
--- a/alloc.c
+++ b/alloc.c
@@ -73,7 +73,7 @@ void *alloc_tag_node_the_repository(void)
 }
 
 static struct alloc_state object_state;
-void *alloc_object_node(void)
+void *alloc_object_node_the_repository(void)
 {
 	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
 	obj->type = OBJ_NONE;
diff --git a/cache.h b/cache.h
index 32f340cde59..2d60359a964 100644
--- a/cache.h
+++ b/cache.h
@@ -1772,7 +1772,8 @@ extern void *alloc_tree_node_the_repository(void);
 extern void *alloc_commit_node_the_repository(void);
 #define alloc_tag_node(r) alloc_tag_node_##r()
 extern void *alloc_tag_node_the_repository(void);
-extern void *alloc_object_node(void);
+#define alloc_object_node(r) alloc_object_node_##r()
+extern void *alloc_object_node_the_repository(void);
 extern void alloc_report(void);
 extern unsigned int alloc_commit_index(void);
 
diff --git a/object.c b/object.c
index 91edc30770c..b8c3f923c51 100644
--- a/object.c
+++ b/object.c
@@ -180,7 +180,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
 		obj = create_object(the_repository, sha1,
-				    alloc_object_node());
+				    alloc_object_node(the_repository));
 	return obj;
 }
 
-- 
2.17.0.255.g8bfb7c0704

