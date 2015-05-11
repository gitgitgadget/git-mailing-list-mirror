From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/18] verify_refname_available(): rename function
Date: Mon, 11 May 2015 17:25:13 +0200
Message-ID: <1431357920-25090-12-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpaj-0002aa-FP
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbbEKPZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:51 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48229 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963AbbEKPZt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:49 -0400
X-AuditID: 12074412-f79e46d0000036b4-55-5550c9fd4ad6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BD.B7.14004.DF9C0555; Mon, 11 May 2015 11:25:49 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnN002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:47 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqPv3ZECowdNj7BZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7oxDn3uYCy7LV5x8eYG5gXGlZBcjJ4eEgInE4cnL2SBsMYkL99YD2Vwc
	QgKXGSW2r9nCCuEcZ5L4OPE7O0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgV2MEveWTmUBSQgL
	uEr0b34DNpZFQFXizJM5zCA2L1D8xbwXUOvkJM4f/wkW5wSKL716GaxXSMBFounxPZYJjLwL
	GBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoSEmdAOxvUn5Q4xCnAwKvHw
	GlzwDxViTSwrrsw9xCjJwaQkyvtrb0CoEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe5TVAOd6U
	xMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCd43J4AaBYtS01Mr0jJzShDS
	TBycIMO5pESKU/NSUosSS0sy4kHREV8MjA+QFA/Q3q8g7bzFBYm5QFGI1lOMilLivAtBEgIg
	iYzSPLixsOTxilEc6Eth3o8gVTzAxAPX/QpoMBPQYMc4sMEliQgpqQZG0y8yEiteSt2Zo7GB
	X439YMX9U0afWOZv9+0p7ua74tXy6dKuyqb58W8LFuzZe+5tkUfC6/CrXDJtOv57E8XEhc5N
	6GLIFHSWDt63e1+N2rygcPXXRVc+8LPe3SIlyu3J++FqVKxkeUvwn5Tlb+8waj3s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268785>

Rename is_refname_available() to verify_refname_available() and change
its return value from 1 for success to 0 for success, to be consistent
with our error-handling convention. In a moment it will also get a
"struct strbuf *err" parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 0fa70fb..703e93d 100644
--- a/refs.c
+++ b/refs.c
@@ -263,7 +263,7 @@ struct ref_dir {
  * presence of an empty subdirectory does not block the creation of a
  * similarly-named reference.  (The fact that reference names with the
  * same leading components can conflict *with each other* is a
- * separate issue that is regulated by is_refname_available().)
+ * separate issue that is regulated by verify_refname_available().)
  *
  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
@@ -858,13 +858,14 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 }
 
 /*
- * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference in dir. If
- * extras is non-NULL, it is a list of additional refnames with which
- * refname is not allowed to conflict. If skip is non-NULL, ignore
- * potential conflicts with refs in skip (e.g., because they are
- * scheduled for deletion in the same operation). Behavior is
- * undefined if the same name is listed in both extras and skip.
+ * Return 0 if a reference named refname could be created without
+ * conflicting with the name of an existing reference in dir.
+ * Otherwise, return a negative value. If extras is non-NULL, it is a
+ * list of additional refnames with which refname is not allowed to
+ * conflict. If skip is non-NULL, ignore potential conflicts with refs
+ * in skip (e.g., because they are scheduled for deletion in the same
+ * operation). Behavior is undefined if the same name is listed in
+ * both extras and skip.
  *
  * Two reference names conflict if one of them exactly matches the
  * leading components of the other; e.g., "refs/foo/bar" conflicts
@@ -873,15 +874,15 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
  *
  * extras and skip must be sorted.
  */
-static int is_refname_available(const char *refname,
-				const struct string_list *extras,
-				const struct string_list *skip,
-				struct ref_dir *dir)
+static int verify_refname_available(const char *refname,
+				    const struct string_list *extras,
+				    const struct string_list *skip,
+				    struct ref_dir *dir)
 {
 	const char *slash;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
-	int ret = 0;
+	int ret = -1;
 
 	/*
 	 * For the sake of comments in this function, suppose that
@@ -1007,7 +1008,7 @@ static int is_refname_available(const char *refname,
 	}
 
 	/* No conflicts were found */
-	ret = 1;
+	ret = 0;
 
 cleanup:
 	strbuf_release(&dirname);
@@ -2383,7 +2384,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_sha1(lock->old_sha1) &&
-	    !is_refname_available(refname, extras, skip, get_packed_refs(&ref_cache))) {
+	    verify_refname_available(refname, extras, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2824,8 +2825,10 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = is_refname_available(newname, NULL, &skip, get_packed_refs(&ref_cache))
-		&& is_refname_available(newname, NULL, &skip, get_loose_refs(&ref_cache));
+	ret = !verify_refname_available(newname, NULL, &skip,
+					get_packed_refs(&ref_cache))
+		&& !verify_refname_available(newname, NULL, &skip,
+					     get_loose_refs(&ref_cache));
 	string_list_clear(&skip, 0);
 	return ret;
 }
-- 
2.1.4
