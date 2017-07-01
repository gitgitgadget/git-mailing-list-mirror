Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543BE20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdGAScW (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:22 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59137 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752121AbdGAScV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:21 -0400
X-AuditID: 1207440c-c4dff70000001e54-3a-5957eab4419e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.2E.07764.4BAE7595; Sat,  1 Jul 2017 14:32:20 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBf010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:18 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 28/30] repack_without_refs(): don't lock or unlock the packed refs
Date:   Sat,  1 Jul 2017 20:31:06 +0200
Message-Id: <5354fb6b0a1ac30061ecf30852ee877b599ae1ac.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvlVXikwfzDohZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGUsfDyLrWC/XsXsd0YNjNdUuxg5
        OSQETCRaXk1h7GLk4hAS2MEksWLecyYI5ySTxKRXfxhBqtgEdCUW9TQzgdgiAmoSE9sOsYAU
        MQtMYpZ4e20hWEJYIFTiybQPYDaLgKrE0bbdrCA2r0CUxKnbf9kh1slL7Gq7CBbnFLCQ+NO2
        nhnEFhIwl2g+2McygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQ
        oOPZwfhtncwhRgEORiUe3g0hYZFCrIllxZW5hxglOZiURHlXXguNFOJLyk+pzEgszogvKs1J
        LT7EKMHBrCTCm/s8PFKINyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PBoSTB
        ywSMLiHBotT01Iq0zJwShDQTByfIcB6g4QvvggwvLkjMLc5Mh8ifYtTleDXh/zcmIZa8/LxU
        KXHe1pdARQIgRRmleXBzYMniFaM40FvCvAwg63iAiQZu0iugJUxAS4RnhIAsKUlESEk1MDaq
        HrzLwrzL6Oz1ijkxnwtyHfMN/ugfE/Z5ovrfzHntX6cTOw/PtCw/zH40eF3svzCXdf6tAYJx
        +X0y+jLmNsxcz4/qTLky089TiKlq4dcdpUFeB/cdYORab1m2m3vZbolLimlpl3P1ur1e35ou
        k3BN16ic5aJa6xKN/L2XotQm6nJsD740RYmlOCPRUIu5qDgRAHc1a83xAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change `repack_without_refs()` to expect the packed-refs lock to be
held already, and not to release the lock before returning. Change the
callers to deal with lock management.

This change makes it possible for callers to hold the packed-refs lock
for a longer span of time, a possibility that will eventually make it
possible to fix some longstanding races.

The only semantic change here is that `repack_without_refs()` used to
forget to release the lock in the `if (!removed)` exit path. That
omission is now fixed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  | 47 +++++++++++++++++++++++++++++++----------------
 refs/packed-backend.c | 32 ++++++++------------------------
 2 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 93bdc8f0c8..e9b95592b6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1149,24 +1149,16 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	if (!refnames->nr)
 		return 0;
 
-	result = repack_without_refs(refs->packed_ref_store, refnames, &err);
-	if (result) {
-		/*
-		 * If we failed to rewrite the packed-refs file, then
-		 * it is unsafe to try to remove loose refs, because
-		 * doing so might expose an obsolete packed value for
-		 * a reference that might even point at an object that
-		 * has been garbage collected.
-		 */
-		if (refnames->nr == 1)
-			error(_("could not delete reference %s: %s"),
-			      refnames->items[0].string, err.buf);
-		else
-			error(_("could not delete references: %s"), err.buf);
+	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
+		goto error;
 
-		goto out;
+	if (repack_without_refs(refs->packed_ref_store, refnames, &err)) {
+		packed_refs_unlock(refs->packed_ref_store);
+		goto error;
 	}
 
+	packed_refs_unlock(refs->packed_ref_store);
+
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
@@ -1174,9 +1166,24 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
-out:
 	strbuf_release(&err);
 	return result;
+
+error:
+	/*
+	 * If we failed to rewrite the packed-refs file, then it is
+	 * unsafe to try to remove loose refs, because doing so might
+	 * expose an obsolete packed value for a reference that might
+	 * even point at an object that has been garbage collected.
+	 */
+	if (refnames->nr == 1)
+		error(_("could not delete reference %s: %s"),
+		      refnames->items[0].string, err.buf);
+	else
+		error(_("could not delete references: %s"), err.buf);
+
+	strbuf_release(&err);
+	return -1;
 }
 
 /*
@@ -2569,11 +2576,19 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		}
 	}
 
+	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
 	if (repack_without_refs(refs->packed_ref_store, &refs_to_delete, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
+		packed_refs_unlock(refs->packed_ref_store);
 		goto cleanup;
 	}
 
+	packed_refs_unlock(refs->packed_ref_store);
+
 	/* Delete the reflogs of any references that were deleted: */
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
 		strbuf_reset(&sb);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5cf6b3d40e..377c775adb 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -669,25 +669,12 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	return -1;
 }
 
-/*
- * Rollback the lockfile for the packed-refs file, and discard the
- * in-memory packed reference cache.  (The packed-refs file will be
- * read anew if it is needed again after this function is called.)
- */
-static void rollback_packed_refs(struct packed_ref_store *refs)
-{
-	packed_assert_main_repository(refs, "rollback_packed_refs");
-
-	if (!is_lock_file_locked(&refs->lock))
-		die("BUG: packed-refs not locked");
-	packed_refs_unlock(&refs->base);
-	clear_packed_ref_cache(refs);
-}
-
 /*
  * Rewrite the packed-refs file, omitting any refs listed in
  * 'refnames'. On error, leave packed-refs unchanged, write an error
- * message to 'err', and return a nonzero value.
+ * message to 'err', and return a nonzero value. The packed refs lock
+ * must be held when calling this function; it will still be held when
+ * the function returns.
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
@@ -700,11 +687,13 @@ int repack_without_refs(struct ref_store *ref_store,
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int needs_repacking = 0, removed = 0;
-	int ret;
 
 	packed_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
 
+	if (!is_lock_file_locked(&refs->lock))
+		die("BUG: repack_without_refs called without holding lock");
+
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
 		if (get_packed_ref(refs, refname->string)) {
@@ -717,9 +706,6 @@ int repack_without_refs(struct ref_store *ref_store,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (packed_refs_lock(&refs->base, 0, err))
-		return -1;
-
 	packed = get_packed_refs(refs);
 
 	/* Remove refnames from the cache */
@@ -731,14 +717,12 @@ int repack_without_refs(struct ref_store *ref_store,
 		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_packed_refs(refs);
+		clear_packed_ref_cache(refs);
 		return 0;
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs(&refs->base, err);
-	packed_refs_unlock(ref_store);
-	return ret;
+	return commit_packed_refs(&refs->base, err);
 }
 
 static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
-- 
2.11.0

