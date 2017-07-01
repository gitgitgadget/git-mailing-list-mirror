Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220A220209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdGAScf (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:35 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46462 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752172AbdGAScd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:33 -0400
X-AuditID: 12074413-b2dff700000069ec-9f-5957eaa3c66f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.EC.27116.3AAE7595; Sat,  1 Jul 2017 14:32:03 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBY010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:01 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 21/30] commit_packed_refs(): report errors rather than dying
Date:   Sat,  1 Jul 2017 20:30:59 +0200
Message-Id: <6adc870c99c80bffcadf34637b98126b698e27e4.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLv4VXikwcVV1hZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGXc+q9X8N684sfDn+wNjAt0uxg5
        OCQETCQ+nSnsYuTiEBLYwSTxZnIvK4Rzkkni/td1zF2MnBxsAroSi3qamUBsEQE1iYlth1hA
        ipgFJjFLvL22ECwhLOAvsef0HTCbRUBVYt73PjCbVyBK4kLbBVYQW0JAXmJX20Uwm1PAQuJP
        23qwBUIC5hLNB/tYJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokR
        EnLCOxh3nZQ7xCjAwajEw7shJCxSiDWxrLgy9xCjJAeTkijvymuhkUJ8SfkplRmJxRnxRaU5
        qcWHGCU4mJVEeHOfh0cK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQk
        eJmAsSUkWJSanlqRlplTgpBm4uAEGc4DNHzhXZDhxQWJucWZ6RD5U4y6HK8m/P/GJMSSl5+X
        KiXO2/oSqEgApCijNA9uDixVvGIUB3pLmDfiBVAVDzDNwE16BbSECWiJ8IwQkCUliQgpqQbG
        rScy6uyMyj1LVELP+/QtDmdxC3XazeG3r1pELENy6rvMO8yxn4/7Bdxn/PniW9PNHI7NKxO3
        HD7za4N0vfL9bu36frlCqeDk1pNd+2Xmr9VYyxS7zp0lfJf0ntlGM9f/TwnjDi//bLlL1UH1
        96SCL5Ma7q9WexYoretnK5Rx17XPqv/4gptKLMUZiYZazEXFiQAOdcgA8AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Report errors via a `struct strbuf *err` rather than by calling
`die()`. To enable this goal, change `write_packed_entry()` to report
errors via a return value and `errno` rather than dying.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  | 10 +++---
 refs/packed-backend.c | 85 +++++++++++++++++++++++++++++++++------------------
 refs/packed-backend.h |  2 +-
 3 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 60f4fa5e7a..2810785efc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1094,6 +1094,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_iterator *iter;
 	int ok;
 	struct ref_to_prune *refs_to_prune = NULL;
+	struct strbuf err = STRBUF_INIT;
 
 	lock_packed_refs(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
 
@@ -1128,10 +1129,11 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_packed_refs(refs->packed_ref_store))
-		die_errno("unable to overwrite old ref-pack file");
+	if (commit_packed_refs(refs->packed_ref_store, &err))
+		die("unable to overwrite old ref-pack file: %s", err.buf);
 
 	prune_refs(refs, refs_to_prune);
+	strbuf_release(&err);
 	return 0;
 }
 
@@ -2693,9 +2695,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 				       &update->new_oid);
 	}
 
-	if (commit_packed_refs(refs->packed_ref_store)) {
-		strbuf_addf(err, "unable to commit packed-refs file: %s",
-			    strerror(errno));
+	if (commit_packed_refs(refs->packed_ref_store, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4676dc3959..18ce47fcb7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -493,15 +493,19 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 /*
  * Write an entry to the packed-refs file for the specified refname.
- * If peeled is non-NULL, write it as the entry's peeled value.
+ * If peeled is non-NULL, write it as the entry's peeled value. On
+ * error, return a nonzero value and leave errno set at the value left
+ * by the failing call to `fprintf()`.
  */
-static void write_packed_entry(FILE *fh, const char *refname,
-			       const unsigned char *sha1,
-			       const unsigned char *peeled)
+static int write_packed_entry(FILE *fh, const char *refname,
+			      const unsigned char *sha1,
+			      const unsigned char *peeled)
 {
-	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
-	if (peeled)
-		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
+	if (fprintf(fh, "%s %s\n", sha1_to_hex(sha1), refname) < 0 ||
+	    (peeled && fprintf(fh, "^%s\n", sha1_to_hex(peeled)) < 0))
+		return -1;
+
+	return 0;
 }
 
 int lock_packed_refs(struct ref_store *ref_store, int flags)
@@ -550,49 +554,74 @@ static const char PACKED_REFS_HEADER[] =
 /*
  * Write the current version of the packed refs cache from memory to
  * disk. The packed-refs file must already be locked for writing (see
- * lock_packed_refs()). Return zero on success. On errors, set errno
- * and return a nonzero value.
+ * lock_packed_refs()). Return zero on success. On errors, rollback
+ * the lockfile, write an error message to `err`, and return a nonzero
+ * value.
  */
-int commit_packed_refs(struct ref_store *ref_store)
+int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
 				"commit_packed_refs");
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
-	int ok, error = 0;
-	int save_errno = 0;
+	int ok;
+	int ret = -1;
 	FILE *out;
 	struct ref_iterator *iter;
 
 	if (!is_lock_file_locked(&refs->lock))
-		die("BUG: packed-refs not locked");
+		die("BUG: commit_packed_refs() called when unlocked");
 
 	out = fdopen_lock_file(&refs->lock, "w");
-	if (!out)
-		die_errno("unable to fdopen packed-refs descriptor");
+	if (!out) {
+		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
+			    strerror(errno));
+		goto error;
+	}
 
-	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
+	if (fprintf(out, "%s", PACKED_REFS_HEADER) < 0) {
+		strbuf_addf(err, "error writing to %s: %s",
+			    get_lock_file_path(&refs->lock), strerror(errno));
+		goto error;
+	}
 
 	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		struct object_id peeled;
 		int peel_error = ref_iterator_peel(iter, &peeled);
 
-		write_packed_entry(out, iter->refname, iter->oid->hash,
-				   peel_error ? NULL : peeled.hash);
+		if (write_packed_entry(out, iter->refname, iter->oid->hash,
+				       peel_error ? NULL : peeled.hash)) {
+			strbuf_addf(err, "error writing to %s: %s",
+				    get_lock_file_path(&refs->lock),
+				    strerror(errno));
+			ref_iterator_abort(iter);
+			goto error;
+		}
 	}
 
-	if (ok != ITER_DONE)
-		die("error while iterating over references");
+	if (ok != ITER_DONE) {
+		strbuf_addf(err, "unable to write packed-refs file: "
+			    "error iterating over old contents");
+		goto error;
+	}
 
 	if (commit_lock_file(&refs->lock)) {
-		save_errno = errno;
-		error = -1;
+		strbuf_addf(err, "error overwriting %s: %s",
+			    refs->path, strerror(errno));
+		goto out;
 	}
+
+	ret = 0;
+	goto out;
+
+error:
+	rollback_lock_file(&refs->lock);
+
+out:
 	release_packed_ref_cache(packed_ref_cache);
-	errno = save_errno;
-	return error;
+	return ret;
 }
 
 /*
@@ -628,7 +657,7 @@ int repack_without_refs(struct ref_store *ref_store,
 				"repack_without_refs");
 	struct ref_dir *packed;
 	struct string_list_item *refname;
-	int ret, needs_repacking = 0, removed = 0;
+	int needs_repacking = 0, removed = 0;
 
 	packed_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
@@ -665,11 +694,7 @@ int repack_without_refs(struct ref_store *ref_store,
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs(&refs->base);
-	if (ret)
-		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
-			    strerror(errno));
-	return ret;
+	return commit_packed_refs(&refs->base, err);
 }
 
 static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index beea9c14b5..3d4057b65b 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -14,7 +14,7 @@ int lock_packed_refs(struct ref_store *ref_store, int flags);
 void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid);
 
-int commit_packed_refs(struct ref_store *ref_store);
+int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err);
 
 int repack_without_refs(struct ref_store *ref_store,
 			struct string_list *refnames, struct strbuf *err);
-- 
2.11.0

