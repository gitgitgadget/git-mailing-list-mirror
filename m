Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C96520A21
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdIMRQ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:59 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62799 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751421AbdIMRQx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:53 -0400
X-AuditID: 1207440e-bf9ff70000007085-f9-59b968037360
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 11.9E.28805.30869B95; Wed, 13 Sep 2017 13:16:51 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIic001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:49 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/20] packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
Date:   Wed, 13 Sep 2017 19:16:08 +0200
Message-Id: <fa59662345ea577724d1c40fd8b7fdf7344cbd8e.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqMucsTPS4O1VI4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoEr4+mXbywF9zUrbn3uZWpgfK3QxcjJISFgIrFj5QmW
        LkYuDiGBHUwSty7tgHJOMkn0LH3BDlLFJqArsainmQnEFhFQk5jYdgisiFngKZPEzpN3WUES
        wgIREmcXbAdKcHCwCKhKLP6nCRLmFYiSWLCgjR1im7zEuQe3mUFsTgELiY07njCC2EIC5hKN
        c3YyTmDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJMD4djC2r5c5
        xCjAwajEw2thszNSiDWxrLgy9xCjJAeTkijvXl2gEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
        oCigHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgtcpHahRsCg1PbUi
        LTOnBCHNxMEJMpwHaLggSA1vcUFibnFmOkT+FKMuR8fNu3+YhFjy8vNSpcR5/6YCFQmAFGWU
        5sHNgSWGV4ziQG8J89qDjOIBJhW4Sa+AljABLTlzegfIkpJEhJRUA6PNAua/3zu3cn5u+LhM
        r17r7zr+ezen6dbMXVkZc/BrbJSJTMF19oXvCvN9Xjcbpuy2DyyQ22PYcem6c2jMFrlvlTkN
        ykZSrw55n3OXmuV7QOCX+u4DOUtiTV+orF//IbNz9/xNd0S5b24Mij/6dxHzVVef5Dq1CXZt
        C7j3i9ood17V/73exE+JpTgj0VCLuag4EQA4Uard5wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have an efficient way to iterate, in order, over the
mmapped contents of the `packed-refs` file, we can use that directly
to implement reference iteration for the `packed_ref_store`, rather
than iterating over the `ref_cache`. This is the next step towards
getting rid of the `ref_cache` entirely.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 2a36dd9afb..a018a6c8ad 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -372,6 +372,27 @@ static int cmp_packed_ref_entries(const void *v1, const void *v2)
 	}
 }
 
+/*
+ * Compare a packed-refs record pointed to by `rec` to the specified
+ * NUL-terminated refname.
+ */
+static int cmp_entry_to_refname(const char *rec, const char *refname)
+{
+	const char *r1 = rec + GIT_SHA1_HEXSZ + 1;
+	const char *r2 = refname;
+
+	while (1) {
+		if (*r1 == '\n')
+			return *r2 ? -1 : 0;
+		if (!*r2)
+			return 1;
+		if (*r1 != *r2)
+			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
+		r1++;
+		r2++;
+	}
+}
+
 /*
  * `packed_refs->buf` is not known to be sorted. Check whether it is,
  * and if not, sort it into new memory and munmap/free the old
@@ -478,6 +499,17 @@ static const char *find_start_of_record(const char *buf, const char *p)
 	return p;
 }
 
+/*
+ * Return a pointer to the start of the record following the record
+ * that contains `*p`. If none is found before `end`, return `end`.
+ */
+static const char *find_end_of_record(const char *p, const char *end)
+{
+	while (++p < end && (p[-1] != '\n' || p[0] == '^'))
+		;
+	return p;
+}
+
 /*
  * We want to be able to compare mmapped reference records quickly,
  * without totally parsing them. We can do so because the records are
@@ -511,6 +543,65 @@ static void verify_buffer_safe(struct packed_ref_cache *packed_refs)
 				 last_line, eof - last_line);
 }
 
+/*
+ * Find the place in `cache->buf` where the start of the record for
+ * `refname` starts. If `mustexist` is true and the reference doesn't
+ * exist, then return NULL. If `mustexist` is false and the reference
+ * doesn't exist, then return the point where that reference would be
+ * inserted. In the latter mode, `refname` doesn't have to be a proper
+ * reference name; for example, one could search for "refs/replace/"
+ * to find the start of any replace references.
+ *
+ * The record is sought using a binary search, so `cache->buf` must be
+ * sorted.
+ */
+static const char *find_reference_location(struct packed_ref_cache *cache,
+					   const char *refname, int mustexist)
+{
+	/*
+	 * This is not *quite* a garden-variety binary search, because
+	 * the data we're searching is made up of records, and we
+	 * always need to find the beginning of a record to do a
+	 * comparison. A "record" here is one line for the reference
+	 * itself and zero or one peel lines that start with '^'. Our
+	 * loop invariant is described in the next two comments.
+	 */
+
+	/*
+	 * A pointer to the character at the start of a record whose
+	 * preceding records all have reference names that come
+	 * *before* `refname`.
+	 */
+	const char *lo = cache->buf + cache->header_len;
+
+	/*
+	 * A pointer to a the first character of a record whose
+	 * reference name comes *after* `refname`.
+	 */
+	const char *hi = cache->eof;
+
+	while (lo < hi) {
+		const char *mid, *rec;
+		int cmp;
+
+		mid = lo + (hi - lo) / 2;
+		rec = find_start_of_record(lo, mid);
+		cmp = cmp_entry_to_refname(rec, refname);
+		if (cmp < 0) {
+			lo = find_end_of_record(mid, hi);
+		} else if (cmp > 0) {
+			hi = rec;
+		} else {
+			return rec;
+		}
+	}
+
+	if (mustexist)
+		return NULL;
+	else
+		return lo;
+}
+
 /*
  * Read from the `packed-refs` file into a newly-allocated
  * `packed_ref_cache` and return it. The return value will already
@@ -818,6 +909,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 		const char *prefix, unsigned int flags)
 {
 	struct packed_ref_store *refs;
+	struct packed_ref_cache *packed_refs;
+	const char *start;
 	struct packed_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
@@ -835,13 +928,23 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	 * the packed-ref cache is up to date with what is on disk,
 	 * and re-reads it if not.
 	 */
+	iter->cache = packed_refs = get_packed_ref_cache(refs);
+	acquire_packed_ref_cache(packed_refs);
 
-	iter->cache = get_packed_ref_cache(refs);
-	acquire_packed_ref_cache(iter->cache);
-	iter->iter0 = cache_ref_iterator_begin(iter->cache->cache, prefix, 0);
+	if (prefix && *prefix)
+		start = find_reference_location(packed_refs, prefix, 0);
+	else
+		start = packed_refs->buf + packed_refs->header_len;
+
+	iter->iter0 = mmapped_ref_iterator_begin(
+			packed_refs, start, packed_refs->eof);
 
 	iter->flags = flags;
 
+	if (prefix && *prefix)
+		/* Stop iteration after we've gone *past* prefix: */
+		ref_iterator = prefix_ref_iterator_begin(ref_iterator, prefix, 0);
+
 	return ref_iterator;
 }
 
-- 
2.14.1

