Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA6220A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbdDPGmd (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56011 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753523AbdDPGmb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:31 -0400
X-AuditID: 12074413-f4fff700000077e1-b6-58f312553192
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 65.87.30689.55213F85; Sun, 16 Apr 2017 02:42:29 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN5025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:27 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/20] refs_verify_refname_available(): implement once for all backends
Date:   Sun, 16 Apr 2017 08:41:26 +0200
Message-Id: <629e13e1c3025b26809638b0d29f2c5f96b3e797.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqBsq9DnCoOm/kcXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugSvj8MzZrAXv7SqO3bNuYDxh2MXIySEhYCLx
        5dhFpi5GLg4hgR1MErO6XzBCOCeYJI5OeM0MUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFngMZPE
        32XdLCAJYYEoia0rzwEVcXCwCKhKNDcFgIR5gcIHvk5lh9gmL7Gr7SIriM0pYCEx5e4GsFYh
        AXOJ7cevMk9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIyTQhHcw
        7jopd4hRgINRiYfXwv9ThBBrYllxZe4hRkkOJiVRXpn/QCG+pPyUyozE4oz4otKc1OJDjBIc
        zEoivMksnyOEeFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvB8EgBoF
        i1LTUyvSMnNKENJMHJwgw3mAhm8FqeEtLkjMLc5Mh8ifYlSUEuf9AZIQAElklObB9cISwStG
        caBXhHmZBYGqeIBJBK77FdBgJqDBDJM/gAwuSURISTUwbjur+LrxaeaEjwqxlrP0haL4Ysza
        9/y6Xsvf4B6tebJ1qYLohG2NHRKWstvEjaZEmT7+ZCjAPHfqh0ydeqsrP0SrN++deVCSe9pl
        saaEAxlcQnU3F53da7N3ceyTIulDdv+u2ex7kjH7/XnH52Wrpz+MeXRloxrPemnNMnuesrjl
        1bs/Vj+8ocRSnJFoqMVcVJwIAJpzpZLfAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that we can now implement
`refs_verify_refname_available()` based on the other virtual
functions, so there is no need for it to be defined at the backend
level. Instead, define it once in `refs.c` and remove the
`files_backend` definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h               |  2 +-
 refs/files-backend.c | 39 +++++-------------------
 refs/refs-internal.h |  7 -----
 4 files changed, 92 insertions(+), 41 deletions(-)

diff --git a/refs.c b/refs.c
index 2ae18097d4..e841248b01 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "hashmap.h"
 #include "lockfile.h"
+#include "iterator.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
 #include "object.h"
@@ -1658,11 +1659,91 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 int refs_verify_refname_available(struct ref_store *refs,
 				  const char *refname,
-				  const struct string_list *extra,
+				  const struct string_list *extras,
 				  const struct string_list *skip,
 				  struct strbuf *err)
 {
-	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
+	const char *slash;
+	const char *extra_refname;
+	struct strbuf dirname = STRBUF_INIT;
+	struct strbuf referent = STRBUF_INIT;
+	struct object_id oid;
+	unsigned int type;
+	struct ref_iterator *iter;
+	int ok;
+	int ret = -1;
+
+	/*
+	 * For the sake of comments in this function, suppose that
+	 * refname is "refs/foo/bar".
+	 */
+
+	assert(err);
+
+	strbuf_grow(&dirname, strlen(refname) + 1);
+	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+		/* Expand dirname to the new prefix, not including the trailing slash: */
+		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
+
+		/*
+		 * We are still at a leading dir of the refname (e.g.,
+		 * "refs/foo"; if there is a reference with that name,
+		 * it is a conflict, *unless* it is in skip.
+		 */
+		if (skip && string_list_has_string(skip, dirname.buf))
+			continue;
+
+		if (!refs_read_raw_ref(refs, dirname.buf, oid.hash, &referent, &type)) {
+			strbuf_addf(err, "'%s' exists; cannot create '%s'",
+				    dirname.buf, refname);
+			goto cleanup;
+		}
+
+		if (extras && string_list_has_string(extras, dirname.buf)) {
+			strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+				    refname, dirname.buf);
+			goto cleanup;
+		}
+	}
+
+	/*
+	 * We are at the leaf of our refname (e.g., "refs/foo/bar").
+	 * There is no point in searching for a reference with that
+	 * name, because a refname isn't considered to conflict with
+	 * itself. But we still need to check for references whose
+	 * names are in the "refs/foo/bar/" namespace, because they
+	 * *do* conflict.
+	 */
+	strbuf_addstr(&dirname, refname + dirname.len);
+	strbuf_addch(&dirname, '/');
+
+	iter = refs_ref_iterator_begin(refs, dirname.buf, 0,
+				       DO_FOR_EACH_INCLUDE_BROKEN);
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		if (skip &&
+		    string_list_has_string(skip, iter->refname))
+			continue;
+
+		strbuf_addf(err, "'%s' exists; cannot create '%s'",
+			    iter->refname, refname);
+		ref_iterator_abort(iter);
+		goto cleanup;
+	}
+
+	if (ok != ITER_DONE)
+		die("BUG: error while iterating over references");
+
+	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
+	if (extra_refname)
+		strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+			    refname, extra_refname);
+	else
+		ret = 0;
+
+cleanup:
+	strbuf_release(&referent);
+	strbuf_release(&dirname);
+	return ret;
 }
 
 int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 49e97d7d5f..07cf4cd41b 100644
--- a/refs.h
+++ b/refs.h
@@ -97,7 +97,7 @@ int read_ref(const char *refname, unsigned char *sha1);
 
 int refs_verify_refname_available(struct ref_store *refs,
 				  const char *refname,
-				  const struct string_list *extra,
+				  const struct string_list *extras,
 				  const struct string_list *skip,
 				  struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2a0538dea7..4185025efa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1724,10 +1724,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				goto error_return;
 			} else if (remove_dir_recursively(&ref_file,
 							  REMOVE_DIR_EMPTY_ONLY)) {
-				if (verify_refname_available_dir(
-						    refname, extras, skip,
-						    get_loose_refs(refs),
-						    err)) {
+				if (refs_verify_refname_available(
+						    &refs->base, refname,
+						    extras, skip, err)) {
 					/*
 					 * The error message set by
 					 * verify_refname_available() is OK.
@@ -2094,9 +2093,9 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		 */
 		if (remove_empty_directories(&ref_file)) {
 			last_errno = errno;
-			if (!verify_refname_available_dir(
-					    refname, extras, skip,
-					    get_loose_refs(refs), err))
+			if (!refs_verify_refname_available(
+					    &refs->base,
+					    refname, extras, skip, err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    refname);
 			goto error_return;
@@ -2108,9 +2107,8 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	if (!resolved) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !verify_refname_available_dir(
-				    refname, extras, skip,
-				    get_loose_refs(refs), err))
+		    !refs_verify_refname_available(&refs->base, refname,
+						   extras, skip, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
 
@@ -2606,26 +2604,6 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	return ret;
 }
 
-static int files_verify_refname_available(struct ref_store *ref_store,
-					  const char *newname,
-					  const struct string_list *extras,
-					  const struct string_list *skip,
-					  struct strbuf *err)
-{
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_READ, "verify_refname_available");
-	struct ref_dir *packed_refs = get_packed_refs(refs);
-	struct ref_dir *loose_refs = get_loose_refs(refs);
-
-	if (verify_refname_available_dir(newname, extras, skip,
-					 packed_refs, err) ||
-	    verify_refname_available_dir(newname, extras, skip,
-					 loose_refs, err))
-		return -1;
-
-	return 0;
-}
-
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
@@ -4288,7 +4266,6 @@ struct ref_storage_be refs_be_files = {
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
-	files_verify_refname_available,
 
 	files_reflog_iterator_begin,
 	files_for_each_reflog_ent,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 545989ae7f..3d46131efb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -590,12 +590,6 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store,
 			    const char *refname, unsigned char *sha1,
 			    struct strbuf *referent, unsigned int *type);
 
-typedef int verify_refname_available_fn(struct ref_store *ref_store,
-					const char *newname,
-					const struct string_list *extras,
-					const struct string_list *skip,
-					struct strbuf *err);
-
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
@@ -612,7 +606,6 @@ struct ref_storage_be {
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
-	verify_refname_available_fn *verify_refname_available;
 
 	reflog_iterator_begin_fn *reflog_iterator_begin;
 	for_each_reflog_ent_fn *for_each_reflog_ent;
-- 
2.11.0

