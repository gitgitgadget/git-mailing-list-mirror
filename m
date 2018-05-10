Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6711F424
	for <e@80x24.org>; Thu, 10 May 2018 00:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965884AbeEJAlF (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:41:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41570 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935639AbeEJAkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id v63-v6so191859pfk.8
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTqhfTtmV3pMirYUYgWlXw/kCqlEQoXZJCMU2+NSS4k=;
        b=LSULfLLJ5skA2NblH/XtanuB4FpwOUID5gOY3UDiF6uPtaNyzCHxEn/nQqOVegcitV
         j1NLbX1y6tcxLPqLeCx8czuMXUL9ZWQNF6GQYI0sBlpzPdYr0gTZrZhe+1JGh5AIfrVK
         SxdYJ+lcASO16XZvrFvEmEeVe7sDPQRVWG6rF9NsBMlaVa5RHGM6lgZtTK6ptNQhtQZj
         nkZaL2LVLRkxNneucOHv0qGL6ejM7IzzdapSD2iLzvfCIi35hNcwqRI29z3EqYre0bc/
         tnJ44a3+hwB2MBfMjbGuft8ZILWV0tK+8P+pBzFHWnMNdGD/h79ufRF9FIH4pVr4hUHC
         eCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTqhfTtmV3pMirYUYgWlXw/kCqlEQoXZJCMU2+NSS4k=;
        b=Wv+iIZMVdZOiFUCsI4XEWo7Vj4JNhmFWS7Jo+YnLqIstCMcQ1EniTdnpTfW44r/fkB
         4YTgi6NTY/lF8NxJ20ilW+3n5r/8bESdeqoHBzTV98H4fL3WqYblWWdZqqy3ZIbqwehM
         K/Gm4Qa1obgX+mH73YoQj465UMBrYNmll5vk82Ud3b+HbImBqineSzHlK5qNHbKW2ApS
         N9wgFNF8atMYB6YF11MPag0omgHq7jRCKK9BKDuvv9G2zDCGI5ZiaeTJZonwzgzAA4PC
         0WDtOf8XkiiEfp4dwwT0Y+WzV2uOoxzxPOfXPKdu0+Q4ARhb8+J+bDdB6LUDof+KwoJh
         AESw==
X-Gm-Message-State: ALQs6tBNsajN2i0qsOyanFsMS7wY3iIYlOlHFyMGoyMqyk8Pl265vLF9
        51L4NjMRhGa9JpsKf0EprQHr7Ab8JoU=
X-Google-Smtp-Source: AB8JxZppL0qQwFGyjMhRjI2QfaBa6W9oXlmaeyqJgfKcluoaoza2GNURcOs0MBxd6c1wkYyWplQwbg==
X-Received: by 2002:a65:4805:: with SMTP id h5-v6mr23014880pgs.96.1525912840612;
        Wed, 09 May 2018 17:40:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id n73sm22478158pfb.167.2018.05.09.17.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 07/13] alloc: add repository argument to alloc_tag_node
Date:   Wed,  9 May 2018 17:40:18 -0700
Message-Id: <20180510004024.93974-8-sbeller@google.com>
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
 tag.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 9e2b897ec1d..290250e3595 100644
--- a/alloc.c
+++ b/alloc.c
@@ -65,7 +65,7 @@ void *alloc_tree_node_the_repository(void)
 }
 
 static struct alloc_state tag_state;
-void *alloc_tag_node(void)
+void *alloc_tag_node_the_repository(void)
 {
 	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
diff --git a/cache.h b/cache.h
index bf6e8c87d83..32f340cde59 100644
--- a/cache.h
+++ b/cache.h
@@ -1770,7 +1770,8 @@ extern void *alloc_blob_node_the_repository(void);
 extern void *alloc_tree_node_the_repository(void);
 #define alloc_commit_node(r) alloc_commit_node_##r()
 extern void *alloc_commit_node_the_repository(void);
-extern void *alloc_tag_node(void);
+#define alloc_tag_node(r) alloc_tag_node_##r()
+extern void *alloc_tag_node_the_repository(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
 extern unsigned int alloc_commit_index(void);
diff --git a/tag.c b/tag.c
index 7150b759d66..02ef4eaafc0 100644
--- a/tag.c
+++ b/tag.c
@@ -94,7 +94,7 @@ struct tag *lookup_tag(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_tag_node());
+				     alloc_tag_node(the_repository));
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
-- 
2.17.0.255.g8bfb7c0704

