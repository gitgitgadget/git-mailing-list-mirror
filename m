Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B5B2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbdIHNxF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:53:05 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64568 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752923AbdIHNwV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:21 -0400
X-AuditID: 12074413-3a3ff70000007929-89-59b2a0940e54
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 46.C7.31017.490A2B95; Fri,  8 Sep 2017 09:52:20 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvk2002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:18 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/11] files_ref_store: use a transaction to update packed refs
Date:   Fri,  8 Sep 2017 15:51:51 +0200
Message-Id: <3356d2dae41d5b9cff120a88a0b25bf61e959fe0.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqDtlwaZIgxu7BSzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC1ur5jPbNE95S2jxY+WHmaLzZvbWRw4PP6+/8DksXPWXXaPBZtKPZ717mH0
        uHhJ2ePzJrkAtigum5TUnMyy1CJ9uwSujHkf17AUtAZX7J/xjbGB8Z1zFyMnh4SAicS2r3OY
        uhi5OIQEdjBJPNz3gw3COckkMWPJRGaQKjYBXYlFPc1MILaIgJrExLZDLCBFzAJPmSR2nrzL
        CpIQFgiSOL7pC5jNIqAq8a11A1gzr0CUxLvPF1kh1slLnHtwGyzOKWAh8erfGjYQW0jAXOLq
        7kmsExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p3cQICTHhHYy7Tsod
        YhTgYFTi4bUI3hgpxJpYVlyZe4hRkoNJSZRXpmdTpBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
        XvNZQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvwHygRsGi1PTU
        irTMnBKENBMHJ8hwHqDhG0FqeIsLEnOLM9Mh8qcYdTk6bt79wyTEkpeflyolzts2D6hIAKQo
        ozQPbg4sNbxiFAd6S5h3CsgoHmBagZv0CmgJE9CSkucbQJaUJCKkpBoYe6IvRp2MEIpyfc68
        S0jT+I+ejdKpc+YTc5POMWTzJTU7GqeYf3/fNkvZW3P6P2378P83l9flBv/q+5vhZsdYlb5k
        0c3jB6+uUr0kw2lfGl4kuF53+cZrrdk7Oo8r7bB8nrf7hPSOCQ+Yr1wL51bvn/fCW9FTSzoi
        eNYJjqtSFxI0V8YEPGdRYinOSDTUYi4qTgQAOQAK9egCAAA=
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
index 2700e3b5d5..29eb5e826f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2397,13 +2397,22 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2415,6 +2424,17 @@ static void files_transaction_cleanup(struct ref_transaction *transaction)
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
 
@@ -2431,12 +2451,17 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
@@ -2503,6 +2528,41 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
@@ -2510,7 +2570,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	string_list_clear(&affected_refnames, 0);
 
 	if (ret)
-		files_transaction_cleanup(transaction);
+		files_transaction_cleanup(refs, transaction);
 	else
 		transaction->state = REF_TRANSACTION_PREPARED;
 
@@ -2525,9 +2585,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
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
 
@@ -2536,6 +2597,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		return 0;
 	}
 
+	backend_data = transaction->backend_data;
+	packed_transaction = backend_data->packed_transaction;
+
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2571,7 +2635,23 @@ static int files_transaction_finish(struct ref_store *ref_store,
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
@@ -2589,39 +2669,27 @@ static int files_transaction_finish(struct ref_store *ref_store,
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
@@ -2639,7 +2707,6 @@ static int files_transaction_finish(struct ref_store *ref_store,
 	}
 
 	strbuf_release(&sb);
-	string_list_clear(&refs_to_delete, 0);
 	return ret;
 }
 
@@ -2647,7 +2714,10 @@ static int files_transaction_abort(struct ref_store *ref_store,
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
index 64a81345a8..100d50e362 100755
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
@@ -461,7 +461,7 @@ test_expect_failure 'no bogus intermediate values during delete' '
 	test_must_fail git rev-parse --verify --quiet $prefix/foo
 '
 
-test_expect_failure 'delete fails cleanly if packed-refs file is locked' '
+test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	prefix=refs/locked-packed-refs &&
 	# Set up a reference with differing loose and packed versions:
 	git update-ref $prefix/foo $C &&
-- 
2.14.1

