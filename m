From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 33/41] refs.c: pass the ref log message to _create/delete/update instead of _commit
Date: Thu, 29 May 2014 09:07:51 -0700
Message-ID: <1401379676-9307-10-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sj-0006y9-K5
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575AbaE2QI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:28 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:60970 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so105453oag.1
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IfpNAJobbWOtQfdp3HdWV42InCCWa4x7vDkugzjU0rE=;
        b=PZ9in6BM4qR3lt0vY11sVsKMrXjFM2WfNLoLzygsGaexsV3k7/UrHR6OAU6Nr9EARW
         hHXJeIxpXGppygodzwsunXgt042w7V/RHh57gdr0yx+5EBxR42SNhAcW2OCFU1YcHRln
         MV4Xjbvp4My3CF9meV5fNlDl/GptHw0QEzQnmnu41OLm/skJf3DZtcCV8WSMJBTQTeJj
         BOX5uiCEiFKtzCervINJ6TxlePUKh4N4tHEyDkXU0RdrfpGWTYMjUrikH5GbcjFt4tlB
         HmA+FrnCFxEhwoK1eyWyev33Pz103pe2DwyfE1KEox4P7pWf3PSNeJFCC5tHhdv1o/b7
         IduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IfpNAJobbWOtQfdp3HdWV42InCCWa4x7vDkugzjU0rE=;
        b=HxyAoyrBSoZvMWvVSUvGos/ei4aGQsuN53tXCVcAPz4Bxsst/O8e27lE7UYDRy633m
         IEb09qHQyCIbSqWQ6HmHDmFlRuZak74QBaRXcQYVu7Cs6Iedye4z/LoyJqdZFWxIjlbC
         K4Dd0+CksCYbHiaE4rhTEPc9IdMHht1Fq4Vx6lpUp86ev1dk6j4H/fef4EQ31acDMR6O
         9kCjqC1iGNHD2QHoH+0JyygUVrEr0JFmr4cTjYCp70RsM887ReSFONvDPbFk+i3oku70
         UoMCzJCt1SfxtJejFToa5HmVN89bwMfx7arkB0gEpvUCLzjUQguvWgmZSu6Qmzi6FYEc
         KNJA==
X-Gm-Message-State: ALoCoQmzP0zz9obUehn2B9BaMUPNfKF8mF8EuTAmmQB93u4tjp8BVbZOBOGI3t2F7dZAro16+3aa
X-Received: by 10.51.17.10 with SMTP id ga10mr3449979igd.4.1401379679770;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si81561yhq.3.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7879E31C3F9;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2D087E1678; Thu, 29 May 2014 09:07:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250383>

Change the reference transactions so that we pass the reflog message
through to the create/delete/update function instead of the commit message.
This allows for individual messages for each change in a multi ref
transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               |  4 ++--
 builtin/commit.c       |  4 ++--
 builtin/fetch.c        |  3 +--
 builtin/receive-pack.c |  7 ++++---
 builtin/replace.c      |  4 ++--
 builtin/tag.c          |  4 ++--
 builtin/update-ref.c   | 13 +++++++------
 fast-import.c          |  8 ++++----
 refs.c                 | 34 +++++++++++++++++++++-------------
 refs.h                 |  8 ++++----
 sequencer.c            |  4 ++--
 walker.c               |  5 ++---
 12 files changed, 53 insertions(+), 45 deletions(-)

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
index 7db194f..608296c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1721,8 +1721,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index 13f4a63..5653fa2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -586,10 +586,11 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, &err) ||
-		    ref_transaction_commit(transaction, "push", &err)) {
-
+					   new_sha1, old_sha1, 0, 1, "push",
+					   &err) ||
+		    ref_transaction_commit(transaction, &err)) {
 			const char *str;
+
 			string_list_append(&error_strings, err.buf);
 			str = error_strings.items[error_strings.nr - 1].string;
 			strbuf_release(&err);
diff --git a/builtin/replace.c b/builtin/replace.c
index f24d814..09bfd40 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -160,8 +160,8 @@ static int replace_object_sha1(const char *object_ref,
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
index 587ef4a..7ca8b5a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1709,8 +1709,8 @@ static int update_branch(struct branch *b)
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
@@ -1749,12 +1749,12 @@ static void dump_tags(void)
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
index 696bc4f..9c19267 100644
--- a/refs.c
+++ b/refs.c
@@ -2343,8 +2343,8 @@ static void prune_ref(struct ref_to_prune *r)
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
@@ -2539,8 +2539,8 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
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
@@ -3290,6 +3290,7 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
+	char *msg;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3342,9 +3343,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -3365,7 +3367,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3379,13 +3381,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
@@ -3399,13 +3403,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
@@ -3420,6 +3426,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3433,8 +3441,8 @@ int update_ref(const char *action, const char *refname,
 	t = ref_transaction_begin(&err);
 	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err) ||
-	    ref_transaction_commit(t, action, &err)) {
+				   !!oldval, action, &err) ||
+	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_free(t);
@@ -3475,7 +3483,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err)
+			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3524,7 +3532,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     msg);
+					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
 				const char *str = "Cannot update the ref '%s'.";
diff --git a/refs.h b/refs.h
index dee7c8f..5c6c20f 100644
--- a/refs.h
+++ b/refs.h
@@ -287,7 +287,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -302,7 +302,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -316,7 +316,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -325,7 +325,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.0.rc3.474.g3833130
