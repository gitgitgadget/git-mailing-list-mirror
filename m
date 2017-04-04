Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E159D20966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbdDDKV7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:21:59 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36396 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbdDDKV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:21:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so36310817pgh.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSGU7IxdoO9vkgTfkSa3RLHPlTiNgC+k6hyBMDr8VNQ=;
        b=KU3GRkpchKKbktbqXn2RSa80iIfNR7wvfu2+qQrX/318ruYLHbNH4qYl+dk+J0lG9x
         Dw3QYGKiQZcbko7XwpAnNu9/egAeEPBLAVP5PHvksouqYZR4dq6wdxNp2Py11ZqmXgG9
         c85UafmaA0ChL6UE0hO6bTSkmeKZmWN3pRcNTA7NOQAO1oIRGKeQ88kJi3smFvPeMWEZ
         KX6nOhjTS8Ldn22if6dAD+aToe+RTpHmVi7d9jKd/sIpic5+HGpJK5cFVGo8xKgiY2vD
         0zstV8mMVJFe7trRnpuGBfaZtbOqcaU9xBU0NLXuRLwvPMv5x67cs1mgN45V9ouPYAQ+
         qYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSGU7IxdoO9vkgTfkSa3RLHPlTiNgC+k6hyBMDr8VNQ=;
        b=BtklxIKjknpb+LRm2YmsonxxkjQ2KjXjwsRdonk3ZryHYNXPBaJVFZh9yTLKflOZEA
         zvECzuYt2NNInp1c0xGnpfjCyw7WpSuQtLtxmSRfVtwREaahXsmtPs0FyxVe2pStk5kt
         rLKkQaXpxqObtbf82+Bn38+m/QHTDbpc0EPamrjqbSGcG3kSzjvaJTxSXUxzGaj6rceI
         p5EVifjnpDFUIp5bghgyzhPFJa3m3qPJsasnSrF9LMBeHmJASub8PeiaqJ8LfwRoFbCu
         cNABR/fSdoRrHS8vuOU3Cdaen8FSdtqiWAwCHbJL1NadMjrjP4UfasZ4B9LYqxBbxddY
         2Kvg==
X-Gm-Message-State: AFeK/H2P/IIYcJwEDhgdZSue02IOevboHOYKgapcmwxBoADZ47rj4RXS5WCmA0BHux5B8Q==
X-Received: by 10.99.51.200 with SMTP id z191mr22636226pgz.137.1491301317148;
        Tue, 04 Apr 2017 03:21:57 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id x15sm30899315pfk.68.2017.04.04.03.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2017 03:21:56 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 04 Apr 2017 17:21:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 2/5] refs.c: make submodule ref store hashmap generic
Date:   Tue,  4 Apr 2017 17:21:20 +0700
Message-Id: <20170404102123.25315-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170404102123.25315-1-pclouds@gmail.com>
References: <20170318100206.5980-1-pclouds@gmail.com>
 <20170404102123.25315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the "submodule" from submodule_hash_entry and other
function names. The goal is to reuse the same code and data structure
for other ref store types. The first one is worktree ref stores.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index ec1f563824..875e30a0b8 100644
--- a/refs.c
+++ b/refs.c
@@ -1450,32 +1450,32 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	return 0;
 }
 
-struct submodule_hash_entry
+struct ref_store_hash_entry
 {
 	struct hashmap_entry ent; /* must be the first member! */
 
 	struct ref_store *refs;
 
-	/* NUL-terminated name of submodule: */
-	char submodule[FLEX_ARRAY];
+	/* NUL-terminated identifier of the ref store: */
+	char name[FLEX_ARRAY];
 };
 
-static int submodule_hash_cmp(const void *entry, const void *entry_or_key,
+static int ref_store_hash_cmp(const void *entry, const void *entry_or_key,
 			      const void *keydata)
 {
-	const struct submodule_hash_entry *e1 = entry, *e2 = entry_or_key;
-	const char *submodule = keydata ? keydata : e2->submodule;
+	const struct ref_store_hash_entry *e1 = entry, *e2 = entry_or_key;
+	const char *name = keydata ? keydata : e2->name;
 
-	return strcmp(e1->submodule, submodule);
+	return strcmp(e1->name, name);
 }
 
-static struct submodule_hash_entry *alloc_submodule_hash_entry(
-		const char *submodule, struct ref_store *refs)
+static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
+		const char *name, struct ref_store *refs)
 {
-	struct submodule_hash_entry *entry;
+	struct ref_store_hash_entry *entry;
 
-	FLEX_ALLOC_STR(entry, submodule, submodule);
-	hashmap_entry_init(entry, strhash(submodule));
+	FLEX_ALLOC_STR(entry, name, name);
+	hashmap_entry_init(entry, strhash(name));
 	entry->refs = refs;
 	return entry;
 }
@@ -1487,19 +1487,19 @@ static struct ref_store *main_ref_store;
 static struct hashmap submodule_ref_stores;
 
 /*
- * Return the ref_store instance for the specified submodule. If that
- * ref_store hasn't been initialized yet, return NULL.
+ * Look up a ref store by name. If that ref_store hasn't been
+ * registered yet, return NULL.
  */
-static struct ref_store *lookup_submodule_ref_store(const char *submodule)
+static struct ref_store *lookup_ref_store_map(struct hashmap *map,
+					      const char *name)
 {
-	struct submodule_hash_entry *entry;
+	struct ref_store_hash_entry *entry;
 
-	if (!submodule_ref_stores.tablesize)
+	if (!map->tablesize)
 		/* It's initialized on demand in register_ref_store(). */
 		return NULL;
 
-	entry = hashmap_get_from_hash(&submodule_ref_stores,
-				      strhash(submodule), submodule);
+	entry = hashmap_get_from_hash(map, strhash(name), name);
 	return entry ? entry->refs : NULL;
 }
 
@@ -1535,20 +1535,19 @@ struct ref_store *get_main_ref_store(void)
 }
 
 /*
- * Register the specified ref_store to be the one that should be used
- * for submodule. It is a fatal error to call this function twice for
- * the same submodule.
+ * Associate a ref store with a name. It is a fatal error to call this
+ * function twice for the same name.
  */
-static void register_submodule_ref_store(struct ref_store *refs,
-					 const char *submodule)
+static void register_ref_store_map(struct hashmap *map,
+				   const char *type,
+				   struct ref_store *refs,
+				   const char *name)
 {
-	if (!submodule_ref_stores.tablesize)
-		hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
+	if (!map->tablesize)
+		hashmap_init(map, ref_store_hash_cmp, 0);
 
-	if (hashmap_put(&submodule_ref_stores,
-			alloc_submodule_hash_entry(submodule, refs)))
-		die("BUG: ref_store for submodule '%s' initialized twice",
-		    submodule);
+	if (hashmap_put(map, alloc_ref_store_hash_entry(name, refs)))
+		die("BUG: %s ref_store '%s' initialized twice", type, name);
 }
 
 struct ref_store *get_submodule_ref_store(const char *submodule)
@@ -1565,7 +1564,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		return get_main_ref_store();
 	}
 
-	refs = lookup_submodule_ref_store(submodule);
+	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
 	if (refs)
 		return refs;
 
@@ -1584,7 +1583,8 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	/* pretend that add_submodule_odb() has been called */
 	refs = ref_store_init(submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
-	register_submodule_ref_store(refs, submodule);
+	register_ref_store_map(&submodule_ref_stores, "submodule",
+			       refs, submodule);
 
 	strbuf_release(&submodule_sb);
 	return refs;
-- 
2.11.0.157.gd943d85

