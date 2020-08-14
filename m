Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ADEC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DA920774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQcX4Mxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHNGAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgHNGAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 02:00:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA8C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so7299456wrl.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xSpUs6GBGHA0Z7gRgI7p2cQUrYpeal/uZZpC6dTpAfk=;
        b=HQcX4MxkgLm290f3RfVTx1IL4JH9vjcKLTguIkOHhrmYQHPPl9PZtL8Ed1kFPhHrpS
         nKPS7Z2R66R1Eyme7ZaKSku3WXrkuek+A3SUBFoy7H2/2UEWo+ocTo2Ot/tCG7mpAMos
         LYE822SMvXT/cgMnRwNBV2kjwRNcfZ5MQye9/zqWPrsK5M+WOfhLaHKQjJGhEe5AZZom
         m8FwQaUhtpqDDTSYezQ6r2Nyjbayyie921xJ8CLYt9yZet258ZpEz78+6N5B+iDICYon
         evWRMcUAWGYWN8mGKFEWhjPE46OxcetaB/ZHDG0GjA/IYZ2iscLNzOKUn9bMFNGgp3yF
         vJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xSpUs6GBGHA0Z7gRgI7p2cQUrYpeal/uZZpC6dTpAfk=;
        b=bB6fRrYjXXjFrs5zY4Ehn8ZaYUXgxP9kC5HEbG1K3MymcOTxblZW6KMwI5eYoQ8mKx
         7ndCg77UJ6mOQIcHXrtxYyvjCfJ0404ez9incnPenHxmhI4Tc3Kw+w6tl2m8K/KeYWDl
         Q+umEEg+oPgpJrKWYLNZwU3/hU3dR9DEU3gQnFx2M8MFrVKqeCng4SMD967KZdHePxIC
         NHoXHutnXCC0TeuVgEu6SJe/8/zoH6SdunV7FIIUilgU448/xYHk79s7FffjFsQpwkf9
         V6OxDUNX0T6ZvP8x0vwaxZS5GkAAlB2B+h0PKUfnyoUlqsLjpxKhScjsLZczrA8HB9tH
         N53Q==
X-Gm-Message-State: AOAM531cKHhCOtB8nj8yJVS2pRK1yXGO3rP9A5oXackvKteSSnGnaKIW
        dSIEDkHafJLXMJrBF2axRy3CfiOV3D4=
X-Google-Smtp-Source: ABdhPJyC+I0pl19v6hsuHvKMHFCZzESQfAVTdMkBx3DUEhh9hWGpON0qw1+UbTjxLTeehzNJSVf6Dg==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr1257017wrq.166.1597384822630;
        Thu, 13 Aug 2020 23:00:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w64sm14127089wmb.26.2020.08.13.23.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:00:22 -0700 (PDT)
Message-Id: <6d679c5b46541208f5fa714174555ff0dc756b9a.1597384820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
        <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 06:00:18 +0000
Subject: [PATCH v2 1/3] mem-pool: add convenience functions for xstrdup and
 xstrndup
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
index a2841a4a9a..33fda1c411 100644
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
+		die(_("mem_pool_xstrdup: out of memory"));
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
+		die(_("mem_pool_xstrndup: out of memory"));
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

