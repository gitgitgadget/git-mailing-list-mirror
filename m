Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A3D20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbdGASbx (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:53 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59200 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752040AbdGASbw (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:52 -0400
X-AuditID: 12074411-cebff700000033ea-47-5957ea8c8b88
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.BA.13290.C8AE7595; Sat,  1 Jul 2017 14:31:40 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBO010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:38 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/30] lock_packed_refs(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:49 +0200
Message-Id: <f459f865a71462d9ddac20c9d01fbb80470c24e7.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNvzKjzSoOuHssXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBldW+8wFkyWqejb9YG1gXGaeBcj
        J4eEgInEpNnXmLsYuTiEBHYwSWz5858VwjnJJDH33wNWkCo2AV2JRT3NTCC2iICaxMS2Qywg
        RcwCk5gl3l5bCJYQFgiWmPviFwuIzSKgKnFk90N2EJtXIEriyafFrBDr5CV2tV0EszkFLCT+
        tK1nBrGFBMwlmg/2sUxg5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQT
        IyTsBHcwzjgpd4hRgINRiYd3Q0hYpBBrYllxZe4hRkkOJiVR3pXXQiOF+JLyUyozEosz4otK
        c1KLDzFKcDArifDmPg+PFOJNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAo
        SfBOegnUKFiUmp5akZaZU4KQZuLgBBnOAzR84V2Q4cUFibnFmekQ+VOMuhyvJvz/xiTEkpef
        lyolztsKMkgApCijNA9uDixdvGIUB3pLmDfiBVAVDzDVwE16BbSECWiJ8IwQkCUliQgpqQbG
        1MJ1LO/1WDpMHy1mNJhQbsOi8TBNwPlVWeG885ym+wvKD/RWZ0/oUDfuU39u6Rt+8zlT13Ht
        Wbw3ezqnM9/MFBFdX3VoWVhDp8emgxMfrPgxp2auSmrf4Qe7Xb7MevKlJ8P1h73ztl9nAx+5
        75wxWfLJgtAjW+vff761pWVu3qfN7es+3KycqMRSnJFoqMVcVJwIAFpPFo/yAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4943207098..0d8f39089f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -80,6 +80,19 @@ static struct packed_ref_store *packed_ref_store_create(
 	return refs;
 }
 
+/*
+ * Die if refs is not the main ref store. caller is used in any
+ * necessary error messages.
+ */
+static void packed_assert_main_repository(struct packed_ref_store *refs,
+					  const char *caller)
+{
+	if (refs->store_flags & REF_STORE_MAIN)
+		return;
+
+	die("BUG: operation %s only allowed for main ref store", caller);
+}
+
 /*
  * Future: need to be in "struct repository"
  * when doing a full libification.
@@ -1334,13 +1347,13 @@ static void write_packed_entry(FILE *fh, const char *refname,
  * hold_lock_file_for_update(). Return 0 on success. On errors, set
  * errno appropriately and return a nonzero value.
  */
-static int lock_packed_refs(struct files_ref_store *refs, int flags)
+static int lock_packed_refs(struct packed_ref_store *refs, int flags)
 {
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
 	struct packed_ref_cache *packed_ref_cache;
 
-	files_assert_main_repository(refs, "lock_packed_refs");
+	packed_assert_main_repository(refs, "lock_packed_refs");
 
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
@@ -1348,8 +1361,8 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	}
 
 	if (hold_lock_file_for_update_timeout(
-			    &refs->packed_ref_store->lock,
-			    refs->packed_ref_store->path,
+			    &refs->lock,
+			    refs->path,
 			    flags, timeout_value) < 0)
 		return -1;
 
@@ -1361,9 +1374,9 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * cache is still valid. We've just locked the file, but it
 	 * might have changed the moment *before* we locked it.
 	 */
-	validate_packed_ref_cache(refs->packed_ref_store);
+	validate_packed_ref_cache(refs);
 
-	packed_ref_cache = get_packed_ref_cache(refs->packed_ref_store);
+	packed_ref_cache = get_packed_ref_cache(refs);
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
@@ -1560,7 +1573,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	int ok;
 	struct ref_to_prune *refs_to_prune = NULL;
 
-	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
+	lock_packed_refs(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
@@ -1629,7 +1642,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(refs, 0)) {
+	if (lock_packed_refs(refs->packed_ref_store, 0)) {
 		unable_to_lock_message(refs->packed_ref_store->path, errno, err);
 		return -1;
 	}
@@ -3198,7 +3211,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
-	if (lock_packed_refs(refs, 0)) {
+	if (lock_packed_refs(refs->packed_ref_store, 0)) {
 		strbuf_addf(err, "unable to lock packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
-- 
2.11.0

