Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59082200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeEGW7c (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:32 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35256 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeEGW7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:31 -0400
Received: by mail-pg0-f67.google.com with SMTP id j11-v6so20298764pgf.2
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TfHt+QFnlFsw9F3fGjIrHcUOHYogNrRA//oGqLDV/Ko=;
        b=JawsFbNrHQKmJpNRkA8JNxTg/bL9wWI46igpRUVLXGdnZsUmpIU6YSEz9WgnZ6KOUy
         IBUWc9xJU3DvQiXx14tdgCGaFIGAAF7Fgc6vuKABLgLoLOadFaVB8K9PzkWJiLtwK+T4
         7qwMZrN7r0EYDatCM1IMMkt0M54DVryxQjeceBKZjIettR4RTwzxXe5Dxd+aVrzlEA+Z
         C/2Nd3k0GsiSkR+OCiDkTBboaUuYOQGC73sOa7FoHxnyF64oOegZwt6py3Ra/vIuM0nr
         CUqxyhpMAobP5WurZFYDSVX8K5E8ZIX7n29dOxAtIlpwleNcfc14cgBb0eWXYIIX+eqe
         4Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TfHt+QFnlFsw9F3fGjIrHcUOHYogNrRA//oGqLDV/Ko=;
        b=fqFHP20MWTvL+YDtED+UVvjYzKpLQFXUhdc3Niq4s9hh3JgVo37XgYGsbOuC6iOP74
         KTUJFkknwO047wir0cKWK7cmVALlNlxjr97F4TpKIZ/qrjLn2mLcR5aSAtJY3VulkYKy
         ezWXZVU4xjKWcgsmXSREh7ErX6ekeTZXo3QjaDRIsE5Kxez+IwDxUq7XJr+8+LZALxeS
         b3+xY+FxeGHyl/6ZFru020LOs4UWtZFXu8n+wKFphUeL2KQmV+kuboypig0z3nS1qSsR
         bHmRKiBv/88JUrTTgyrt3FrImExedY+eszLBIoq4ALqDABZGWNuonGSsxqM70k9Z1KDo
         n2lg==
X-Gm-Message-State: ALQs6tDPl92dps1bYmdcBIjiC1zA08IlP4WBhIiYrvQXvj7cNLrjY1/m
        pvMq9kR/MWyHmNE6QnjgWGK3iZFTpM0=
X-Google-Smtp-Source: AB8JxZp56QKI4F6NVEOuYvhbac/1uxjWt7JBD5ye229dscUtBxb1n+AO9vlt3oS4YHHVfNcu9QUQ+Q==
X-Received: by 10.167.132.199 with SMTP id x7mr10869889pfn.195.1525733970170;
        Mon, 07 May 2018 15:59:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id h75sm40246894pfh.148.2018.05.07.15.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 04/13] alloc: add repository argument to alloc_blob_node
Date:   Mon,  7 May 2018 15:59:07 -0700
Message-Id: <20180507225916.155236-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small mechanical change; it doesn't change the
implementation to handle repositories other than the_repository yet.
Use a macro to catch callers passing a repository other than
the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c | 2 +-
 blob.c  | 2 +-
 cache.h | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadfacdd..6c5c376a25a 100644
--- a/alloc.c
+++ b/alloc.c
@@ -49,7 +49,7 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 }
 
 static struct alloc_state blob_state;
-void *alloc_blob_node(void)
+void *alloc_blob_node_the_repository(void)
 {
 	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
diff --git a/blob.c b/blob.c
index 85c2143f299..9e64f301895 100644
--- a/blob.c
+++ b/blob.c
@@ -9,7 +9,7 @@ struct blob *lookup_blob(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_blob_node());
+				     alloc_blob_node(the_repository));
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
diff --git a/cache.h b/cache.h
index 3a4d80e92bf..2258e611275 100644
--- a/cache.h
+++ b/cache.h
@@ -1764,7 +1764,8 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
-extern void *alloc_blob_node(void);
+#define alloc_blob_node(r) alloc_blob_node_##r()
+extern void *alloc_blob_node_the_repository(void);
 extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
-- 
2.17.0.255.g8bfb7c0704

