Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38D6C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAF120774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxDUkhws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgHNGA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgHNGA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 02:00:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA12C061383
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so6952414wmi.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WtXZWh6pt0FaPHABN/FTBHRCSSbwwXDrKtHLlwlWOGo=;
        b=oxDUkhws0cw4f89ECkiYD2DwfWbCL79nfALEbkPFIkC2roBLy4JcuB0n5tCxaDWDZV
         QLYm/EjtD83Fk3sJtoWLMsZJrQqDnx9ap35j+EX8uCv88zzGNmNN3aoR7/5lRYgInGky
         XadQ3JxAeR4/qy+tWdNI2MceogD1ph+FCVRVOuBsGDwpeLwbFnGTQ1A8jmosule7anfP
         LszUUbS21f6Fr+++LT0cwMEUloAvjJodeDwxP1/e49NwziFC0A5VuBi23atnxPisvLIV
         0dFo5Uvn/v/gWlS4zHIKQPPw0fIEfvO7SSRj/F30XZXpu/vLbqXLsDHrdUiFULZwMsod
         xwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WtXZWh6pt0FaPHABN/FTBHRCSSbwwXDrKtHLlwlWOGo=;
        b=Hj3ltQvYkM+k41Rw7+TmKhjnysQ41VhMlUOWTHnIpFvG6XuH8Zpxt+j06BLjq8UF5U
         FFwIEcRbHhZetN/TXpfPsYE9ZBsvl5vdPEgJMgVjLSk0vaiOhjFY4ziuECxP6brOFd4v
         qktlWQVptV+94wZqlcegiIHUHGkJh39vtolkjM+TOdn/isn1SAljVSYBDVZyZ3Vl6i0q
         We50v1qTHlJ4zgpfc+3XRq7zZaUZwJoxZFsXEbv8qje9WWZWO8OPk0FxAqdpPcOVdipY
         JTzgLs1qAgfS/8rbi1PrdC/GpElg2LdIZb6Uw+GrLRVF19dQDu2TCeykNXnH9dpc2d7z
         WHfA==
X-Gm-Message-State: AOAM533odLeg+tjvwX2epEgjXdYfb6D+YlfG7Tb4BwrGZS2xf8jeWkRg
        TumdIRTVwMM3vdte/gUuXHDy9qXVPQc=
X-Google-Smtp-Source: ABdhPJxdbktd5jZbUIybUlCMitzdGdTkIzrdl08SIXhCnhfo5E98+AeSjxuZ7X2CPRwqpZeBPJFreQ==
X-Received: by 2002:a1c:e0c2:: with SMTP id x185mr987602wmg.124.1597384824310;
        Thu, 13 Aug 2020 23:00:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm14494479wra.81.2020.08.13.23.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:00:23 -0700 (PDT)
Message-Id: <616402c64e1e01f88e962cf88f4ed1307d986a04.1597384820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
        <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 06:00:20 +0000
Subject: [PATCH v2 3/3] mem-pool: use consistent pool variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

About half the function declarations in mem-pool.h used 'struct mem_pool
*pool', while the other half used 'struct mem_pool *mem_pool'.  Make the
code a bit more consistent by just using 'pool' in preference to
'mem_pool' everywhere.

No behavioral changes included; this is just a mechanical rename (though
a line or two was rewrapped as well).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 mem-pool.c | 40 +++++++++++++++++++++-------------------
 mem-pool.h |  4 ++--
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 305bcd3542..593605fce2 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -12,11 +12,13 @@
  * `insert_after`. If `insert_after` is NULL, then insert block at the
  * head of the linked list.
  */
-static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t block_alloc, struct mp_block *insert_after)
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *pool,
+					     size_t block_alloc,
+					     struct mp_block *insert_after)
 {
 	struct mp_block *p;
 
-	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
+	pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
 	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
 
 	p->next_free = (char *)p->space;
@@ -26,8 +28,8 @@ static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t b
 		p->next_block = insert_after->next_block;
 		insert_after->next_block = p;
 	} else {
-		p->next_block = mem_pool->mp_block;
-		mem_pool->mp_block = p;
+		p->next_block = pool->mp_block;
+		pool->mp_block = p;
 	}
 
 	return p;
@@ -42,11 +44,11 @@ void mem_pool_init(struct mem_pool *pool, size_t initial_size)
 		mem_pool_alloc_block(pool, initial_size, NULL);
 }
 
-void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
+void mem_pool_discard(struct mem_pool *pool, int invalidate_memory)
 {
 	struct mp_block *block, *block_to_free;
 
-	block = mem_pool->mp_block;
+	block = pool->mp_block;
 	while (block)
 	{
 		block_to_free = block;
@@ -58,11 +60,11 @@ void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 		free(block_to_free);
 	}
 
-	mem_pool->mp_block = NULL;
-	mem_pool->pool_alloc = 0;
+	pool->mp_block = NULL;
+	pool->pool_alloc = 0;
 }
 
-void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
+void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 {
 	struct mp_block *p = NULL;
 	void *r;
@@ -71,15 +73,15 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 
-	if (mem_pool->mp_block &&
-	    mem_pool->mp_block->end - mem_pool->mp_block->next_free >= len)
-		p = mem_pool->mp_block;
+	if (pool->mp_block &&
+	    pool->mp_block->end - pool->mp_block->next_free >= len)
+		p = pool->mp_block;
 
 	if (!p) {
-		if (len >= (mem_pool->block_alloc / 2))
-			return mem_pool_alloc_block(mem_pool, len, mem_pool->mp_block);
+		if (len >= (pool->block_alloc / 2))
+			return mem_pool_alloc_block(pool, len, pool->mp_block);
 
-		p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc, NULL);
+		p = mem_pool_alloc_block(pool, pool->block_alloc, NULL);
 	}
 
 	r = p->next_free;
@@ -87,10 +89,10 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 	return r;
 }
 
-void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
+void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size)
 {
 	size_t len = st_mult(count, size);
-	void *r = mem_pool_alloc(mem_pool, len);
+	void *r = mem_pool_alloc(pool, len);
 	memset(r, 0, len);
 	return r;
 }
@@ -118,12 +120,12 @@ char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len)
 	return memcpy(ret, str, minlen);
 }
 
-int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+int mem_pool_contains(struct mem_pool *pool, void *mem)
 {
 	struct mp_block *p;
 
 	/* Check if memory is allocated in a block */
-	for (p = mem_pool->mp_block; p; p = p->next_block)
+	for (p = pool->mp_block; p; p = p->next_block)
 		if ((mem >= ((void *)p->space)) &&
 		    (mem < ((void *)p->end)))
 			return 1;
diff --git a/mem-pool.h b/mem-pool.h
index a55ee4bc38..022b3097e9 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -29,7 +29,7 @@ void mem_pool_init(struct mem_pool *pool, size_t initial_size);
 /*
  * Discard all the memory the memory pool is responsible for.
  */
-void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory);
+void mem_pool_discard(struct mem_pool *pool, int invalidate_memory);
 
 /*
  * Alloc memory from the mem_pool.
@@ -58,6 +58,6 @@ void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
  * Check if a memory pointed at by 'mem' is part of the range of
  * memory managed by the specified mem_pool.
  */
-int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
+int mem_pool_contains(struct mem_pool *pool, void *mem);
 
 #endif
-- 
gitgitgadget
