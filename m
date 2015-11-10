From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 02/10] verify_refname_available(): new function
Date: Tue, 10 Nov 2015 12:42:32 +0100
Message-ID: <9a6fdf279cd6f1132d2dcd28f200565bf800ba28.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7Kg-0000gn-7R
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbbKJLnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:12 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63184 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751952AbbKJLnE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:04 -0500
X-AuditID: 1207440d-f79136d00000402c-40-5641d83f6384
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.79.16428.F38D1465; Tue, 10 Nov 2015 06:42:55 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABglj6014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:42:53 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1LW/4RhmsP4Bs8X8TScYLbqudDNZ
	NPReYbaYNOUmk8XtFfOZLX609DBbzLxqbdHb94nV4t+EGgdOj7/vPzB57Jx1l91jwaZSj7MH
	Mz2e9e5h9Lh4Sdlj/9JtbB4Lnt9n9/i8SS6AM4rbJimxpCw4Mz1P3y6BO2PfjDb2gkPaFb+3
	XWJvYJyk3MXIySEhYCJx78IURghbTOLCvfVsXYxcHEIClxklnq9bzgjhnGCS6Lh6jx2kik1A
	V2JRTzMTiC0ioCYxse0QC0gRs8A1JokzT6azgCSEBZwk5r3fwQpiswioSrxsbWMDsXkFoiRO
	LV7DBrFOTmLK/XagQRwcnAIWEnPPZYCEhQTMJY63T2ScwMi7gJFhFaNcYk5prm5uYmZOcWqy
	bnFyYl5eapGukV5uZoleakrpJkZIcPLuYPy/TuYQowAHoxIP74RvDmFCrIllxZW5hxglOZiU
	RHn3n3IME+JLyk+pzEgszogvKs1JLT7EKMHBrCTCa/8CqJw3JbGyKrUoHyYlzcGiJM6rtkTd
	T0ggPbEkNTs1tSC1CCYrw8GhJMHrfh1oqGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJ
	RjwoNuKLgdEBkuIB2qsE0s5bXJCYCxSFaD3FqCglzqsFkhAASWSU5sGNhaWcV4ziQF8K8zqD
	VPEA0xVc9yugwUxAg5f6gzxUXJKIkJJqYBQMcMyqeCkYai1dpPdaRebXg199OXzNS17/W/Tm
	g4s106PIlOP7XWbPTRa0ShG8Vil+3i95hn/IffF1zsG1Cnk5Zw48b7s/K9hZqyiJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281111>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a new verify_refname_available() function, which checks whether the
refname is available for use, taking all references (both packed and
loose) into account. This function, unlike the old
verify_refname_available(), has semantics independent of the choice of
reference storage, and can therefore be implemented by alternative
reference backends.

Use the new function in a couple of places.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 66 ++++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 0617e0c..ddcdf81 100644
--- a/refs.c
+++ b/refs.c
@@ -279,7 +279,7 @@ struct ref_dir {
  * presence of an empty subdirectory does not block the creation of a
  * similarly-named reference.  (The fact that reference names with the
  * same leading components can conflict *with each other* is a
- * separate issue that is regulated by verify_refname_available_dir().)
+ * separate issue that is regulated by verify_refname_available().)
  *
  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
@@ -897,19 +897,7 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 /*
  * Return 0 if a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.
- * Otherwise, return a negative value and write an explanation to err.
- * If extras is non-NULL, it is a list of additional refnames with
- * which refname is not allowed to conflict. If skip is non-NULL,
- * ignore potential conflicts with refs in skip (e.g., because they
- * are scheduled for deletion in the same operation). Behavior is
- * undefined if the same name is listed in both extras and skip.
- *
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "refs/foo/bar" conflicts
- * with both "refs/foo" and with "refs/foo/bar/baz" but not with
- * "refs/foo/bar" or "refs/foo/barbados".
- *
- * extras and skip must be sorted.
+ * See verify_refname_available for more information.
  */
 static int verify_refname_available_dir(const char *refname,
 					const struct string_list *extras,
@@ -3120,6 +3108,40 @@ out:
 	return ret;
 }
 
+/*
+ * Return 0 if a reference named refname could be created without
+ * conflicting with the name of an existing reference. Otherwise,
+ * return a negative value and write an explanation to err. If extras
+ * is non-NULL, it is a list of additional refnames with which refname
+ * is not allowed to conflict. If skip is non-NULL, ignore potential
+ * conflicts with refs in skip (e.g., because they are scheduled for
+ * deletion in the same operation). Behavior is undefined if the same
+ * name is listed in both extras and skip.
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ *
+ * extras and skip must be sorted.
+ */
+static int verify_refname_available(const char *newname,
+				    struct string_list *extras,
+				    struct string_list *skip,
+				    struct strbuf *err)
+{
+	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
+	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
+
+	if (verify_refname_available_dir(newname, extras, skip,
+					 packed_refs, err) ||
+	    verify_refname_available_dir(newname, extras, skip,
+					 loose_refs, err))
+		return -1;
+
+	return 0;
+}
+
 static int rename_ref_available(const char *oldname, const char *newname)
 {
 	struct string_list skip = STRING_LIST_INIT_NODUP;
@@ -3127,10 +3149,7 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available_dir(newname, NULL, &skip,
-					    get_packed_refs(&ref_cache), &err)
-		&& !verify_refname_available_dir(newname, NULL, &skip,
-						 get_loose_refs(&ref_cache), &err);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
 	if (!ret)
 		error("%s", err.buf);
 
@@ -4334,8 +4353,6 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
-	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -4376,12 +4393,9 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		if ((update->flags & REF_HAVE_OLD) &&
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
-		if (verify_refname_available_dir(update->refname,
-						 &affected_refnames, NULL,
-						 loose_refs, err) ||
-		    verify_refname_available_dir(update->refname,
-						 &affected_refnames, NULL,
-						 packed_refs, err)) {
+		if (verify_refname_available(update->refname,
+					     &affected_refnames, NULL,
+					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
-- 
2.6.2
