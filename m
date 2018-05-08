Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D30200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755543AbeEHTh4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:37:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43807 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755519AbeEHThy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id j20so10122114pff.10
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTqhfTtmV3pMirYUYgWlXw/kCqlEQoXZJCMU2+NSS4k=;
        b=B8iCqIJ4HKZMmUW4ykxUHa5NySUgEdXCdjk494Nqh+5rEyFaRFW/boSPyyQQRtd1qu
         7nnab5MdBUY67K5jwRvV6EvwRORUZO1LQ68JbcRM+dzlpe1ToSE1U6ArxhxIKf5Lqc46
         JplX31rNNwbo+gerPXEAyZps5oI7jHG4VSl6fj/1X33zfxwUxOt9PYs0Pd95ArCImoWa
         7FPBMy56SOrMhoVVnBrSKondPLBn58J6uSHhS/uw4n5hbI4BzEK8gadgq8/Zam7VXq6w
         4CRi8gOU1wsikGtWhXuh3L4HO63Qo53jFz0P/PAwzk5EjamLjYvCyL/RSr0yDT0DW8x5
         UeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTqhfTtmV3pMirYUYgWlXw/kCqlEQoXZJCMU2+NSS4k=;
        b=KUr0PYUhVYJ1M0FyGbq3H6qKO+VPI9D4z9zYTSBP7TzcaxSWqCNeqKQcCoN0GHs9iQ
         ytyKwNS5VwKnclNWn4WG+3rx8/nQLefvsb+q9YHlHs/A3kNj4sTlltMJn52HMXwd0LQU
         3ahNXaVbDXc29BovkhOjb88DSZnzNvenH47qyhPbT3qx2N5HMhi770LhdvlbAt5qmTOV
         gdvcO3TtpxYFUkyCTkBcFn8ogDGY3mblxbhMnrSYbjx5SUNw4qFRnZVSlt+JIJLZjU5O
         YbiXrgAxX0VZ5wniKyumWvA/euW+wA+NkbVyrEKyujVKRTowYLSAunHuVbUPgjT5YqNs
         smHQ==
X-Gm-Message-State: ALQs6tD1yyqSrn5XWyDzFt7/oGxFn9ElByHjKc2N7+uYaGj7c8ZTXQor
        g/XOXaYitF4/z6AM0MkzG5BisQ==
X-Google-Smtp-Source: AB8JxZq+1u1eDrGOb78MgLYoikEIFpGnLFgfPLNT2ojc8Ye/sB+Xh440UViA1tTXTGwQVf0M7Q18yg==
X-Received: by 2002:a63:a34d:: with SMTP id v13-v6mr34073896pgn.224.1525808273389;
        Tue, 08 May 2018 12:37:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id q64sm46336171pfg.180.2018.05.08.12.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 07/13] alloc: add repository argument to alloc_tag_node
Date:   Tue,  8 May 2018 12:37:30 -0700
Message-Id: <20180508193736.14883-8-sbeller@google.com>
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

