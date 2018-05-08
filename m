Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83ED9200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755662AbeEHTiU (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:38:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33664 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754659AbeEHThu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:50 -0400
Received: by mail-pf0-f193.google.com with SMTP id f20so15642787pfn.0
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0M49anvLElxs1frAEBYUbXYyy/a9bLY76JJa6hARs8=;
        b=MLRJ2NGvvEa7NH79fysytGV9VIYBrjr26FBus7bpMWoOFbywJHxi1ezaGK4KWC4t/J
         luBIYuQnWI4vS3RWRmFX6hg6R6wscQRLlTMUIZqHhJxSLjm/+Mo1k8/Jaw9/FslCQAS9
         vXzGLoKIYcP792JBROuYUfnM0DWWxq/j4Zb/PTncB0nCd9aiy3Sjo6WgmPBaIvplqALD
         7hsjW8pnRa8FKgR5AQLf03BQDhnN4ARtFSBxEUi0AKOlo58W4dMoILXPEi83AioDbS44
         wHjug8x8s2PfgEHAASHZAxnjJ8OQT8O5kXsumLv1nTTa69KrGhRBXEOh0xpTFVuW8cPN
         xWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0M49anvLElxs1frAEBYUbXYyy/a9bLY76JJa6hARs8=;
        b=glvYnyh28WYrj08sisZ1yaqhDruXRE+L7Ya/paahOSsDOZ76IhUg9ANBiw39+TeKrn
         wUqNteoohHr876NIFRHJLTRwJJx6Kenk0eKtzyQSmSuNfeMzX2HCbHJFLvVa8F9w2nU5
         abXyfp+EWVHo82wG13A4ddwgmp29UE4qS7XQofcJWTI0guKZZx7BFQYw5rdotEkw1336
         +8RMli/D0TA3WKkkFyRzyaoWwz5k0vE1dwufz9v4Wx4z7AvzFH+v5+myINb0nClCBhoH
         JznyoMwqbOUKalNLaLtnZCiiGuQEZxLmCd37nxNkkQSRMXUyV1/XgrVutLvMwJK7Jz+h
         rggw==
X-Gm-Message-State: ALKqPwcUT22sF2HUIMXi4+R3u5ywUCYxXvEj+NgNyfPcxyQt+I/1STOU
        7OrFoot1AnuBmkmC1KklP6gwHg==
X-Google-Smtp-Source: AB8JxZrvXRF6UDoPFeEdL6pekKIHxJcRSXnkY/ZZfNQ7+9fWFGU7zhx+PlQsRzum2t9MF/y85Lb4UQ==
X-Received: by 2002:a63:af17:: with SMTP id w23-v6mr255693pge.247.1525808268870;
        Tue, 08 May 2018 12:37:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id u70sm51731066pfk.121.2018.05.08.12.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 04/13] alloc: add repository argument to alloc_blob_node
Date:   Tue,  8 May 2018 12:37:27 -0700
Message-Id: <20180508193736.14883-5-sbeller@google.com>
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

