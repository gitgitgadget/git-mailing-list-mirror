Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759BAC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5496920639
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga9Qz/dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgHOWEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgHOVuz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C701C0F26D8
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so10996637wrs.11
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kq93Opb3Of8+871dcjR152dIowralAE8w6S6qrlJb3A=;
        b=ga9Qz/dxK6MbhVZ3aFYnfC7jc0ibRP7SfKRsR0R9e39l+x6+JAcOq11KuTZh3k38dV
         uwM4HG73IhvpOfQyqyZmjW3mAX40fBX1pux0psTFamm27+VpRj29grdTcHLyzSL6L0hr
         n2D0dEOBpBj3w9oI1+xwlmlFQEmaiEFcQ1U5BXxNjRQA6YjDv9PC21hV4x4jzj07qkh/
         +5hHMDmasNTZNIwszChLBuTpCwjSEVtdQepm/TusMNA1camN/X4NsiTeGBZaWWIwbp+M
         v2DzB7JUI9F6iRIjGrB4UEwRyyGHe7i6s9FGBCAbM6vD7paJUk//RtlUXvlohQNY8Tzt
         Q+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kq93Opb3Of8+871dcjR152dIowralAE8w6S6qrlJb3A=;
        b=Q9of8ArZLE4LPfTPIYrIxUsRREMqCy00I0Q8I4Cb+EJmQcOnZ+VtynzLDiPY3j8nD9
         PjvCFhGfhRA64wL0QwjqFw9pvGZbKZa0xxQzMehF/yL2ktOIAxjQhybmq5McaNMgpg03
         b7m1wqprDie2Rrfs6hkV9iVNE5U49CT8l37nW1Rdfgzvz5cJlbL+OLlaRjXBpFQj9+5a
         +KUvoJkp5pGVuq237MR6EJYFqTwLYWAdeDvECix7b51Excc2zT21SaGgw8VBuQpIbEk8
         JkFkeA6LW3BrLiP9IKXgpv4NItcho28fMLGKYG5W9ZtwNcT4q1sJ4rLMrvyos+ionndK
         cx1g==
X-Gm-Message-State: AOAM532uflaO/UPIEgNijspQ4bCjfYfF09Xx6HeHhC7KmT7XeRaSKfRV
        1viysv/zL1RpveRiSRm64mzhVBRb0b4=
X-Google-Smtp-Source: ABdhPJxbizw/9qIrZuh5g9B6LB0HAQ6NPamob8VcQPpQOTVKIwsvoKb1EWbv158HZsSxlBi95Kr+bw==
X-Received: by 2002:a5d:6047:: with SMTP id j7mr7509554wrt.315.1597513080263;
        Sat, 15 Aug 2020 10:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g145sm30018304wmg.23.2020.08.15.10.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:37:59 -0700 (PDT)
Message-Id: <e7f6bf8a8ce441dcbfcf36b4043c23066464573a.1597513078.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
References: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
        <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 17:37:55 +0000
Subject: [PATCH v3 1/3] mem-pool: add convenience functions for strdup and
 strndup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

fast-import had a special mem_pool_strdup() convenience function that I
want to be able to use from the new merge algorithm I am writing.  Move
it from fast-import to mem-pool, and also add a mem_pool_strndup()
while at it that I also want to use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c | 12 ++----------
 mem-pool.c    | 18 ++++++++++++++++++
 mem-pool.h    |  6 ++++++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ce47794db6..c45fe7474c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -526,14 +526,6 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
-static char *pool_strdup(const char *s)
-{
-	size_t len = strlen(s) + 1;
-	char *r = mem_pool_alloc(&fi_mem_pool, len);
-	memcpy(r, s, len);
-	return r;
-}
-
 static void insert_mark(struct mark_set *s, uintmax_t idnum, struct object_entry *oe)
 {
 	while ((idnum >> s->shift) >= 1024) {
@@ -615,7 +607,7 @@ static struct branch *new_branch(const char *name)
 		die("Branch name doesn't conform to GIT standards: %s", name);
 
 	b = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
-	b->name = pool_strdup(name);
+	b->name = mem_pool_strdup(&fi_mem_pool, name);
 	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
 	b->branch_tree.versions[1].mode = S_IFDIR;
@@ -2806,7 +2798,7 @@ static void parse_new_tag(const char *arg)
 
 	t = mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
 	memset(t, 0, sizeof(struct tag));
-	t->name = pool_strdup(arg);
+	t->name = mem_pool_strdup(&fi_mem_pool, arg);
 	if (last_tag)
 		last_tag->next_tag = t;
 	else
diff --git a/mem-pool.c b/mem-pool.c
index a2841a4a9a..020b51e0c5 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -102,6 +102,24 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
 	return r;
 }
 
+char *mem_pool_strdup(struct mem_pool *pool, const char *str)
+{
+	size_t len = strlen(str) + 1;
+	char *ret = mem_pool_alloc(pool, len);
+
+	return memcpy(ret, str, len);
+}
+
+char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len)
+{
+	char *p = memchr(str, '\0', len);
+	size_t actual_len = (p ? p - str : len);
+	char *ret = mem_pool_alloc(pool, actual_len+1);
+
+	ret[actual_len] = '\0';
+	return memcpy(ret, str, actual_len);
+}
+
 int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
 {
 	struct mp_block *p;
diff --git a/mem-pool.h b/mem-pool.h
index 999d3c3a52..ca062c9070 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -41,6 +41,12 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
  */
 void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
 
+/*
+ * Allocate memory from the memory pool and copy str into it.
+ */
+char *mem_pool_strdup(struct mem_pool *pool, const char *str);
+char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len);
+
 /*
  * Move the memory associated with the 'src' pool to the 'dst' pool. The 'src'
  * pool will be empty and not contain any memory. It still needs to be free'd
-- 
gitgitgadget

