Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EE020281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbdISGXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:16 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42102 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbdISGXK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:10 -0400
X-AuditID: 1207440c-7e5ff7000000143e-ff-59c0b7cdf0e5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 41.47.05182.DC7B0C95; Tue, 19 Sep 2017 02:23:09 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1m002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/21] packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
Date:   Tue, 19 Sep 2017 08:22:23 +0200
Message-Id: <81f7f71db378c38e51e0d995f458d8fbd1ea43c9.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqHt2+4FIg0vvJSzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZXR1vmAsOKRZsXrubpYGxisKXYyc
        HBICJhIrVp1n62Lk4hAS2MEk0TK7gxnCOcUk8fDZY3aQKjYBXYlFPc1MILaIgJrExLZDLCBF
        zAIrmSUmbb3CCpIQFoiWODp3DlARBweLgKrE/ZNWIGFegSiJ5y9fskJsk5c49+A2M4jNKWAh
        0bxnOwtIuZCAucSBo8UTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSnd
        xAgJOJ4djN/WyRxiFOBgVOLhFbi2P1KINbGsuDL3EKMkB5OSKG/YpgORQnxJ+SmVGYnFGfFF
        pTmpxYcYJTiYlUR4Dy0CyvGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiU
        JHgVgZElJFiUmp5akZaZU4KQZuLgBBnOAzRcBaSGt7ggMbc4Mx0if4pRl6Pj5t0/TEIsefl5
        qVLivPe3ARUJgBRllObBzYElileM4kBvCfM2gFTxAJMM3KRXQEuYgJZkbwBbUpKIkJJqYFQK
        mmv3WHbjl8pjXSVr93seP5DYcaqp8KbF7XM29or5x9e0fVracGj+4QXOhxOjz+llivOvqMjl
        5dxlmf3e9n20+4qeUyyX+WKYw2UmX7hqdmVTlbNsyoyNzy4ujZk7n+2LprTCj6opnsmFLBGe
        N07FquoVy/BduZXxaYXvSYMsm4jt8WLL1JVYijMSDbWYi4oTAa8CcZPvAgAA
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
index f336690f16..53d0b7e3d6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -397,6 +397,27 @@ static int cmp_packed_ref_entries(const void *v1, const void *v2)
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
@@ -503,6 +524,17 @@ static const char *find_start_of_record(const char *buf, const char *p)
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
@@ -591,6 +623,65 @@ static int load_contents(struct packed_ref_cache *packed_refs)
 	return 1;
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
@@ -887,6 +978,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 		const char *prefix, unsigned int flags)
 {
 	struct packed_ref_store *refs;
+	struct packed_ref_cache *packed_refs;
+	const char *start;
 	struct packed_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
@@ -904,13 +997,23 @@ static struct ref_iterator *packed_ref_iterator_begin(
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

