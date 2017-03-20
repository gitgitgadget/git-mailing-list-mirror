Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E512095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbdCTQiH (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:38:07 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50740 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755524AbdCTQdq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:46 -0400
X-AuditID: 1207440e-cb3ff7000000340b-4b-58d00466e1b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.2C.13323.66400D85; Mon, 20 Mar 2017 12:33:43 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9F010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:41 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/20] refs_verify_refname_available(): use function in more places
Date:   Mon, 20 Mar 2017 17:33:10 +0100
Message-Id: <80808305cd86f4fb3b8b06cd78ba8d0a9cbf11a5.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqJvOciHC4FOPkkXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j672I2wez3r3MHpcvKTs8XmTXABb
        FJdNSmpOZllqkb5dAlfG8on/mQtm2lTsPNjJ3sC4UK+LkZNDQsBE4vW7cyxdjFwcQgI7mCTW
        vJvMDuGcYpI4c2YtI0gVm4CuxKKeZiYQW0RATWJi2yGwDmaBR4wSV+ffZQdJCAsES9xf950F
        xGYRUJX49ecumM0rECXxf89XVoh18hK72i6C2ZwCFhJf7jeC1QgJmEt0Luhln8DIs4CRYRWj
        XGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSEDx7WBsXy9ziFGAg1GJh3fFlfMR
        QqyJZcWVuYcYJTmYlER5n94GCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhrXoJlONNSaysSi3K
        h0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAuYLgQISRYlJqeWpGWmVOCkGbi4AQZ
        zgM0fA5IDW9xQWJucWY6RP4Uo6KUOO/3/0BbBUASGaV5cL2wiH/FKA70ijDvLZB2HmCygOt+
        BTSYCWjwshtnQAaXJCKkpBoYpY+w6ZedkHaM73CaIdLyrv4Ak2VHYN41Hmk3M4EdUebFFm6T
        LT1eXqj90bqzYs9e5fs/Z++cXV8d5m95+tyZgi/nW67EMzbdPN7ZpZq+0KjVYamVlfsylfNn
        S3e8+B83z0ZR1Jh724/oR7f+nGovNKk+cScw36fM50ycRZQXF9f3lp6TqplKLMUZiYZazEXF
        iQBr4/FW0wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change `lock_raw_ref()` and `lock_ref_sha1_basic()` to use
`refs_verify_refname_available()` instead of
`verify_refname_available_dir()`. This means that those callsites now
check for conflicts with all references rather than just packed refs,
but the performance cost shouldn't be significant (and will be
regained later).

These were the last callers of `verify_refname_available_dir()`, so
also delete that (very complicated) function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 171 ++++-----------------------------------------------
 1 file changed, 11 insertions(+), 160 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 447f2767f3..cad56efb04 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -738,152 +738,6 @@ static struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir)
 	return ref_iterator;
 }
 
-struct nonmatching_ref_data {
-	const struct string_list *skip;
-	const char *conflicting_refname;
-};
-
-static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
-{
-	struct nonmatching_ref_data *data = vdata;
-
-	if (data->skip && string_list_has_string(data->skip, entry->name))
-		return 0;
-
-	data->conflicting_refname = entry->name;
-	return 1;
-}
-
-/*
- * Return 0 if a reference named refname could be created without
- * conflicting with the name of an existing reference in dir.
- * See verify_refname_available for more information.
- */
-static int verify_refname_available_dir(const char *refname,
-					const struct string_list *extras,
-					const struct string_list *skip,
-					struct ref_dir *dir,
-					struct strbuf *err)
-{
-	const char *slash;
-	const char *extra_refname;
-	int pos;
-	struct strbuf dirname = STRBUF_INIT;
-	int ret = -1;
-
-	/*
-	 * For the sake of comments in this function, suppose that
-	 * refname is "refs/foo/bar".
-	 */
-
-	assert(err);
-
-	strbuf_grow(&dirname, strlen(refname) + 1);
-	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
-		/* Expand dirname to the new prefix, not including the trailing slash: */
-		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
-
-		/*
-		 * We are still at a leading dir of the refname (e.g.,
-		 * "refs/foo"; if there is a reference with that name,
-		 * it is a conflict, *unless* it is in skip.
-		 */
-		if (dir) {
-			pos = search_ref_dir(dir, dirname.buf, dirname.len);
-			if (pos >= 0 &&
-			    (!skip || !string_list_has_string(skip, dirname.buf))) {
-				/*
-				 * We found a reference whose name is
-				 * a proper prefix of refname; e.g.,
-				 * "refs/foo", and is not in skip.
-				 */
-				strbuf_addf(err, "'%s' exists; cannot create '%s'",
-					    dirname.buf, refname);
-				goto cleanup;
-			}
-		}
-
-		if (extras && string_list_has_string(extras, dirname.buf) &&
-		    (!skip || !string_list_has_string(skip, dirname.buf))) {
-			strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-				    refname, dirname.buf);
-			goto cleanup;
-		}
-
-		/*
-		 * Otherwise, we can try to continue our search with
-		 * the next component. So try to look up the
-		 * directory, e.g., "refs/foo/". If we come up empty,
-		 * we know there is nothing under this whole prefix,
-		 * but even in that case we still have to continue the
-		 * search for conflicts with extras.
-		 */
-		strbuf_addch(&dirname, '/');
-		if (dir) {
-			pos = search_ref_dir(dir, dirname.buf, dirname.len);
-			if (pos < 0) {
-				/*
-				 * There was no directory "refs/foo/",
-				 * so there is nothing under this
-				 * whole prefix. So there is no need
-				 * to continue looking for conflicting
-				 * references. But we need to continue
-				 * looking for conflicting extras.
-				 */
-				dir = NULL;
-			} else {
-				dir = get_ref_dir(dir->entries[pos]);
-			}
-		}
-	}
-
-	/*
-	 * We are at the leaf of our refname (e.g., "refs/foo/bar").
-	 * There is no point in searching for a reference with that
-	 * name, because a refname isn't considered to conflict with
-	 * itself. But we still need to check for references whose
-	 * names are in the "refs/foo/bar/" namespace, because they
-	 * *do* conflict.
-	 */
-	strbuf_addstr(&dirname, refname + dirname.len);
-	strbuf_addch(&dirname, '/');
-
-	if (dir) {
-		pos = search_ref_dir(dir, dirname.buf, dirname.len);
-
-		if (pos >= 0) {
-			/*
-			 * We found a directory named "$refname/"
-			 * (e.g., "refs/foo/bar/"). It is a problem
-			 * iff it contains any ref that is not in
-			 * "skip".
-			 */
-			struct nonmatching_ref_data data;
-
-			data.skip = skip;
-			data.conflicting_refname = NULL;
-			dir = get_ref_dir(dir->entries[pos]);
-			sort_ref_dir(dir);
-			if (do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data)) {
-				strbuf_addf(err, "'%s' exists; cannot create '%s'",
-					    data.conflicting_refname, refname);
-				goto cleanup;
-			}
-		}
-	}
-
-	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
-	if (extra_refname)
-		strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-			    refname, extra_refname);
-	else
-		ret = 0;
-
-cleanup:
-	strbuf_release(&dirname);
-	return ret;
-}
-
 struct packed_ref_cache {
 	struct ref_entry *root;
 
@@ -1563,7 +1417,7 @@ static void unlock_ref(struct ref_lock *lock)
  *
  * If the reference doesn't already exist, verify that refname doesn't
  * have a D/F conflict with any existing references. extras and skip
- * are passed to verify_refname_available_dir() for this check.
+ * are passed to refs_verify_refname_available() for this check.
  *
  * If mustexist is not set and the reference is not found or is
  * broken, lock the reference anyway but clear sha1.
@@ -1578,7 +1432,7 @@ static void unlock_ref(struct ref_lock *lock)
  *
  * but it includes a lot more code to
  * - Deal with possible races with other processes
- * - Avoid calling verify_refname_available_dir() when it can be
+ * - Avoid calling refs_verify_refname_available() when it can be
  *   avoided, namely if we were successfully able to read the ref
  * - Generate informative error messages in the case of failure
  */
@@ -1635,7 +1489,8 @@ static int lock_raw_ref(struct files_ref_store *refs,
 			} else {
 				/*
 				 * The error message set by
-				 * verify_refname_available_dir() is OK.
+				 * refs_verify_refname_available() is
+				 * OK.
 				 */
 				ret = TRANSACTION_NAME_CONFLICT;
 			}
@@ -1759,16 +1614,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
 
 		/*
 		 * If the ref did not exist and we are creating it,
-		 * make sure there is no existing packed ref whose
-		 * name begins with our refname, nor a packed ref
-		 * whose name is a proper prefix of our refname.
+		 * make sure there is no existing ref that conflicts
+		 * with refname:
 		 */
-		if (verify_refname_available_dir(
-				    refname, extras, skip,
-				    get_packed_refs(refs),
-				    err)) {
+		if (refs_verify_refname_available(
+				    &refs->base, refname,
+				    extras, skip, err))
 			goto error_return;
-		}
 	}
 
 	ret = 0;
@@ -2125,9 +1977,8 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	 * our refname.
 	 */
 	if (is_null_oid(&lock->old_oid) &&
-	    verify_refname_available_dir(refname, extras, skip,
-					 get_packed_refs(refs),
-					 err)) {
+	    refs_verify_refname_available(&refs->base, refname,
+					  extras, skip, err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
-- 
2.11.0

