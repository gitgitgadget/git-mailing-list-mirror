Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA3F200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755525AbeEHThx (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:37:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46050 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeEHThv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id c10so24422949pfi.12
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YM7G6Z3HwNhnwoCpQ06RPZi6MtHJQRwAUDaoS/o4eM8=;
        b=mVCZv+zYsZ7OlpZZ9ztOZ+z/uCkDSfRnWp9p3806TLAe2XM+M6bJNDcvCJiAlglgmt
         5VkrjgHou07t4zDNkscJs8QXT072G+0pAU3zAAGSRQiYa4Pv5HCzBkl3ONfChW9/SO3l
         4JzamyL2S4Hf3zrD9ptrW6fhdys5KY6+0ul4iH4QLZcZx6YG1HBa6TVb62WY48/ailnU
         gng+LQRYjC1wG5tbxD6iX2/rmtKIGFgt8HbtzgDfdts4ZXg4ckLOUgEdN7iIAtQ5FmFm
         adILh4DKG50m38z8ymiP+P+M57Iq0Oea+xzfMdVES3Pw0arSRaYNkiwqiGSkYqHIkTCe
         Y4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YM7G6Z3HwNhnwoCpQ06RPZi6MtHJQRwAUDaoS/o4eM8=;
        b=DBre/UIKbzj4aJeoVsPkzi/SxD/3ysNeUgfFBajnBE6gujFx6gFBax7wEcdoUPtIez
         s9SdeoFAEwKF/3BA7PzCBBEFK3ywAKX1pedqCC+HRHDW+KG+5DC7Jiw4pocDzp2BAAJx
         ou0Xi2zC1QiTY39ycx9bROK2ugklXOI9HIXcgJtFGXAmPr8sKaAWTPqoqGWLoa+TlwlC
         Mq/q7O6/HcqDIXK3omzSnyAD+Jmtr/N91WhEbqTBZ4TwvSz65lrBkjN2nLuvfMwS2O5v
         hhnpEkbS09np71kN8gCLMsecRbYXWls+F7HBwMOqz1bYEFw/NsAPeoNp3eAVMNI88hZ+
         vLMA==
X-Gm-Message-State: ALQs6tArjl/NJ1KP3mFi/nTjDVLILtTMZ8B528ceZoCLQ3Z3/2oVz3/M
        nrRBGIdp94x0LivQYNoMRdAVLTZU0uA=
X-Google-Smtp-Source: AB8JxZpTe8tuHJgQsaZks2LrbB5TlH5WvMnPOVZvdVOdYW23sQ/f0F3cxe2B7nqyqqsmO551W8y0GQ==
X-Received: by 2002:a63:b54b:: with SMTP id u11-v6mr33690010pgo.365.1525808270522;
        Tue, 08 May 2018 12:37:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 65sm53541627pft.74.2018.05.08.12.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 05/13] alloc: add repository argument to alloc_tree_node
Date:   Tue,  8 May 2018 12:37:28 -0700
Message-Id: <20180508193736.14883-6-sbeller@google.com>
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

