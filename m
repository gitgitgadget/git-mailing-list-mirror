Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C0E1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeCUQnD (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:43:03 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45529 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeCUQm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:42:27 -0400
Received: by mail-qk0-f193.google.com with SMTP id s9so6095250qke.12
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wP29c83X1n+HNob5SFa0NpM8WBQ0on3QL6Ry0gis/TA=;
        b=bBM4XTI5U/Sgj76cRDhOavZSdVysAL2h5O0ynzns77WGMZWHoWu32BtuViRESHHLKy
         gQT1w/q7jPtgdn0/Pg+XeFA+z842OalQEs+APAJkHcXa02zwFrZzYk9URIV+i5+Tp6ts
         UKmVPGiqvc2zcODYfccUFre2cE1q7RhrzhJGbLwi7rbwAAAf7E3WF7nebn0Ej+9nJfhr
         eI7CnNSXQ5oMCAl1qp6EwqkKjQpBkJLQcHS3kpkq+XqO13WJwGeUk36EwYbxTZIpogT6
         IO2UaZUPiNDB94dRFRaqh3TtZL4qVUP4xw++NUY8eQAnzkL3vxcO1tPbPs6oTpORqZlR
         E1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wP29c83X1n+HNob5SFa0NpM8WBQ0on3QL6Ry0gis/TA=;
        b=XMd5fJ7POan9h11m7E3qvPyR7S5/86O71ILKMznqL3J7ia4bbh8e0WTOkFZlLKmw9G
         IaXOATk0sVyukO7ShTq8mfdm6XJUMHsgHIBuSbH80IPcgKOn5cR8zGi1jGetdbhEUdlq
         hoIXuTGW6w28+kuVE+jRwrOxgdvKRF6XqUdG4KGJQDa8vwlsDRP8N6Su98D2Fq1eHVBR
         oDO26JNnpoblf3NN1DQUdvWDgon/eO3SJw0SwFpByBTELbGRMpgv4QqBZGIo+FlHoP8i
         SKN86qCIedeNLHwQbDhgidK5c/LQUMA7NlKJbZYxHltOruG9921ZErKI6+tOyKruWlUs
         qMyQ==
X-Gm-Message-State: AElRT7HKJ3+zjeHlcDJTylaqPuaon4+gI3KjOA6k703hkRiHGrD+0rqw
        ZRpit1StM96yE587uDQ+EZ9W8spI
X-Google-Smtp-Source: AG47ELt8UgopLBAtpKryARXt49iWwQ7U/VSHyilUpj9ZbhU/RD5es1jYHmrzrhVoYESk8UukivKFuw==
X-Received: by 10.55.17.105 with SMTP id b102mr14006391qkh.136.1521650546839;
        Wed, 21 Mar 2018 09:42:26 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id m24sm3235584qtc.81.2018.03.21.09.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:42:26 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 2/3] Introduce a reusable memory pool type
Date:   Wed, 21 Mar 2018 12:41:51 -0400
Message-Id: <20180321164152.204869-3-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Extract the existing memory pool logic used by fast-import into a
generalized component. This memory pool component can then be used by
other components that need this functionality.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Makefile   |   1 +
 mem-pool.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h |  48 +++++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

diff --git a/Makefile b/Makefile
index a1d8775adb..1e142b1dd9 100644
--- a/Makefile
+++ b/Makefile
@@ -832,6 +832,7 @@ LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
+LIB_OBJS += mem-pool.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
diff --git a/mem-pool.c b/mem-pool.c
new file mode 100644
index 0000000000..3028bc3c67
--- /dev/null
+++ b/mem-pool.c
@@ -0,0 +1,130 @@
+/*
+ * Memory Pool implementation logic.
+ */
+
+#include "cache.h"
+#include "mem-pool.h"
+
+#define MIN_ALLOC_GROWTH_SIZE 1024 * 1024
+
+struct mp_block {
+	struct mp_block *next_block;
+	char *next_free;
+	char *end;
+	uintmax_t space[FLEX_ARRAY];
+};
+
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t block_alloc)
+{
+	struct mp_block *p;
+
+	/* Round up to a 'uintmax_t' alignment */
+	if (block_alloc & (sizeof(uintmax_t) - 1))
+		block_alloc += sizeof(uintmax_t) - (block_alloc & (sizeof(uintmax_t) - 1));
+
+	mem_pool->pool_alloc += block_alloc;
+
+	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+
+	p->next_block = mem_pool->mp_block;
+	p->next_free = (char *)p->space;
+	p->end = p->next_free + block_alloc;
+	mem_pool->mp_block = p;
+
+	return p;
+}
+
+void mem_pool_init(struct mem_pool **mem_pool, size_t block_alloc, size_t initial_size)
+{
+	if (!(*mem_pool))
+	{
+		if (block_alloc < MIN_ALLOC_GROWTH_SIZE)
+			block_alloc = MIN_ALLOC_GROWTH_SIZE;
+
+		*mem_pool = xmalloc(sizeof(struct mem_pool));
+		(*mem_pool)->pool_alloc = 0;
+		(*mem_pool)->mp_block = 0;
+		(*mem_pool)->block_alloc = block_alloc;
+
+		if (initial_size > 0)
+			mem_pool_alloc_block((*mem_pool), initial_size);
+	}
+}
+
+void mem_pool_discard(struct mem_pool *mem_pool)
+{
+	struct mp_block *block, *block_to_free;
+	for (block = mem_pool->mp_block; block;)
+	{
+		block_to_free = block;
+		block = block->next_block;
+		free(block_to_free);
+	}
+
+	free(mem_pool);
+}
+
+void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
+{
+	struct mp_block *p;
+	void *r;
+
+	/* Round up to a 'uintmax_t' alignment */
+	if (len & (sizeof(uintmax_t) - 1))
+		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+
+	p = mem_pool->mp_block;
+
+	if (p &&
+	   (p->end - p->next_free < len)) {
+		for (p = p->next_block; p; p = p->next_block)
+			if (p->end - p->next_free >= len)
+				break;
+	}
+
+	if (!p) {
+		if (len >= ((mem_pool->block_alloc - sizeof(struct mp_block)) / 2)) {
+			p = mem_pool_alloc_block(mem_pool, len);
+		}
+		else
+			p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
+	}
+
+	r = p->next_free;
+	p->next_free += len;
+	return r;
+}
+
+void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
+{
+	size_t len = st_mult(count, size);
+	void *r = mem_pool_alloc(mem_pool, len);
+	memset(r, 0, len);
+	return r;
+}
+
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+{
+	struct mp_block *p;
+	for (p = mem_pool->mp_block; p; p = p->next_block)
+		if ((mem >= ((void *)p->space)) &&
+		    (mem < ((void *)p->end)))
+			return 1;
+
+	return 0;
+}
+
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
+{
+	struct mp_block **tail = &dst->mp_block;
+	/* find pointer of dst's last block (if any) */
+	while (*tail)
+		tail = &(*tail)->next_block;
+
+	/* append the blocks from src to dst */
+	*tail = src->mp_block;
+
+	dst->pool_alloc += src->pool_alloc;
+	src->pool_alloc = 0;
+	src->mp_block = NULL;
+}
diff --git a/mem-pool.h b/mem-pool.h
new file mode 100644
index 0000000000..902ef8caf2
--- /dev/null
+++ b/mem-pool.h
@@ -0,0 +1,48 @@
+#ifndef MEM_POOL_H
+#define MEM_POOL_H
+
+struct mem_pool {
+	struct mp_block *mp_block;
+
+	/* The size of new blocks to grow the pool by. */
+	size_t block_alloc;
+
+	/* The total amount of memory allocated by the pool. */
+	size_t pool_alloc;
+};
+
+/*
+ * Initialize mem_pool with specified parameters for initial size and
+ * how much to grow when a larger memory block is required.
+ */
+void mem_pool_init(struct mem_pool **mem_pool, size_t alloc_growth_size, size_t initial_size);
+
+/*
+ * Move the memory associated with the 'src' pool to the 'dst' pool. The 'src'
+ * pool will be empty and not contain any memory. It still needs to be free'd
+ * with a call to `mem_pool_discard`.
+ */
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
+
+/*
+ * Discard a memory pool and free all the memory it is responsible for.
+ */
+void mem_pool_discard(struct mem_pool *mem_pool);
+
+/*
+ * Alloc memory from the mem_pool.
+ */
+void *mem_pool_alloc(struct mem_pool *pool, size_t len);
+
+/*
+ * Allocate and zero memory from the memory pool.
+ */
+void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
+
+/*
+ * Check if a memory pointed at by 'mem' is part of the range of
+ * memory managed by the specified mem_pool.
+ */
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
+
+#endif
-- 
2.14.3

