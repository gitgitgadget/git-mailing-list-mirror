Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DB41FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933180AbdCaOLn (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:43 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64946 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933155AbdCaOLl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:41 -0400
X-AuditID: 12074412-4bbff70000000b04-31-58de63994615
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 26.16.02820.9936ED85; Fri, 31 Mar 2017 10:11:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBj010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:36 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/20] refs_verify_refname_available(): implement once for all backends
Date:   Fri, 31 Mar 2017 16:11:02 +0200
Message-Id: <22abd274bfdada94b3654a811ee209822640765f.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqDsr+V6EwbfXqhZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6MvdtfsxV8sas4tekeYwPjacMuRk4OCQET
        iR8P5rOB2EICO5gklsyS6GLkArJPMknsnfaCGSTBJqArsainmQnEFhFQk5jYdogFpIhZ4A2T
        xIEtv1hAEsICURIzft5nBbFZBFQlnu/vA5vKCxSf2/qNDWKbvMSutotgNZwCFhLrZh5ih9hs
        LrFg7QS2CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEhJrQDsb1
        J+UOMQpwMCrx8Cr43YsQYk0sK67MPcQoycGkJMrrGw4U4kvKT6nMSCzOiC8qzUktPsQowcGs
        JMLLFAeU401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4GUExpSQYFFq
        empFWmZOCUKaiYMTZDgP0PAFSSDDiwsSc4sz0yHypxgVpcR5WUESAiCJjNI8uF5YKnjFKA70
        ijAvH0gVDzCNwHW/AhrMBDTY4utdkMEliQgpqQbGSTFCLBU8s0R4H14qO83pGrVd9kdfyKsz
        Nn/SysqaTE1LQlsmXckNWV33vJ47Uu3UAq3nV64e2rPxeY9Oy9aenUtSHidOjm28fLaWT644
        fAvXzuBnN6bEuIZd9T5vprvOXGnulO3N6j9t3N0vbd4b+8ghWT+wf669bPrRWG+GRn/GlWbz
        g34rsRRnJBpqMRcVJwIAMIbHL+ACAAA=
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
index aeb704ab92..2cf531b9c7 100644
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
@@ -1661,11 +1662,91 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
+		ok = ref_iterator_abort(iter);
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
index e7a075e864..447f2767f3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1725,10 +1725,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
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
@@ -2097,9 +2096,9 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
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
@@ -2111,9 +2110,8 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
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
 
@@ -2609,26 +2607,6 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
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
@@ -4291,7 +4269,6 @@ struct ref_storage_be refs_be_files = {
 
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

