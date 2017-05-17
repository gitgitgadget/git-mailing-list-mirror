Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B032201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbdEQMGS (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:18 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55110 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753184AbdEQMGN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:13 -0400
X-AuditID: 12074413-0c9ff70000001dc3-d3-591c3cb48be3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 09.8E.07619.4BC3C195; Wed, 17 May 2017 08:06:12 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg0000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:10 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/23] files-backend: move `lock` member to `files_ref_store`
Date:   Wed, 17 May 2017 14:05:32 +0200
Message-Id: <9b52c29411fa11ac0d8227d5ae78ba2768485b3f.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqLvFRibS4OEkNYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGuXcz2Qo2ylecmPWetYHxtWQXIweHhICJ
        RM9G5i5GLg4hgR1MErMPLmCHcE4wSZz+Po2xi5GTg01AV2JRTzMTiC0ioCYxse0QC0gRs8Bj
        Jom/y7pZQBLCAr4SW89uACtiEVCVaHv1kRnE5hWIkthw9ByYLSEgL7Gr7SIriM0pYCFx//0j
        dpArhATMJbZfr5zAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkig
        Ce9g3HVS7hCjAAejEg/vBC7pSCHWxLLiytxDjJIcTEqivPsfAIX4kvJTKjMSizPii0pzUosP
        MUpwMCuJ8N40lYkU4k1JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CyWpwcAjcXdK7
        gVGKJS8/L1VJglfIGmiIYFFqempFWmZOCUIpEwcnyCIeoEVcIDW8xQWJucWZ6RD5U4yKUuK8
        sVZACQGQREZpHlwvLEG8YhQHekuYNw+knQeYXOC6XwENZgIa3AzyHW9xSSJCSqqBkf/W5ne+
        nNKzcxscunduaF+V2mHa61gwbe/2Rp6vxXMeeHJNv3gi+Z3X4qV919/MW5a9fdI73sOajC6N
        Hsfu5xpka5jHLRb9tpTnrvC2rUW8giJ/hD/mWBj6Xv7TrHU4QPK8zW21nunKfJ+v3VX3nnCr
        d5NW3+qzFvN62h6HFvg2aHLMtNa+rcRSnJFoqMVcVJwIADUUSlDrAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the `lock` member from `packed_ref_cache` to `files_ref_store`,
since at most one cache can have a locked "packed-refs" file
associated with it. Rename it to `packlock` to make its purpose
clearer in its new home. More changes are coming here shortly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7708994e82..e7ae5538cc 100644
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
+	struct lock_file *packlock;
 };
 
 /* Lock used for the main packed-refs file: */
@@ -104,7 +102,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 	if (refs->packed) {
 		struct packed_ref_cache *packed_refs = refs->packed;
 
-		if (packed_refs->lock)
+		if (refs->packlock)
 			die("internal error: packed-ref cache cleared while locked");
 		refs->packed = NULL;
 		release_packed_ref_cache(packed_refs);
@@ -408,7 +406,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 {
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
-	if (!packed_ref_cache->lock)
+	if (!refs->packlock)
 		die("internal error: packed refs not locked");
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		      create_ref_entry(refname, sha1, REF_ISPACKED, 1));
@@ -1312,7 +1310,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * the packed-refs file.
 	 */
 	packed_ref_cache = get_packed_ref_cache(refs);
-	packed_ref_cache->lock = &packlock;
+	refs->packlock = &packlock;
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
@@ -1335,10 +1333,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
-	if (!packed_ref_cache->lock)
+	if (!refs->packlock)
 		die("internal error: packed-refs not locked");
 
-	out = fdopen_lock_file(packed_ref_cache->lock, "w");
+	out = fdopen_lock_file(refs->packlock, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
@@ -1356,11 +1354,11 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_lock_file(packed_ref_cache->lock)) {
+	if (commit_lock_file(refs->packlock)) {
 		save_errno = errno;
 		error = -1;
 	}
-	packed_ref_cache->lock = NULL;
+	refs->packlock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
 	errno = save_errno;
 	return error;
@@ -1378,10 +1376,10 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "rollback_packed_refs");
 
-	if (!packed_ref_cache->lock)
+	if (!refs->packlock)
 		die("internal error: packed-refs not locked");
-	rollback_lock_file(packed_ref_cache->lock);
-	packed_ref_cache->lock = NULL;
+	rollback_lock_file(refs->packlock);
+	refs->packlock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(refs);
 }
-- 
2.11.0

