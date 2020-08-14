Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A50C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D7C20716
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKCGk0Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNDCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 23:02:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E42C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so8428742ejb.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uIgFIt8Ho9VBTnemjPpMjOLiOzEVlYlY0UxocbEAnyo=;
        b=AKCGk0NgyINFFLVLGDxJKNDxOWLDR2FQQoVd9T5TAe2z2Qlu/o/lIC1TquVkcLlvAA
         TTXuDD2kTsYy0sE4gKDAdy7z+L4VvZM3vuREu8H+fdualNgN9EvJjMivtSLoL4BWE1n7
         lMRnULPvtJuZAvVq4h9GnsA5juzJsnenulcgdF7+vAkwCtdHfXH+JQ1I8jW4sH9u22Zq
         i6vt5g80VO/JIvHrFK15NXrFnNQfkq2hCDG2w9e3H33lSN7QH8MmPx6pL3Ixwg2+t4eg
         UQO70F8fxtgO0Bvgh+DAokourwTsGmxLOdACnSZqfHhLtYedB0WBl9bYEnM0eiOHagNC
         wK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uIgFIt8Ho9VBTnemjPpMjOLiOzEVlYlY0UxocbEAnyo=;
        b=NSVqsGsDM07cSgY6JSQb+FYTIlOwE/IObu3qCBHH3YwUr+eQX3Myemq1BphfewSCQa
         4N6/23BKVOIo2x/LKVmyKKNU1wZxSpJyKWaaAGpHBDmbtCe6MhA+ls35UtPnuL/jwyKe
         7IRHH7VaJ/4+POVId/WDWRwNysHGb4GPSbekE7RHhJOTmwUhAJQgbWKO4XsSBN7Fyhep
         XcdcA7VZ1YHs6UmOw0Xw0dZHJ+fpHOHIprB8QfAMfNJJ08r8g77J7Qxv1KSUOH/9LhFH
         DHC0U03eJBOqYrMQhTdDJa3l/3wXxrrsnBKRzAeLWD+EqlEI5Fd/u5PKgFpI8FB58Ucq
         uSVw==
X-Gm-Message-State: AOAM533y7PQOmEk+ZIKJP0CthR+tDYMgGcYCcVpYjMSlxuM6ed9+jQM/
        iZpfBDF+ioDDsDTf3nPrgdINidCm
X-Google-Smtp-Source: ABdhPJySBPRItU0GWL8V/a0lYoCPqTyUSi/Vhx5gKj37FmOdBVca901GaJnkZnmS9QRxRvmYHjRBaQ==
X-Received: by 2002:a17:906:7698:: with SMTP id o24mr524116ejm.182.1597374137797;
        Thu, 13 Aug 2020 20:02:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm5634782ejy.78.2020.08.13.20.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:02:17 -0700 (PDT)
Message-Id: <eae8b2923f7834f3b1d030f6eb4dc093b94da91b.1597374135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 03:02:13 +0000
Subject: [PATCH 1/3] mem-pool: add convenience functions for xstrdup and
 xstrndup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

fast-import had a special mem_pool_xstrdup() convenience function that I
want to be able to use from the new merge algorithm I am writing.  Move
it from fast-import to mem-pool, and also add a mem_pool_xstrndup()
while at it that I also want to use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c | 12 ++----------
 mem-pool.c    | 23 +++++++++++++++++++++++
 mem-pool.h    |  6 ++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ce47794db6..dd5b563950 100644
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
+	b->name = mem_pool_xstrdup(&fi_mem_pool, name);
 	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
 	b->branch_tree.versions[1].mode = S_IFDIR;
@@ -2806,7 +2798,7 @@ static void parse_new_tag(const char *arg)
 
 	t = mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
 	memset(t, 0, sizeof(struct tag));
-	t->name = pool_strdup(arg);
+	t->name = mem_pool_xstrdup(&fi_mem_pool, arg);
 	if (last_tag)
 		last_tag->next_tag = t;
 	else
diff --git a/mem-pool.c b/mem-pool.c
index a2841a4a9a..3a8c54d9df 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -102,6 +102,29 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
 	return r;
 }
 
+char *mem_pool_xstrdup(struct mem_pool *pool, const char *str)
+{
+	size_t len = strlen(str) + 1;
+	char *ret = mem_pool_alloc(pool, len);
+
+	if (!ret)
+		die("Out of memory, mem_pool_xstrdup failed");
+
+	return memcpy(ret, str, len);
+}
+
+char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len)
+{
+	size_t minlen = strnlen(str, len);
+	char *ret = mem_pool_alloc(pool, minlen+1);
+
+	if (!ret)
+		die("Out of memory, mem_pool_xstrndup failed");
+
+	ret[minlen] = '\0';
+	return memcpy(ret, str, minlen);
+}
+
 int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
 {
 	struct mp_block *p;
diff --git a/mem-pool.h b/mem-pool.h
index 999d3c3a52..fcaa2d462b 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -41,6 +41,12 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
  */
 void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
 
+/*
+ * Allocate memory from the memory pool and copy str into it.
+ */
+char *mem_pool_xstrdup(struct mem_pool *pool, const char *str);
+char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len);
+
 /*
  * Move the memory associated with the 'src' pool to the 'dst' pool. The 'src'
  * pool will be empty and not contain any memory. It still needs to be free'd
-- 
gitgitgadget

