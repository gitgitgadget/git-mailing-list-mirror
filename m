Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE612C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DA8206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="dc+xRMiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHJVf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHJVf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A9C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so9850327qkb.8
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDmyu5JAlxx/KyrSc8Q/vhIIFpog0hTyKPjy3UkMPMI=;
        b=dc+xRMiHcsXIXMV3aEIX0Ye0djqLzKkJ5tI9vGSAw/AclpclBPPyGNXFYpXeJQrecv
         6NxNwLmTd2GPWMvoxazdaPyBriaRv5KxbyTbmQD/+Cq9cgVqSPkmeddH+fiBIq4Of9qK
         zf8nd40bZcoIWOWmUyqA9a9A09ch1QiKMDCF5kxDBpwey8cndlRRPqOOqtEnhXECj4Eq
         fUOtbpnE04kj0MZDKL6umHTZzzK0sxTNiUxv0NMHHaa5sr0HLfk6cBGWQOWFK3H78iEd
         FdU6BcQzHH/5XwpzGghssVnnzS4ZL2D3INcFPVIapUs0hQAlMKlApOrg1ze9D96Uvyds
         WMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDmyu5JAlxx/KyrSc8Q/vhIIFpog0hTyKPjy3UkMPMI=;
        b=C/Aom0zTuWU8DpZOWM5Ho4rDVYIVpnfDKT+FRepLPCyrOugZ7YisrQyxKiHE+2rhCJ
         Gf9IcE8v3xZ068USfRCLTR7wDstP6XNHt8eX+xkRk8hVEuzYhjROZVHymnTgzecOQCo9
         srJjGxjTxEqYa4b+QgI7K+8/IwXm5xqs7Z+OW9if9obpAoSnBXZ/jVkZ3fwzxt31Ex08
         PxdPU92jJdSAYiXweRMgS4QX1ZpP8YgacXXNh9gcwJ+allDgJ5W3HyZIik91MKy/kDV/
         oyz190xlyWpo6xiaxIoet3DMffCjh/pYjkbK3YhC2Hm0WS4gKuubxDz2qkdsTY8WMzJt
         gaaQ==
X-Gm-Message-State: AOAM531m4YGaSEg6cte6/erdZazzscvFxVEKUlN+hPr5TQ8XG0sEpmaO
        d2fMw1mjfFUyNvkMmdCcR82VHWIXQL8=
X-Google-Smtp-Source: ABdhPJwTmDkNYK5nbYwc7aDtOBag3AazUKThlREtZdT3g0F/GsVjSP2CV52qeo8NHpFhHREInmJm1g==
X-Received: by 2002:a37:6255:: with SMTP id w82mr28249071qkb.392.1597095326933;
        Mon, 10 Aug 2020 14:35:26 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:25 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: [RFC PATCH 14/21] make_transient_cache_entry(): optionally alloc from mem_pool
Date:   Mon, 10 Aug 2020 18:33:22 -0300
Message-Id: <9050b9da6748b7b64508255741f925d9d57983af.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index 269cf02feb..d2ab40cb4c 100644
--- a/builtin/checkout--helper.c
+++ b/builtin/checkout--helper.c
@@ -30,7 +30,7 @@ static void packet_to_ci(char *line, int len, struct checkout_item *ci)
 	}
 
 	memset(ci, 0, sizeof(*ci));
-	ci->ce = make_empty_transient_cache_entry(fixed_portion->name_len);
+	ci->ce = make_empty_transient_cache_entry(fixed_portion->name_len, NULL);
 	ci->ce->ce_namelen = fixed_portion->name_len;
 	ci->ce->ce_mode = fixed_portion->ce_mode;
 	memcpy(ci->ce->name, variant, ci->ce->ce_namelen);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3e09b29cfe..8e4a3c1df0 100644
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
index e6963cf8fe..e2b41c5f8b 100644
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
index 8ed1c29b54..eeb122cca4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -811,8 +811,10 @@ struct cache_entry *make_empty_cache_entry(struct index_state *istate, size_t le
 	return mem_pool__ce_calloc(find_mem_pool(istate), len);
 }
 
-struct cache_entry *make_empty_transient_cache_entry(size_t len)
+struct cache_entry *make_empty_transient_cache_entry(size_t len, struct mem_pool *mp)
 {
+	if (mp)
+		return mem_pool__ce_calloc(mp, len);
 	return xcalloc(1, cache_entry_size(len));
 }
 
@@ -846,8 +848,10 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
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
@@ -858,7 +862,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct o
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
2.27.0

