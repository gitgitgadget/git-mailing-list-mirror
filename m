Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6644D201A7
	for <e@80x24.org>; Fri, 12 May 2017 20:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbdELUCu (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 16:02:50 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35994 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbdELUCs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 16:02:48 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so34899094pfg.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eyJYQBMwF99ePriWGwwCGPCBx3E+Pw5dg7ecglP3bpo=;
        b=u7wplWBz2co1StFzDn2P/MLAZETG83npbt5fHmbfNwewe6Pqm3pqa30QK3Ma+MvHgT
         bYCEeAHq5s8njrXRqGWnR7lS/7iHEoqU74lCZ9z9ob+SBsCIhrrx0TXLvj3iJ617PipO
         ATKWkXAQLbd5Xx1q0wc/WZPzIzmORyWizPfYENyouwQhNJSYNOPGmooS5NLqP33/64fa
         Cg3/w0u79CwvgGfKVjZosJBSYLkRk1FANgP44R2ZOYTOR9o65WP/pLn8iIeepdO9/Flp
         ndBzMog/hUfWJM4fO42Vespmj4exAxrPsrW6P/CPlPio5fEQpwwksC4xktpxlVUN8mjP
         2w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eyJYQBMwF99ePriWGwwCGPCBx3E+Pw5dg7ecglP3bpo=;
        b=bKFClca8r/id+9dAsk4PenNgEbtcnPq/e7iJExCCvPews8if3sEQsk6IpgIpYK523w
         Ra08wDfY9KcGbIyPuxQX1oIuz4jVSZn1E0x5+YDwFKdCA/5vIFuRlARLsmCEwfVXVC1P
         vtjPYudCIFpvfFhI9emAlpSBLcMn+riZtsiVCNHQSj2OrTrw4s1ClHGvh5Zy+unoCePh
         lhxuSIWyJmw34/jl7qTuqbfEV8w4Xy8xHLcCLbQsTNWxgbn0KTCqZXN3glg6EuTN531Y
         kdeP92zpzVF9oqHgc5jJkg2CFXjijYEa+N3jV9X3ZGjqsvNJFewdVLeNIramhYl6yLl3
         i1DQ==
X-Gm-Message-State: AODbwcA0sAagPaovd2JkPz3rZpa3GUc8uYyRWbypRyjCiw80jNax9wt1
        pvWU7wzYvdOfEY04
X-Received: by 10.84.143.36 with SMTP id 33mr7888798ply.45.1494619367993;
        Fri, 12 May 2017 13:02:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:2e:7379:3e91:e314])
        by smtp.gmail.com with ESMTPSA id a85sm7967163pfg.7.2017.05.12.13.02.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 13:02:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] hashmap: hashmap_get_next passes through keydata as well
Date:   Fri, 12 May 2017 13:02:44 -0700
Message-Id: <20170512200244.25245-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'keydata' may be of value in the underlying compare function to decide
if the given two entries are the same.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-hashmap.txt | 6 ++++--
 diffcore-rename.c                       | 2 +-
 hashmap.c                               | 5 +++--
 hashmap.h                               | 3 ++-
 name-hash.c                             | 2 +-
 t/helper/test-hashmap.c                 | 2 +-
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index ccc634bbd7..343f1660a9 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -140,11 +140,11 @@ to `hashmap_cmp_fn` to decide whether the entry matches the key.
 `hash` is the hash code of the entry to look up.
 +
 If an entry with matching hash code is found, `keydata` is passed to
-`hashmap_cmp_fn` to decide whether the entry matches the key. The
+`hashmap_cmp_fn` to decide whether the `entry` matches the key. The
 `entry_or_key` parameter points to a bogus hashmap_entry structure that
 should not be used in the comparison.
 
-`void *hashmap_get_next(const struct hashmap *map, const void *entry)`::
+`void *hashmap_get_next(const struct hashmap *map, const void *entry, const void *keydata)`::
 
 	Returns the next equal hashmap entry, or NULL if not found. This can be
 	used to iterate over duplicate entries (see `hashmap_add`).
@@ -153,6 +153,8 @@ should not be used in the comparison.
 +
 `entry` is the hashmap_entry to start the search from, obtained via a previous
 call to `hashmap_get` or `hashmap_get_next`.
++
+`keydata` is passed to `hashmap_cmp_fn` to decide whether the entry matches the key.
 
 `void hashmap_add(struct hashmap *map, void *entry)`::
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86bd..0007fcba23 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -280,7 +280,7 @@ static int find_identical_files(struct hashmap *srcs,
 	 * Find the best source match for specified destination.
 	 */
 	p = hashmap_get_from_hash(srcs, hash_filespec(target), NULL);
-	for (; p; p = hashmap_get_next(srcs, p)) {
+	for (; p; p = hashmap_get_next(srcs, p, NULL)) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
diff --git a/hashmap.c b/hashmap.c
index 7d1044eb5d..f144d2fc04 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -182,11 +182,12 @@ void *hashmap_get(const struct hashmap *map, const void *key, const void *keydat
 	return *find_entry_ptr(map, key, keydata);
 }
 
-void *hashmap_get_next(const struct hashmap *map, const void *entry)
+void *hashmap_get_next(const struct hashmap *map, const void *entry,
+		       const void *keydata)
 {
 	struct hashmap_entry *e = ((struct hashmap_entry *) entry)->next;
 	for (; e; e = e->next)
-		if (entry_equals(map, entry, e, NULL))
+		if (entry_equals(map, entry, e, keydata))
 			return e;
 	return NULL;
 }
diff --git a/hashmap.h b/hashmap.h
index de6022a3a9..536c53a8ab 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -64,7 +64,8 @@ static inline void hashmap_entry_init(void *entry, unsigned int hash)
 }
 extern void *hashmap_get(const struct hashmap *map, const void *key,
 		const void *keydata);
-extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
+extern void *hashmap_get_next(const struct hashmap *map, const void *entry,
+			      const void *keydata);
 extern void hashmap_add(struct hashmap *map, void *entry);
 extern void *hashmap_put(struct hashmap *map, void *entry);
 extern void *hashmap_remove(struct hashmap *map, const void *key,
diff --git a/name-hash.c b/name-hash.c
index 39309efb7f..55758ab232 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -703,7 +703,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	while (ce) {
 		if (same_name(ce, name, namelen, icase))
 			return ce;
-		ce = hashmap_get_next(&istate->name_hash, ce);
+		ce = hashmap_get_next(&istate->name_hash, ce, NULL);
 	}
 	return NULL;
 }
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 7aa9440e27..fa33b32317 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -206,7 +206,7 @@ int cmd_main(int argc, const char **argv)
 				puts("NULL");
 			while (entry) {
 				puts(get_value(entry));
-				entry = hashmap_get_next(&map, entry);
+				entry = hashmap_get_next(&map, entry, NULL);
 			}
 
 		} else if (!strcmp("remove", cmd) && l1) {
-- 
2.13.0.18.g183880de0a

