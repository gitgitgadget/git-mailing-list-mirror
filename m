Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777D820401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbdFWHCs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:48 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50360 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754131AbdFWHCq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:46 -0400
X-AuditID: 1207440f-b81ff7000000740c-ba-594cbd14bce0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FF.EF.29708.41DBC495; Fri, 23 Jun 2017 03:02:44 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o67001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:42 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/29] commit_packed_refs(): use a staging file separate from the lockfile
Date:   Fri, 23 Jun 2017 09:01:40 +0200
Message-Id: <d8fa8dec13eb095c0c39ef0de2ee8987d6bf9d77.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqCuy1yfSYPs8SYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDL2rullL9gqX3HmxD32BsZ/El2M
        nBwSAiYS82feZu1i5OIQEtjBJLHp9Ad2COcUk8T1tx8YQarYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVhCWCBW4sWDWcwgNouAqsT0o4/B4rwCURI/dj9ggVgnL7Gr7SIriM0pYCHR
        M3E5O4gtJGAuser3atYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRu
        YoSEHf8Oxq71MocYBTgYlXh4E856RwqxJpYVV+YeYpTkYFIS5dWM9IkU4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMKrswoox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS
        4O3cA9QoWJSanlqRlplTgpBm4uAEGc4DNNxjM8jw4oLE3OLMdIj8KUZFKXHeDbuBEgIgiYzS
        PLheWFp4xSgO9IowbyJIFQ8wpcB1vwIazAQ0eMYasMEliQgpqQbGBB+xjKU3d/W3S3asjjYL
        bWh6KK1csJzhh2Ce2v+l+aIfPyyTaHq66+q8yZIfp/9W3JxvZq/9stdk7iIBa4PZoldif2zS
        +SG+umyJ1EFX36T94Vr8rL8TK8Iyp+TvUxCSOiiuOVtasWteVsmFjnlZF2fembJKat69QuHD
        qsq3FvUzxn6P6JqixFKckWioxVxUnAgAJNl3XeYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will want to be able to hold the lockfile for `packed-refs` even
after we have activated the new values. So use a separate tempfile,
`packed-refs.new`, as a place to stage the new contents of the
`packed-refs` file. For now this is all done within
`commit_packed_refs()`, but that will change shortly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 18ce47fcb7..71f92ed6f0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -68,6 +68,13 @@ struct packed_ref_store {
 	 * thus the enclosing `packed_ref_store`) must not be freed.
 	 */
 	struct lock_file lock;
+
+	/*
+	 * Temporary file used when rewriting new contents to the
+	 * "packed-refs" file. Note that this (and thus the enclosing
+	 * `packed_ref_store`) must not be freed.
+	 */
+	struct tempfile tempfile;
 };
 
 struct ref_store *packed_ref_store_create(const char *path,
@@ -522,10 +529,16 @@ int lock_packed_refs(struct ref_store *ref_store, int flags)
 		timeout_configured = 1;
 	}
 
+	/*
+	 * Note that we close the lockfile immediately because we
+	 * don't write new content to it, but rather to a separate
+	 * tempfile.
+	 */
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
 			    refs->path,
-			    flags, timeout_value) < 0)
+			    flags, timeout_value) < 0 ||
+	    close_lock_file(&refs->lock))
 		return -1;
 
 	/*
@@ -567,13 +580,23 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 		get_packed_ref_cache(refs);
 	int ok;
 	int ret = -1;
+	struct strbuf sb = STRBUF_INIT;
 	FILE *out;
 	struct ref_iterator *iter;
 
 	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: commit_packed_refs() called when unlocked");
 
-	out = fdopen_lock_file(&refs->lock, "w");
+	strbuf_addf(&sb, "%s.new", refs->path);
+	if (create_tempfile(&refs->tempfile, sb.buf) < 0) {
+		strbuf_addf(err, "unable to create file %s: %s",
+			    sb.buf, strerror(errno));
+		strbuf_release(&sb);
+		goto out;
+	}
+	strbuf_release(&sb);
+
+	out = fdopen_tempfile(&refs->tempfile, "w");
 	if (!out) {
 		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
 			    strerror(errno));
@@ -582,7 +605,7 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 
 	if (fprintf(out, "%s", PACKED_REFS_HEADER) < 0) {
 		strbuf_addf(err, "error writing to %s: %s",
-			    get_lock_file_path(&refs->lock), strerror(errno));
+			    get_tempfile_path(&refs->tempfile), strerror(errno));
 		goto error;
 	}
 
@@ -594,7 +617,7 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 		if (write_packed_entry(out, iter->refname, iter->oid->hash,
 				       peel_error ? NULL : peeled.hash)) {
 			strbuf_addf(err, "error writing to %s: %s",
-				    get_lock_file_path(&refs->lock),
+				    get_tempfile_path(&refs->tempfile),
 				    strerror(errno));
 			ref_iterator_abort(iter);
 			goto error;
@@ -602,13 +625,13 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	}
 
 	if (ok != ITER_DONE) {
-		strbuf_addf(err, "unable to write packed-refs file: "
+		strbuf_addf(err, "unable to rewrite packed-refs file: "
 			    "error iterating over old contents");
 		goto error;
 	}
 
-	if (commit_lock_file(&refs->lock)) {
-		strbuf_addf(err, "error overwriting %s: %s",
+	if (rename_tempfile(&refs->tempfile, refs->path)) {
+		strbuf_addf(err, "error replacing %s: %s",
 			    refs->path, strerror(errno));
 		goto out;
 	}
@@ -617,9 +640,10 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	goto out;
 
 error:
-	rollback_lock_file(&refs->lock);
+	delete_tempfile(&refs->tempfile);
 
 out:
+	rollback_lock_file(&refs->lock);
 	release_packed_ref_cache(packed_ref_cache);
 	return ret;
 }
-- 
2.11.0

