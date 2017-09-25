Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5D920C11
	for <e@80x24.org>; Mon, 25 Sep 2017 08:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbdIYIBJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:01:09 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43121 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934054AbdIYIBF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:01:05 -0400
X-AuditID: 12074413-38bff70000007929-d8-59c8b7c16c68
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.A8.31017.1C7B8C95; Mon, 25 Sep 2017 04:01:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6b027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:01:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/21] ref_store: implement `refs_peel_ref()` generically
Date:   Mon, 25 Sep 2017 10:00:14 +0200
Message-Id: <b9c1f576a02d52df52ded4324f909568b94d3851.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqHtw+4lIg7NLuC3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZXx8M4m9YJJ+xYRnW1gbGHeqdTFy
        ckgImEhs6etl6mLk4hAS2MEkMelPIyuEc4pJYu6h22wgVWwCuhKLepqZQGwRATWJiW2HWECK
        mAVWMktM2nqFFSQhLOAjsXPBEWYQm0VAVWLH8SOMIDavQJTEhOWP2SDWyUuce3AbrIZTwELi
        zZkjYHEhAXOJ8zdusU5g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQT
        IyTohHcw7jopd4hRgINRiYc34t/xSCHWxLLiytxDjJIcTEqivHf5TkQK8SXlp1RmJBZnxBeV
        5qQWH2KU4GBWEuE9thoox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS
        4DUFRpeQYFFqempFWmZOCUKaiYMTZDgP0PDl20CGFxck5hZnpkPkTzHqcnTcvPuHSYglLz8v
        VUqcdwNIkQBIUUZpHtwcWLJ4xSgO9JYw70KQKh5gooGb9ApoCRPQkt6pYEtKEhFSUg2Mjsv1
        wv+urJ5/ZH3TPNcpJxxXT1vDJnqSd53i/4/9ZsdWfzz59aOCZNjJ0Lsrl0yZyyBx+6h97FMV
        bjnTH/0Wj3ZY/Hxu+y7kx64DhhsVQtS6S/50rJVuPV3VJzlPUSHo9rG885/SDY5vmXTigvSB
        rbbmPjH3r3yawbeinq9YTOrEi7M32KYcX6fEUpyRaKjFXFScCAAOgRit8QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're about to stop storing packed refs in a `ref_cache`. That means
that the only way we have left to optimize `peel_ref()` is by checking
whether the reference being peeled is the one currently being iterated
over (in `current_ref_iter`), and if so, using `ref_iterator_peel()`.
But this can be done generically; it doesn't have to be implemented
per-backend.

So implement `refs_peel_ref()` in `refs.c` and remove the `peel_ref()`
method from the refs API.

This removes the last callers of a couple of functions, so delete
them. More cleanup to come...

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                | 18 +++++++++++++++++-
 refs/files-backend.c  | 38 --------------------------------------
 refs/packed-backend.c | 36 ------------------------------------
 refs/refs-internal.h  |  3 ---
 4 files changed, 17 insertions(+), 78 deletions(-)

diff --git a/refs.c b/refs.c
index 101c107ee8..c5e6f79c77 100644
--- a/refs.c
+++ b/refs.c
@@ -1735,7 +1735,23 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags)
 int refs_peel_ref(struct ref_store *refs, const char *refname,
 		  unsigned char *sha1)
 {
-	return refs->be->peel_ref(refs, refname, sha1);
+	int flag;
+	unsigned char base[20];
+
+	if (current_ref_iter && current_ref_iter->refname == refname) {
+		struct object_id peeled;
+
+		if (ref_iterator_peel(current_ref_iter, &peeled))
+			return -1;
+		hashcpy(sha1, peeled.hash);
+		return 0;
+	}
+
+	if (refs_read_ref_full(refs, refname,
+			       RESOLVE_REF_READING, base, &flag))
+		return -1;
+
+	return peel_object(base, sha1);
 }
 
 int peel_ref(const char *refname, unsigned char *sha1)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 35648c89fc..7d12de88d0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -655,43 +655,6 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	return ret;
 }
 
-static int files_peel_ref(struct ref_store *ref_store,
-			  const char *refname, unsigned char *sha1)
-{
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
-			       "peel_ref");
-	int flag;
-	unsigned char base[20];
-
-	if (current_ref_iter && current_ref_iter->refname == refname) {
-		struct object_id peeled;
-
-		if (ref_iterator_peel(current_ref_iter, &peeled))
-			return -1;
-		hashcpy(sha1, peeled.hash);
-		return 0;
-	}
-
-	if (refs_read_ref_full(ref_store, refname,
-			       RESOLVE_REF_READING, base, &flag))
-		return -1;
-
-	/*
-	 * If the reference is packed, read its ref_entry from the
-	 * cache in the hope that we already know its peeled value.
-	 * We only try this optimization on packed references because
-	 * (a) forcing the filling of the loose reference cache could
-	 * be expensive and (b) loose references anyway usually do not
-	 * have REF_KNOWS_PEELED.
-	 */
-	if (flag & REF_ISPACKED &&
-	    !refs_peel_ref(refs->packed_ref_store, refname, sha1))
-		return 0;
-
-	return peel_object(base, sha1);
-}
-
 struct files_ref_iterator {
 	struct ref_iterator base;
 
@@ -3012,7 +2975,6 @@ struct ref_storage_be refs_be_files = {
 	files_initial_transaction_commit,
 
 	files_pack_refs,
-	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
 	files_rename_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index be614e79f5..dbbba45502 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -850,26 +850,6 @@ static struct packed_ref_cache *get_packed_ref_cache(struct packed_ref_store *re
 	return refs->cache;
 }
 
-static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_cache)
-{
-	return get_ref_dir(packed_ref_cache->cache->root);
-}
-
-static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
-{
-	return get_packed_ref_dir(get_packed_ref_cache(refs));
-}
-
-/*
- * Return the ref_entry for the given refname from the packed
- * references.  If it does not exist, return NULL.
- */
-static struct ref_entry *get_packed_ref(struct packed_ref_store *refs,
-					const char *refname)
-{
-	return find_ref_entry(get_packed_refs(refs), refname);
-}
-
 static int packed_read_raw_ref(struct ref_store *ref_store,
 			       const char *refname, unsigned char *sha1,
 			       struct strbuf *referent, unsigned int *type)
@@ -896,21 +876,6 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 	return 0;
 }
 
-static int packed_peel_ref(struct ref_store *ref_store,
-			   const char *refname, unsigned char *sha1)
-{
-	struct packed_ref_store *refs =
-		packed_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
-				"peel_ref");
-	struct ref_entry *r = get_packed_ref(refs, refname);
-
-	if (!r || peel_entry(r, 0))
-		return -1;
-
-	hashcpy(sha1, r->u.value.peeled.hash);
-	return 0;
-}
-
 struct packed_ref_iterator {
 	struct ref_iterator base;
 
@@ -1597,7 +1562,6 @@ struct ref_storage_be refs_be_packed = {
 	packed_initial_transaction_commit,
 
 	packed_pack_refs,
-	packed_peel_ref,
 	packed_create_symref,
 	packed_delete_refs,
 	packed_rename_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d7f233beba..cc6c373f59 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -562,8 +562,6 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
-typedef int peel_ref_fn(struct ref_store *ref_store,
-			const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
@@ -668,7 +666,6 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *initial_transaction_commit;
 
 	pack_refs_fn *pack_refs;
-	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
 	rename_ref_fn *rename_ref;
-- 
2.14.1

