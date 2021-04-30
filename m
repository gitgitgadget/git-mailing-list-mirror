Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C14C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FA661476
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhD3Vlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhD3Vle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:34 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEC5C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:45 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a18so28918329qtj.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/38sFQa6zRAfOZz7FManGZbEWRjFsxK9Oe9+m5j86c=;
        b=O3RQo1uoPRW4Lhu0wYtPUfWYQc4oleeihzCqcsqyZA5ATPXiPfJi1+I2NXs5MvAYf4
         5RVnvUKkFyfTPRQuH+WaD2RBOkAKS8R/hWUgDIjHn9hsp0TKTflB9nIF9VpytaB4HNiQ
         FB4pE27evuoMaROWNXx0FK+NYpd3nGnZZ5neRYmFAufCVgeygL1TIydGCYD6PDe3kOsk
         oH+O/XLDsz2Gggj3u4SbOhdZ3JKnApuViG7CXOg26JsmXW4nA+p0gd8Exg06NLNS2zNl
         Ew42JOvVzk42OF0WA20CDglEPgx52pGBhkyj5Hf2hLquzBFNmpwlZwwEvr9bGalbZY6Z
         3pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/38sFQa6zRAfOZz7FManGZbEWRjFsxK9Oe9+m5j86c=;
        b=lpR31A4KI4UqSw7EwjNAVkeS+5ME6q++2gHmbnN5MORbP5nfmD8pR8WJJcFcJV4p4i
         w/ui9Yxcjv37eVckKwmJTIPdca2ZkT8UjXFX3NaetN2bisvS+8uFw4J8sUTrS6Hp1wOU
         69qGX38k7mRcAkmLA5mtP765GvVcm7EmMSLJioc/m5C1rSXOUB/lrnPVB21ZfT9Pkac1
         ytANKGNT2sgn8iVghp/GIjZUeFobS0PLjCE7ncQI7W9xpjXZ5Py2KaRa9TWBCEba4jQ2
         8WBC2BwLCc4uysMDQnnBSEc8ZCgaZTlGMJ8vKg54yAEW3gXrhOJwZ5NM2TTw9Rn+6OKo
         SFsg==
X-Gm-Message-State: AOAM5331tTzIudp9706fgtJseFlEhEOCiVPlV3MMOckpLvvZ7QCpxXQN
        WOoQt7rfnhv0hFscN6s5weZZIdHnb5yktw==
X-Google-Smtp-Source: ABdhPJxpNWITMRmIdvyv/ivr4QNgHmOBx/9RxmlcqVVlHicx9VFeMWV14/BCbFYcS2NSwP+oGyOnMw==
X-Received: by 2002:ac8:544d:: with SMTP id d13mr6637739qtq.93.1619818844643;
        Fri, 30 Apr 2021 14:40:44 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:44 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 1/8] make_transient_cache_entry(): optionally alloc from mem_pool
Date:   Fri, 30 Apr 2021 18:40:28 -0300
Message-Id: <f870040bfb3e73ee8cd27352b0acc65bb54be560.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow make_transient_cache_entry() to optionally receive a mem_pool
struct in which it should allocate the entry. This will be used in the
following patch, to store some transient entries which should persist
until parallel checkout finishes.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout--worker.c |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/difftool.c         |  2 +-
 cache.h                    | 11 ++++++-----
 read-cache.c               | 12 ++++++++----
 unpack-trees.c             |  2 +-
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 31e0de2f7e..289a9b8f89 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -39,7 +39,7 @@ static void packet_to_pc_item(const char *buffer, int len,
 	}
 
 	memset(pc_item, 0, sizeof(*pc_item));
-	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len);
+	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len, NULL);
 	pc_item->ce->ce_namelen = fixed_portion->name_len;
 	pc_item->ce->ce_mode = fixed_portion->ce_mode;
 	memcpy(pc_item->ce->name, variant, pc_item->ce->ce_namelen);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4c696ef480..db667d0267 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -291,7 +291,7 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_transient_cache_entry(mode, &oid, path, 2);
+	ce = make_transient_cache_entry(mode, &oid, path, 2, NULL);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL, nr_checkouts);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index ef25729d49..afacbcd581 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -323,7 +323,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_transient_cache_entry(mode, oid, path, 0);
+	ce = make_transient_cache_entry(mode, oid, path, 0, NULL);
 	ret = checkout_entry(ce, state, NULL, NULL);
 
 	discard_cache_entry(ce);
diff --git a/cache.h b/cache.h
index 148d9ab5f1..b6b42cc3f3 100644
--- a/cache.h
+++ b/cache.h
@@ -356,16 +356,17 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate,
 					   size_t name_len);
 
 /*
- * Create a cache_entry that is not intended to be added to an index.
- * Caller is responsible for discarding the cache_entry
- * with `discard_cache_entry`.
+ * Create a cache_entry that is not intended to be added to an index. If `mp`
+ * is not NULL, the entry is allocated within the given memory pool. Caller is
+ * responsible for discarding "loose" entries with `discard_cache_entry()` and
+ * the mem_pool with `mem_pool_discard(mp, should_validate_cache_entries())`.
  */
 struct cache_entry *make_transient_cache_entry(unsigned int mode,
 					       const struct object_id *oid,
 					       const char *path,
-					       int stage);
+					       int stage, struct mem_pool *mp);
 
-struct cache_entry *make_empty_transient_cache_entry(size_t name_len);
+struct cache_entry *make_empty_transient_cache_entry(size_t len, struct mem_pool *mp);
 
 /*
  * Discard cache entry.
diff --git a/read-cache.c b/read-cache.c
index 5a907af2fb..eb389ccb8f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -813,8 +813,10 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate, size_t le
 	return mem_pool__ce_calloc(find_mem_pool(istate), len);
 }
 
-struct cache_entry *make_empty_transient_cache_entry(size_t len)
+struct cache_entry *make_empty_transient_cache_entry(size_t len, struct mem_pool *mp)
 {
+	if (mp)
+		return mem_pool__ce_calloc(mp, len);
 	return xcalloc(1, cache_entry_size(len));
 }
 
@@ -848,8 +850,10 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	return ret;
 }
 
-struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct object_id *oid,
-					       const char *path, int stage)
+struct cache_entry *make_transient_cache_entry(unsigned int mode,
+					       const struct object_id *oid,
+					       const char *path, int stage,
+					       struct mem_pool *mp)
 {
 	struct cache_entry *ce;
 	int len;
@@ -860,7 +864,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct o
 	}
 
 	len = strlen(path);
-	ce = make_empty_transient_cache_entry(len);
+	ce = make_empty_transient_cache_entry(len, mp);
 
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
diff --git a/unpack-trees.c b/unpack-trees.c
index 4b77e52c6b..fa5b7ab7ee 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1034,7 +1034,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	size_t len = traverse_path_len(info, tree_entry_len(n));
 	struct cache_entry *ce =
 		is_transient ?
-		make_empty_transient_cache_entry(len) :
+		make_empty_transient_cache_entry(len, NULL) :
 		make_empty_cache_entry(istate, len);
 
 	ce->ce_mode = create_ce_mode(n->mode);
-- 
2.30.1

