Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C462C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CD4613BC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhEDQ2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhEDQ2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 12:28:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30BCC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 09:27:47 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n22so6739033qtk.9
        for <git@vger.kernel.org>; Tue, 04 May 2021 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VybqBhJ09WiaZ1uEY5aPrt2z+Ibg179/hVRuauV7WIM=;
        b=eCPyO/xqcDSA4qms51jkJhwG/tT7sjsg+bFWjsMYfrC8uVPoSJADVpIdHZJK8v6Tg7
         HpDMDAsgDHaBPCfl3PixKMhPV6xi4XlGmnZ6236JFX3CW8/lT3qFzScUzta9AZUCigKU
         y48Tx9fHTnmbLBoghpkhBWhAwljWuyvSKPRDbOpRRfpmwu5WwRzNd0zEwoz39NfQlmH0
         G192/DMuNjGhlFb3Q3Sv7vP1LS6VFej/cLxMUbhAA9GxoCPj6T3k1IBg7/esBkg/mCHO
         7/W8B9Q3E/ET7ln+SDN2iq74lT8qyaaIyhha5bR0PhZl+Xga6HToLAouGI2xJmv9EXWZ
         d/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VybqBhJ09WiaZ1uEY5aPrt2z+Ibg179/hVRuauV7WIM=;
        b=n+YpGyxhHCJj1geCGOqwrzyaRk2LclSdLhprsldhuK5o33YplQ/mlmZkQNCQOzalz0
         IoQDpLRanyMFoW2m0MeOFrIFfaqZK9qPOPliVE+TKwymZTQEpGFJ31BBXhktUCRKNuv9
         vU30ZNPmP0k3aKNZxF2HmxAiNASAxZ2FShbmgD8RHwUiPXfu8YQrPAt1bvZQB7BXflwR
         XG4BC073RPQtV05vFuohF8lLES8bZ5ZdyYmY+9mznjPYPyWP/duQrBaGfSCSgw6fLSv/
         zKkmbknaG9pEka8SZ4kErXwdPKN91amqj9VzWMhlD0EtPw2BY9lAWMvMCwo7qLu8eMP9
         Mgkw==
X-Gm-Message-State: AOAM530Cbp1sZ+Wq6yiCz8CZ+RAuiLHm2lcYgnwxY99BMBRSwVCbJcpE
        ZGM3AsvdIPnoAFdO6TcKrm9hr3CItMA77A==
X-Google-Smtp-Source: ABdhPJwudX0U0pohfCTdI4QXS5bJfeba9YlvyhZ3LRMZPkeB5GcL9gG3D9GS8+hBLywSMObgovIkzA==
X-Received: by 2002:ac8:7314:: with SMTP id x20mr23126397qto.320.1620145666756;
        Tue, 04 May 2021 09:27:46 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x19sm11202689qkx.107.2021.05.04.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:27:46 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        stolee@gmail.com, tboegi@web.de
Subject: [PATCH v3 1/8] make_transient_cache_entry(): optionally alloc from mem_pool
Date:   Tue,  4 May 2021 13:27:28 -0300
Message-Id: <bf6c7114aa241fc7a8d6254545b4a37ac21e5bc4.1620145501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1620145501.git.matheus.bernardino@usp.br>
References: <cover.1620145501.git.matheus.bernardino@usp.br>
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
 cache.h                    | 14 +++++++++-----
 read-cache.c               | 14 ++++++++++----
 unpack-trees.c             |  2 +-
 6 files changed, 23 insertions(+), 13 deletions(-)

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
index 5bd9128d1a..a597f31d53 100644
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
index 0202a43052..89334b77fb 100644
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
index b785ffb383..0e2b952647 100644
--- a/cache.h
+++ b/cache.h
@@ -370,16 +370,20 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate,
 					   size_t name_len);
 
 /*
- * Create a cache_entry that is not intended to be added to an index.
- * Caller is responsible for discarding the cache_entry
- * with `discard_cache_entry`.
+ * Create a cache_entry that is not intended to be added to an index. If
+ * `ce_mem_pool` is not NULL, the entry is allocated within the given memory
+ * pool. Caller is responsible for discarding "loose" entries with
+ * `discard_cache_entry()` and the memory pool with
+ * `mem_pool_discard(ce_mem_pool, should_validate_cache_entries())`.
  */
 struct cache_entry *make_transient_cache_entry(unsigned int mode,
 					       const struct object_id *oid,
 					       const char *path,
-					       int stage);
+					       int stage,
+					       struct mem_pool *ce_mem_pool);
 
-struct cache_entry *make_empty_transient_cache_entry(size_t name_len);
+struct cache_entry *make_empty_transient_cache_entry(size_t len,
+						     struct mem_pool *ce_mem_pool);
 
 /*
  * Discard cache entry.
diff --git a/read-cache.c b/read-cache.c
index 72a1d339c9..86f95fe62e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -839,8 +839,11 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate, size_t le
 	return mem_pool__ce_calloc(find_mem_pool(istate), len);
 }
 
-struct cache_entry *make_empty_transient_cache_entry(size_t len)
+struct cache_entry *make_empty_transient_cache_entry(size_t len,
+						     struct mem_pool *ce_mem_pool)
 {
+	if (ce_mem_pool)
+		return mem_pool__ce_calloc(ce_mem_pool, len);
 	return xcalloc(1, cache_entry_size(len));
 }
 
@@ -874,8 +877,11 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	return ret;
 }
 
-struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct object_id *oid,
-					       const char *path, int stage)
+struct cache_entry *make_transient_cache_entry(unsigned int mode,
+					       const struct object_id *oid,
+					       const char *path,
+					       int stage,
+					       struct mem_pool *ce_mem_pool)
 {
 	struct cache_entry *ce;
 	int len;
@@ -886,7 +892,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct o
 	}
 
 	len = strlen(path);
-	ce = make_empty_transient_cache_entry(len);
+	ce = make_empty_transient_cache_entry(len, ce_mem_pool);
 
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
diff --git a/unpack-trees.c b/unpack-trees.c
index 7a1804c314..f88a69f8e7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1038,7 +1038,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	size_t len = traverse_path_len(info, tree_entry_len(n));
 	struct cache_entry *ce =
 		is_transient ?
-		make_empty_transient_cache_entry(len) :
+		make_empty_transient_cache_entry(len, NULL) :
 		make_empty_cache_entry(istate, len);
 
 	ce->ce_mode = create_ce_mode(n->mode);
-- 
2.30.1

