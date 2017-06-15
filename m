Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56E420401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbdFOOst (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:49 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57536 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752481AbdFOOsr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:47 -0400
X-AuditID: 12074413-d7bff7000000742e-43-59429e489633
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.83.29742.84E92495; Thu, 15 Jun 2017 10:48:40 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRL014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:38 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 27/28] repack_without_refs(): don't lock or unlock the packed refs
Date:   Thu, 15 Jun 2017 16:47:32 +0200
Message-Id: <44c3fe546430eead4af08479c2bc30cef37d973e.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqOsxzynS4NYtQ4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJW3NnKXrBfr2LRo9QGxmuqXYyc
        HBICJhI/j/9l7GLk4hAS2MEkMe/xfSYI5ySTRNOPJlaQKjYBXYlFPc1MILaIgJrExLZDLCBF
        zAKTmCXeXlsIlhAWCJL4Mn8pC4jNIqAqMePZcjCbVyBKYun6X+wQ6+QldrVdBBvKKWAhMfvL
        OuYuRg6gbeYSx5ZrTGDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11wvN7NELzWldBMj
        JOSEdzDuOil3iFGAg1GJh/dErVOkEGtiWXFl7iFGSQ4mJVFefjmgEF9SfkplRmJxRnxRaU5q
        8SFGCQ5mJRHeqXOAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV7j
        uUCNgkWp6akVaZk5JQhpJg5OkOE8QMP/gg0vLkjMLc5Mh8ifYlSUEufNAmkWAElklObB9cJS
        witGcaBXhHn7Qap4gOkErvsV0GAmoMFBFxxABpckIqSkGhjtPNLF/JbNXhxhcva9lTOH8wNb
        N74a7seXlA/4FAqUnLiuvH7f45bfuYF13qvsjjbvL+8xeuzePv/A3+uS1S/Db53y2LeB0+fH
        I8Ojmb8ZfdNnNws+qxK+9mTWg5VCOYwbNmzfxbvf8Fdhb/sMvnuTxAuPvzjm2OPfdsz+u8vW
        P3q3XOyFFA2UWIozEg21mIuKEwFZx5YM5AIAAA==
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
forgot to release the lock in the `if (!removed)` exit path. That
omission is now fixed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  | 47 +++++++++++++++++++++++++++++++----------------
 refs/packed-backend.c | 32 ++++++++------------------------
 2 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 09dad2806e..972dd5c0c9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1137,24 +1137,16 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
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
 
@@ -1162,9 +1154,24 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
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
@@ -2557,11 +2564,19 @@ static int files_transaction_finish(struct ref_store *ref_store,
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
index 54b48d1f02..721afd066a 100644
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

