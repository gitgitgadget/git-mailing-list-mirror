From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 20/25] refs: move peel_object to the common code
Date: Tue,  3 Nov 2015 08:40:04 +0100
Message-ID: <da2e70b06e99e0b949a03a9b2fc9f8fccdc01c93.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWK0-0005em-0l
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbbKCHr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:56 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59985 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751892AbbKCHry (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:54 -0500
X-AuditID: 12074412-f79a76d000007c8b-d8-563864f7eaea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 67.A6.31883.7F468365; Tue,  3 Nov 2015 02:40:39 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdH016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:38 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqPs9xSLMYOIpeYv5m04wWnRd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB5XLyk7LHg+X12j8+b5AJYorhtkhJLyoIz0/P07RK4M14cmcRW
	8FaloudJA1MD4wzZLkZODgkBE4nJz58zQdhiEhfurWfrYuTiEBK4zChxbt8OFgjnGJPE+vUP
	mEGq2AR0JRb1NIN1iAioSUxsOwRUxMHBLFAkcadfByQsLOAsca3xKCOIzSKgKrHs2UQWEJtX
	IEri2PSJzBDL5CSm3G8HG8MpYCHx4O4fdhBbSMBcYtO9ZWwTGHkXMDKsYpRLzCnN1c1NzMwp
	Tk3WLU5OzMtLLdI108vNLNFLTSndxAgJH6EdjOtPyh1iFOBgVOLh/bHMPEyINbGsuDL3EKMk
	B5OSKO+6GIswIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8BYFAOd6UxMqq1KJ8mJQ0B4uSOO/P
	xep+QgLpiSWp2ampBalFMFkZDg4lCd5LyUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJ
	pSUZ8aDIiC8GxgZIigdo70qQdt7igsRcoChE6ylGRSlx3osgCQGQREZpHtxYWFJ4xSgO9KUw
	70SQKh5gQoHrfgU0mAlocPg2U5DBJYkIKakGxvl+2sLfheNUvFcUiYQnyN9WvP363CaZpx3d
	Uqq1Jx6vEv7R/3XRP6kjb7b+4+/LEQ+Im/X0T2q506lq84xji5pUj81/6GGwdEf2nadpmxZF
	ixjJ8nQ9uHK4IeHIwZi2l5PNZyX6tQbGRG/7u/DQ7Oy1tWdWfJ0ZeewU88m6rXOb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280771>

From: David Turner <dturner@twopensource.com>

This function does not contain any backend specific code so move it to
the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 53 ----------------------------------------------------
 refs/refs-internal.h | 34 +++++++++++++++++++++++++++++++++
 refs/refs.c          | 23 +++++++++++++++++++++++
 3 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4807b32..2073004 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1612,59 +1612,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-enum peel_status {
-	/* object was peeled successfully: */
-	PEEL_PEELED = 0,
-
-	/*
-	 * object cannot be peeled because the named object (or an
-	 * object referred to by a tag in the peel chain), does not
-	 * exist.
-	 */
-	PEEL_INVALID = -1,
-
-	/* object cannot be peeled because it is not a tag: */
-	PEEL_NON_TAG = -2,
-
-	/* ref_entry contains no peeled value because it is a symref: */
-	PEEL_IS_SYMREF = -3,
-
-	/*
-	 * ref_entry cannot be peeled because it is broken (i.e., the
-	 * symbolic reference cannot even be resolved to an object
-	 * name):
-	 */
-	PEEL_BROKEN = -4
-};
-
-/*
- * Peel the named object; i.e., if the object is a tag, resolve the
- * tag recursively until a non-tag is found.  If successful, store the
- * result to sha1 and return PEEL_PEELED.  If the object is not a tag
- * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
- * and leave sha1 unchanged.
- */
-static enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
-{
-	struct object *o = lookup_unknown_object(name);
-
-	if (o->type == OBJ_NONE) {
-		int type = sha1_object_info(name, NULL);
-		if (type < 0 || !object_as_type(o, type, 0))
-			return PEEL_INVALID;
-	}
-
-	if (o->type != OBJ_TAG)
-		return PEEL_NON_TAG;
-
-	o = deref_tag_noverify(o);
-	if (!o)
-		return PEEL_INVALID;
-
-	hashcpy(sha1, o->sha1);
-	return PEEL_PEELED;
-}
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a1655e3..5b4176e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -59,6 +59,40 @@ int refname_is_safe(const char *refname);
  * value to ref_update::flags
  */
 
+enum peel_status {
+	/* object was peeled successfully: */
+	PEEL_PEELED = 0,
+
+	/*
+	 * object cannot be peeled because the named object (or an
+	 * object referred to by a tag in the peel chain), does not
+	 * exist.
+	 */
+	PEEL_INVALID = -1,
+
+	/* object cannot be peeled because it is not a tag: */
+	PEEL_NON_TAG = -2,
+
+	/* ref_entry contains no peeled value because it is a symref: */
+	PEEL_IS_SYMREF = -3,
+
+	/*
+	 * ref_entry cannot be peeled because it is broken (i.e., the
+	 * symbolic reference cannot even be resolved to an object
+	 * name):
+	 */
+	PEEL_BROKEN = -4
+};
+
+/*
+ * Peel the named object; i.e., if the object is a tag, resolve the
+ * tag recursively until a non-tag is found.  If successful, store the
+ * result to sha1 and return PEEL_PEELED.  If the object is not a tag
+ * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
+ * and leave sha1 unchanged.
+ */
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
+
 /**
  * Information needed for a single ref update. Set new_sha1 to the new
  * value or to null_sha1 to delete the ref. To check the old value
diff --git a/refs/refs.c b/refs/refs.c
index 6bf790b..5d95804 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -4,6 +4,8 @@
 #include "../cache.h"
 #include "refs-internal.h"
 #include "../lockfile.h"
+#include "../object.h"
+#include "../tag.h"
 
 static int is_per_worktree_ref(const char *refname)
 {
@@ -994,3 +996,24 @@ int refname_is_safe(const char *refname)
 	}
 	return 1;
 }
+
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
+{
+	struct object *o = lookup_unknown_object(name);
+
+	if (o->type == OBJ_NONE) {
+		int type = sha1_object_info(name, NULL);
+		if (type < 0 || !object_as_type(o, type, 0))
+			return PEEL_INVALID;
+	}
+
+	if (o->type != OBJ_TAG)
+		return PEEL_NON_TAG;
+
+	o = deref_tag_noverify(o);
+	if (!o)
+		return PEEL_INVALID;
+
+	hashcpy(sha1, o->sha1);
+	return PEEL_PEELED;
+}
-- 
2.6.2
