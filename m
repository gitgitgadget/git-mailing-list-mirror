Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8F9201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdEQMG3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55110 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753015AbdEQMGU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:20 -0400
X-AuditID: 12074413-0e1ff70000001dc3-de-591c3cba5331
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.8E.07619.ABC3C195; Wed, 17 May 2017 08:06:18 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg3000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:16 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/23] ref_transaction_commit(): break into multiple functions
Date:   Wed, 17 May 2017 14:05:35 +0200
Message-Id: <5ec5f3f9b4c9fc9f719d116b48dcf7b61e74ae49.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqLvLRibSYPNhaYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG/KtnmQumxFRM6uVoYJzi1cXIySEhYCLx
        5chK5i5GLg4hgR1MEr1bTzCDJIQETjBJXG2SBrHZBHQlFvU0M4HYIgJqEhPbDrGANDALPGaS
        +LusmwUkISzgJ7Fz6zKgIg4OFgFVib27lEHCvAJREqevvWKEWCYvsavtIiuIzSlgIXH//SN2
        kHIhAXOJ7dcrJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokREmTC
        Oxh3nZQ7xCjAwajEwzuBSzpSiDWxrLgy9xCjJAeTkijv/gdAIb6k/JTKjMTijPii0pzU4kOM
        EhzMSiK8N01lIoV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8QtZA
        jYJFqempFWmZOSUIaSYOTpDhPEDDuUBqeIsLEnOLM9Mh8qcYFaXEeWOtgBICIImM0jy4XlgS
        eMUoDvSKMG8eSDsPMIHAdb8CGswENLgZ5CPe4pJEhJRUA+PkxUXGMQx7Pvd+Ls0OOfE76JcZ
        m7vorukr1Oy1v075qdg+N+PKH5edUxWe2+osnbTsduzSG3rtPnL8wgejz337JsNT4T+xpPDg
        HW/p9+0Ci79Pa5qoFOdUkNf4S/vWZPOG3nqN8LkS87zvTK8wNV++L/7c1U/Cy8KvhHpM8K3v
        mbr8h0Xxn4dKLMUZiYZazEXFiQBqROpG3QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Break the function `ref_transaction_commit()` into two functions,
`ref_transaction_prepare()` and `ref_transaction_finish()`, with a
third function, `ref_transaction_abort()`, that can be used to abort
the transaction. Break up the `ref_store` methods similarly.

This split will make it easier to implement compound reference stores,
where a transaction might have to span multiple underlying stores. In
that case, we would first want to "prepare" the sub-transactions in
each of the reference stores. If any of the "prepare" steps fails, we
would "abort" all of the sub-transactions. Only if all of the
"prepare" steps succeed would we "finish" each of them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 34 ++++++++++++++++++++++---
 refs.h               | 37 ++++++++++++++++++++++++++-
 refs/files-backend.c | 71 +++++++++++++++++++++++++++++++++++++++++-----------
 refs/refs-internal.h | 42 ++++++++++++++++++++++++-------
 4 files changed, 157 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 14dec88e7f..689362db1e 100644
--- a/refs.c
+++ b/refs.c
@@ -1689,8 +1689,8 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 				  refs_heads_master, logmsg);
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+int ref_transaction_prepare(struct ref_transaction *transaction,
+			    struct strbuf *err)
 {
 	struct ref_store *refs = transaction->ref_store;
 
@@ -1700,7 +1700,35 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	return refs->be->transaction_commit(refs, transaction, err);
+	return refs->be->transaction_prepare(refs, transaction, err);
+}
+
+int ref_transaction_finish(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	struct ref_store *refs = transaction->ref_store;
+
+	return refs->be->transaction_finish(refs, transaction, err);
+}
+
+int ref_transaction_abort(struct ref_transaction *transaction,
+			  struct strbuf *err)
+{
+	struct ref_store *refs = transaction->ref_store;
+
+	return refs->be->transaction_abort(refs, transaction, err);
+}
+
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	int ret;
+
+	ret = ref_transaction_prepare(transaction, err);
+	if (ret)
+		return ret;
+
+	return ref_transaction_finish(transaction, err);
 }
 
 int refs_verify_refname_available(struct ref_store *refs,
diff --git a/refs.h b/refs.h
index b2d9626be6..4139e917f5 100644
--- a/refs.h
+++ b/refs.h
@@ -525,7 +525,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 
 /*
  * Commit all of the changes that have been queued in transaction, as
- * atomically as possible.
+ * atomically as possible. This is equivalent to calling
+ * `ref_transaction_prepare()` then `ref_transaction_finish()` (see
+ * below), which you can call yourself if you want finer control over
+ * reference updates.
  *
  * Returns 0 for success, or one of the below error codes for errors.
  */
@@ -536,6 +539,38 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
+/*
+ * Perform the preparatory stages of commiting `transaction`. Acquire
+ * any needed locks, check preconditions, etc.; basically, do as much
+ * as possible to ensure that the transaction will be able to go
+ * through, stopping just short of making any irrevocable or
+ * user-visible changes. Anything that this function does should be
+ * able to be finished up by calling `ref_transaction_finish()` or
+ * rolled back by calling `ref_transaction_abort()`.
+ *
+ * On success, return 0 and leave the transaction in "prepared" state.
+ * On failure, abort the transaction and return one of the
+ * `TRANSACTION_*` constants.
+ *
+ * Callers who don't need such fine-grained control over commiting
+ * reference transactions should just call `ref_transaction_commit()`.
+ */
+int ref_transaction_prepare(struct ref_transaction *transaction,
+			    struct strbuf *err);
+
+/*
+ * Perform the final commit of `transaction`, which has already been
+ * prepared.
+ */
+int ref_transaction_finish(struct ref_transaction *transaction,
+			   struct strbuf *err);
+
+/*
+ * Abort `transaction`, which has already been prepared.
+ */
+int ref_transaction_abort(struct ref_transaction *transaction,
+			  struct strbuf *err);
+
 /*
  * Like ref_transaction_commit(), but optimized for creating
  * references when originally initializing a repository (e.g., by "git
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7ddd4f87d5..f48409132d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2867,27 +2867,24 @@ static void files_transaction_cleanup(struct ref_transaction *transaction)
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
-static int files_transaction_commit(struct ref_store *ref_store,
-				    struct ref_transaction *transaction,
-				    struct strbuf *err)
+static int files_transaction_prepare(struct ref_store *ref_store,
+				     struct ref_transaction *transaction,
+				     struct strbuf *err)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE,
-			       "ref_transaction_commit");
+			       "ref_transaction_prepare");
 	size_t i;
 	int ret = 0;
-	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
-	struct string_list_item *ref_to_delete;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct object_id head_oid;
-	struct strbuf sb = STRBUF_INIT;
 
 	assert(err);
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: commit called for transaction that is not open");
+		die("BUG: prepare called for transaction that is not open");
 
 	if (!transaction->nr)
 		goto cleanup;
@@ -2949,6 +2946,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	 * that new values are valid, and write new values to the
 	 * lockfiles, ready to be activated. Only keep one lockfile
 	 * open at a time to avoid running out of file descriptors.
+	 * Note that lock_ref_for_update() might append more updates
+	 * to the transaction.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2956,7 +2955,41 @@ static int files_transaction_commit(struct ref_store *ref_store,
 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, &affected_refnames, err);
 		if (ret)
-			goto cleanup;
+			break;
+	}
+
+cleanup:
+	free(head_ref);
+	string_list_clear(&affected_refnames, 0);
+
+	if (ret)
+		files_transaction_cleanup(transaction);
+	else
+		transaction->state = REF_TRANSACTION_PREPARED;
+
+	return ret;
+}
+
+static int files_transaction_finish(struct ref_store *ref_store,
+				    struct ref_transaction *transaction,
+				    struct strbuf *err)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "ref_transaction_finish");
+	size_t i;
+	int ret = 0;
+	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
+	struct string_list_item *ref_to_delete;
+	struct strbuf sb = STRBUF_INIT;
+
+	assert(err);
+
+	if (transaction->state != REF_TRANSACTION_PREPARED)
+		die("BUG: finish called for transaction that is not prepared");
+
+	if (!transaction->nr) {
+		transaction->state = REF_TRANSACTION_CLOSED;
+		return 0;
 	}
 
 	/* Perform updates first so live commits remain referenced */
@@ -3037,7 +3070,6 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 cleanup:
 	files_transaction_cleanup(transaction);
-	strbuf_release(&sb);
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -3054,13 +3086,22 @@ static int files_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
+	strbuf_release(&sb);
 	string_list_clear(&refs_to_delete, 0);
-	free(head_ref);
-	string_list_clear(&affected_refnames, 0);
-
 	return ret;
 }
 
+static int files_transaction_abort(struct ref_store *ref_store,
+				   struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	if (transaction->state != REF_TRANSACTION_PREPARED)
+		die("BUG: abort called for transaction that is not prepared");
+
+	files_transaction_cleanup(transaction);
+	return 0;
+}
+
 static int ref_present(const char *refname,
 		       const struct object_id *oid, int flags, void *cb_data)
 {
@@ -3327,7 +3368,9 @@ struct ref_storage_be refs_be_files = {
 	"files",
 	files_ref_store_create,
 	files_init_db,
-	files_transaction_commit,
+	files_transaction_prepare,
+	files_transaction_finish,
+	files_transaction_abort,
 	files_initial_transaction_commit,
 
 	files_pack_refs,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9ed4387c8c..2ff65d3ebd 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -185,17 +185,26 @@ struct ref_update *ref_transaction_add_update(
 
 /*
  * Transaction states.
- * OPEN:   The transaction is in a valid state and can accept new updates.
- *         An OPEN transaction can be committed.
- * CLOSED: A closed transaction is no longer active and no other operations
- *         than free can be used on it in this state.
- *         A transaction can either become closed by successfully committing
- *         an active transaction or if there is a failure while building
- *         the transaction thus rendering it failed/inactive.
+ *
+ * OPEN:   The transaction is in a valid state and new updates can be
+ *         added to it. An OPEN transaction can be prepared or
+ *         committed.
+ *
+ * PREPARED: ref_transaction_prepare(), which locks all of the
+ *         references involved in the update and checks that the
+ *         update has no errors, has been called successfully for the
+ *         transaction.
+ *
+ * CLOSED: The transaction is no longer active. No other operations
+ *         than free can be used on it in this state. A transaction
+ *         becomes closed if there is a failure while building the
+ *         transaction, if an active transaction is committed, or if a
+ *         prepared transaction is finished.
  */
 enum ref_transaction_state {
 	REF_TRANSACTION_OPEN   = 0,
-	REF_TRANSACTION_CLOSED = 1
+	REF_TRANSACTION_PREPARED = 1,
+	REF_TRANSACTION_CLOSED = 2
 };
 
 /*
@@ -497,6 +506,18 @@ typedef struct ref_store *ref_store_init_fn(const char *gitdir,
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
+typedef int ref_transaction_prepare_fn(struct ref_store *refs,
+				       struct ref_transaction *transaction,
+				       struct strbuf *err);
+
+typedef int ref_transaction_finish_fn(struct ref_store *refs,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err);
+
+typedef int ref_transaction_abort_fn(struct ref_store *refs,
+				     struct ref_transaction *transaction,
+				     struct strbuf *err);
+
 typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
@@ -599,7 +620,10 @@ struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
 	ref_init_db_fn *init_db;
-	ref_transaction_commit_fn *transaction_commit;
+
+	ref_transaction_prepare_fn *transaction_prepare;
+	ref_transaction_finish_fn *transaction_finish;
+	ref_transaction_abort_fn *transaction_abort;
 	ref_transaction_commit_fn *initial_transaction_commit;
 
 	pack_refs_fn *pack_refs;
-- 
2.11.0

