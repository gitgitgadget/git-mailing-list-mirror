Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74451200B9
	for <e@80x24.org>; Thu,  3 May 2018 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbeECWSO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 18:18:14 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46685 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECWSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 18:18:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id z4-v6so14079822pgu.13
        for <git@vger.kernel.org>; Thu, 03 May 2018 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UvOo2kCuW9eLy+fjW6OkCBNShQ69nPq8tg7/o7X5yrY=;
        b=ddLgq8V7inI33YTcap04H1ugy6LI5sHQ4+XYLaGCUpIAPuRKKEHWi8p7R79X54wmuW
         kLlw18AsEcre8jU7wv1JPXsmMfNyyDuiDYP+RGfxXSMO4L3AVxDw9fwr6T/uwBkwlL3i
         Qs1/jpIG/mgIrMhk/QQUl5oMw7CGAQ2f3/yGUNS1AtmDZ9RrK5s0UHhwbdXMummaQZRa
         NXEMEy7arrSt9693xetX6fxLaEmdFEhrxfgfSGCAkGgSsE8kR2hgrElI/i3x16Ho2c7z
         6WzwctjQvHs7EEcdM50CAIOLzwl44qcE4EXYCnc+St36g9dDbLsNvs+WzRvm0pGLcpYe
         W2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UvOo2kCuW9eLy+fjW6OkCBNShQ69nPq8tg7/o7X5yrY=;
        b=H2Xt8vvsWspKSN6ZJyShGDqgrtZUmGSGCW2MvtKWMxA3qDCi0TljzqF94agvX8JJQP
         nUan/wBhML73H9KjlbBeoN6MsMBXUWqIRAqB8okiQcTTUQxtBAKByvSh3U+dqamg2z3D
         jNZWMx02t55L8e51UBGPNnPTr851zv01YBwQTiXLtF7sCdECDbmFNgL4Let7ZX3aDYou
         FBT8x7en6POCfZ/YlmH9ZWyr9EPOZSrSgVD0VxeBIkNWMH41NgkBI7qh+yA1m7+/tLMa
         LgzTB5QZ6yyLvZ3/BZz6PLHs7MGyHVTH6kqyC2ZLPAOfXsM1NIlkAWsz4pnR7ko2F8RL
         gsMg==
X-Gm-Message-State: ALQs6tC4frF52eD0Ix2oxdhwAI6GP3mSEpLd03vfwHpOV3dNCrWxpsTq
        pmfMgVedOBGgvHmZJvKoKneESw==
X-Google-Smtp-Source: AB8JxZoeBOHMaH+jAGGJnLkU/LjjIZ/dTgaqxg/O8mZjimJmCJzDQ7MQtSXcdA1lrJqktX6MVNVyZw==
X-Received: by 10.167.133.131 with SMTP id w3mr24331512pfn.197.1525385892341;
        Thu, 03 May 2018 15:18:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id c11sm28283673pfh.15.2018.05.03.15.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 15:18:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jamill@microsoft.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sbeller@google.com, peff@peff.net
Subject: [PATCH] alloc.c: replace alloc by mempool
Date:   Thu,  3 May 2018 15:18:02 -0700
Message-Id: <20180503221802.61110-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <BL0PR2101MB1106BA184260609DA69988A6CE870@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <BL0PR2101MB1106BA184260609DA69988A6CE870@BL0PR2101MB1106.namprd21.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

>> The reason for my doubt is the potential quadratic behavior for new allocations,
>> in mem_pool_alloc() we walk all mp_blocks to see if we can fit the requested
>> allocation in one of the later blocks.
>> So if we call mem_pool_alloc a million times, we get a O(n) mp_blocks which
>> we'd have to walk in each call.
>
> With the current design, when a new mp_block is allocated, it is
> placed at the head of the linked list. This means that the most
> recently allocated mp_block is the 1st block that is
> searched. The *vast* majority of allocations should be fulfilled
> from this 1st block. It is only when the block is full that we
> search other mp_blocks in the list.

I just measured on git.git and linux.git (both of which are not *huge* by
any standard, but should give a good indication. linux has  6M objects,
and when allocating 1024 at a time, we run into the new block allocation
~6000 times).

I could not measure any meaningful difference.

linux.git $ git count-objects -v
count: 0
size: 0
in-pack: 6036543
packs: 2
size-pack: 2492985
prune-packable: 0
garbage: 0
size-garbage: 0

(with this patch)
 Performance counter stats for '/u/git/git count-objects -v' (30 runs):

          2.123683      task-clock:u (msec)       #    0.831 CPUs utilized            ( +-  2.32% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
               126      page-faults:u             #    0.059 M/sec                    ( +-  0.22% )
           895,900      cycles:u                  #    0.422 GHz                      ( +-  1.40% )
           976,596      instructions:u            #    1.09  insn per cycle           ( +-  0.01% )
           218,256      branches:u                #  102.772 M/sec                    ( +-  0.01% )
             8,331      branch-misses:u           #    3.82% of all branches          ( +-  0.61% )

       0.002556203 seconds time elapsed                                          ( +-  2.20% )

  Performance counter stats for 'git count-objects -v' (30 runs):

          2.410352      task-clock:u (msec)       #    0.801 CPUs utilized            ( +-  2.79% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
               131      page-faults:u             #    0.054 M/sec                    ( +-  0.16% )
           993,301      cycles:u                  #    0.412 GHz                      ( +-  1.99% )
         1,087,428      instructions:u            #    1.09  insn per cycle           ( +-  0.02% )
           244,292      branches:u                #  101.351 M/sec                    ( +-  0.02% )
             9,264      branch-misses:u           #    3.79% of all branches          ( +-  0.57% )

       0.003010854 seconds time elapsed                                          ( +-  2.54% )

So I think we could just replace it for now and optimize again later, if it
turns out to be a problem. I think the easiest optimisation is to increase
the allocation size of having a lot more objects per mp_block.

> If this is a concern, I think
> we have a couple low cost options to mitigate it (maybe a flag to
> control whether we search past the 1st mp_block for space, or
> logic to move blocks out of the search queue when they are
> full or fall below a threshold for available space).

Instead of a flag I thought of its own struct with its own functions,
which would not just have a different searching behavior, but also
store the size in the struct such that you can just call
fixed_size_mem_pool_alloc(void) to get another pointer.
A flag might be more elegant.

>
> If this is of interest, I could contribute a patch to enable one
> of these behaviors?

I am tempted to just do away with alloc.c for now and use the mem-pool.

Thanks,
Stefan



 alloc.c | 60 +++++++++++----------------------------------------------
 1 file changed, 11 insertions(+), 49 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadfacdd..bf003e161be 100644
--- a/alloc.c
+++ b/alloc.c
@@ -15,6 +15,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "mem-pool.h"
 
 #define BLOCKING 1024
 
@@ -26,61 +27,39 @@ union any_object {
 	struct tag tag;
 };
 
-struct alloc_state {
-	int count; /* total number of nodes allocated */
-	int nr;    /* number of nodes left in current allocation */
-	void *p;   /* first free node in current allocation */
-};
-
-static inline void *alloc_node(struct alloc_state *s, size_t node_size)
-{
-	void *ret;
-
-	if (!s->nr) {
-		s->nr = BLOCKING;
-		s->p = xmalloc(BLOCKING * node_size);
-	}
-	s->nr--;
-	s->count++;
-	ret = s->p;
-	s->p = (char *)s->p + node_size;
-	memset(ret, 0, node_size);
-	return ret;
-}
-
-static struct alloc_state blob_state;
+static struct mem_pool blob_state = {NULL, sizeof(struct blob)*1024 - sizeof(struct mp_block), 0 };
 void *alloc_blob_node(void)
 {
-	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
+	struct blob *b = mem_pool_alloc(&blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
 	return b;
 }
 
-static struct alloc_state tree_state;
+static struct mem_pool tree_state = {NULL, sizeof(struct tree)*1024 - sizeof(struct mp_block), 0 };
 void *alloc_tree_node(void)
 {
-	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
+	struct tree *t = mem_pool_alloc(&tree_state, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
 	return t;
 }
 
-static struct alloc_state tag_state;
+static struct mem_pool tag_state = {NULL, sizeof(struct tag)*1024 - sizeof(struct mp_block), 0 };
 void *alloc_tag_node(void)
 {
-	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
+	struct tag *t = mem_pool_alloc(&tag_state, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
 	return t;
 }
 
-static struct alloc_state object_state;
+static struct mem_pool object_state = {NULL, sizeof(union any_object)*1024 - sizeof(struct mp_block), 0 };
 void *alloc_object_node(void)
 {
-	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
+	struct object *obj = mem_pool_alloc(&object_state, sizeof(union any_object));
 	obj->type = OBJ_NONE;
 	return obj;
 }
 
-static struct alloc_state commit_state;
+static struct mem_pool commit_state = {NULL, sizeof(struct commit)*1024 - sizeof(struct mp_block), 0 };
 
 unsigned int alloc_commit_index(void)
 {
@@ -90,26 +69,9 @@ unsigned int alloc_commit_index(void)
 
 void *alloc_commit_node(void)
 {
-	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
+	struct commit *c = mem_pool_alloc(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index();
 	return c;
 }
 
-static void report(const char *name, unsigned int count, size_t size)
-{
-	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
-			name, count, (uintmax_t) size);
-}
-
-#define REPORT(name, type)	\
-    report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
-
-void alloc_report(void)
-{
-	REPORT(blob, struct blob);
-	REPORT(tree, struct tree);
-	REPORT(commit, struct commit);
-	REPORT(tag, struct tag);
-	REPORT(object, union any_object);
-}
-- 
2.17.0.441.gb46fe60e1d-goog

