From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/18] verify_refname_available(): rename function
Date: Fri,  1 May 2015 14:25:51 +0200
Message-ID: <1430483158-14349-12-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1n-0001As-UD
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbbEAM0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:31 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55396 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745AbbEAM0Z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:25 -0400
X-AuditID: 12074413-f79f26d0000030e7-27-554370f033a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.EC.12519.0F073455; Fri,  1 May 2015 08:26:24 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zo004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:23 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPuhwDnUYPIyNouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ/xevIW9oFuh4sn0c+wNjHckuxg5OSQETCQ+tnQwQ9hiEhfurWfrYuTiEBK4zCixeddU
	RpCEkMAJJom/EyRAbDYBXYlFPc1MILaIgJrExLZDLCANzAIdjBIXlm9jB0kICzhJbHy7iwXE
	ZhFQlXj25w8riM0r4CrRu/wyO8Q2OYnzx38Cbebg4ASKf5maCLHLReL+969sExh5FzAyrGKU
	S8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p3cQICSjhHYy7TsodYhTgYFTi4eU46RQq
	xJpYVlyZe4hRkoNJSZTXNsE5VIgvKT+lMiOxOCO+qDQntfgQowQHs5II7z11oBxvSmJlVWpR
	PkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYI3MR+oUbAoNT21Ii0zpwQhzcTBCTKc
	S0qkODUvJbUosbQkIx4UGfHFwNgASfEA7V0G0s5bXJCYCxSFaD3FqCglztsDkhAASWSU5sGN
	haWJV4ziQF8K87ICk4YQDzDFwHW/AhrMBDT4/C0HkMEliQgpqQbGsNrk1fKPdQ9NbHw5f5Ml
	55Q5525NdHpq82K5qukHjbKPC2qYDs653s62YknwysusKzzl79m37vJQelb5297+i/6sDQFT
	J9WfmPb4353nIZMlnO1vc5R1K/gLfc56tnSzZuTRR7Gfvja0zt11c22cKbvBHMvw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268127>

Rename is_refname_available() to verify_refname_available() and change
its return value from 1 for success to 0 for success, to be consistent
with our error-handling convention. In a moment it will also get a
"struct strbuf *err" parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 81fbb33..cd8aeed 100644
--- a/refs.c
+++ b/refs.c
@@ -268,7 +268,7 @@ struct ref_dir {
  * presence of an empty subdirectory does not block the creation of a
  * similarly-named reference.  (The fact that reference names with the
  * same leading components can conflict *with each other* is a
- * separate issue that is regulated by is_refname_available().)
+ * separate issue that is regulated by verify_refname_available().)
  *
  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
@@ -863,13 +863,14 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
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
  * leading components of the other; e.g., "foo/bar" conflicts with
@@ -878,15 +879,15 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
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
 
 	strbuf_grow(&dirname, strlen(refname) + 1);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
@@ -989,7 +990,7 @@ static int is_refname_available(const char *refname,
 	}
 
 	/* No conflicts were found */
-	ret = 1;
+	ret = 0;
 
 cleanup:
 	strbuf_release(&dirname);
@@ -2364,7 +2365,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_sha1(lock->old_sha1) &&
-	    !is_refname_available(refname, extras, skip, get_packed_refs(&ref_cache))) {
+	    verify_refname_available(refname, extras, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2804,8 +2805,10 @@ static int rename_ref_available(const char *oldname, const char *newname)
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
