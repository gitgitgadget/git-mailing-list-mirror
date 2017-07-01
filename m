Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E68920209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdGAScP (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:15 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45228 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752118AbdGAScN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:13 -0400
X-AuditID: 12074412-b97ff70000000fed-da-5957eaa562fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8F.65.04077.5AAE7595; Sat,  1 Jul 2017 14:32:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBZ010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 22/30] commit_packed_refs(): use a staging file separate from the lockfile
Date:   Sat,  1 Jul 2017 20:31:00 +0200
Message-Id: <9b920206192a0dfb65c5aec03015332ab561bace.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvsVXikwWEni7XP7jBZPF9/gt2i
        60o3k0VD7xVmi9sr5jNbLHn4mtmie8pbRosfLT3MFps3t7M4cHr8ff+ByWPnrLvsHgs2lXp0
        tR9h83jWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Mvau6WUv2CpfcebEPfYGxn8SXYyc
        HBICJhLvf85i7WLk4hAS2MEk8aX/IyOEc5JJYsOj3UwgVWwCuhKLeprBbBEBNYmJbYdYQIqY
        BSYxS7y9thAsISwQKzHzyAMwm0VAVWJr13owm1cgSuLC5lPsEOvkJXa1XWQFsTkFLCT+tK1n
        BrGFBMwlmg/2sUxg5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyTo
        hHYwrj8pd4hRgINRiYd3Q0hYpBBrYllxZe4hRkkOJiVR3pXXQiOF+JLyUyozEosz4otKc1KL
        DzFKcDArifDmPg+PFOJNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuCd
        9BKoUbAoNT21Ii0zpwQhzcTBCTKcB2j4wrsgw4sLEnOLM9Mh8qcYdTleTfj/jUmIJS8/L1VK
        nLcVZJAASFFGaR7cHFiyeMUoDvSWMC8DMHUI8QATDdykV0BLmICWCM8IAVlSkoiQkmpgbF3K
        rnH3TVxNp1Ly8e1e29cXR7p6St2uYGRd+Xgvq/Tb9oiYXfL2RUKN/3iDJ4gnzupvuHdjo+ma
        hf6px1U3Ca2ZVhLhcpRT+aTOfxc9xRIjmSfX9l+UbphyqOVnrAXfwbCdZl4bOxm3+idYR1uL
        qJb/zp0u0yQx157p8E7Bxv3T3ROnlDxTYinOSDTUYi4qTgQAvnlNdvECAAA=
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

