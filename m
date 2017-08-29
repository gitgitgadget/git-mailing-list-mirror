Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BAC20285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdH2IVE (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:21:04 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52717 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751066AbdH2IU7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:20:59 -0400
X-AuditID: 1207440d-853ff70000000f42-54-59a523e9ab10
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A3.61.03906.9E325A95; Tue, 29 Aug 2017 04:20:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcS2002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:56 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/10] files_ref_store: use a transaction to update packed refs
Date:   Tue, 29 Aug 2017 10:20:32 +0200
Message-Id: <25b38730abe97c29d04116b4b2c6067934dfca14.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqPtKeWmkwdPvLBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxsf709gLWoMrDi67wtbA+M65i5GTQ0LAROJw/3f2
        LkYuDiGBHUwSbU+3s0E4J5kkTq04xg5SxSagK7Gop5kJxBYRUJOY2HaIBaSIWeApk8TOk3dZ
        QRLCAv4Sk99PYO5i5OBgEVCVmLhDFSTMKxAlMfnLSkaIbfIS5x7cZgaxOQUsJC59fgQWFxIw
        lzjd+YB5AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghAca7g/H/
        OplDjAIcjEo8vCusl0QKsSaWFVfmHmKU5GBSEuXNUFgaKcSXlJ9SmZFYnBFfVJqTWnyIUYKD
        WUmEN5gdKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuDlAkaSkGBR
        anpqRVpmTglCmomDE2Q4D9BwJ5Aa3uKCxNzizHSI/ClGRSlx3gmKQAkBkERGaR5cLywBvGIU
        B3pFmNcXpJ0HmDzgul8BDWYCGqwouBBkcEkiQkqqgXGScH3R4rlOkV6nrGrZf0+Zahjr9OtY
        wa9DsQdON1n5zvqpkbDdYc8GARu1Ykt1Xl/j7DgLht71bVvUTc67aj5IPbJv8re7B4NzNya2
        LJjl3iL8pVwjtjP8oUFWi0bBpS3eT9qOaLebLQoS43h0zGJfuJnos8Yff+ed013f8PDRa4GZ
        sx4yT1ZiKc5INNRiLipOBABzxtmK2wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When processing a `files_ref_store` transaction, it is sometimes
necessary to delete some references from the "packed-refs" file. Do
that using a reference transaction conducted against the
`packed_ref_store`.

This change further decouples `files_ref_store` from
`packed_ref_store`. It also fixes multiple problems, including the two
revealed by test cases added in the previous commit.

First, the old code didn't obtain the `packed-refs` lock until
`files_transaction_finish()`. This means that a failure to acquire the
`packed-refs` lock (e.g., due to contention with another process)
wasn't detected until it was too late (problems like this are supposed
to be detected in the "prepare" phase). The new code acquires the
`packed-refs` lock in `files_transaction_prepare()`, the same stage of
the processing when the loose reference locks are being acquired,
removing another reason why the "prepare" phase might succeed and the
"finish" phase might nevertheless fail.

Second, the old code deleted the loose version of a reference before
deleting any packed version of the same reference. This left a moment
when another process might think that the packed version of the
reference is current, which is incorrect. (Even worse, the packed
version of the reference can be arbitrarily old, and might even point
at an object that has since been garbage-collected.)

Third, if a reference deletion fails to acquire the `packed-refs` lock
altogether, then the old code might leave the repository in the
incorrect state (possibly corrupt) described in the previous
paragraph.

Now we activate the new "packed-refs" file (sans any references that
are being deleted) *before* deleting the corresponding loose
references. But we hold the "packed-refs" lock until after the loose
references have been finalized, thus preventing a simultaneous
"pack-refs" process from packing the loose version of the reference in
the time gap, which would otherwise defeat our attempt to delete it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c         | 132 +++++++++++++++++++++++++++++++++----------
 t/t1404-update-ref-errors.sh |   4 +-
 2 files changed, 103 insertions(+), 33 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29c7c78602..4f4c47b9db 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2391,13 +2391,22 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	return 0;
 }
 
+struct files_transaction_backend_data {
+	struct ref_transaction *packed_transaction;
+	int packed_refs_locked;
+};
+
 /*
  * Unlock any references in `transaction` that are still locked, and
  * mark the transaction closed.
  */
-static void files_transaction_cleanup(struct ref_transaction *transaction)
+static void files_transaction_cleanup(struct files_ref_store *refs,
+				      struct ref_transaction *transaction)
 {
 	size_t i;
+	struct files_transaction_backend_data *backend_data =
+		transaction->backend_data;
+	struct strbuf err = STRBUF_INIT;
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2409,6 +2418,17 @@ static void files_transaction_cleanup(struct ref_transaction *transaction)
 		}
 	}
 
+	if (backend_data->packed_transaction &&
+	    ref_transaction_abort(backend_data->packed_transaction, &err)) {
+		error("error aborting transaction: %s", err.buf);
+		strbuf_release(&err);
+	}
+
+	if (backend_data->packed_refs_locked)
+		packed_refs_unlock(refs->packed_ref_store);
+
+	free(backend_data);
+
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
@@ -2425,12 +2445,17 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	char *head_ref = NULL;
 	int head_type;
 	struct object_id head_oid;
+	struct files_transaction_backend_data *backend_data;
+	struct ref_transaction *packed_transaction = NULL;
 
 	assert(err);
 
 	if (!transaction->nr)
 		goto cleanup;
 
+	backend_data = xcalloc(1, sizeof(*backend_data));
+	transaction->backend_data = backend_data;
+
 	/*
 	 * Fail if a refname appears more than once in the
 	 * transaction. (If we end up splitting up any updates using
@@ -2497,6 +2522,41 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					  head_ref, &affected_refnames, err);
 		if (ret)
 			break;
+
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY) &&
+		    !(update->flags & REF_ISPRUNING)) {
+			/*
+			 * This reference has to be deleted from
+			 * packed-refs if it exists there.
+			 */
+			if (!packed_transaction) {
+				packed_transaction = ref_store_transaction_begin(
+						refs->packed_ref_store, err);
+				if (!packed_transaction) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto cleanup;
+				}
+
+				backend_data->packed_transaction =
+					packed_transaction;
+			}
+
+			ref_transaction_add_update(
+					packed_transaction, update->refname,
+					update->flags & ~REF_HAVE_OLD,
+					update->new_oid.hash, update->old_oid.hash,
+					NULL);
+		}
+	}
+
+	if (packed_transaction) {
+		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto cleanup;
+		}
+		backend_data->packed_refs_locked = 1;
+		ret = ref_transaction_prepare(packed_transaction, err);
 	}
 
 cleanup:
@@ -2504,7 +2564,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	string_list_clear(&affected_refnames, 0);
 
 	if (ret)
-		files_transaction_cleanup(transaction);
+		files_transaction_cleanup(refs, transaction);
 	else
 		transaction->state = REF_TRANSACTION_PREPARED;
 
@@ -2519,9 +2579,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		files_downcast(ref_store, 0, "ref_transaction_finish");
 	size_t i;
 	int ret = 0;
-	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
-	struct string_list_item *ref_to_delete;
 	struct strbuf sb = STRBUF_INIT;
+	struct files_transaction_backend_data *backend_data;
+	struct ref_transaction *packed_transaction;
+
 
 	assert(err);
 
@@ -2530,6 +2591,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		return 0;
 	}
 
+	backend_data = transaction->backend_data;
+	packed_transaction = backend_data->packed_transaction;
+
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2565,7 +2629,23 @@ static int files_transaction_finish(struct ref_store *ref_store,
 			}
 		}
 	}
-	/* Perform deletes now that updates are safely completed */
+
+	/*
+	 * Perform deletes now that updates are safely completed.
+	 *
+	 * First delete any packed versions of the references, while
+	 * retaining the packed-refs lock:
+	 */
+	if (packed_transaction) {
+		ret = ref_transaction_commit(packed_transaction, err);
+		ref_transaction_free(packed_transaction);
+		packed_transaction = NULL;
+		backend_data->packed_transaction = NULL;
+		if (ret)
+			goto cleanup;
+	}
+
+	/* Now delete the loose versions of the references: */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->backend_data;
@@ -2583,39 +2663,27 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				}
 				update->flags |= REF_DELETED_LOOSE;
 			}
-
-			if (!(update->flags & REF_ISPRUNING))
-				string_list_append(&refs_to_delete,
-						   lock->ref_name);
 		}
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
-	if (repack_without_refs(refs->packed_ref_store, &refs_to_delete, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		packed_refs_unlock(refs->packed_ref_store);
-		goto cleanup;
-	}
-
-	packed_refs_unlock(refs->packed_ref_store);
-
 	/* Delete the reflogs of any references that were deleted: */
-	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		strbuf_reset(&sb);
-		files_reflog_path(refs, &sb, ref_to_delete->string);
-		if (!unlink_or_warn(sb.buf))
-			try_remove_empty_parents(refs, ref_to_delete->string,
-						 REMOVE_EMPTY_PARENTS_REFLOG);
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY) &&
+		    !(update->flags & REF_ISPRUNING)) {
+			strbuf_reset(&sb);
+			files_reflog_path(refs, &sb, update->refname);
+			if (!unlink_or_warn(sb.buf))
+				try_remove_empty_parents(refs, update->refname,
+							 REMOVE_EMPTY_PARENTS_REFLOG);
+		}
 	}
 
 	clear_loose_ref_cache(refs);
 
 cleanup:
-	files_transaction_cleanup(transaction);
+	files_transaction_cleanup(refs, transaction);
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2633,7 +2701,6 @@ static int files_transaction_finish(struct ref_store *ref_store,
 	}
 
 	strbuf_release(&sb);
-	string_list_clear(&refs_to_delete, 0);
 	return ret;
 }
 
@@ -2641,7 +2708,10 @@ static int files_transaction_abort(struct ref_store *ref_store,
 				   struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	files_transaction_cleanup(transaction);
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "ref_transaction_abort");
+
+	files_transaction_cleanup(refs, transaction);
 	return 0;
 }
 
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 752f83c377..26e5ff6843 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -404,7 +404,7 @@ test_expect_success 'broken reference blocks indirect create' '
 	test_cmp expected output.err
 '
 
-test_expect_failure 'no bogus intermediate values during delete' '
+test_expect_success 'no bogus intermediate values during delete' '
 	prefix=refs/slow-transaction &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
@@ -459,7 +459,7 @@ test_expect_failure 'no bogus intermediate values during delete' '
 	test_must_fail git rev-parse --verify --quiet $prefix/foo
 '
 
-test_expect_failure 'delete fails cleanly if packed-refs file is locked' '
+test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	prefix=refs/locked-packed-refs &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
-- 
2.14.1

