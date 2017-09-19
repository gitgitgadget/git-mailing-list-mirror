Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9721D20281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdISGX1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:27 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44603 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbdISGXV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:21 -0400
X-AuditID: 12074412-1fdff7000000748d-55-59c0b7d85559
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A1.CB.29837.8D7B0C95; Tue, 19 Sep 2017 02:23:20 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1r002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:18 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/21] mmapped_ref_iterator: inline into `packed_ref_iterator`
Date:   Tue, 19 Sep 2017 08:22:28 +0200
Message-Id: <7e2152dc4d05bee9e822c4a9690a2c9d3b2fce6b.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqHtj+4FIg7dTuSzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZazvWctSsDyiomHpLsYGxmfuXYyc
        HBICJhInVpxn6mLk4hAS2MEkMeHlWyjnFJPE5qU7GUGq2AR0JRb1NDOB2CICahIT2w6xgBQx
        C6xklpi09QorSEJYIFBix/uzYA0sAqoS+x8uZQexeQWiJK7PaWCEWCcvce7BbWYQm1PAQqJ5
        z3agQRxA28wlDhwtnsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZG
        SMgJ7WBcf1LuEKMAB6MSD6/Atf2RQqyJZcWVuYcYJTmYlER5wzYdiBTiS8pPqcxILM6ILyrN
        SS0+xCjBwawkwntoEVCONyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mC
        d/E2oEbBotT01Iq0zJwShDQTByfIcB6g4cUgNbzFBYm5xZnpEPlTjLocHTfv/mESYsnLz0uV
        Eue9D1IkAFKUUZoHNweWKl4xigO9Jcy7B6SKB5hm4Ca9AlrCBLQkewPYkpJEhJRUA+Pub3H/
        n+n8WiD889DXDp+Vb58q/DgaO/WOffbc2jnJ8S8/5TmXH3mRccb4MQ+nU77Af4mpzMITNmWv
        2zqVbX9wP0v3oaivMw/b7DGOXd23SCVv15mrHrM6qj5M/9QXmquzXfDVqWZVxtTC75pTzl+5
        HL24TLz2kWRG++2D3w5JX9WZnHE17BeTEktxRqKhFnNRcSIAffCIkvACAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `packed_ref_iterator` is now delegating to
`mmapped_ref_iterator` rather than `cache_ref_iterator` to do the
heavy lifting, there is no need to keep the two iterators separate. So
"inline" `mmapped_ref_iterator` into `packed_ref_iterator`. This
removes a bunch of boilerplate.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 284 ++++++++++++++++++++------------------------------
 1 file changed, 114 insertions(+), 170 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b1571872fa..92b837a237 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -225,157 +225,6 @@ static NORETURN void die_invalid_line(const char *path,
 
 }
 
-/*
- * This value is set in `base.flags` if the peeled value of the
- * current reference is known. In that case, `peeled` contains the
- * correct peeled value for the reference, which might be `null_sha1`
- * if the reference is not a tag or if it is broken.
- */
-#define REF_KNOWS_PEELED 0x40
-
-/*
- * An iterator over a packed-refs file that is currently mmapped.
- */
-struct mmapped_ref_iterator {
-	struct ref_iterator base;
-
-	struct packed_ref_cache *packed_refs;
-
-	/* The current position in the mmapped file: */
-	const char *pos;
-
-	/* The end of the mmapped file: */
-	const char *eof;
-
-	struct object_id oid, peeled;
-
-	struct strbuf refname_buf;
-};
-
-static int mmapped_ref_iterator_advance(struct ref_iterator *ref_iterator)
-{
-	struct mmapped_ref_iterator *iter =
-		(struct mmapped_ref_iterator *)ref_iterator;
-	const char *p = iter->pos, *eol;
-
-	strbuf_reset(&iter->refname_buf);
-
-	if (iter->pos == iter->eof)
-		return ref_iterator_abort(ref_iterator);
-
-	iter->base.flags = REF_ISPACKED;
-
-	if (iter->eof - p < GIT_SHA1_HEXSZ + 2 ||
-	    parse_oid_hex(p, &iter->oid, &p) ||
-	    !isspace(*p++))
-		die_invalid_line(iter->packed_refs->refs->path,
-				 iter->pos, iter->eof - iter->pos);
-
-	eol = memchr(p, '\n', iter->eof - p);
-	if (!eol)
-		die_unterminated_line(iter->packed_refs->refs->path,
-				      iter->pos, iter->eof - iter->pos);
-
-	strbuf_add(&iter->refname_buf, p, eol - p);
-	iter->base.refname = iter->refname_buf.buf;
-
-	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (!refname_is_safe(iter->base.refname))
-			die("packed refname is dangerous: %s",
-			    iter->base.refname);
-		oidclr(&iter->oid);
-		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
-	}
-	if (iter->packed_refs->peeled == PEELED_FULLY ||
-	    (iter->packed_refs->peeled == PEELED_TAGS &&
-	     starts_with(iter->base.refname, "refs/tags/")))
-		iter->base.flags |= REF_KNOWS_PEELED;
-
-	iter->pos = eol + 1;
-
-	if (iter->pos < iter->eof && *iter->pos == '^') {
-		p = iter->pos + 1;
-		if (iter->eof - p < GIT_SHA1_HEXSZ + 1 ||
-		    parse_oid_hex(p, &iter->peeled, &p) ||
-		    *p++ != '\n')
-			die_invalid_line(iter->packed_refs->refs->path,
-					 iter->pos, iter->eof - iter->pos);
-		iter->pos = p;
-
-		/*
-		 * Regardless of what the file header said, we
-		 * definitely know the value of *this* reference. But
-		 * we suppress it if the reference is broken:
-		 */
-		if ((iter->base.flags & REF_ISBROKEN)) {
-			oidclr(&iter->peeled);
-			iter->base.flags &= ~REF_KNOWS_PEELED;
-		} else {
-			iter->base.flags |= REF_KNOWS_PEELED;
-		}
-	} else {
-		oidclr(&iter->peeled);
-	}
-
-	return ITER_OK;
-}
-
-static int mmapped_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				    struct object_id *peeled)
-{
-	struct mmapped_ref_iterator *iter =
-		(struct mmapped_ref_iterator *)ref_iterator;
-
-	if ((iter->base.flags & REF_KNOWS_PEELED)) {
-		oidcpy(peeled, &iter->peeled);
-		return is_null_oid(&iter->peeled) ? -1 : 0;
-	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
-		return -1;
-	} else {
-		return !!peel_object(iter->oid.hash, peeled->hash);
-	}
-}
-
-static int mmapped_ref_iterator_abort(struct ref_iterator *ref_iterator)
-{
-	struct mmapped_ref_iterator *iter =
-		(struct mmapped_ref_iterator *)ref_iterator;
-
-	release_packed_ref_cache(iter->packed_refs);
-	strbuf_release(&iter->refname_buf);
-	base_ref_iterator_free(ref_iterator);
-	return ITER_DONE;
-}
-
-static struct ref_iterator_vtable mmapped_ref_iterator_vtable = {
-	mmapped_ref_iterator_advance,
-	mmapped_ref_iterator_peel,
-	mmapped_ref_iterator_abort
-};
-
-struct ref_iterator *mmapped_ref_iterator_begin(
-		struct packed_ref_cache *packed_refs,
-		const char *pos, const char *eof)
-{
-	struct mmapped_ref_iterator *iter = xcalloc(1, sizeof(*iter));
-	struct ref_iterator *ref_iterator = &iter->base;
-
-	if (!packed_refs->buf)
-		return empty_ref_iterator_begin();
-
-	base_ref_iterator_init(ref_iterator, &mmapped_ref_iterator_vtable, 1);
-
-	iter->packed_refs = packed_refs;
-	acquire_packed_ref_cache(iter->packed_refs);
-	iter->pos = pos;
-	iter->eof = eof;
-	strbuf_init(&iter->refname_buf, 0);
-
-	iter->base.oid = &iter->oid;
-
-	return ref_iterator;
-}
-
 struct packed_ref_entry {
 	const char *start;
 	size_t len;
@@ -857,38 +706,120 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 	return 0;
 }
 
+/*
+ * This value is set in `base.flags` if the peeled value of the
+ * current reference is known. In that case, `peeled` contains the
+ * correct peeled value for the reference, which might be `null_sha1`
+ * if the reference is not a tag or if it is broken.
+ */
+#define REF_KNOWS_PEELED 0x40
+
+/*
+ * An iterator over a packed-refs file that is currently mmapped.
+ */
 struct packed_ref_iterator {
 	struct ref_iterator base;
 
-	struct packed_ref_cache *cache;
-	struct ref_iterator *iter0;
+	struct packed_ref_cache *packed_refs;
+
+	/* The current position in the mmapped file: */
+	const char *pos;
+
+	/* The end of the mmapped file: */
+	const char *eof;
+
+	struct object_id oid, peeled;
+
+	struct strbuf refname_buf;
+
 	unsigned int flags;
 };
 
+static int next_record(struct packed_ref_iterator *iter)
+{
+	const char *p = iter->pos, *eol;
+
+	strbuf_reset(&iter->refname_buf);
+
+	if (iter->pos == iter->eof)
+		return ITER_DONE;
+
+	iter->base.flags = REF_ISPACKED;
+
+	if (iter->eof - p < GIT_SHA1_HEXSZ + 2 ||
+	    parse_oid_hex(p, &iter->oid, &p) ||
+	    !isspace(*p++))
+		die_invalid_line(iter->packed_refs->refs->path,
+				 iter->pos, iter->eof - iter->pos);
+
+	eol = memchr(p, '\n', iter->eof - p);
+	if (!eol)
+		die_unterminated_line(iter->packed_refs->refs->path,
+				      iter->pos, iter->eof - iter->pos);
+
+	strbuf_add(&iter->refname_buf, p, eol - p);
+	iter->base.refname = iter->refname_buf.buf;
+
+	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!refname_is_safe(iter->base.refname))
+			die("packed refname is dangerous: %s",
+			    iter->base.refname);
+		oidclr(&iter->oid);
+		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
+	}
+	if (iter->packed_refs->peeled == PEELED_FULLY ||
+	    (iter->packed_refs->peeled == PEELED_TAGS &&
+	     starts_with(iter->base.refname, "refs/tags/")))
+		iter->base.flags |= REF_KNOWS_PEELED;
+
+	iter->pos = eol + 1;
+
+	if (iter->pos < iter->eof && *iter->pos == '^') {
+		p = iter->pos + 1;
+		if (iter->eof - p < GIT_SHA1_HEXSZ + 1 ||
+		    parse_oid_hex(p, &iter->peeled, &p) ||
+		    *p++ != '\n')
+			die_invalid_line(iter->packed_refs->refs->path,
+					 iter->pos, iter->eof - iter->pos);
+		iter->pos = p;
+
+		/*
+		 * Regardless of what the file header said, we
+		 * definitely know the value of *this* reference. But
+		 * we suppress it if the reference is broken:
+		 */
+		if ((iter->base.flags & REF_ISBROKEN)) {
+			oidclr(&iter->peeled);
+			iter->base.flags &= ~REF_KNOWS_PEELED;
+		} else {
+			iter->base.flags |= REF_KNOWS_PEELED;
+		}
+	} else {
+		oidclr(&iter->peeled);
+	}
+
+	return ITER_OK;
+}
+
 static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
 	int ok;
 
-	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
+	while ((ok = next_record(iter)) == ITER_OK) {
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
-		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
+		    ref_type(iter->base.refname) != REF_TYPE_PER_WORKTREE)
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->iter0->refname,
-					    iter->iter0->oid,
-					    iter->iter0->flags))
+		    !ref_resolves_to_object(iter->base.refname, &iter->oid,
+					    iter->flags))
 			continue;
 
-		iter->base.refname = iter->iter0->refname;
-		iter->base.oid = iter->iter0->oid;
-		iter->base.flags = iter->iter0->flags;
 		return ITER_OK;
 	}
 
-	iter->iter0 = NULL;
 	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
 		ok = ITER_ERROR;
 
@@ -901,7 +832,14 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
 
-	return ref_iterator_peel(iter->iter0, peeled);
+	if ((iter->base.flags & REF_KNOWS_PEELED)) {
+		oidcpy(peeled, &iter->peeled);
+		return is_null_oid(&iter->peeled) ? -1 : 0;
+	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
+		return -1;
+	} else {
+		return !!peel_object(iter->oid.hash, peeled->hash);
+	}
 }
 
 static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
@@ -910,10 +848,8 @@ static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
 		(struct packed_ref_iterator *)ref_iterator;
 	int ok = ITER_DONE;
 
-	if (iter->iter0)
-		ok = ref_iterator_abort(iter->iter0);
-
-	release_packed_ref_cache(iter->cache);
+	strbuf_release(&iter->refname_buf);
+	release_packed_ref_cache(iter->packed_refs);
 	base_ref_iterator_free(ref_iterator);
 	return ok;
 }
@@ -939,6 +875,11 @@ static struct ref_iterator *packed_ref_iterator_begin(
 		required_flags |= REF_STORE_ODB;
 	refs = packed_downcast(ref_store, required_flags, "ref_iterator_begin");
 
+	packed_refs = get_packed_ref_cache(refs);
+
+	if (!packed_refs->buf)
+		return empty_ref_iterator_begin();
+
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
@@ -948,7 +889,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	 * the packed-ref cache is up to date with what is on disk,
 	 * and re-reads it if not.
 	 */
-	iter->cache = packed_refs = get_packed_ref_cache(refs);
+	iter->packed_refs = packed_refs;
 	acquire_packed_ref_cache(packed_refs);
 
 	if (prefix && *prefix)
@@ -956,8 +897,11 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	else
 		start = packed_refs->buf + packed_refs->header_len;
 
-	iter->iter0 = mmapped_ref_iterator_begin(packed_refs,
-						 start, packed_refs->eof);
+	iter->pos = start;
+	iter->eof = packed_refs->eof;
+	strbuf_init(&iter->refname_buf, 0);
+
+	iter->base.oid = &iter->oid;
 
 	iter->flags = flags;
 
-- 
2.14.1

