From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 05/26] refs.c: move update_ref to refs.c
Date: Tue, 27 Oct 2015 22:14:06 -0400
Message-ID: <1445998467-11511-6-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:17:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGIq-0003A1-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbbJ1COy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:14:54 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36255 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbbJ1COs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:48 -0400
Received: by igdg1 with SMTP id g1so97168733igd.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pBYkZcgpx2Tf0RfUD4XSaRjZZjpyFl2J0pAD8BYi0uo=;
        b=foZanXzLKTFnDLfysNrVi3iDdnozUTL1O5c8HKk6OO7zEzB5r1Xj6YV7H/OFHm/n/J
         ZS2GeMUnbvivwufG3HhhoN7h8+fFOyygNHBRprkbVZsE/pRE0Q8DLXwAVKHSDpg2uO6d
         1i168Jr3rpkm7FGCgZxEnjtfkfEbOUa+xuonn0VwwyKxfj14ot5RT3pZfeL+5biwASM7
         p+zYJXamSifTZgSZughy5sJLmE55s7dI8TxeBgL6AJIh9GpoQbZb034Ng5nhGTdA1Awz
         yrfEsxDJkFNy/tZumDwGB4FvwBbTIF/3Y9Mg7B8n9qQqaeI/Hr7afLlY2zWvL59xUPgc
         2pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pBYkZcgpx2Tf0RfUD4XSaRjZZjpyFl2J0pAD8BYi0uo=;
        b=mbR6tPIOdNpY48N7zPSUtpGOhhV+lVTnKLq0+eNZHuevZli44qw+Gd6ifNjNnODU8x
         emiJsF6bP52dr2nc2v7yZZ0YsSrwVwaLWl8zs30bs+wNiRyeoBcUh6iZQ/zjfSmjNVxT
         CiReRDd6Cg1i6gcONAjWPQEgIZN2SOGR5M6xfdandHrKDt62hecSOi2SiCI39k035l9l
         PTvUv+sK2HkRjmmL/BmME7dcm/Cyb+OxelyMs6PNjd6pHmXBDFcgNkPZD1k4ZVJN3VJz
         HOpX4HmtNk0KT+lyG+0B9EWAbu/ciI00ZuB7IbCjDR3HrsBQRqmXZ0pEE1s4eASsDbWT
         TH6A==
X-Gm-Message-State: ALoCoQm0OPyNPmVaLEwB5uN3fdnKCwo0Dn4EFKJsDLlRMkG/cNmuXSeoRn5dEWs2C7yNzrdUe3+9
X-Received: by 10.50.66.208 with SMTP id h16mr315379igt.7.1445998488051;
        Tue, 27 Oct 2015 19:14:48 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280351>

From: Ronnie Sahlberg <sahlberg@google.com>

Move update_ref() to the refs.c file since this function does not
contain any backend specific code.  Move the ref classifier functions
and write_pseudoref as well, since update_ref depends on them.

Based on Ronnie Sahlberg's patch

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 117 +-------------------------------------------------------
 refs.c          | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 116 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index fe71ea0..f03d68c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2675,8 +2675,6 @@ struct pack_refs_cb_data {
 	struct ref_to_prune *ref_to_prune;
 };
 
-static int is_per_worktree_ref(const char *refname);
-
 /*
  * An each_ref_entry_fn that is run over loose references only.  If
  * the loose reference can be packed, add an entry in the packed ref
@@ -2691,7 +2689,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
 	/* Do not pack per-worktree refs: */
-	if (is_per_worktree_ref(entry->name))
+	if (ref_type(entry->name) == REF_TYPE_PER_WORKTREE)
 		return 0;
 
 	/* ALWAYS pack tags */
@@ -2886,77 +2884,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
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
diff --git a/refs.c b/refs.c
index 77492ff..610fab0 100644
--- a/refs.c
+++ b/refs.c
@@ -1,3 +1,119 @@
 /*
  * Common refs code for all backends.
  */
+#include "cache.h"
+#include "refs.h"
+#include "lockfile.h"
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
2.4.2.658.g6d8523e-twtrsrc
