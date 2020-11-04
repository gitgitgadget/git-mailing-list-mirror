Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FFC388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0720759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ti3A0rON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgKDUeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUeR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:17 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5449C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:16 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 12so16730944qkl.8
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpOp2zYy3AVNtEGGB0cUfzAQMxUY6wDiP/Wi3AyUs7o=;
        b=ti3A0rONlOdqOdnnIKYxxqwNOByg8hNmN4qdur+uYKVvCl6h9VrGcUVc+TkWTWQDLO
         c3sav82FRfg31oqSEaMRcbuxjEG1fqLdvDSF2J6p2tW34efJOFbSaC7wA3u8+jf7yeph
         OaVzSuOD4/E6Lx1/5wo+TmGSrNKXLxz/0CjiSEj+LXpkFYbD1+8ALP4E0oHhLleZtvo+
         u08EGzZgHo/riEDgQ9sOaX2kpPyB5q6cqQHzdrjp2pTrGJUOZzX8dql2grblBnityKY0
         RfgbEgFMhY0VRW5bqhUwR5O+PHKDV7lGYiNEG98OMctmtUaXBwWS+X1JXZFEUtn6cII4
         h5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpOp2zYy3AVNtEGGB0cUfzAQMxUY6wDiP/Wi3AyUs7o=;
        b=QPWNxgnFRfVhIOsvhLzi5txsrnpvG2+lic6RLfe+A06sgIS/yrM4a+D6nQhT0jX1iB
         Cn9tTbtfk9cas7oHfRr6mQb32AzCXZLJKyaIW/76hp4Riw9s3AiCFOpsQsGM1v9sG/bC
         aqbW0UMvhH+UN83gxiS1aAx61+yzySnxS25gGvqk5ThijDmy+4tTK/1lYVHl06UIOtKG
         +iLmkuTCEiT194XVVUYxp5rtLg4JxAoIOCWsm42pGHNtMRzCMqpAKtJ7A65BemO/x15u
         +soTvUKhosPMQSWMOjOEK5GHCbzaONZ2LMM7djwlAFn9+mzO433PObUP/kaJWFZPpvS/
         DLBw==
X-Gm-Message-State: AOAM532oaIMNUz00Jg92s2a6WPsQbzGR82j0GyAn7NMP2iKxOClzJJLH
        aZ0TJb4Fcq6pOz7CJDyAjCWzAEIo5BaifQ==
X-Google-Smtp-Source: ABdhPJxpAHRz+ALpWAAuUXNqvAv4Xctjuumfw0j95OUe4ceqhlXExpHFU58o8HzFrxSD7uhFaK8BdQ==
X-Received: by 2002:a05:620a:201b:: with SMTP id c27mr27007111qka.279.1604522055565;
        Wed, 04 Nov 2020 12:34:15 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:14 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 13/19] make_transient_cache_entry(): optionally alloc from mem_pool
Date:   Wed,  4 Nov 2020 17:33:12 -0300
Message-Id: <960116579abc0b5a805a1af2565fb6060afaa68c.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
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
index a61ed76f0d..5d6f3e71d0 100644
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

