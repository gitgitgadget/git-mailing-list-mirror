Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6FE20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdJOWII (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751729AbdJOWID (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:08:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 763D960466;
        Sun, 15 Oct 2017 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105283;
        bh=KFdVTasizudOyq0wV/EYnLsMUscFMldX2tZ7ngTxBSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1f3CWlVuhboV+SKmUOTHgPYFaOo4WAO+7+4D2Oynse4imDoN1ZJ9h4GOx43AUJ0y2
         /Lw24Gel3tMvw8I4GsrFOFJqHM/ptDnG0MQ4dQ33jANslPL6ECCiGfPuMPBmA+5ke/
         fu9208kfTTBQGlqjTAyz0I17krV2utTlBxMoqRQ4dhmJn172d2QU4YQESXrYXa8T34
         ySeJayyDQWl0IkxCcsKyDgsmPkTAUI1Rt4qk4M9qj+GgDMR0a6js6UkWIotWog+wPp
         LehHZyGmrhmvePNLlUbeM4jezIfARd/89CfxZ/ovKvpdq60NrwoC2zPotcvOEfObt4
         nEHWHIu0Igp7AlgCN/4sJGxowu354VzixWZolGqvZURhHiw4+ID9wSZyC6xgbiZuNl
         S2gCWllSaBi5WzAbYdcG14o960zeYfAwufj7MfQOgP52XFfKGTF9oj0D0PZI2zZBmw
         cWpOhjvmMd/WkGx4/4ikF+340v0fPHnqVOphovsPA1JzwP7TeME
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 24/25] refs: convert read_raw_ref backends to struct object_id
Date:   Sun, 15 Oct 2017 22:07:11 +0000
Message-Id: <20171015220712.97308-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the unsigned char * parameter to struct object_id * for
files_read_raw_ref and packed_read_raw_ref.  Update the documentation.
Switch from using get_sha1_hex and a hard-coded 40 to using
parse_oid_hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c                |  8 ++++----
 refs/files-backend.c  | 13 +++++++------
 refs/packed-backend.c |  4 ++--
 refs/refs-internal.h  | 10 +++++-----
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 6546346b6a..62a7621025 100644
--- a/refs.c
+++ b/refs.c
@@ -1382,10 +1382,10 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 }
 
 int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, unsigned char *sha1,
+		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type)
 {
-	return ref_store->be->read_raw_ref(ref_store, refname, sha1, referent, type);
+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent, type);
 }
 
 /* This function needs to return a meaningful errno on failure */
@@ -1428,7 +1428,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		unsigned int read_flags = 0;
 
 		if (refs_read_raw_ref(refs, refname,
-				      oid->hash, &sb_refname, &read_flags)) {
+				      oid, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 
 			/* In reading mode, refs must eventually resolve */
@@ -1879,7 +1879,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, oid.hash, &referent, &type)) {
+		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
 			strbuf_addf(err, "'%s' exists; cannot create '%s'",
 				    dirname.buf, refname);
 			goto cleanup;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8bf2ef8a77..c1626490c2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -261,7 +261,7 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 }
 
 static int files_read_raw_ref(struct ref_store *ref_store,
-			      const char *refname, unsigned char *sha1,
+			      const char *refname, struct object_id *oid,
 			      struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
@@ -270,6 +270,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
 	const char *buf;
+	const char *p;
 	struct stat st;
 	int fd;
 	int ret = -1;
@@ -304,7 +305,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 		if (errno != ENOENT)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      sha1, referent, type)) {
+				      oid, referent, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -344,7 +345,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 		 * packed ref:
 		 */
 		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      sha1, referent, type)) {
+				      oid, referent, type)) {
 			errno = EISDIR;
 			goto out;
 		}
@@ -390,8 +391,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	 * Please note that FETCH_HEAD has additional
 	 * data after the sha.
 	 */
-	if (get_sha1_hex(buf, sha1) ||
-	    (buf[40] != '\0' && !isspace(buf[40]))) {
+	if (parse_oid_hex(buf, oid, &p) ||
+	    (*p != '\0' && !isspace(*p))) {
 		*type |= REF_ISBROKEN;
 		errno = EINVAL;
 		goto out;
@@ -545,7 +546,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	 */
 
 	if (files_read_raw_ref(&refs->base, refname,
-			       lock->old_oid.hash, referent, type)) {
+			       &lock->old_oid, referent, type)) {
 		if (errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b7652738be..74f1dea0f4 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -716,7 +716,7 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 }
 
 static int packed_read_raw_ref(struct ref_store *ref_store,
-			       const char *refname, unsigned char *sha1,
+			       const char *refname, struct object_id *oid,
 			       struct strbuf *referent, unsigned int *type)
 {
 	struct packed_ref_store *refs =
@@ -734,7 +734,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 		return -1;
 	}
 
-	if (get_sha1_hex(rec, sha1))
+	if (get_oid_hex(rec, oid))
 		die_invalid_line(refs->path, rec, snapshot->eof - rec);
 
 	*type = REF_ISPACKED;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 54059c1daf..b0f3e300c7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -181,7 +181,7 @@ struct ref_update {
 };
 
 int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, unsigned char *sha1,
+		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type);
 
 /*
@@ -619,13 +619,13 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
  *
- * - If refname is the name of a normal reference, fill in sha1
+ * - If refname is the name of a normal reference, fill in oid
  *   (leaving referent unchanged).
  *
  * - If refname is the name of a symbolic reference, write the full
  *   name of the reference to which it refers (e.g.
  *   "refs/heads/master") to referent and set the REF_ISSYMREF bit in
- *   type (leaving sha1 unchanged). The caller is responsible for
+ *   type (leaving oid unchanged). The caller is responsible for
  *   validating that referent is a valid reference name.
  *
  * WARNING: refname might be used as part of a filename, so it is
@@ -637,7 +637,7 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  *
  * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
  * and return -1. If the ref exists but is neither a symbolic ref nor
- * a sha1, it is broken; set REF_ISBROKEN in type, set errno to
+ * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
  * EINVAL, and return -1. If there is another error reading the ref,
  * set errno appropriately and return -1.
  *
@@ -654,7 +654,7 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  *   refname will still be valid and unchanged.
  */
 typedef int read_raw_ref_fn(struct ref_store *ref_store,
-			    const char *refname, unsigned char *sha1,
+			    const char *refname, struct object_id *oid,
 			    struct strbuf *referent, unsigned int *type);
 
 struct ref_storage_be {
-- 
2.15.0.rc0.271.g36b669edcc

