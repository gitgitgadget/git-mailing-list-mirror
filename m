Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA7D1FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeEAVeS (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36939 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEAVeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id e9so5983877pfi.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IRb0CNVx1X5fWrYvM130g2hLFXKbyWCq2kIVUQjEtlY=;
        b=R3H1q4bYoQKggHzxqP+DVd2dLgRHmg0YieL0soAL6+38qiDrPN67ZTQ4RcRVXPmF+E
         CEqrE51N1FjVHrMRd+JC8L1ujNW1Wc/GcFiHxLQWCR2zLCXjwxZoMS+RXp372ZzlSP5/
         vJLoQPr1ulUN4FrpH7AJFSvkq0tcBHSDpuxBD/6SSa1JayHJFJ+GARg72bl9+KcItiRD
         g/ET7prhUnIdfAHwSLIipDJL2rREz5FrzE47BGZJT2hGb5SuPGVY0dIK+U+3+dEG8Wld
         +vsrOvLC+4crlY6cGHrGQckq+eJkADYyEF4F3XCRkfOsIm/lp2kaTqmhior0VudWh7d6
         WTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IRb0CNVx1X5fWrYvM130g2hLFXKbyWCq2kIVUQjEtlY=;
        b=n52tdfv8WiARgN1BHLnAopAcIKimuIvq5bBSTdR8H0MZKD0JXOtWMlQrgQGG6nNjtR
         tP6Py62UqxH/vHJr/8F2GvqB9fsdYWS9IbxZsBgZ+v/KxQxGBbvQSBdnHJOzkFwNIOuj
         +umyoKG3OdVhBwNsT/UOyr09H1JCOzdK5J0eQ++BjQV2hDvu0QZ4uA6hjwuYLM2Of3zi
         ckBiATMN9pXo6oVocQ6eqecW+nPWW2jtVC/U9Motk4Q+XaWFawf/K8CihmpbAuYLQgF+
         8GqPzol5fkAaovjBDm3ERoKLnma8VGAGk0LbaQgYgfARWX56USeoMBMNklEjFd9iuS+Z
         29XQ==
X-Gm-Message-State: ALQs6tCETtcfzH3M6uG3rCS308Sq7wxNwN/gdyGILTNwuu5B0YtvQTAi
        KYGCOiMuTPGSAi88attlPqI2hVOmXtQ=
X-Google-Smtp-Source: AB8JxZq0BVbHi25nwJrU1Xi/IpaSdJ8m0HEfbd4SbaAKbVwezJcK7kzVB95Mp+edF+4tOl80pUvarA==
X-Received: by 2002:a17:902:57d8:: with SMTP id g24-v6mr17958275plj.337.1525210455212;
        Tue, 01 May 2018 14:34:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z125sm19798521pfz.163.2018.05.01.14.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/13] alloc: add repository argument to alloc_tree_node
Date:   Tue,  1 May 2018 14:33:55 -0700
Message-Id: <20180501213403.14643-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.17.0.441.gb46fe60e1d-goog

