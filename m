Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2497C2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbdEVOSi (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:38 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56192 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934683AbdEVOSd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:33 -0400
X-AuditID: 1207440e-7afff70000007d8a-51-5922f3376028
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 44.59.32138.733F2295; Mon, 22 May 2017 10:18:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24J023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:29 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/25] files-backend: move `lock` member to `files_ref_store`
Date:   Mon, 22 May 2017 16:17:40 +0200
Message-Id: <21939432bc90e0cb58f4b8e1e6a082b9beee93b3.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqGv+WSnSYNs+K4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxs2LM1kLnshX
        7Gy7wtrAuEiqi5GTQ0LAROLeq7vMXYxcHEICO5gkFk2+wQThnGKSaHr6jgWkik1AV2JRTzMT
        iC0ioCYxse0QC0gRs8AGZok301eDJYQFAiQ+NmwDsjk4WARUJV63aoGEeQWiJA6/Xc0CsU1e
        YlfbRVYQm1PAQuL3rANgrUIC5hK9/1azTGDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI
        11gvN7NELzWldBMjJBD5djC2r5c5xCjAwajEw6vxWClSiDWxrLgy9xCjJAeTkijv0TdAIb6k
        /JTKjMTijPii0pzU4kOMEhzMSiK82neBcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2amp
        BalFMFkNDg6Bu0t6NzBKseTl56UqSfDqfQIaIliUmp5akZaZU4JQysTBCbKIB2jRmg8gi4oL
        EnOLM9Mh8qcYFaXEeQ1AmgVAEhmleXC9sATyilEc6C1h3kKQKh5g8oHrfgU0mAlosPUzeZDB
        JYkIKakGxo7EI8bCd8I9PU4XqxyR93N61v7u8MZrJxvTyx8t+Fw3vbqBme/NrRl8qdX/J8jL
        SLzRZiy8MXVOwIMnU+fmbxCev/YYz1v/4iUZ/NZujQsXXMg8ufHo/dZFGjWFEonr/0fWz3+9
        923T7vnFOaV/WFfu2b/I6cSckGmamuU3Z972ef/VNfOejLESS3FGoqEWc1FxIgB52STV+wIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the `lock` member from `packed_ref_cache` to `files_ref_store`,
since at most one cache can have a locked "packed-refs" file
associated with it. Rename it to `packed_refs_lock` to make its
purpose clearer in its new home. More changes are coming here shortly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fce8265aa7..bfc555a417 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -43,15 +43,6 @@ struct packed_ref_cache {
 	 */
 	unsigned int referrers;
 
-	/*
-	 * Iff the packed-refs file associated with this instance is
-	 * currently locked for writing, this points at the associated
-	 * lock (which is owned by somebody else).  The referrer count
-	 * is also incremented when the file is locked and decremented
-	 * when it is unlocked.
-	 */
-	struct lock_file *lock;
-
 	/* The metadata from when this packed-refs cache was read */
 	struct stat_validity validity;
 };
@@ -70,6 +61,13 @@ struct files_ref_store {
 
 	struct ref_cache *loose;
 	struct packed_ref_cache *packed;
+
+	/*
+	 * Iff the packed-refs file associated with this instance is
+	 * currently locked for writing, this points at the associated
+	 * lock (which is owned by somebody else).
+	 */
+	struct lock_file *packed_refs_lock;
 };
 
 /* Lock used for the main packed-refs file: */
@@ -104,7 +102,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 	if (refs->packed) {
 		struct packed_ref_cache *packed_refs = refs->packed;
 
-		if (packed_refs->lock)
+		if (refs->packed_refs_lock)
 			die("BUG: packed-ref cache cleared while locked");
 		refs->packed = NULL;
 		release_packed_ref_cache(packed_refs);
@@ -396,7 +394,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 {
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
-	if (!packed_ref_cache->lock)
+	if (!refs->packed_refs_lock)
 		die("BUG: packed refs not locked");
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		      create_ref_entry(refname, oid, REF_ISPACKED, 1));
@@ -1300,7 +1298,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * the packed-refs file.
 	 */
 	packed_ref_cache = get_packed_ref_cache(refs);
-	packed_ref_cache->lock = &packlock;
+	refs->packed_refs_lock = &packlock;
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
@@ -1323,10 +1321,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
-	if (!packed_ref_cache->lock)
+	if (!refs->packed_refs_lock)
 		die("BUG: packed-refs not locked");
 
-	out = fdopen_lock_file(packed_ref_cache->lock, "w");
+	out = fdopen_lock_file(refs->packed_refs_lock, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
@@ -1344,11 +1342,11 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_lock_file(packed_ref_cache->lock)) {
+	if (commit_lock_file(refs->packed_refs_lock)) {
 		save_errno = errno;
 		error = -1;
 	}
-	packed_ref_cache->lock = NULL;
+	refs->packed_refs_lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
 	errno = save_errno;
 	return error;
@@ -1366,10 +1364,10 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "rollback_packed_refs");
 
-	if (!packed_ref_cache->lock)
+	if (!refs->packed_refs_lock)
 		die("BUG: packed-refs not locked");
-	rollback_lock_file(packed_ref_cache->lock);
-	packed_ref_cache->lock = NULL;
+	rollback_lock_file(refs->packed_refs_lock);
+	refs->packed_refs_lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(refs);
 }
-- 
2.11.0

