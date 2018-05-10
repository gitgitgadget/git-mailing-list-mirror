Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87CC1F424
	for <e@80x24.org>; Thu, 10 May 2018 00:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935641AbeEJAkl (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37541 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935635AbeEJAkj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id f7-v6so243380plr.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YM7G6Z3HwNhnwoCpQ06RPZi6MtHJQRwAUDaoS/o4eM8=;
        b=a75WTqQknArRrLpoKeIIFiawq131ReuMn5BWGi79USZKn2JcrEsOx0zgMayEmBXsq7
         5woO3IpzXthcFwW+pMEGGPD25QJff+RhvmbUQ+Ng/Dhy2PYMgvCy4Nj6an/BBsXdYpHA
         1RWRK1RcEGUyI57REkvP+9iQPY1L4ZAn/GMsvHJ6xRfwLkUZOkHK22GYtmMp9W06IXvB
         K2VZZH9chE36gIrtx5etbM/hRXDpY5rLIW5iE4vdxUlicuXTv2FP/PEeqwQU+2BB2Wrg
         GTGMOOhoYHiiC/QDNVnqlaXbzkG+SSwHLJ3RpqX+lw2VEViwfrtAEeh7O/yFf662bqJx
         vkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YM7G6Z3HwNhnwoCpQ06RPZi6MtHJQRwAUDaoS/o4eM8=;
        b=oTiSlHeZ2STWk3kda7mY4kY1kcHD5FnD+jWG+asIhteTMjoOZ0R1lcUxo6m2SSVSBh
         t7AS3G+vDe4iIfqMnWKk5coMar00wttIPJ3EQ9Ispr7VU+0lJdDkdN1kHiLT1AZNEDLl
         EL7hSsc5thbRmHJR/ybIHBZSFv8fXmLfbCuPPwme+F4YsDuMOQ8oB2+Ixgjfv7ha6RKT
         VqGBR5n2PkhhdI8ckCi2piz+VKPQ4TaJSdFmYOQo3DGK9+jJz6Kg6NioNp7J3EJDc/0k
         0j4mFGzzuuCNbZmpQU+U+ZP7NJJdhA+CDDwWwd2tXh2p1SP66uQ7EBLwIGjPTmTaIXFs
         iplQ==
X-Gm-Message-State: ALQs6tBqbZ5wu4fbUmvzZRBLHHtCjjZQVXbh8A8/EeAa5nFwvGcdXHip
        IsgYJzz8kr9V/XsHu2d5YRPRdfJgxNg=
X-Google-Smtp-Source: AB8JxZqwE6vp43g0s3wVpuEgBgX6EDT9ELwgnXm5fl+WFMft/xuMyagX87jNYe2SqXd3IxgYxH3YEQ==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6-v6mr39621381plt.31.1525912837825;
        Wed, 09 May 2018 17:40:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l63sm58658136pfi.6.2018.05.09.17.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 05/13] alloc: add repository argument to alloc_tree_node
Date:   Wed,  9 May 2018 17:40:16 -0700
Message-Id: <20180510004024.93974-6-sbeller@google.com>
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
 tree.c  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 6c5c376a25a..2c8d1430758 100644
--- a/alloc.c
+++ b/alloc.c
@@ -57,7 +57,7 @@ void *alloc_blob_node_the_repository(void)
 }
 
 static struct alloc_state tree_state;
-void *alloc_tree_node(void)
+void *alloc_tree_node_the_repository(void)
 {
 	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
diff --git a/cache.h b/cache.h
index 2258e611275..1717d07a2c5 100644
--- a/cache.h
+++ b/cache.h
@@ -1766,7 +1766,8 @@ void encode_85(char *buf, const unsigned char *data, int bytes);
 /* alloc.c */
 #define alloc_blob_node(r) alloc_blob_node_##r()
 extern void *alloc_blob_node_the_repository(void);
-extern void *alloc_tree_node(void);
+#define alloc_tree_node(r) alloc_tree_node_##r()
+extern void *alloc_tree_node_the_repository(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
diff --git a/tree.c b/tree.c
index 63730e3fb46..58cf19b4fa8 100644
--- a/tree.c
+++ b/tree.c
@@ -197,7 +197,7 @@ struct tree *lookup_tree(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_tree_node());
+				     alloc_tree_node(the_repository));
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
-- 
2.17.0.255.g8bfb7c0704

