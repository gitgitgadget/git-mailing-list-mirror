From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 05/25] refs: move delete_pseudoref and delete_ref to the common code
Date: Tue,  3 Nov 2015 08:39:49 +0100
Message-ID: <66b3ecccedd5eac095e8e165a363a3a3d1a2a920.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:47:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWJv-0005au-TB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbbKCHrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:52 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44587 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbbKCHrv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:51 -0500
X-AuditID: 12074414-f794f6d000007852-91-563864e58035
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B7.2D.30802.5E468365; Tue,  3 Nov 2015 02:40:21 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd2016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:20 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPs0xSLMYOZtU4v5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE748usQ4wFTUoVd3/8Ym1gfCrdxcjJISFgIjFn0wQmCFtM4sK99WxdjFwcQgKXGSWO/9jL
	DOEcY5LYvH82M0gVm4CuxKKeZrAOEQE1iYlth1hAipgFFjFKtL6ZDpYQFgiXmLrvP1gDi4Cq
	xJpN11hBbF6BKInD/05ArZOTmHK/HczmFLCQeHD3DzuILSRgLrHp3jK2CYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKEhJTIDsYjJ+UOMQpwMCrx8C5YYh4mxJpY
	VlyZe4hRkoNJSZR3XYxFmBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3oJAoBxvSmJlVWpRPkxK
	moNFSZz322J1PyGB9MSS1OzU1ILUIpisDAeHkgTvpWSgRsGi1PTUirTMnBKENBMHJ8hwLimR
	4tS8lNSixNKSjHhQdMQXA+MDJMUDtDchBWRvcUFiLlAUovUUo6KUOO9FkLkCIImM0jy4sbBE
	8YpRHOhLYd6JIFU8wCQD1/0KaDAT0ODwbaYgg0sSEVJSDYyeKzm/vnG7ZSTwyEz8u050nb4/
	/+aLM5nqbKdZhywRdLjYFjqbWbUqaVVh1apAK5agJg75GfvUjs98aMR58MyKZBstjXPHbsvF
	XjmTdck9aY5v7JZ0/eUvHocffDep4Z/Epe/aczcfuvbP9M+jqIvOavenPDfob7C+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280770>

From: Ronnie Sahlberg <sahlberg@google.com>

Move delete_pseudoref() and delete_ref() to refs/refs.c since these
functions do not contain any backend specific code. We can't move
delete_refs yet because it depends on the files-backend-specific
repack_without_refs.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 56 ----------------------------------------------------
 refs/refs.c          | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e8c592a..6d502ac 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2892,62 +2892,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
-{
-	static struct lock_file lock;
-	const char *filename;
-
-	filename = git_path("%s", pseudoref);
-
-	if (old_sha1 && !is_null_sha1(old_sha1)) {
-		int fd;
-		unsigned char actual_old_sha1[20];
-
-		fd = hold_lock_file_for_update(&lock, filename,
-					       LOCK_DIE_ON_ERROR);
-		if (fd < 0)
-			die_errno(_("Could not open '%s' for writing"), filename);
-		if (read_ref(pseudoref, actual_old_sha1))
-			die("could not read ref '%s'", pseudoref);
-		if (hashcmp(actual_old_sha1, old_sha1)) {
-			warning("Unexpected sha1 when deleting %s", pseudoref);
-			rollback_lock_file(&lock);
-			return -1;
-		}
-
-		unlink(filename);
-		rollback_lock_file(&lock);
-	} else {
-		unlink(filename);
-	}
-
-	return 0;
-}
-
-int delete_ref(const char *refname, const unsigned char *old_sha1,
-	       unsigned int flags)
-{
-	struct ref_transaction *transaction;
-	struct strbuf err = STRBUF_INIT;
-
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
-		return delete_pseudoref(refname, old_sha1);
-
-	transaction = ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, old_sha1,
-				   flags, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		error("%s", err.buf);
-		ref_transaction_free(transaction);
-		strbuf_release(&err);
-		return 1;
-	}
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
-	return 0;
-}
-
 int delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
diff --git a/refs/refs.c b/refs/refs.c
index a63a58d..96d5c6d 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -117,3 +117,59 @@ int update_ref(const char *msg, const char *refname,
 		ref_transaction_free(t);
 	return 0;
 }
+
+static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
+{
+	static struct lock_file lock;
+	const char *filename;
+
+	filename = git_path("%s", pseudoref);
+
+	if (old_sha1 && !is_null_sha1(old_sha1)) {
+		int fd;
+		unsigned char actual_old_sha1[20];
+
+		fd = hold_lock_file_for_update(&lock, filename,
+					       LOCK_DIE_ON_ERROR);
+		if (fd < 0)
+			die_errno(_("Could not open '%s' for writing"), filename);
+		if (read_ref(pseudoref, actual_old_sha1))
+			die("could not read ref '%s'", pseudoref);
+		if (hashcmp(actual_old_sha1, old_sha1)) {
+			warning("Unexpected sha1 when deleting %s", pseudoref);
+			rollback_lock_file(&lock);
+			return -1;
+		}
+
+		unlink(filename);
+		rollback_lock_file(&lock);
+	} else {
+		unlink(filename);
+	}
+
+	return 0;
+}
+
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags)
+{
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
+		return delete_pseudoref(refname, old_sha1);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, old_sha1,
+				   flags, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
+		return 1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return 0;
+}
-- 
2.6.2
