Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957561FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168338AbdDXKCB (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:02:01 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36659 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168334AbdDXKBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:01:55 -0400
Received: by mail-it0-f68.google.com with SMTP id x188so15101134itb.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOKFYrlDIUWPywVncxyUPLttmCl/xiyogs4t3POuSio=;
        b=WpOb3lcvbrBTeboD5Mqk8GBCfPJMCbb9S02VhrO/HgkpBnDtNAvb1+MlifbAVdDfcg
         b6uNmQozkEHh5rxdu8V7jpQMlUIh/xP/E2um6Zs6Gla2H33gbriGxKkuGBP5Wia79BuC
         0AmBPQK/7NjtKEJH8RWPbn/uX6UYW6DOsQcR9FwIbqw/6LxXShpFHAO4GIxj1cbbvhLQ
         n6pOsPnM0KpZ0yfpC7XLYxTbIb/LlUtJbSkpGQwnv9K83klpapntB+sxKUddESeX67pi
         ecBidXBhr6kKCTvpQmm6De/3pf9eEAR6XNt1RxpZKPDizNhCnIxmeujnOOpPyiAMygsY
         7dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOKFYrlDIUWPywVncxyUPLttmCl/xiyogs4t3POuSio=;
        b=JEaW74shi5NnhuHQPpWNdM6ZFVaQ3bGa9K5NsAjQYbcA7KQTMtQzB86HVGYUJOxAd3
         XevWYT5/KZFHfumnUZiYmPqAfj84klCbzpFzGZeMFol/i4baftCGiUbXiz6oQqA6RwtV
         vv8EpRLKJkQLYFOP47+Ue6bzqrN+HFyXBt5IxxqQtfL/I1mClc6VB3aompDq9OJbicZz
         bRPMgUd8DQyQQDRmnbPf0yVtgQj72KR99NhPURJ6wnkWrdzBr1VKxd+p3x9xnyhQOMHY
         tYwlBCfXvLl4Zy4s3pTJrdBr/sx1nj8eMYIbno5f0lzgqlvqN9Bm6RLLF2VZd6aogHDa
         b1kQ==
X-Gm-Message-State: AN3rC/53US6M230WavG9KzbzJ7LLNlsbq3zAPcBuCIOTqEYiDgTbHwJf
        0x2XnhMB/b6RBg==
X-Received: by 10.84.218.200 with SMTP id g8mr31631268plm.57.1493028109042;
        Mon, 24 Apr 2017 03:01:49 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z5sm29871062pfd.76.2017.04.24.03.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 03:01:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Apr 2017 17:01:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 2/6] refs.c: make submodule ref store hashmap generic
Date:   Mon, 24 Apr 2017 17:01:20 +0700
Message-Id: <20170424100124.24637-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170424100124.24637-1-pclouds@gmail.com>
References: <20170404102123.25315-1-pclouds@gmail.com>
 <20170424100124.24637-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index bad05ba861..96eba92475 100644
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
 	/* assume that add_submodule_odb() has been called */
 	refs = ref_store_init(submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
-	register_submodule_ref_store(refs, submodule);
+	register_ref_store_map(&submodule_ref_stores, "submodule",
+			       refs, submodule);
 
 	strbuf_release(&submodule_sb);
 	return refs;
-- 
2.11.0.157.gd943d85

