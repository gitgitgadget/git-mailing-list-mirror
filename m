Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8CC200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeEGW7k (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33253 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbeEGW7g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:36 -0400
Received: by mail-pg0-f66.google.com with SMTP id i194-v6so20298658pgd.0
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9RZm0a19d6XMRRGAySMBinLN+inJho8lwY5c6JlmK8=;
        b=SefBgkx5x3CJyWzfWTDstewr1d7grd0e8JcVYzXc3ppQ5ykJyW2+SSl1q/jEtA1r5q
         g1PxYXEyc7VfIpujv+2cHZbnqgbp8q2JupgmQJeYVRxD7QB9JehmpLIWKkPXUgi8QYf4
         1TZuZH921ljVzMC2iJvuMHJudWq6OfXiT2ousgo7waQ081zstwgsyb1LTAOQz/M/IIHw
         xBl6/ajdwTfg9SlQ6W9FlBXk8m6TQQi0QK9d8cPtfNu+h0CFHl67scefRpye3lIEUMBA
         CyJvCGPetkB9GL4okKTuA7wq8nJILt0DKTervOPmDfYz8SWRI9CSauutiXfBQMT2fpDq
         J5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9RZm0a19d6XMRRGAySMBinLN+inJho8lwY5c6JlmK8=;
        b=OW/Ablpd/BR3lUl3pcO5dqv/SBSm0SDSlCWezvqHUC9VGDdmwzVYuvceWjUXIOOVWy
         qb+B6Yhg4YWCpDyWTV9qqjAbCal/c30eD0sIcRImuE+YuH6rLdezOaUB4LkBNPBJ9621
         wwMG3ZmvthqrKtDj3KEb663xFqYdTKza8XEYMwEfSxvw91WaPdcpv3lG5VoKdvXk2MrW
         VkUlKGnpGcnKc9bwnAfDEFzMW0IaQLmGbyQLZOKcO0I9XTAoRVstdh3lmsPegrzPeGRL
         LnMG/ApzD46KeiznL5YWrgPJq/IkAoJ65BYt2oLJEMm60Wssj8mRikHb4icpkPRTwBK9
         w7DQ==
X-Gm-Message-State: ALQs6tCha4Ea4FGHK1uHzkAH41nVHT8lhkOvAVLz4wRYXi6TrvZoxxj9
        VmA0qPoPRhS+1MgTpltJFbKYOzYIO48=
X-Google-Smtp-Source: AB8JxZo8xg4m8efnRoWqjjyySfJ+ERz/PCLqPSVS3llqYZ/VmF5LQhvCdyF0grP7qFH0VUFbBiqmdQ==
X-Received: by 2002:a65:650a:: with SMTP id x10-v6mr26477518pgv.169.1525733975165;
        Mon, 07 May 2018 15:59:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p71sm52736349pfl.170.2018.05.07.15.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 07/13] alloc: add repository argument to alloc_tag_node
Date:   Mon,  7 May 2018 15:59:10 -0700
Message-Id: <20180507225916.155236-8-sbeller@google.com>
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

