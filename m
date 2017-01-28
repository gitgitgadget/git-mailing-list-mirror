Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5871F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdA1CDY (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:24 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34606 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdA1CDD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:03:03 -0500
Received: by mail-pg0-f42.google.com with SMTP id 14so85554628pgg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bu8PdVI9KtliC7BAG2FvtvVZXEMr77aSCjlmX3mU0qk=;
        b=FSQXRRbrDt7GlGaURQY4REo9aHJ3rqk8LMzz3dBv0ez7v9upBAO6Kb09QK70MhlXHN
         VFOTnv/xI7f/WL3nuOgWe7UBXcjbdw4stESYdKYYT+SFGeMbqrSk1LtSb5UDcZaF1Zeg
         RBqraS0yCLM9WbK8zsqv6zEucjDC9eylxtt+RxGi7RrVY6ScyWfiaEbcKUoKMVPhFodQ
         1rBkLhC2Hl5bqYjm8e9mOoW9VBabr1YZ64uZpXIaLzQa8izJ7nuRXj2tlZn5xOfrzBbk
         EoRZBNR+R9aKrGXhrGXOrK0ntMu1GJyh9curTpMCiKThzJZJLttG4GVasdLFuVeIA6jI
         T2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bu8PdVI9KtliC7BAG2FvtvVZXEMr77aSCjlmX3mU0qk=;
        b=f+SmThae6ovvi8RsQa082Tk/IjxtjJuG+fomAv9NGm+OCXACGEB2YMIsBoOhhcC8oh
         f0t1KEUZl0H5Y2V/fK8/ZhqRkKwm782aL7Ghf/I4OmyCdmhRqtS8q5pYNyaiDwj7bG78
         rfsXaf7kAd5f0fzWIuLau4n1Pe75DeCkZmLupPU7ilEA1Wy0m6os4J3iz5ZxXJ8oXY7f
         SO/Do8wHRIvpDirQJyNy/W4OgbIPhryzsjGRVX1CNdXuDcJwS3dqy4V60sDMllXKW3Ms
         oCVozrL/8cgfFSyA2H7Iy6hG/3Ogs7C41Ux8RnhRLdhIBsLv75o9VG347JH7GlRxLj5E
         ys5g==
X-Gm-Message-State: AIkVDXKPtcEv6yrcYiDRFZ4TXRHkwqPyRwxW9uo3SVVrSUP+Q+tWe8Kn+pfZPfxKoXOW7nCV
X-Received: by 10.98.31.18 with SMTP id f18mr12139485pff.36.1485568982345;
        Fri, 27 Jan 2017 18:03:02 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:03:01 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 22/27] attr: eliminate global check_all_attr array
Date:   Fri, 27 Jan 2017 18:02:02 -0800
Message-Id: <20170128020207.179015-23-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is a reliance on 'check_all_attr' which is a global
array of 'attr_check_item' items which is used to store the value of
each attribute during the collection process.

This patch eliminates this global and instead creates an array per
'attr_check' instance which is then used in the attribute collection
process.  This brings the attribute system one step closer to being
thread-safe.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 121 ++++++++++++++++++++++++++++++++++++++++++++---------------------
 attr.h |   5 +++
 2 files changed, 87 insertions(+), 39 deletions(-)

diff --git a/attr.c b/attr.c
index e008f3026..2637804b1 100644
--- a/attr.c
+++ b/attr.c
@@ -34,7 +34,6 @@ struct git_attr {
 	int maybe_real;
 	char name[FLEX_ARRAY]; /* attribute name */
 };
-static int attr_nr;
 
 /*
  * NEEDSWORK: maybe-real, maybe-macro are not property of
@@ -45,9 +44,6 @@ static int attr_nr;
  */
 static int cannot_trust_maybe_real;
 
-/* NEEDSWORK: This will become per git_attr_check */
-static struct attr_check_item *check_all_attr;
-
 const char *git_attr_name(const struct git_attr *attr)
 {
 	return attr->name;
@@ -143,6 +139,57 @@ static void attr_hashmap_add(struct attr_hashmap *map,
 	hashmap_add(&map->map, e);
 }
 
+struct all_attrs_item {
+	const struct git_attr *attr;
+	const char *value;
+};
+
+/*
+ * Reallocate and reinitialize the array of all attributes (which is used in
+ * the attribute collection process) in 'check' based on the global dictionary
+ * of attributes.
+ */
+static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
+{
+	int i;
+
+	hashmap_lock(map);
+
+	if (map->map.size < check->all_attrs_nr)
+		die("BUG: interned attributes shouldn't be deleted");
+
+	/*
+	 * If the number of attributes in the global dictionary has increased
+	 * (or this attr_check instance doesn't have an initialized all_attrs
+	 * field), reallocate the provided attr_check instance's all_attrs
+	 * field and fill each entry with its corresponding git_attr.
+	 */
+	if (map->map.size != check->all_attrs_nr) {
+		struct attr_hash_entry *e;
+		struct hashmap_iter iter;
+		hashmap_iter_init(&map->map, &iter);
+
+		REALLOC_ARRAY(check->all_attrs, map->map.size);
+		check->all_attrs_nr = map->map.size;
+
+		while ((e = hashmap_iter_next(&iter))) {
+			const struct git_attr *a = e->value;
+			check->all_attrs[a->attr_nr].attr = a;
+		}
+	}
+
+	hashmap_unlock(map);
+
+	/*
+	 * Re-initialize every entry in check->all_attrs.
+	 * This re-initialization can live outside of the locked region since
+	 * the attribute dictionary is no longer being accessed.
+	 */
+	for (i = 0; i < check->all_attrs_nr; i++) {
+		check->all_attrs[i].value = ATTR__UNKNOWN;
+	}
+}
+
 static int attr_name_valid(const char *name, size_t namelen)
 {
 	/*
@@ -196,16 +243,6 @@ static struct git_attr *git_attr_internal(const char *name, int namelen)
 
 		attr_hashmap_add(&g_attr_hashmap, a->name, namelen, a);
 		assert(a->attr_nr == (g_attr_hashmap.map.size - 1));
-
-		/*
-		 * NEEDSWORK: per git_attr_check check_all_attr
-		 * will be initialized a lot more lazily, not
-		 * like this, and not here.
-		 */
-		REALLOC_ARRAY(check_all_attr, ++attr_nr);
-		check_all_attr[a->attr_nr].attr = a;
-		check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
-		assert(a->attr_nr == (attr_nr - 1));
 	}
 
 	hashmap_unlock(&g_attr_hashmap);
@@ -513,6 +550,10 @@ void attr_check_clear(struct attr_check *check)
 	check->items = NULL;
 	check->alloc = 0;
 	check->nr = 0;
+
+	free(check->all_attrs);
+	check->all_attrs = NULL;
+	check->all_attrs_nr = 0;
 }
 
 void attr_check_free(struct attr_check *check)
@@ -860,16 +901,16 @@ static int path_matches(const char *pathname, int pathlen,
 			      pattern, prefix, pat->patternlen, pat->flags);
 }
 
-static int macroexpand_one(int attr_nr, int rem);
+static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem);
 
-static int fill_one(const char *what, struct match_attr *a, int rem)
+static int fill_one(const char *what, struct all_attrs_item *all_attrs,
+		    struct match_attr *a, int rem)
 {
-	struct attr_check_item *check = check_all_attr;
 	int i;
 
-	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
+	for (i = a->num_attr - 1; rem > 0 && i >= 0; i--) {
 		struct git_attr *attr = a->state[i].attr;
-		const char **n = &(check[attr->attr_nr].value);
+		const char **n = &(all_attrs[attr->attr_nr].value);
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
@@ -878,14 +919,15 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 				  attr, v);
 			*n = v;
 			rem--;
-			rem = macroexpand_one(attr->attr_nr, rem);
+			rem = macroexpand_one(all_attrs, attr->attr_nr, rem);
 		}
 	}
 	return rem;
 }
 
 static int fill(const char *path, int pathlen, int basename_offset,
-		struct attr_stack *stk, int rem)
+		struct attr_stack *stk, struct all_attrs_item *all_attrs,
+		int rem)
 {
 	int i;
 	const char *base = stk->origin ? stk->origin : "";
@@ -896,18 +938,18 @@ static int fill(const char *path, int pathlen, int basename_offset,
 			continue;
 		if (path_matches(path, pathlen, basename_offset,
 				 &a->u.pat, base, stk->originlen))
-			rem = fill_one("fill", a, rem);
+			rem = fill_one("fill", all_attrs, a, rem);
 	}
 	return rem;
 }
 
-static int macroexpand_one(int nr, int rem)
+static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem)
 {
 	struct attr_stack *stk;
 	int i;
 
-	if (check_all_attr[nr].value != ATTR__TRUE ||
-	    !check_all_attr[nr].attr->maybe_macro)
+	if (all_attrs[nr].value != ATTR__TRUE ||
+	    !all_attrs[nr].attr->maybe_macro)
 		return rem;
 
 	for (stk = attr_stack; stk; stk = stk->prev) {
@@ -916,7 +958,7 @@ static int macroexpand_one(int nr, int rem)
 			if (!ma->is_macro)
 				continue;
 			if (ma->u.attr->attr_nr == nr)
-				return fill_one("expand", ma, rem);
+				return fill_one("expand", all_attrs, ma, rem);
 		}
 	}
 
@@ -924,9 +966,9 @@ static int macroexpand_one(int nr, int rem)
 }
 
 /*
- * Collect attributes for path into the array pointed to by
- * check_all_attr. If num is non-zero, only attributes in check[] are
- * collected. Otherwise all attributes are collected.
+ * Collect attributes for path into the array pointed to by check->all_attrs.
+ * If check->check_nr is non-zero, only attributes in check[] are collected.
+ * Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, struct attr_check *check)
 {
@@ -949,15 +991,15 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 	}
 
 	prepare_attr_stack(path, dirlen);
-	for (i = 0; i < attr_nr; i++)
-		check_all_attr[i].value = ATTR__UNKNOWN;
+	all_attrs_init(&g_attr_hashmap, check);
+
 	if (check->nr && !cannot_trust_maybe_real) {
 		rem = 0;
 		for (i = 0; i < check->nr; i++) {
 			const struct git_attr *a = check->items[i].attr;
 			if (!a->maybe_real) {
-				struct attr_check_item *c;
-				c = check_all_attr + a->attr_nr;
+				struct all_attrs_item *c;
+				c = check->all_attrs + a->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
@@ -966,9 +1008,9 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 			return;
 	}
 
-	rem = attr_nr;
+	rem = check->all_attrs_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename_offset, stk, rem);
+		rem = fill(path, pathlen, basename_offset, stk, check->all_attrs, rem);
 }
 
 int git_check_attr(const char *path, struct attr_check *check)
@@ -978,7 +1020,8 @@ int git_check_attr(const char *path, struct attr_check *check)
 	collect_some_attrs(path, check);
 
 	for (i = 0; i < check->nr; i++) {
-		const char *value = check_all_attr[check->items[i].attr->attr_nr].value;
+		size_t n = check->items[i].attr->attr_nr;
+		const char *value = check->all_attrs[n].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
 		check->items[i].value = value;
@@ -994,9 +1037,9 @@ void git_all_attrs(const char *path, struct attr_check *check)
 	attr_check_reset(check);
 	collect_some_attrs(path, check);
 
-	for (i = 0; i < attr_nr; i++) {
-		const char *name = check_all_attr[i].attr->name;
-		const char *value = check_all_attr[i].value;
+	for (i = 0; i < check->all_attrs_nr; i++) {
+		const char *name = check->all_attrs[i].attr->name;
+		const char *value = check->all_attrs[i].value;
 		struct attr_check_item *item;
 		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
 			continue;
diff --git a/attr.h b/attr.h
index 898e1a8c9..5aaf55c3e 100644
--- a/attr.h
+++ b/attr.h
@@ -4,6 +4,9 @@
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
 
+/* opaque structure used internally for attribute collection */
+struct all_attrs_item;
+
 /*
  * Given a string, return the gitattribute object that
  * corresponds to it.
@@ -33,6 +36,8 @@ struct attr_check {
 	int nr;
 	int alloc;
 	struct attr_check_item *items;
+	int all_attrs_nr;
+	struct all_attrs_item *all_attrs;
 };
 
 extern struct attr_check *attr_check_alloc(void);
-- 
2.11.0.483.g087da7b7c-goog

