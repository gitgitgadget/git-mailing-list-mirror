Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A65C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8F122268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQHByRsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKBSzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBSz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE7C061A4B
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w1so15868549wrm.4
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oxdzbg13YO8U12UWlzUNnE5Q1NvcmWK9n+pCvBDtaLE=;
        b=SQHByRsc7tESNX590LsRxOQgAUY1klxKjdNYpK3e2OUMfdE65VjAWbxvipP7ZleaGA
         RQngreGCXCfH0eomBJBhDgMyGm4+L9CU42WW1m0TrestPQ1fEPKXSiH88i1bkKC0jxtY
         UeB+rIBaLclE+iwLD5YuUhaVf0vXc7lgpTE+35fkyZ9+mzwVIhjH98p0v8XittNSLPkW
         MgvWLvB+FHjNNq6lepF3Duzb0PBqUg5zYVuyexLyLVepKki7Q3A4PR5RbVyuQGhR9jlI
         yIeRAbgNDmpw9Ya1N0inkyNaY1cFOkUiGgmOWR+dhflhp2aAINpQWDbU9Hr4IcbampOe
         PSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Oxdzbg13YO8U12UWlzUNnE5Q1NvcmWK9n+pCvBDtaLE=;
        b=qYm2VwA4c6C639/RfWsQtrVygr+uOgdCacjoGdRlw7BE0eNQg8EePOs89T4QLuh1pG
         4PY09anqNQkjwfQTr0tqsWHNKvHrdbb5BsMoTXvD9qPq/Cr6do32pA4E7lUBOyV35G8A
         DmCVB+PZPqLDFxVSbXSN7YMztmtfjW26fD4czd7xB4DOgtq22EESumBVuffgqPq1LoBh
         XPVqgvJy5Vm7Z9eo0t9G+nIdDoM5HWVDIBE58nUczxYFCkkgxGvUmG0+KnxwSdjr8HgN
         EVYpAFdeQgA7k+kyjJmrKMDr1KwLc/6hBpRwnM6vBYH2F9I5TC9oIGEV5hVUTFSqoo8/
         dkng==
X-Gm-Message-State: AOAM533TTkSc2MVxNRvgzte014+VfgC0TrvpUluurWavI5WGpklcritq
        m6kKarWWZ9uI05MTYaacGCbMTlzZ+DE=
X-Google-Smtp-Source: ABdhPJzvE/sFEwQK1ZA1thimKsUzU965KnGKKtRX/DxYiceM2tZXJcWQB5v9cULqfE4qqa/GrsO7lw==
X-Received: by 2002:adf:e610:: with SMTP id p16mr15447335wrm.302.1604343325643;
        Mon, 02 Nov 2020 10:55:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x22sm427042wmj.25.2020.11.02.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:25 -0800 (PST)
Message-Id: <7f93cbb525704c0bd254181082e3ed1a2782a2d2.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:12 +0000
Subject: [PATCH v3 12/13] strmap: take advantage of FLEXPTR_ALLOC_STR when
 relevant
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

By default, we do not use a mempool and strdup_strings is true; in this
case, we can avoid both an extra allocation and an extra free by just
over-allocating for the strmap_entry leaving enough space at the end to
copy the key.  FLEXPTR_ALLOC_STR exists for exactly this purpose, so
make use of it.

Also, adjust the case when we are using a memory pool and strdup_strings
is true to just do one allocation from the memory pool instead of two so
that the strmap_clear() and strmap_remove() code can just avoid freeing
the key in all cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 35 ++++++++++++++++++-----------------
 strmap.h |  1 +
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/strmap.c b/strmap.c
index 34bca92522..9abd47fd4b 100644
--- a/strmap.c
+++ b/strmap.c
@@ -59,11 +59,8 @@ static void strmap_free_entries_(struct strmap *map, int free_values)
 	hashmap_for_each_entry(&map->map, &iter, e, ent) {
 		if (free_values)
 			free(e->value);
-		if (!map->pool) {
-			if (map->strdup_strings)
-				free((char*)e->key);
+		if (!map->pool)
 			free(e);
-		}
 	}
 }
 
@@ -88,16 +85,23 @@ void *strmap_put(struct strmap *map, const char *str, void *data)
 		old = entry->value;
 		entry->value = data;
 	} else {
-		const char *key = str;
-
-		entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
-				  : xmalloc(sizeof(*entry));
+		if (map->strdup_strings) {
+			if (!map->pool) {
+				FLEXPTR_ALLOC_STR(entry, key, str);
+			} else {
+				/* Remember +1 for nul byte twice below */
+				size_t len = strlen(str);
+				entry = mem_pool_alloc(map->pool,
+					       st_add3(sizeof(*entry), len, 1));
+				memcpy(entry->keydata, str, len+1);
+			}
+		} else if (!map->pool) {
+			entry = xmalloc(sizeof(*entry));
+		} else {
+			entry = mem_pool_alloc(map->pool, sizeof(*entry));
+		}
 		hashmap_entry_init(&entry->ent, strhash(str));
-
-		if (map->strdup_strings)
-			key = map->pool ? mem_pool_strdup(map->pool, str)
-					: xstrdup(str);
-		entry->key = key;
+		entry->key = map->strdup_strings ? entry->keydata : str;
 		entry->value = data;
 		hashmap_add(&map->map, &entry->ent);
 	}
@@ -130,11 +134,8 @@ void strmap_remove(struct strmap *map, const char *str, int free_value)
 		return;
 	if (free_value)
 		free(ret->value);
-	if (!map->pool) {
-		if (map->strdup_strings)
-			free((char*)ret->key);
+	if (!map->pool)
 		free(ret);
-	}
 }
 
 void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
diff --git a/strmap.h b/strmap.h
index 6ffa6afb6a..0dd80b276e 100644
--- a/strmap.h
+++ b/strmap.h
@@ -14,6 +14,7 @@ struct strmap_entry {
 	struct hashmap_entry ent;
 	const char *key;
 	void *value;
+	char keydata[FLEX_ARRAY]; /* if strdup_strings=1, key == &keydata[0] */
 };
 
 int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
-- 
gitgitgadget

