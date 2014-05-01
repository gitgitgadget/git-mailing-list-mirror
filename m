From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 34/42] refs.c: pass the ref log message to _create/delete/update instead of _commit
Date: Thu,  1 May 2014 13:37:34 -0700
Message-ID: <1398976662-6962-35-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxkp-0001dO-6U
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbaEAUip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:45 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:52267 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaEAUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:59 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so676236pab.3
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pbEBQbcfjG1Tc0xLruohsnQ53dUSwYUWMWVh8mVirc=;
        b=Y2jXG8RODI1Tp/lNXJLwoGQ1OK/R2R9Z4fHR/khVBXdiRDkcmwzzI3Pt/tWjEw2SLQ
         C/nER4DzW9PwpMlocJZuVkVk3xLmZ1zXzozoki7uetpPgdErmqkL4RaUWrfXIMUzO4US
         gABdUVVogO9V6ycrt1ro0lCGlXM/iTQ1OWGtksnu294mIoyMbpSFbJ1ofgyQ3BLzMMKR
         kUkCcZBoD/6xkC7usgYDa1cwAw+m+g8luJ2gp8Si7Bp84QQ75cmKXUa0vyQ/K5/93a5o
         Jkd2JIOzc4/nDjUVASSduSiAtAyGYzxNUzIyJuTpAVOsNmuapYEjlNvLyHIhPjScZoNd
         HZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pbEBQbcfjG1Tc0xLruohsnQ53dUSwYUWMWVh8mVirc=;
        b=Zqf3KSldaDWKx0DPO7hNutQx0diZgXW2eZu93M5UxPK6Nbhrd1WbHl0yBeN3FZEeiR
         NGFHQPUvNwx3nIQZmjtIv2cZdbSfRZ67TE2DGxtClh7L22Vo7Foj/qniDIwFutaK4Nkk
         QzxAZD+qPHaJEDMUorrfzYcQzdHlVaNAirxKzWOhE/XAhiDmA9+MoFhXoQIUBrwaScFs
         Nr4nwyE0xRnsY/UWqaljFjHS/8mbo/m2r9hjbDMMdMZSstEMd/AK7iCqksZ6J7/1BE1e
         cFgxWBt8/CnBw+iBhzu35fJhJ7/J/KI/fEJ2jaUkfnaRYSsp6GJyctwIuPDF3P9j7xFl
         FUTQ==
X-Gm-Message-State: ALoCoQnSOu8RjjFHGVb879bx2NZmWsqLbAl+cXmRjvQdb/hEx13py3YjtT8tmny+n4lftyuL8Mg4
X-Received: by 10.66.233.65 with SMTP id tu1mr6681096pac.35.1398976678947;
        Thu, 01 May 2014 13:37:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si2611485yhl.7.2014.05.01.13.37.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A2F0731C2C1;
	Thu,  1 May 2014 13:37:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 597CDE097F; Thu,  1 May 2014 13:37:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247851>

Change the reference transactions so that we pass the reflog message
through to the create/delete/update function instead of the commit message.
This allows for individual messages for each change in a multi ref
transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               |  6 +++---
 builtin/commit.c       |  4 ++--
 builtin/fetch.c        | 10 ++++++++--
 builtin/receive-pack.c |  4 ++--
 builtin/replace.c      |  4 ++--
 builtin/tag.c          |  4 ++--
 builtin/update-ref.c   | 13 +++++++------
 fast-import.c          |  8 ++++----
 refs.c                 | 34 +++++++++++++++++++++-------------
 refs.h                 |  8 ++++----
 sequencer.c            |  4 ++--
 walker.c               |  6 +++---
 12 files changed, 60 insertions(+), 45 deletions(-)

diff --git a/branch.c b/branch.c
index 8e58908..74d55e7 100644
--- a/branch.c
+++ b/branch.c
@@ -300,9 +300,9 @@ void create_branch(const char *head,
 
 		transaction = ref_transaction_begin();
 		if (!transaction ||
-			ref_transaction_update(transaction, ref.buf, sha1,
-					       null_sha1, 0, !forcing) ||
-			ref_transaction_commit(transaction, msg, &err))
+		    ref_transaction_update(transaction, ref.buf, sha1,
+					   null_sha1, 0, !forcing, msg) ||
+		    ref_transaction_commit(transaction, &err))
 				die_errno(_("%s: failed to write ref: %s"),
 					  ref.buf, err.buf);
 		ref_transaction_free(transaction);
diff --git a/builtin/commit.c b/builtin/commit.c
index 5bdcf9e..0f4e1fc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1681,8 +1681,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head ?
 				   current_head->object.sha1 : NULL,
-				   0, !!current_head) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+				   0, !!current_head, sb.buf) ||
+	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die(_("HEAD: cannot update ref: %s"), err.buf);
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5dbd0f0..3a849b0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -374,11 +374,17 @@ static int s_update_ref(const char *action,
 			struct ref *ref,
 			int check_old)
 {
+	char msg[1024];
+	char *rla = getenv("GIT_REFLOG_ACTION");
+
 	if (dry_run)
 		return 0;
+	if (!rla)
+		rla = default_rla.buf;
+	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
 	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
-			       ref->old_sha1, 0, check_old))
+				   ref->old_sha1, 0, check_old, msg))
 		return STORE_REF_ERROR_OTHER;
 
 	return 0;
@@ -670,7 +676,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
-	if (ref_transaction_commit(transaction, "fetch_ref transaction", NULL))
+	if (ref_transaction_commit(transaction, NULL))
 		rc |= errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 		  STORE_REF_ERROR_OTHER;
 	ref_transaction_free(transaction);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d580176..991c659 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -582,7 +582,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			return "shallow error";
 
 		if (ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1))
+					   new_sha1, old_sha1, 0, 1, "push"))
 			return "failed to update";
 		return NULL; /* good */
 	}
@@ -823,7 +823,7 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
-	if (ref_transaction_commit(transaction, "push", &err))
+	if (ref_transaction_commit(transaction, &err))
 		error("%s", err.buf);
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
diff --git a/builtin/replace.c b/builtin/replace.c
index 5999f7d..47c360c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -161,8 +161,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev)) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+				   0, !is_null_sha1(prev), NULL) ||
+	    ref_transaction_commit(transaction, &err))
 		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
 	ref_transaction_free(transaction);
diff --git a/builtin/tag.c b/builtin/tag.c
index d59154a..c039355 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -705,8 +705,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, !is_null_sha1(prev)) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+				   0, !is_null_sha1(prev), NULL) ||
+	    ref_transaction_commit(transaction, &err))
 		die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
 	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7fe9c11..c5aff92 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,6 +16,7 @@ static struct ref_transaction *transaction;
 
 static char line_termination = '\n';
 static int update_flags;
+static const char *msg;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -198,7 +199,7 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 		die("update %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old))
+				   update_flags, have_old, msg))
 		die("update %s: failed", refname);
 
 	update_flags = 0;
@@ -226,7 +227,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create %s: extra input: %s", refname, next);
 
 	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags))
+				   update_flags, msg))
 		die("failed transaction create for %s", refname);
 
 	update_flags = 0;
@@ -258,7 +259,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old))
+				   update_flags, have_old, msg))
 		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
@@ -291,7 +292,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old))
+				   update_flags, have_old, msg))
 		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
@@ -344,7 +345,7 @@ static void update_refs_stdin(void)
 
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
-	const char *refname, *oldval, *msg = NULL;
+	const char *refname, *oldval;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
 	struct strbuf err = STRBUF_INIT;
@@ -371,7 +372,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, msg, &err))
+		if (ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		return 0;
diff --git a/fast-import.c b/fast-import.c
index 5587cf6..099e71b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1710,8 +1710,8 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1) ||
-	    ref_transaction_commit(transaction, msg, &err)) {
+				   0, 1, msg) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_rollback(transaction);
 		error("Unable to update branch %s: %s", b->name, err.buf);
 		strbuf_release(&err);
@@ -1745,10 +1745,10 @@ static void dump_tags(void)
 		sprintf(ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name, t->sha1,
-					   NULL, 0, 0))
+					   NULL, 0, 0, msg))
 			failure |= error("Unable to update %s", err.buf);
 	}
-	if (failure || ref_transaction_commit(transaction, msg, &err))
+	if (failure || ref_transaction_commit(transaction, &err))
 		failure |= error("Unable to update %s", err.buf);
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
diff --git a/refs.c b/refs.c
index 96b03e5..7e58693 100644
--- a/refs.c
+++ b/refs.c
@@ -2339,8 +2339,8 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1) ||
-	    ref_transaction_commit(transaction, NULL, &err)) {
+				   REF_ISPRUNING, 1, NULL) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_rollback(transaction);
 		warning("prune_ref: %s", err.buf);
 		strbuf_release(&err);
@@ -2503,8 +2503,8 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1)) ||
-	    ref_transaction_commit(transaction, NULL, NULL)) {
+				   sha1 && !is_null_sha1(sha1), NULL) ||
+	    ref_transaction_commit(transaction, NULL)) {
 		ref_transaction_rollback(transaction);
 		return 1;
 	}
@@ -3239,6 +3239,7 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
+	const char *msg;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3272,9 +3273,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	if (!transaction)
 		return;
 
-	for (i = 0; i < transaction->nr; i++)
+	for (i = 0; i < transaction->nr; i++) {
+	  free((char *)transaction->updates[i]->msg);
 		free(transaction->updates[i]);
-
+	}
 	free(transaction->updates);
 	free(transaction);
 }
@@ -3305,7 +3307,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+			   int flags, int have_old, const char *msg)
 {
 	struct ref_update *update;
 
@@ -3321,13 +3323,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags)
+			   int flags, const char *msg)
 {
 	struct ref_update *update;
 
@@ -3343,13 +3347,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old)
+			   int flags, int have_old, const char *msg)
 {
 	struct ref_update *update;
 
@@ -3366,6 +3372,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3379,8 +3387,8 @@ int update_ref(const char *action, const char *refname,
 	t = ref_transaction_begin();
 	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval) ||
-	    ref_transaction_commit(t, action, &err)) {
+				   !!oldval, action) ||
+	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_rollback(t);
@@ -3422,7 +3430,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err)
+			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3471,7 +3479,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     msg);
+					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
 				const char *str = "Cannot update the ref '%s'.";
diff --git a/refs.h b/refs.h
index 340e11a..7a89415 100644
--- a/refs.h
+++ b/refs.h
@@ -237,7 +237,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old);
+			   int flags, int have_old, const char *msg);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
@@ -248,7 +248,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags);
+			   int flags, const char *msg);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
@@ -258,7 +258,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old);
+			   int flags, int have_old, const char *msg);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
@@ -267,7 +267,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * why the transaction failed.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err);
+			   struct strbuf *err);
 
 /*
  * Free an existing transaction.
diff --git a/sequencer.c b/sequencer.c
index 0cfdaf0..3a0ee09 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -285,8 +285,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+				   0, !unborn, sb.buf) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_rollback(transaction);
 		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
 		strbuf_release(&sb);
diff --git a/walker.c b/walker.c
index 6044ccf..c2a1266 100644
--- a/walker.c
+++ b/walker.c
@@ -291,12 +291,12 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		sprintf(ref_name, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, ref_name,
 					   &sha1[20 * i], NULL,
-					   0, 0))
+					   0, 0,
+					   msg ? msg : "fetch (unknown)"))
 			goto rollback_and_fail;
 	}
 
-	if (ref_transaction_commit(transaction, msg ? msg : "fetch (unknown)",
-				   &err)) {
+	if (ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		goto rollback_and_fail;
 	}
-- 
2.0.0.rc1.351.g4d2c8e4
