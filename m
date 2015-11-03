From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 18/25] refs: move refname_is_safe to the common code
Date: Tue,  3 Nov 2015 08:40:02 +0100
Message-ID: <0ceed2b4f61fd896995994690ae2dcd06d602ee2.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWD7-0007c0-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbbKCHkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:42 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56104 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752963AbbKCHkh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:37 -0500
X-AuditID: 12074413-f79bd6d000007ac2-81-563864f5650d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A2.03.31426.5F468365; Tue,  3 Nov 2015 02:40:37 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdF016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:36 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPs1xSLMYG2zvMX8TScYLbqudDNZ
	NPReYba4vWI+s8W/CTUOrB5/339g8liwqdTj4iVljwXP77N7fN4kF8AaxW2TlFhSFpyZnqdv
	l8Cd8WDvDLaCbrmKY1vuMjUwvhTvYuTkkBAwkbgyZwojhC0mceHeerYuRi4OIYHLjBIzVxxi
	hXCOMUls/PSSGaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwCJGiYdHtrOCJIQF3CXu/nsFVsQi
	oCpxZsFesDivQJTE2ts3WSDWyUlMud8OVsMpYCHx4O4fdhBbSMBcYtO9ZWwTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJKeEdjLtOyh1iFOBgVOLhXbDEPEyI
	NbGsuDL3EKMkB5OSKO+6GIswIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8BYFAOd6UxMqq1KJ8
	mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG8EMHaEBItS01Mr0jJzShDSTBycIMO5
	pESKU/NSUosSS0sy4kHREV8MjA+QFA/Q3gSQdt7igsRcoChE6ylGRSlx3snJQAkBkERGaR7c
	WFiieMUoDvSlMO8FkCoeYJKB634FNJgJaHD4NlOQwSWJCCmpBkbtpz+MQtMu/DB8GSb06Wu/
	dunBnnYHGdHpb0/pnRX1mKv05myBseTPE6qai33Cny6f4DZTQf7wTL+/TzI3bdz7bv9xxyP7
	Z6xZ5a/Vu83kmayz8TP572dNgir9V/9rPz7ZKS6xXM1SYlX7o8qs7Iopps0al2Yd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280762>

From: David Turner <dturner@twopensource.com>

This function does not contain any backend specific code, so move it
to the common code. This function might be used by other refs
backends.

While we are doing so, improve the comment's grammar and clarify a
safety rule.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 ---------------------------------
 refs/refs-internal.h | 15 +++++++++++++++
 refs/refs.c          | 24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1719720..3a4aff6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -196,39 +196,6 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
-/*
- * Check if a refname is safe.
- * For refs that start with "refs/" we consider it safe as long they do
- * not try to resolve to outside of refs/.
- *
- * For all other refs we only consider them safe iff they only contain
- * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
- * "config").
- */
-static int refname_is_safe(const char *refname)
-{
-	if (starts_with(refname, "refs/")) {
-		char *buf;
-		int result;
-
-		buf = xmalloc(strlen(refname) + 1);
-		/*
-		 * Does the refname try to escape refs/?
-		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
-		 * is not.
-		 */
-		result = !normalize_path_copy(buf, refname + strlen("refs/"));
-		free(buf);
-		return result;
-	}
-	while (*refname) {
-		if (!isupper(*refname) && *refname != '_')
-			return 0;
-		refname++;
-	}
-	return 1;
-}
-
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
 					  int check_name)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 94f5dde..5ae084b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -10,6 +10,21 @@
 #include "../refs.h"
 
 /*
+ * Return true iff refname is minimally safe. "Safe" here means that
+ * deleting a loose reference by this name will not do any damage, for
+ * example by causing a file that is not a reference to be deleted.
+ * This function does not check that the reference name is legal; for
+ * that, use check_refname_format().
+ *
+ * We consider a refname that starts with "refs/" to be safe as long
+ * as any ".." components that it might contain do not escape "refs/".
+ * Names that do not start with "refs/" are considered safe iff they
+ * consist entirely of upper case characters and '_' (like "HEAD" and
+ * "MERGE_HEAD" but not "config" or "FOO/BAR").
+ */
+int refname_is_safe(const char *refname);
+
+/*
  * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
  * refs (i.e., because the reference is about to be deleted anyway).
  */
diff --git a/refs/refs.c b/refs/refs.c
index 0d0579f..31f1b19 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -949,3 +949,27 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      NULL, old_sha1,
 				      flags, NULL, err);
 }
+
+int refname_is_safe(const char *refname)
+{
+	if (starts_with(refname, "refs/")) {
+		char *buf;
+		int result;
+
+		buf = xmalloc(strlen(refname) + 1);
+		/*
+		 * Does the refname try to escape refs/?
+		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
+		 * is not.
+		 */
+		result = !normalize_path_copy(buf, refname + strlen("refs/"));
+		free(buf);
+		return result;
+	}
+	while (*refname) {
+		if (!isupper(*refname) && *refname != '_')
+			return 0;
+		refname++;
+	}
+	return 1;
+}
-- 
2.6.2
