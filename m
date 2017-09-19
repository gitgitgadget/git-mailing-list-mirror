Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69ADE20281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdISGXd (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53611 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751479AbdISGXO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:14 -0400
X-AuditID: 12074413-3a3ff70000007929-75-59c0b7d1dc39
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E0.F2.31017.1D7B0C95; Tue, 19 Sep 2017 02:23:13 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1o002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:11 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/21] ref_store: implement `refs_peel_ref()` generically
Date:   Tue, 19 Sep 2017 08:22:25 +0200
Message-Id: <4bfae266be39a1ecc217380f4a8b1eafb669f521.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqHtx+4FIg92v1CzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZdw8NputYJJ+xeZnk9kbGHeqdTFy
        cEgImEhc7NHuYuTkEBLYwSRx9UlRFyMXkH2KSeLi4j3MIAk2AV2JRT3NTCC2iICaxMS2Qywg
        RcwCK5klJm29wgqSEBbwkThyro0NxGYRUJXoWH0brIFXIEpi/+IGMFtCQF7i3IPbYEM5BSwk
        mvdsZwE5QkjAXOLA0eIJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRu
        YoSEm/AOxl0n5Q4xCnAwKvHwClzbHynEmlhWXJl7iFGSg0lJlDds04FIIb6k/JTKjMTijPii
        0pzU4kOMEhzMSiK8hxYB5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxK
        EryKwLgSEixKTU+tSMvMKUFIM3FwggznARquAlLDW1yQmFucmQ6RP8Woy9Fx8+4fJiGWvPy8
        VClx3vvbgIoEQIoySvPg5sDSxCtGcaC3hHkbQKp4gCkGbtIroCVMQEuyN4AtKUlESEk1MHb3
        mX4rfr7oel6S6rJ7JyLkjcpi3k/cIV14xjP4rFIXa7f2qwD5WN7+eKGWZXMWcLn+beiyihR0
        /Dll5bnerC17wuq11f2Z6jbNki77d7jdd8OcznMvLz7Zs1nBeterE8rquww7t+6ctmaTDU+s
        3Z4Pe1ilRVJ7+H1/XTxRmnToSdht21UdPUosxRmJhlrMRcWJADdoN37uAgAA
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
index 2cf2f7f73d..6a930a440c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -849,26 +849,6 @@ static struct packed_ref_cache *get_packed_ref_cache(struct packed_ref_store *re
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
@@ -895,21 +875,6 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
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
 
@@ -1596,7 +1561,6 @@ struct ref_storage_be refs_be_packed = {
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

