From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 04/25] refs: move update_ref to refs/refs.c
Date: Tue,  3 Nov 2015 08:39:48 +0100
Message-ID: <c57c5d140bfb905aa00bc86a35e8f580b3334e10.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWJX-0005FN-LZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbbKCHrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:25 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59982 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098AbbKCHrY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:24 -0500
X-AuditID: 12074412-f79a76d000007c8b-aa-563864e4bbea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C6.A6.31883.4E468365; Tue,  3 Nov 2015 02:40:20 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd1016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:19 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqPskxSLM4HCPhsX8TScYLbqudDNZ
	NPReYba4vWI+s8W/CTUOrB5/339g8liwqdTj4iVljwXP77N7fN4kF8AaxW2TlFhSFpyZnqdv
	l8CdMfN6I2vBZtuK6Wu+sDYwfjLoYuTkkBAwkfj4qY0NwhaTuHBvPZgtJHCZUWLuzvAuRi4g
	+xiTxPpfF1lAEmwCuhKLepqZQGwRATWJiW2HWECKmAUWMUq0vpkOlODgEBawk+ibxw9isgio
	Suz6nAVSzisQJdGyegU7xC45iSn328HGcApYSDy4+4cdYq+5xKZ7y9gmMPIuYGRYxSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRESTEI7GNeflDvEKMDBqMTD+2OZeZgQa2JZ
	cWXuIUZJDiYlUd51MRZhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4CwKBcrwpiZVVqUX5MClp
	DhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKEryXkoEaBYtS01Mr0jJzShDSTBycIMO5pESK
	U/NSUosSS0sy4kFxEV8MjAyQFA/Q3pUg7bzFBYm5QFGI1lOMilLivBdBEgIgiYzSPLixsBTx
	ilEc6Eth3okgVTzA9ALX/QpoMBPQ4PBtpiCDSxIRUlINjO6WCmdeFE4s3hZ9V3COg+CZjw+T
	haOnbZs74+PDefOXmeX1+eaHL/X8lBXM8UbY89t7H4Y1mZfk33TbX9eYMUlQtlHB+25VH7vz
	gSyP5DeV2uZOqzgZPjHbzZ1Uy/Tw+ruKc68+sBvelmSJ3Oqo5vJF9PE65dVH13Sv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280766>

From: Ronnie Sahlberg <sahlberg@google.com>

Move update_ref() to refs/refs.c since this function does not contain
any backend specific code. Move the ref classifier functions and
write_pseudoref as well, since update_ref depends on them.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 117 +--------------------------------------------------
 refs/refs.c          | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 116 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dc39b36..e8c592a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2683,8 +2683,6 @@ struct pack_refs_cb_data {
 	struct ref_to_prune *ref_to_prune;
 };
 
-static int is_per_worktree_ref(const char *refname);
-
 /*
  * An each_ref_entry_fn that is run over loose references only.  If
  * the loose reference can be packed, add an entry in the packed ref
@@ -2699,7 +2697,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
 	/* Do not pack per-worktree refs: */
-	if (is_per_worktree_ref(entry->name))
+	if (ref_type(entry->name) == REF_TYPE_PER_WORKTREE)
 		return 0;
 
 	/* ALWAYS pack tags */
@@ -2894,77 +2892,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-static int is_per_worktree_ref(const char *refname)
-{
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
-}
-
-static int is_pseudoref_syntax(const char *refname)
-{
-	const char *c;
-
-	for (c = refname; *c; c++) {
-		if (!isupper(*c) && *c != '-' && *c != '_')
-			return 0;
-	}
-
-	return 1;
-}
-
-enum ref_type ref_type(const char *refname)
-{
-	if (is_per_worktree_ref(refname))
-		return REF_TYPE_PER_WORKTREE;
-	if (is_pseudoref_syntax(refname))
-		return REF_TYPE_PSEUDOREF;
-       return REF_TYPE_NORMAL;
-}
-
-static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
-			   const unsigned char *old_sha1, struct strbuf *err)
-{
-	const char *filename;
-	int fd;
-	static struct lock_file lock;
-	struct strbuf buf = STRBUF_INIT;
-	int ret = -1;
-
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
-
-	filename = git_path("%s", pseudoref);
-	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
-	if (fd < 0) {
-		strbuf_addf(err, "Could not open '%s' for writing: %s",
-			    filename, strerror(errno));
-		return -1;
-	}
-
-	if (old_sha1) {
-		unsigned char actual_old_sha1[20];
-
-		if (read_ref(pseudoref, actual_old_sha1))
-			die("could not read ref '%s'", pseudoref);
-		if (hashcmp(actual_old_sha1, old_sha1)) {
-			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
-			rollback_lock_file(&lock);
-			goto done;
-		}
-	}
-
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
-		strbuf_addf(err, "Could not write to '%s'", filename);
-		rollback_lock_file(&lock);
-		goto done;
-	}
-
-	commit_lock_file(&lock);
-	ret = 0;
-done:
-	strbuf_release(&buf);
-	return ret;
-}
-
 static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
 {
 	static struct lock_file lock;
@@ -4105,48 +4032,6 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
 }
 
-int update_ref(const char *msg, const char *refname,
-	       const unsigned char *new_sha1, const unsigned char *old_sha1,
-	       unsigned int flags, enum action_on_err onerr)
-{
-	struct ref_transaction *t = NULL;
-	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
-
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
-	} else {
-		t = ref_transaction_begin(&err);
-		if (!t ||
-		    ref_transaction_update(t, refname, new_sha1, old_sha1,
-					   flags, msg, &err) ||
-		    ref_transaction_commit(t, &err)) {
-			ret = 1;
-			ref_transaction_free(t);
-		}
-	}
-	if (ret) {
-		const char *str = "update_ref failed for ref '%s': %s";
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR:
-			error(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_DIE_ON_ERR:
-			die(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_QUIET_ON_ERR:
-			break;
-		}
-		strbuf_release(&err);
-		return 1;
-	}
-	strbuf_release(&err);
-	if (t)
-		ref_transaction_free(t);
-	return 0;
-}
-
 static int ref_update_reject_duplicates(struct string_list *refnames,
 					struct strbuf *err)
 {
diff --git a/refs/refs.c b/refs/refs.c
index 77492ff..a63a58d 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -1,3 +1,119 @@
 /*
  * Common refs code for all backends.
  */
+#include "../cache.h"
+#include "../refs.h"
+#include "../lockfile.h"
+
+static int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/bisect/");
+}
+
+static int is_pseudoref_syntax(const char *refname)
+{
+	const char *c;
+
+	for (c = refname; *c; c++) {
+		if (!isupper(*c) && *c != '-' && *c != '_')
+			return 0;
+	}
+
+	return 1;
+}
+
+enum ref_type ref_type(const char *refname)
+{
+	if (is_per_worktree_ref(refname))
+		return REF_TYPE_PER_WORKTREE;
+	if (is_pseudoref_syntax(refname))
+		return REF_TYPE_PSEUDOREF;
+       return REF_TYPE_NORMAL;
+}
+
+static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
+			   const unsigned char *old_sha1, struct strbuf *err)
+{
+	const char *filename;
+	int fd;
+	static struct lock_file lock;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = -1;
+
+	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
+
+	filename = git_path("%s", pseudoref);
+	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	if (fd < 0) {
+		strbuf_addf(err, "Could not open '%s' for writing: %s",
+			    filename, strerror(errno));
+		return -1;
+	}
+
+	if (old_sha1) {
+		unsigned char actual_old_sha1[20];
+
+		if (read_ref(pseudoref, actual_old_sha1))
+			die("could not read ref '%s'", pseudoref);
+		if (hashcmp(actual_old_sha1, old_sha1)) {
+			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		}
+	}
+
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
+		strbuf_addf(err, "Could not write to '%s'", filename);
+		rollback_lock_file(&lock);
+		goto done;
+	}
+
+	commit_lock_file(&lock);
+	ret = 0;
+done:
+	strbuf_release(&buf);
+	return ret;
+}
+
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1, const unsigned char *old_sha1,
+	       unsigned int flags, enum action_on_err onerr)
+{
+	struct ref_transaction *t = NULL;
+	struct strbuf err = STRBUF_INIT;
+	int ret = 0;
+
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
+	} else {
+		t = ref_transaction_begin(&err);
+		if (!t ||
+		    ref_transaction_update(t, refname, new_sha1, old_sha1,
+					   flags, msg, &err) ||
+		    ref_transaction_commit(t, &err)) {
+			ret = 1;
+			ref_transaction_free(t);
+		}
+	}
+	if (ret) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
+		}
+		strbuf_release(&err);
+		return 1;
+	}
+	strbuf_release(&err);
+	if (t)
+		ref_transaction_free(t);
+	return 0;
+}
-- 
2.6.2
