Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C651020281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdISGXp (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:45 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64765 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751109AbdISGWn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:22:43 -0400
X-AuditID: 1207440d-86bff70000000f42-10-59c0b7aebf3d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.1B.03906.EA7B0C95; Tue, 19 Sep 2017 02:22:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1Y002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:36 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/21] ref_iterator: keep track of whether the iterator output is ordered
Date:   Tue, 19 Sep 2017 08:22:09 +0200
Message-Id: <cbad77c8cf579651c4448b1c6a5a7a703723eb9b.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqLtu+4FIg+ebJC3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZdxZvoix4FVAxbWtTxkbGF87dTFy
        ckgImEj8f/aRrYuRi0NIYAeTxLRraxghnFNMEtdXXWQHqWIT0JVY1NPMBGKLCKhJTGw7xAJS
        xCywklli0tYrrF2MHBzCAjESS6eog9SwCKhK3P7+DKyeVyBKYv/d3awQ2+Qlzj24zQxicwpY
        SDTv2c4C0iokYC5x4GjxBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNK
        NzFCAo53B+P/dTKHGAU4GJV4eAWu7Y8UYk0sK67MPcQoycGkJMobtulApBBfUn5KZUZicUZ8
        UWlOavEhRgkOZiUR3kOLgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4O
        JQleRWBkCQkWpaanVqRl5pQgpJk4OEGG8wANVwGp4S0uSMwtzkyHyJ9iNOb4MenKHyaOjpt3
        /zAJseTl56VKifN+3gpUKgBSmlGaBzcNljReMYoDPSfM27ANqIoHmHDg5r0CWsUEtCp7A9iq
        kkSElFQDY9GMSaZHN2X37zZP6F5UKPE4ZMNilVU6t045PVyhbSPxm+OxUNteQ8fXPSZCt+Pb
        pmVr7J/2e3PS8YbA9vSVDPw/ti6wWPCHO6/lVdct53DN0ytl9r6XWNU5j+u+8LHLzWmbLy+d
        uUL+dGEw4yIOq8iKGfOX1kzzVy09Pf/lIfXpcauir+VNNFdiKc5INNRiLipOBACWRz3A9QIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

References are iterated over in order by refname, but reflogs are not.
Some consumers of reference iteration care about the difference. Teach
each `ref_iterator` to keep track of whether its output is ordered.

`overlay_ref_iterator` is one of the picky consumers. Add a sanity
check in `overlay_ref_iterator_begin()` to verify that its inputs are
ordered.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                |  4 ++++
 refs/files-backend.c  | 16 +++++++++-------
 refs/iterator.c       | 15 ++++++++++-----
 refs/packed-backend.c |  2 +-
 refs/ref-cache.c      |  2 +-
 refs/ref-cache.h      |  3 ++-
 refs/refs-internal.h  | 23 +++++++++++++++++++----
 7 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index b0106b8162..101c107ee8 100644
--- a/refs.c
+++ b/refs.c
@@ -1309,6 +1309,10 @@ struct ref_iterator *refs_ref_iterator_begin(
 	if (trim)
 		iter = prefix_ref_iterator_begin(iter, "", trim);
 
+	/* Sanity check for subclasses: */
+	if (!iter->ordered)
+		BUG("reference iterator is not ordered");
+
 	return iter;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 961424a4ea..35648c89fc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -762,7 +762,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 		const char *prefix, unsigned int flags)
 {
 	struct files_ref_store *refs;
-	struct ref_iterator *loose_iter, *packed_iter;
+	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
@@ -772,10 +772,6 @@ static struct ref_iterator *files_ref_iterator_begin(
 
 	refs = files_downcast(ref_store, required_flags, "ref_iterator_begin");
 
-	iter = xcalloc(1, sizeof(*iter));
-	ref_iterator = &iter->base;
-	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable);
-
 	/*
 	 * We must make sure that all loose refs are read before
 	 * accessing the packed-refs file; this avoids a race
@@ -811,7 +807,13 @@ static struct ref_iterator *files_ref_iterator_begin(
 			refs->packed_ref_store, prefix, 0,
 			DO_FOR_EACH_INCLUDE_BROKEN);
 
-	iter->iter0 = overlay_ref_iterator_begin(loose_iter, packed_iter);
+	overlay_iter = overlay_ref_iterator_begin(loose_iter, packed_iter);
+
+	iter = xcalloc(1, sizeof(*iter));
+	ref_iterator = &iter->base;
+	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
+			       overlay_iter->ordered);
+	iter->iter0 = overlay_iter;
 	iter->flags = flags;
 
 	return ref_iterator;
@@ -2084,7 +2086,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
 
-	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
+	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
 	files_reflog_path(refs, &sb, NULL);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	iter->ref_store = ref_store;
diff --git a/refs/iterator.c b/refs/iterator.c
index 4cf449ef66..c475360f0a 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -25,9 +25,11 @@ int ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 void base_ref_iterator_init(struct ref_iterator *iter,
-			    struct ref_iterator_vtable *vtable)
+			    struct ref_iterator_vtable *vtable,
+			    int ordered)
 {
 	iter->vtable = vtable;
+	iter->ordered = !!ordered;
 	iter->refname = NULL;
 	iter->oid = NULL;
 	iter->flags = 0;
@@ -72,7 +74,7 @@ struct ref_iterator *empty_ref_iterator_begin(void)
 	struct empty_ref_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 
-	base_ref_iterator_init(ref_iterator, &empty_ref_iterator_vtable);
+	base_ref_iterator_init(ref_iterator, &empty_ref_iterator_vtable, 1);
 	return ref_iterator;
 }
 
@@ -205,6 +207,7 @@ static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 };
 
 struct ref_iterator *merge_ref_iterator_begin(
+		int ordered,
 		struct ref_iterator *iter0, struct ref_iterator *iter1,
 		ref_iterator_select_fn *select, void *cb_data)
 {
@@ -219,7 +222,7 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 * references through only if they exist in both iterators.
 	 */
 
-	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
+	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable, ordered);
 	iter->iter0 = iter0;
 	iter->iter1 = iter1;
 	iter->select = select;
@@ -268,9 +271,11 @@ struct ref_iterator *overlay_ref_iterator_begin(
 	} else if (is_empty_ref_iterator(back)) {
 		ref_iterator_abort(back);
 		return front;
+	} else if (!front->ordered || !back->ordered) {
+		BUG("overlay_ref_iterator requires ordered inputs");
 	}
 
-	return merge_ref_iterator_begin(front, back,
+	return merge_ref_iterator_begin(1, front, back,
 					overlay_iterator_select, NULL);
 }
 
@@ -361,7 +366,7 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 
-	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable);
+	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable, iter0->ordered);
 
 	iter->iter0 = iter0;
 	iter->prefix = xstrdup(prefix);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 0279aeceea..e411501871 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -437,7 +437,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
-	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable);
+	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
 
 	/*
 	 * Note that get_packed_ref_cache() internally checks whether
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 76bb723c86..54dfb5218c 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -574,7 +574,7 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
-	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable);
+	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable, 1);
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 
 	iter->levels_nr = 1;
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 794f000fd3..a082bfb06c 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -245,7 +245,8 @@ struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname);
  * Start iterating over references in `cache`. If `prefix` is
  * specified, only include references whose names start with that
  * prefix. If `prime_dir` is true, then fill any incomplete
- * directories before beginning the iteration.
+ * directories before beginning the iteration. The output is ordered
+ * by refname.
  */
 struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 					      const char *prefix,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d7d344de73..d7f233beba 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -329,6 +329,13 @@ int refs_rename_ref_available(struct ref_store *refs,
  */
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
+
+	/*
+	 * Does this `ref_iterator` iterate over references in order
+	 * by refname?
+	 */
+	unsigned int ordered : 1;
+
 	const char *refname;
 	const struct object_id *oid;
 	unsigned int flags;
@@ -374,7 +381,7 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
  * which the refname begins with prefix. If trim is non-zero, then
  * trim that many characters off the beginning of each refname. flags
  * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
- * the iteration.
+ * the iteration. The output is ordered by refname.
  */
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
@@ -400,9 +407,11 @@ typedef enum iterator_selection ref_iterator_select_fn(
  * Iterate over the entries from iter0 and iter1, with the values
  * interleaved as directed by the select function. The iterator takes
  * ownership of iter0 and iter1 and frees them when the iteration is
- * over.
+ * over. A derived class should set `ordered` to 1 or 0 based on
+ * whether it generates its output in order by reference name.
  */
 struct ref_iterator *merge_ref_iterator_begin(
+		int ordered,
 		struct ref_iterator *iter0, struct ref_iterator *iter1,
 		ref_iterator_select_fn *select, void *cb_data);
 
@@ -431,6 +440,8 @@ struct ref_iterator *overlay_ref_iterator_begin(
  * As an convenience to callers, if prefix is the empty string and
  * trim is zero, this function returns iter0 directly, without
  * wrapping it.
+ *
+ * The resulting ref_iterator is ordered if iter0 is.
  */
 struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
@@ -441,11 +452,14 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 /*
  * Base class constructor for ref_iterators. Initialize the
  * ref_iterator part of iter, setting its vtable pointer as specified.
+ * `ordered` should be set to 1 if the iterator will iterate over
+ * references in order by refname; otherwise it should be set to 0.
  * This is meant to be called only by the initializers of derived
  * classes.
  */
 void base_ref_iterator_init(struct ref_iterator *iter,
-			    struct ref_iterator_vtable *vtable);
+			    struct ref_iterator_vtable *vtable,
+			    int ordered);
 
 /*
  * Base class destructor for ref_iterators. Destroy the ref_iterator
@@ -564,7 +578,8 @@ typedef int rename_ref_fn(struct ref_store *ref_store,
  * Iterate over the references in `ref_store` whose names start with
  * `prefix`. `prefix` is matched as a literal string, without regard
  * for path separators. If prefix is NULL or the empty string, iterate
- * over all references in `ref_store`.
+ * over all references in `ref_store`. The output is ordered by
+ * refname.
  */
 typedef struct ref_iterator *ref_iterator_begin_fn(
 		struct ref_store *ref_store,
-- 
2.14.1

