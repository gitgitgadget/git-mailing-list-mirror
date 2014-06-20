From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 41/48] refs.c: pass the ref log message to _create/delete/update instead of _commit
Date: Fri, 20 Jun 2014 07:43:22 -0700
Message-ID: <1403275409-28173-42-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:45:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04d-00037i-1r
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbaFTOoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:07 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:59165 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-ig0-f202.google.com with SMTP id c1so38698igq.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrEZLTqQ3Rsoq6AuundJjKivzfR2YkMEbIm7F1g4fL4=;
        b=oRdjKcN4DsNdpP4ZZdOxNA8rPRhbJUyaVh4YqUgqRbqz44JDR17hXoEsgcppjLl7zh
         PAURUk47TGmYGKCYTO12A6L1I/WKyXdGbtT/43IBtFyiEcy+FkS2Gz0uBBiUJFESn83y
         co8PFCYfcDVhI0ay7FRBoydg+jiiWCAShJqDy4j0tl+bmyH07sOZaPSiFIJ9QnA0Et2S
         ziY3twF7UB6WxGsCBI2YGUfJHfxIVYSBqMkB0K5T8XagUmpU7vNedcBRgzswmNtQ7lZl
         kAcLDjBVR3mtAYZZDqIqWeJNh0wZseduS4kzyTPxqEpT5HdP7NTFSu1eISitAeJe8r2w
         fNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrEZLTqQ3Rsoq6AuundJjKivzfR2YkMEbIm7F1g4fL4=;
        b=DsMgroqaUFpnhAY5f1NSgmO8vGzRxbg9bJV/UeAu4z1I9zkQDVigiWw0bDTbLRE1DZ
         1mQmlu3MeSvsOrxkf3tebViEnhJT8baI+OPLQ0bKTg03iuxfWTDxbr9mh7wLEFjNg73p
         VMot6ErD+4r9XQeqFHmVDlYeXAmmyNHe37XnPUg94fywNymU4+gtztMVYcaAKj7MWdfO
         HW2eo2qtC15VP7x0kA8GfwYf2N/pj1oFFvQmdGXxPuzCMjQIMfIrfbklf7xed//6WhYe
         OEtaJfVvhm3qWAeDbLc0owaJmvUNOqZntYdJDYxHu/747QucWtq8Um/kfvDwZ/VEKgla
         CPig==
X-Gm-Message-State: ALoCoQlTtBEpYi9qGW414g5gRk46k269Yg+noGh6NTJKYfk6FcgfIUAFvofxf0m40lp07fNn3caR
X-Received: by 10.42.164.70 with SMTP id f6mr1394723icy.4.1403275414110;
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si664714yhb.3.2014.06.20.07.43.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CF45A5A40F4;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AB797E0A04; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252247>

Change the reference transactions so that we pass the reflog message
through to the create/delete/update function instead of the commit message.
This allows for individual messages for each change in a multi ref
transaction.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               |  4 ++--
 builtin/commit.c       |  4 ++--
 builtin/fetch.c        |  3 +--
 builtin/receive-pack.c |  5 +++--
 builtin/replace.c      |  4 ++--
 builtin/tag.c          |  4 ++--
 builtin/update-ref.c   | 13 +++++++------
 fast-import.c          |  8 ++++----
 refs.c                 | 34 +++++++++++++++++++++-------------
 refs.h                 |  8 ++++----
 sequencer.c            |  4 ++--
 walker.c               |  5 ++---
 12 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/branch.c b/branch.c
index c1eae00..e0439af 100644
--- a/branch.c
+++ b/branch.c
@@ -301,8 +301,8 @@ void create_branch(const char *head,
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, &err) ||
-		    ref_transaction_commit(transaction, msg, &err))
+					   null_sha1, 0, !forcing, msg, &err) ||
+		    ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 668fa6a..c499826 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1767,8 +1767,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head ?
 				   current_head->object.sha1 : NULL,
-				   0, !!current_head, &err) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+				   0, !!current_head, sb.buf, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..faa1233 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -673,10 +673,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
-
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
-		      " 'git remote prune %s' to remove any old, conflicting "
+		      "'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
 
  abort:
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b51f8ae..0ed1ddd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -585,8 +585,9 @@ static char *update(struct command *cmd, struct shallow_info *si)
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, &err) ||
-		    ref_transaction_commit(transaction, "push", &err)) {
+					   new_sha1, old_sha1, 0, 1, "push",
+					   &err) ||
+		    ref_transaction_commit(transaction, &err)) {
 			char *str = strbuf_detach(&err, NULL);
 			ref_transaction_free(transaction);
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 7528f3d..df060f8 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -170,8 +170,8 @@ static int replace_object_sha1(const char *object_ref,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev), &err) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+				   0, !is_null_sha1(prev), NULL, &err) ||
+	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
 	ref_transaction_free(transaction);
diff --git a/builtin/tag.c b/builtin/tag.c
index c9bfc9a..74af63e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -705,8 +705,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, !is_null_sha1(prev), &err) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+				   0, !is_null_sha1(prev), NULL, &err) ||
+	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index c6ad0be..28b478a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,6 +16,7 @@ static struct ref_transaction *transaction;
 
 static char line_termination = '\n';
 static int update_flags;
+static const char *msg;
 static struct strbuf err = STRBUF_INIT;
 
 /*
@@ -199,7 +200,7 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 		die("update %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, &err))
+				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -227,7 +228,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create %s: extra input: %s", refname, next);
 
 	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags, &err))
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -259,7 +260,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, &err))
+				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -292,7 +293,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, &err))
+				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -345,7 +346,7 @@ static void update_refs_stdin(void)
 
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
-	const char *refname, *oldval, *msg = NULL;
+	const char *refname, *oldval;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
 	struct option options[] = {
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
index a95e1be..0876db2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1708,8 +1708,8 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, &err) ||
-	    ref_transaction_commit(transaction, msg, &err)) {
+				   0, 1, msg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -1748,12 +1748,12 @@ static void dump_tags(void)
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
-					   NULL, 0, 0, &err)) {
+					   NULL, 0, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
 	}
-	if (ref_transaction_commit(transaction, msg, &err))
+	if (ref_transaction_commit(transaction, &err))
 		failure |= error("%s", err.buf);
 
  cleanup:
diff --git a/refs.c b/refs.c
index c7d1f3e..1f17a13 100644
--- a/refs.c
+++ b/refs.c
@@ -2393,8 +2393,8 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, &err) ||
-	    ref_transaction_commit(transaction, NULL, &err)) {
+				   REF_ISPRUNING, 1, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -2589,8 +2589,8 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), &err) ||
-	    ref_transaction_commit(transaction, NULL, &err)) {
+				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
 		strbuf_release(&err);
@@ -3367,6 +3367,7 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
+	char *msg;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3414,9 +3415,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	if (!transaction)
 		return;
 
-	for (i = 0; i < transaction->nr; i++)
+	for (i = 0; i < transaction->nr; i++) {
+		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]);
-
+	}
 	free(transaction->updates);
 	free(transaction);
 }
@@ -3437,7 +3439,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3454,13 +3456,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
-			   int flags,
+			   int flags, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3477,13 +3481,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3501,6 +3507,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3514,8 +3522,8 @@ int update_ref(const char *action, const char *refname,
 	t = ref_transaction_begin(&err);
 	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err) ||
-	    ref_transaction_commit(t, action, &err)) {
+				   !!oldval, action, &err) ||
+	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_free(t);
@@ -3559,7 +3567,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err)
+			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3608,7 +3616,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     msg);
+					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
 				const char *str = "Cannot update the ref '%s'.";
diff --git a/refs.h b/refs.h
index 3b321c2..f24b2c1 100644
--- a/refs.h
+++ b/refs.h
@@ -297,7 +297,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -312,7 +312,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -326,7 +326,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -335,7 +335,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err);
+			   struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
diff --git a/sequencer.c b/sequencer.c
index fd8acaf..f9906ef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -285,8 +285,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn, &err) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+				   0, !unborn, sb.buf, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&sb);
diff --git a/walker.c b/walker.c
index 60d9f9e..fd9ef87 100644
--- a/walker.c
+++ b/walker.c
@@ -295,15 +295,14 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, ref_name.buf,
 					   &sha1[20 * i], NULL, 0, 0,
+					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
 			goto rollback_and_fail;
 		}
 	}
 	if (write_ref) {
-		if (ref_transaction_commit(transaction,
-					   msg ? msg : "fetch (unknown)",
-					   &err)) {
+		if (ref_transaction_commit(transaction, &err)) {
 			error("%s", err.buf);
 			goto rollback_and_fail;
 		}
-- 
2.0.0.420.g181e020.dirty
