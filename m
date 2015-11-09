From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 03/11] verify_refname_available(): new function
Date: Mon,  9 Nov 2015 18:03:40 +0100
Message-ID: <23d05cbc247e5ef9036cb6f20184810745ac540f.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvprw-0007tx-1o
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbbKIRES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:04:18 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54970 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbbKIREL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:04:11 -0500
X-AuditID: 1207440f-f79df6d000007c0f-97-5640d20a89da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 25.EF.31759.A02D0465; Mon,  9 Nov 2015 12:04:10 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yq026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:08 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqMt1ySHMYMcpVov5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xGrxb0KNA4fH3/cfmDx2zrrL7rFgU6nH2YOZHs96
	9zB6XLyk7LHg+X12j8+b5AI4orhtkhJLyoIz0/P07RK4M/bNaGMvOKRd8XvbJfYGxknKXYyc
	HBICJhKbPs9ggbDFJC7cW8/WxcjFISRwmVHi9JkmdgjnBJPE8/OzWEGq2AR0JRb1NDOB2CIC
	ahIT2w6xgBQxCyxkkli5eQ9QgoNDWMBJovGdL0gNi4CqxLOVLxlBbF6BKIm1/QfYILbJSUy5
	3w42h1PAQmLHiX9gNUIC5hITV61hmsDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrole
	bmaJXmpK6SZGSCjy72DsWi9ziFGAg1GJhzdipn2YEGtiWXFl7iFGSQ4mJVHe6BMOYUJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeAt2AeV4UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8my4ANQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYiO+GBgdICke
	oL07QNp5iwsSc4GiEK2nGBWlxHkXgSQEQBIZpXlwY2EJ5hWjONCXwrxbQap4gMkJrvsV0GAm
	oMFL/cEGlyQipKQaGKu22PvztyQ53O4vtj/BtIeHL5Cpf8+f5dP/b1/FLdO4busxxtOaOfsn
	Fb4PPRmjfSA9pKtpM1fXDe7Zcckuj5lWVDsnbZ0aF3XnkM7D23XhOdueP3DIWzSj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281059>

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
