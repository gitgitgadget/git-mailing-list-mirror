Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78055C56201
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F18020738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="xEnGyMVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgJ2CQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgJ2CQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB1C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f93so962198qtb.10
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYmw0wbugerHFiIop6aY7/UBduBtI0oJMxDOPf0MwGM=;
        b=xEnGyMVIOUVJwNhO4qOwoMIRwcMbdJyI9M5EAowWGw+BI08iRSyW1ncm8ImLEGdjIv
         4u9AxjPxSIyMJNsG6pMYEG47fkFxFjauP3wrWG0Yu1MjggsuArM7dn9CAgfej9bdJOnH
         t+GKAFkpI1hFOSDyI1dseJexrO0+HP6oh02POKRCt1UfAf7XMgrChnDmLqYLBpJ2st3j
         +3vVc1VEGJCu6Ps9xwR4iwfqL3EboiYRyTlc20zZpwuNzDiS2TL8NT3jll+48bZFvHJy
         5PabbmWfYtPadiSeoKS0rkumP3gr6jqXQmFJqpHXysxiF1C7Ia3ern1lYxe+6i+ZfdAj
         jxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYmw0wbugerHFiIop6aY7/UBduBtI0oJMxDOPf0MwGM=;
        b=WgecelHJvFGGDL6voGVCMRX4FrzZFJVLr1WQ/1L09yF2HMbrNkM5W+hkM1e7vZ/BdM
         o81BFG/vbcQpnlPd6BlJmSO87GxlO/CLsSFg9GIPaZdp29BZQX8s3WB9cKaPXAHSOf4l
         TYoGulnuyjq3uhOsZHcyAbUgWJA7i9ne9AJjTk7pgBh79rSTKfQCfo5xHbcXzbbfL6DK
         uXLvIsWdS+4qgtCCjvB3SLSF/Zk2sO2wJgzy0rjmBUd1NJ0nAJKE4kfoyEyWGua1f8xc
         Urh4TJWQFD5Jti25WaiC1p9SHxtRdlmfzDXQcgHHL2zUo+J+gnS1eypKJN67EjUMDPmT
         qg7w==
X-Gm-Message-State: AOAM531yTI4bjSdWevJ/MwtbqDFqDG25/oum7SbbSAe+tmaeGgZacIFZ
        k7exfJjBHlikYHXC1k0jKeAkWViOQKojyQ==
X-Google-Smtp-Source: ABdhPJxgjklgBbK0vboaQYijRAwbxP5QY435m0Wjl58SJPqO1gF/DBB9RGf8O/rIXTRtD/uadY1IDA==
X-Received: by 2002:aed:2bc4:: with SMTP id e62mr1777517qtd.26.1603937771113;
        Wed, 28 Oct 2020 19:16:11 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:10 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 13/19] make_transient_cache_entry(): optionally alloc from mem_pool
Date:   Wed, 28 Oct 2020 23:14:50 -0300
Message-Id: <da99b671e6dfcdc0f36ed0277154d63dd7f23e70.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
 builtin/checkout--helper.c |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/difftool.c         |  2 +-
 cache.h                    | 10 +++++-----
 read-cache.c               | 12 ++++++++----
 unpack-trees.c             |  2 +-
 6 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout--helper.c b/builtin/checkout--helper.c
index 67fe37cf11..9646ed9eeb 100644
--- a/builtin/checkout--helper.c
+++ b/builtin/checkout--helper.c
@@ -38,7 +38,7 @@ static void packet_to_pc_item(char *line, int len,
 	}
 
 	memset(pc_item, 0, sizeof(*pc_item));
-	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len);
+	pc_item->ce = make_empty_transient_cache_entry(fixed_portion->name_len, NULL);
 	pc_item->ce->ce_namelen = fixed_portion->name_len;
 	pc_item->ce->ce_mode = fixed_portion->ce_mode;
 	memcpy(pc_item->ce->name, variant, pc_item->ce->ce_namelen);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b18b9d6f3c..c0bf5e6711 100644
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
index dfa22b67eb..5e7a57c8c2 100644
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
index ccfeb9ba2b..b5074b2cb2 100644
--- a/cache.h
+++ b/cache.h
@@ -355,16 +355,16 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate,
 					   size_t name_len);
 
 /*
- * Create a cache_entry that is not intended to be added to an index.
- * Caller is responsible for discarding the cache_entry
- * with `discard_cache_entry`.
+ * Create a cache_entry that is not intended to be added to an index. If mp is
+ * not NULL, the entry is allocated within the given memory pool. Caller is
+ * responsible for discarding the cache_entry with `discard_cache_entry`.
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
index ecf6f68994..f9bac760af 100644
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
index e05e6ceff2..dcb40dc8fa 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1031,7 +1031,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	size_t len = traverse_path_len(info, tree_entry_len(n));
 	struct cache_entry *ce =
 		is_transient ?
-		make_empty_transient_cache_entry(len) :
+		make_empty_transient_cache_entry(len, NULL) :
 		make_empty_cache_entry(istate, len);
 
 	ce->ce_mode = create_ce_mode(n->mode);
-- 
2.28.0

