Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82C12082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbdIHNwW (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:22 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55015 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751166AbdIHNwJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:09 -0400
X-AuditID: 12074412-1e5ff7000000748d-e5-59b2a0881007
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BD.6B.29837.880A2B95; Fri,  8 Sep 2017 09:52:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvju002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:06 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/11] packed_ref_store: implement reference transactions
Date:   Fri,  8 Sep 2017 15:51:45 +0200
Message-Id: <aa14ceccee9bcca73e3163f3626b8339326edad9.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqNuxYFOkwfGvohZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxq7eDtaC78EVS1d/ZWlg/OjQxcjJISFgIrF76j32
        LkYuDiGBHUwSnZevMEI4J5kk5h1ZzgZSxSagK7Gop5kJxBYRUJOY2HaIBaSIWeApk8TOk3dZ
        QRLCAj4Sr74tYAexWQRUJXa8XgJm8wpEScy7docdYp28xLkHt5lBbE4BC4lX/9aALRASMJe4
        unsS6wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQkJMaAfj+pNy
        hxgFOBiVeHhXeG+KFGJNLCuuzD3EKMnBpCTKK9MDFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
        az4LKMebklhZlVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8GhJMEbMB+oUbAoNT21
        Ii0zpwQhzcTBCTKcB2j4/nkgw4sLEnOLM9Mh8qcYdTk6bt79wyTEkpeflyolztsGUiQAUpRR
        mgc3B5YaXjGKA70lzHsRZB0PMK3ATXoFtIQJaEnJ8w0gS0oSEVJSDYyzef8uCl8hfHE637s3
        Uzd1Cx5kuuxoOusRt+WPAmeF3V4rZILTLG+xXudYufPiXubDKZPdY+6FKHY+T52tMNfowBlZ
        4YWSSY6aU/oZrPUTMrhmB0lFibT6TTnTmMC9TcJD52ipTIPR58mXrlytd2QumP5nelCEv/1b
        +SSRk0Z/2A7NOz039K8SS3FGoqEWc1FxIgCyZsyl6AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement the methods needed to support reference transactions for
the packed-refs backend. The new methods are not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 313 +++++++++++++++++++++++++++++++++++++++++++++++++-
 refs/packed-backend.h |   9 ++
 2 files changed, 319 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b76f14e5b3..9ab65c5a0a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -748,25 +748,332 @@ static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
 	return 0;
 }
 
+/*
+ * Write the packed-refs from the cache to the packed-refs tempfile,
+ * incorporating any changes from `updates`. `updates` must be a
+ * sorted string list whose keys are the refnames and whose util
+ * values are `struct ref_update *`. On error, rollback the tempfile,
+ * write an error message to `err`, and return a nonzero value.
+ *
+ * The packfile must be locked before calling this function and will
+ * remain locked when it is done.
+ */
+static int write_with_updates(struct packed_ref_store *refs,
+			      struct string_list *updates,
+			      struct strbuf *err)
+{
+	struct ref_iterator *iter = NULL;
+	size_t i;
+	int ok;
+	FILE *out;
+	struct strbuf sb = STRBUF_INIT;
+	char *packed_refs_path;
+
+	if (!is_lock_file_locked(&refs->lock))
+		die("BUG: write_with_updates() called while unlocked");
+
+	/*
+	 * If packed-refs is a symlink, we want to overwrite the
+	 * symlinked-to file, not the symlink itself. Also, put the
+	 * staging file next to it:
+	 */
+	packed_refs_path = get_locked_file_path(&refs->lock);
+	strbuf_addf(&sb, "%s.new", packed_refs_path);
+	free(packed_refs_path);
+	if (create_tempfile(&refs->tempfile, sb.buf) < 0) {
+		strbuf_addf(err, "unable to create file %s: %s",
+			    sb.buf, strerror(errno));
+		strbuf_release(&sb);
+		return -1;
+	}
+	strbuf_release(&sb);
+
+	out = fdopen_tempfile(&refs->tempfile, "w");
+	if (!out) {
+		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
+			    strerror(errno));
+		goto error;
+	}
+
+	if (fprintf(out, "%s", PACKED_REFS_HEADER) < 0)
+		goto write_error;
+
+	/*
+	 * We iterate in parallel through the current list of refs and
+	 * the list of updates, processing an entry from at least one
+	 * of the lists each time through the loop. When the current
+	 * list of refs is exhausted, set iter to NULL. When the list
+	 * of updates is exhausted, leave i set to updates->nr.
+	 */
+	iter = packed_ref_iterator_begin(&refs->base, "",
+					 DO_FOR_EACH_INCLUDE_BROKEN);
+	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
+		iter = NULL;
+
+	i = 0;
+
+	while (iter || i < updates->nr) {
+		struct ref_update *update = NULL;
+		int cmp;
+
+		if (i >= updates->nr) {
+			cmp = -1;
+		} else {
+			update = updates->items[i].util;
+
+			if (!iter)
+				cmp = +1;
+			else
+				cmp = strcmp(iter->refname, update->refname);
+		}
+
+		if (!cmp) {
+			/*
+			 * There is both an old value and an update
+			 * for this reference. Check the old value if
+			 * necessary:
+			 */
+			if ((update->flags & REF_HAVE_OLD)) {
+				if (is_null_oid(&update->old_oid)) {
+					strbuf_addf(err, "cannot update ref '%s': "
+						    "reference already exists",
+						    update->refname);
+					goto error;
+				} else if (oidcmp(&update->old_oid, iter->oid)) {
+					strbuf_addf(err, "cannot update ref '%s': "
+						    "is at %s but expected %s",
+						    update->refname,
+						    oid_to_hex(iter->oid),
+						    oid_to_hex(&update->old_oid));
+					goto error;
+				}
+			}
+
+			/* Now figure out what to use for the new value: */
+			if ((update->flags & REF_HAVE_NEW)) {
+				/*
+				 * The update takes precedence. Skip
+				 * the iterator over the unneeded
+				 * value.
+				 */
+				if ((ok = ref_iterator_advance(iter)) != ITER_OK)
+					iter = NULL;
+				cmp = +1;
+			} else {
+				/*
+				 * The update doesn't actually want to
+				 * change anything. We're done with it.
+				 */
+				i++;
+				cmp = -1;
+			}
+		} else if (cmp > 0) {
+			/*
+			 * There is no old value but there is an
+			 * update for this reference. Make sure that
+			 * the update didn't expect an existing value:
+			 */
+			if ((update->flags & REF_HAVE_OLD) &&
+			    !is_null_oid(&update->old_oid)) {
+				strbuf_addf(err, "cannot update ref '%s': "
+					    "reference is missing but expected %s",
+					    update->refname,
+					    oid_to_hex(&update->old_oid));
+				goto error;
+			}
+		}
+
+		if (cmp < 0) {
+			/* Pass the old reference through. */
+
+			struct object_id peeled;
+			int peel_error = ref_iterator_peel(iter, &peeled);
+
+			if (write_packed_entry(out, iter->refname,
+					       iter->oid->hash,
+					       peel_error ? NULL : peeled.hash))
+				goto write_error;
+
+			if ((ok = ref_iterator_advance(iter)) != ITER_OK)
+				iter = NULL;
+		} else if (is_null_oid(&update->new_oid)) {
+			/*
+			 * The update wants to delete the reference,
+			 * and the reference either didn't exist or we
+			 * have already skipped it. So we're done with
+			 * the update (and don't have to write
+			 * anything).
+			 */
+			i++;
+		} else {
+			struct object_id peeled;
+			int peel_error = peel_object(update->new_oid.hash,
+						     peeled.hash);
+
+			if (write_packed_entry(out, update->refname,
+					       update->new_oid.hash,
+					       peel_error ? NULL : peeled.hash))
+				goto write_error;
+
+			i++;
+		}
+	}
+
+	if (ok != ITER_DONE) {
+		strbuf_addf(err, "unable to write packed-refs file: "
+			    "error iterating over old contents");
+		goto error;
+	}
+
+	if (close_tempfile(&refs->tempfile)) {
+		strbuf_addf(err, "error closing file %s: %s",
+			    get_tempfile_path(&refs->tempfile),
+			    strerror(errno));
+		strbuf_release(&sb);
+		return -1;
+	}
+
+	return 0;
+
+write_error:
+	strbuf_addf(err, "error writing to %s: %s",
+		    get_tempfile_path(&refs->tempfile), strerror(errno));
+
+error:
+	if (iter)
+		ref_iterator_abort(iter);
+
+	delete_tempfile(&refs->tempfile);
+	return -1;
+}
+
+struct packed_transaction_backend_data {
+	/* True iff the transaction owns the packed-refs lock. */
+	int own_lock;
+
+	struct string_list updates;
+};
+
+static void packed_transaction_cleanup(struct packed_ref_store *refs,
+				       struct ref_transaction *transaction)
+{
+	struct packed_transaction_backend_data *data = transaction->backend_data;
+
+	if (data) {
+		string_list_clear(&data->updates, 0);
+
+		if (is_tempfile_active(&refs->tempfile))
+			delete_tempfile(&refs->tempfile);
+
+		if (data->own_lock && is_lock_file_locked(&refs->lock)) {
+			packed_refs_unlock(&refs->base);
+			data->own_lock = 0;
+		}
+
+		free(data);
+		transaction->backend_data = NULL;
+	}
+
+	transaction->state = REF_TRANSACTION_CLOSED;
+}
+
 static int packed_transaction_prepare(struct ref_store *ref_store,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err)
 {
-	die("BUG: not implemented yet");
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
+			"ref_transaction_prepare");
+	struct packed_transaction_backend_data *data;
+	size_t i;
+	int ret = TRANSACTION_GENERIC_ERROR;
+
+	/*
+	 * Note that we *don't* skip transactions with zero updates,
+	 * because such a transaction might be executed for the side
+	 * effect of ensuring that all of the references are peeled.
+	 * If the caller wants to optimize away empty transactions, it
+	 * should do so itself.
+	 */
+
+	data = xcalloc(1, sizeof(*data));
+	string_list_init(&data->updates, 0);
+
+	transaction->backend_data = data;
+
+	/*
+	 * Stick the updates in a string list by refname so that we
+	 * can sort them:
+	 */
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct string_list_item *item =
+			string_list_append(&data->updates, update->refname);
+
+		/* Store a pointer to update in item->util: */
+		item->util = update;
+	}
+	string_list_sort(&data->updates);
+
+	if (ref_update_reject_duplicates(&data->updates, err))
+		goto failure;
+
+	if (!is_lock_file_locked(&refs->lock)) {
+		if (packed_refs_lock(ref_store, 0, err))
+			goto failure;
+		data->own_lock = 1;
+	}
+
+	if (write_with_updates(refs, &data->updates, err))
+		goto failure;
+
+	transaction->state = REF_TRANSACTION_PREPARED;
+	return 0;
+
+failure:
+	packed_transaction_cleanup(refs, transaction);
+	return ret;
 }
 
 static int packed_transaction_abort(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
 {
-	die("BUG: not implemented yet");
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
+			"ref_transaction_abort");
+
+	packed_transaction_cleanup(refs, transaction);
+	return 0;
 }
 
 static int packed_transaction_finish(struct ref_store *ref_store,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err)
 {
-	die("BUG: not implemented yet");
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
+			"ref_transaction_finish");
+	int ret = TRANSACTION_GENERIC_ERROR;
+	char *packed_refs_path;
+
+	packed_refs_path = get_locked_file_path(&refs->lock);
+	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
+		strbuf_addf(err, "error replacing %s: %s",
+			    refs->path, strerror(errno));
+		goto cleanup;
+	}
+
+	clear_packed_ref_cache(refs);
+	ret = 0;
+
+cleanup:
+	free(packed_refs_path);
+	packed_transaction_cleanup(refs, transaction);
+	return ret;
 }
 
 static int packed_initial_transaction_commit(struct ref_store *ref_store,
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 03b7c1de95..7af2897757 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -1,6 +1,15 @@
 #ifndef REFS_PACKED_BACKEND_H
 #define REFS_PACKED_BACKEND_H
 
+/*
+ * Support for storing references in a `packed-refs` file.
+ *
+ * Note that this backend doesn't check for D/F conflicts, because it
+ * doesn't care about them. But usually it should be wrapped in a
+ * `files_ref_store` that prevents D/F conflicts from being created,
+ * even among packed refs.
+ */
+
 struct ref_store *packed_ref_store_create(const char *path,
 					  unsigned int store_flags);
 
-- 
2.14.1

