Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2D30200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeEGW7m (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44653 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeEGW7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id e6-v6so1010488plt.11
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gK27zVWuIHB+RyknMOXGSS2jwiDIXEkUITRIutWw9yk=;
        b=GPKulCZxQD+Fv18mFOKPBcKzWR7s1i2TdxLDmNBvIcdY9Xp0Ia/gmOhq6w4vQQnNqW
         cUXYnqhmciNgkC8Nohw9Vn53f6++ac+WGgbFJHo40yvj0YuSfKmnlmQZXFaMqixzzBj8
         i9a52T4MijpjYMzy1GZ8EXBhr86pZz4HE2UvkMCRGcndel1iV8P814tUWIJH9ALnnsQr
         rh8B2qS+ljRqbCkkHwraFGSnA3SRsyyrhkU16atYpyDJhr/LPPrn8XeO1D9ESay0LDeA
         XRwS6PZYnmACfe2PK9bWBajaUg26PuJ5guDdVPFi48ghRzXjAwaDlmO4qpkVXNohT/vL
         U4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gK27zVWuIHB+RyknMOXGSS2jwiDIXEkUITRIutWw9yk=;
        b=sguuhu6XlsndVz4emrXIlGiabqK9+U+afjVcNTLpPIiAckiK5UA02NWZPFYieAtrdd
         hpdYyYXlbdXuVzEtoRtBZUrNtLikZ5ymIOOlwbslNXGgxcF3BKr39sCfxT3gpy7R7Lg3
         bzHLO/ULiK8yTtrgqZ+XLb3BOU0fDzsPVJ2zMtds9YxxMvbWzJuSwoMc6Q0QaAEz/hy7
         3AtrvX8E33bnq7BM8iUpEw9uJfQ/UBoE3LbefL57Jbkkd4Hf4dV6iK531HMckEy11Dp2
         ynovy1mSZG07mHq8utK5N2Vhg1HoRhjFKuKd258L/ggSnWTMUI5z+ZrxQuT5x+cl6IsM
         gz9Q==
X-Gm-Message-State: ALQs6tAts5Z3Y99P7uskWMuwxhU0qxXvLEu+T9yldjXSP5nxmyE6dgny
        QrO307GFnbb9R8mb1PcBLpsECuV+tj8=
X-Google-Smtp-Source: AB8JxZpoaHE49JyY/fbxsP7lfCKEj89nfxcInUx2PnggRUzumupQVIEK58G/fX/kQpRNG2DNLzmlvw==
X-Received: by 2002:a17:902:3303:: with SMTP id a3-v6mr24058687plc.209.1525733972007;
        Mon, 07 May 2018 15:59:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m14-v6sm42592pgs.72.2018.05.07.15.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 05/13] alloc: add repository argument to alloc_tree_node
Date:   Mon,  7 May 2018 15:59:08 -0700
Message-Id: <20180507225916.155236-6-sbeller@google.com>
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

