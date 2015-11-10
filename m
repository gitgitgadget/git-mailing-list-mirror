From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 10/10] refs: break out ref conflict checks
Date: Tue, 10 Nov 2015 12:42:40 +0100
Message-ID: <2a2e679320beb395b2ca57e429af3729cd642bf8.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7Kz-0000zW-Nm
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbKJLnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:37 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63195 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752046AbbKJLnJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:09 -0500
X-AuditID: 12074413-f79bd6d000007ac2-a3-5641d84d6308
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5A.0B.31426.D48D1465; Tue, 10 Nov 2015 06:43:09 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABgljE014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:43:07 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqOt7wzHMoG0il8X8TScYLbqudDNZ
	NPReYbaYNOUmk8XtFfOZLX609DBbzLxqbdHb94nVgcPj7/sPTB47Z91l9zh7MNPjWe8eRo+L
	l5Q99i/dxuax4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDOmPO9lL1irVbHusk4DY5tSFyMH
	h4SAicSXleJdjJxAppjEhXvr2boYuTiEBC4zSlx7sYoVwjnBJPG0dS0jSBWbgK7Eop5mJhBb
	REBNYmLbIRYQm1lgGZPErL22ILawgK1E36tX7CA2i4CqxON7B9lAbF6BKIkHG58wQWyTk5hy
	v50J5AhOAQuJuecyQMJCAuYSx9snMk5g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdc
	LzezRC81pXQTIyQMhXcw7jopd4hRgINRiYd3wjeHMCHWxLLiytxDjJIcTEqivPtPOYYJ8SXl
	p1RmJBZnxBeV5qQWH2KU4GBWEuG1fwFUzpuSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpa
	kFoEk5Xh4FCS4D1xDWioYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgq4ouBcQGS
	4gHaq3QdqJ23uCAxFygK0XqKUVFKnFcLJCEAksgozYMbC0surxjFgb4U5p0Isp0HmJjgul8B
	DWYCGrzUH+Sh4pJEhJRUA6PAb2Ffx8KbPy7rmL6a17Htg5myiJtpf4tL53n285sE5Py5rRt5
	O4KMH88L26ahzqEy7+Kso7ZrXhy8y9Nz9PkX+5t2jL5b5/+YsvD9e+s4rbwPjBMO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281115>

From: David Turner <dturner@twopensource.com>

Create new function find_descendant_ref, to hold one of the ref
conflict checks used in verify_refname_available. Multiple backends
will need this function, so move it to the common code.

Also move rename_ref_available to the common code, because alternate
backends might need it and it has no files-backend-specific code.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 44 ++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 49 +++++++------------------------------------------
 refs/refs-internal.h | 16 ++++++++++++++++
 3 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/refs.c b/refs.c
index 1620a53..ad883ec 100644
--- a/refs.c
+++ b/refs.c
@@ -1029,3 +1029,47 @@ int ref_is_hidden(const char *refname)
 	}
 	return 0;
 }
+
+const char *find_descendant_ref(const char *dirname,
+				const struct string_list *extras,
+				const struct string_list *skip)
+{
+	int pos;
+
+	if (!extras)
+		return NULL;
+
+	/*
+	 * Look at the place where dirname would be inserted into
+	 * extras. If there is an entry at that position that starts
+	 * with dirname (remember, dirname includes the trailing
+	 * slash) and is not in skip, then we have a conflict.
+	 */
+	for (pos = string_list_find_insert_index(extras, dirname, 0);
+	     pos < extras->nr; pos++) {
+		const char *extra_refname = extras->items[pos].string;
+
+		if (!starts_with(extra_refname, dirname))
+			break;
+
+		if (!skip || !string_list_has_string(skip, extra_refname))
+			return extra_refname;
+	}
+	return NULL;
+}
+
+int rename_ref_available(const char *oldname, const char *newname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	string_list_insert(&skip, oldname);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
+	if (!ret)
+		error("%s", err.buf);
+
+	string_list_clear(&skip, 0);
+	strbuf_release(&err);
+	return ret;
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index aaf2639..4db3e36 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -728,6 +728,7 @@ static int verify_refname_available_dir(const char *refname,
 					struct strbuf *err)
 {
 	const char *slash;
+	const char *extra_refname;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
 	int ret = -1;
@@ -833,32 +834,12 @@ static int verify_refname_available_dir(const char *refname,
 		}
 	}
 
-	if (extras) {
-		/*
-		 * Check for entries in extras that start with
-		 * "$refname/". We do that by looking for the place
-		 * where "$refname/" would be inserted in extras. If
-		 * there is an entry at that position that starts with
-		 * "$refname/" and is not in skip, then we have a
-		 * conflict.
-		 */
-		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
-		     pos < extras->nr; pos++) {
-			const char *extra_refname = extras->items[pos].string;
-
-			if (!starts_with(extra_refname, dirname.buf))
-				break;
-
-			if (!skip || !string_list_has_string(skip, extra_refname)) {
-				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-					    refname, extra_refname);
-				goto cleanup;
-			}
-		}
-	}
-
-	/* No conflicts were found */
-	ret = 0;
+	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
+	if (extra_refname)
+		strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+			    refname, extra_refname);
+	else
+		ret = 0;
 
 cleanup:
 	strbuf_release(&dirname);
@@ -2473,22 +2454,6 @@ int verify_refname_available(const char *newname,
 	return 0;
 }
 
-static int rename_ref_available(const char *oldname, const char *newname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip, &err);
-	if (!ret)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ret;
-}
-
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 7b6c8bc..c7dded3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -181,4 +181,20 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err);
 
+/*
+ * Check for entries in extras that are within the specified
+ * directory, where dirname is a reference directory name including
+ * the trailing slash (e.g., "refs/heads/foo/"). Ignore any
+ * conflicting references that are found in skip. If there is a
+ * conflicting reference, return its name.
+ *
+ * extras and skip must be sorted lists of reference names. Either one
+ * can be NULL, signifying the empty list.
+ */
+const char *find_descendant_ref(const char *dirname,
+				const struct string_list *extras,
+				const struct string_list *skip);
+
+int rename_ref_available(const char *oldname, const char *newname);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.6.2
