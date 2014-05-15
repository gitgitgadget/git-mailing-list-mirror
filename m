From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 36/44] refs.c: pass the ref log message to _create/delete/update instead of _commit
Date: Thu, 15 May 2014 16:15:33 -0700
Message-ID: <1400195741-22996-37-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4t0-0005AW-P6
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235AbaEOXQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:20 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:34137 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbaEOXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so325919veb.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2WI8r3d1idtftpYjYDXwA2wZkieSTRmG0TlGZ4R3N3Y=;
        b=YFZrvMkJt7HwlL8Fc3vfb250oDtsrgi3wjVFIIUaZV3g/f5W2PgQaUkOqggFGCoVE5
         BrhuWcRZcTBoU+G3EijRmClINH20MPixWSp+6zKK2JZCjr1gk0lIpj9c2tvTqKgxZJSQ
         EDmP/sy1GMQmlo8OWWUzmzuUSZ2QihOEudfNcxtnS48DSNRdBwzup+TnEaaxV7rzr5rZ
         0p/1zL639DxM1W5FOJeOj7l/0jOd7yBH+0mykBNgXpi+ZQar+AmG5hnbOKWdlWY9idIi
         eAMmxukHU0qoNU43/Wm2Bi60qnKGSvbi0WH7lG7qctaiIbSPcatIDDNRXYBiFhqq1AMj
         Gqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2WI8r3d1idtftpYjYDXwA2wZkieSTRmG0TlGZ4R3N3Y=;
        b=NMeMCgx2aR7YDL8LuqOjOhw6rDAvNYBANLIVOOFxWRxf9GVI3Z+spw59ALI+u/sq2V
         7lWuuYEl054RLRci5Y12J+ocaexVKg/hfN8p+wboYmlj08M76peLXikSpVoU20q3rP5V
         BmWIrmsUZvjl0Ttr3m6ae044zDoMMgCzwr1CCTt/6FwdhdvssZQLOC32S9BdaNcqbXMZ
         wUpO4To5dyEx3BkA0e1QPiSYgrVVj1RZbq3oC47t2lVUDdJQ6qjJKHoOdSi206xuUuzB
         sxb4MkbRdUpR33NyzRnvLZBsW7Fypf72dyg9kh2bSDCyvNcB7fy0VyUXJ4Ikr6IkWJXi
         wrpQ==
X-Gm-Message-State: ALoCoQnGwyFSjjG5M4NPOLvt7bh0Qj/dhoNnOM3rQfwsfSwpcgi7r/jbnJlGn6qw1ZUm7FWxwy0O
X-Received: by 10.58.43.170 with SMTP id x10mr6381858vel.36.1400195746219;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si319602yhj.0.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id ED5EF31C25B;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CD887E0FBE; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249232>

Change the reference transactions so that we pass the reflog message
through to the create/delete/update function instead of the commit message.
This allows for individual messages for each change in a multi ref
transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               |  4 ++--
 builtin/commit.c       |  4 ++--
 builtin/fetch.c        | 10 ++++++++--
 builtin/receive-pack.c |  5 +++--
 builtin/replace.c      |  4 ++--
 builtin/tag.c          |  4 ++--
 builtin/update-ref.c   | 13 +++++++------
 fast-import.c          |  8 ++++----
 refs.c                 | 31 +++++++++++++++++++++----------
 refs.h                 |  5 ++++-
 sequencer.c            |  4 ++--
 walker.c               |  6 +++---
 12 files changed, 60 insertions(+), 38 deletions(-)

diff --git a/branch.c b/branch.c
index f78a28b..6dfdc2e 100644
--- a/branch.c
+++ b/branch.c
@@ -301,8 +301,8 @@ void create_branch(const char *head,
 		transaction = ref_transaction_begin();
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
index 6b888f2..b361a13 100644
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
index 5b0cc31..4603cb6 100644
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
-				   ref->old_sha1, 0, check_old, NULL))
+				   ref->old_sha1, 0, check_old, msg, NULL))
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
index 5534138..324a220 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -582,7 +582,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			return "shallow error";
 
 		if (ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, &err))
+					   new_sha1, old_sha1, 0, 1, "push",
+					   &err))
 			return "failed to update";
 		return NULL; /* good */
 	}
@@ -823,7 +824,7 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
-	if (ref_transaction_commit(transaction, "push", &err))
+	if (ref_transaction_commit(transaction, &err))
 		error("%s", err.buf);
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
diff --git a/builtin/replace.c b/builtin/replace.c
index af7f72d..4fa74c1 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -160,8 +160,8 @@ static int replace_object_sha1(const char *object_ref,
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev), &err) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+				   0, !is_null_sha1(prev), NULL, &err) ||
+	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
 	ref_transaction_free(transaction);
diff --git a/builtin/tag.c b/builtin/tag.c
index 30b471c..8d39068 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -705,8 +705,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin();
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
index 4c2145e..8f13d54 100644
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
 		die("update %s: failed: %s", refname, err.buf);
 
 	update_flags = 0;
@@ -227,7 +228,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create %s: extra input: %s", refname, next);
 
 	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags, NULL))
+				   update_flags, msg, &err))
 		die("cannot create ref '%s'", refname);
 
 	update_flags = 0;
@@ -259,7 +260,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, NULL))
+				   update_flags, have_old, msg, &err))
 		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
@@ -292,7 +293,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, &err))
+				   update_flags, have_old, msg, &err))
 		die("verify %s: %s", refname, err.buf);
 
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
index 6ef5cec..db511c3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1709,8 +1709,8 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, &err) ||
-	    ref_transaction_commit(transaction, msg, &err)) {
+				   0, 1, msg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_rollback(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -1744,10 +1744,10 @@ static void dump_tags(void)
 		sprintf(ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name, t->sha1,
-					   NULL, 0, 0, &err))
+					   NULL, 0, 0, msg, &err))
 			failure |= error("%s", err.buf);
 	}
-	if (failure || ref_transaction_commit(transaction, msg, &err))
+	if (failure || ref_transaction_commit(transaction, &err))
 		failure |= error("%s", err.buf);
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
diff --git a/refs.c b/refs.c
index 7efb6bb..5369a39 100644
--- a/refs.c
+++ b/refs.c
@@ -2344,8 +2344,8 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, &err) ||
-	    ref_transaction_commit(transaction, NULL, &err)) {
+				   REF_ISPRUNING, 1, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_rollback(transaction);
 		warning("prune_ref: %s", err.buf);
 		strbuf_release(&err);
@@ -2543,8 +2543,8 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), NULL) ||
-	    ref_transaction_commit(transaction, NULL, NULL)) {
+				   sha1 && !is_null_sha1(sha1), NULL, NULL) ||
+	    ref_transaction_commit(transaction, NULL)) {
 		ref_transaction_rollback(transaction);
 		return 1;
 	}
@@ -3292,6 +3292,7 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
+	const char *msg;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3325,9 +3326,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -3359,6 +3361,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
 			   int flags, int have_old,
+			   const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3375,6 +3378,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3382,6 +3387,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   int flags,
+			   const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3398,6 +3404,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3405,6 +3413,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
 			   int flags, int have_old,
+			   const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3422,6 +3431,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3435,8 +3446,8 @@ int update_ref(const char *action, const char *refname,
 	t = ref_transaction_begin();
 	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err) ||
-	    ref_transaction_commit(t, action, &err)) {
+				   !!oldval, action, NULL) ||
+	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_rollback(t);
@@ -3478,7 +3489,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err)
+			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3527,7 +3538,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     msg);
+					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
 				const char *str = "Cannot update the ref '%s'.";
diff --git a/refs.h b/refs.h
index 832d81b..a59fca8 100644
--- a/refs.h
+++ b/refs.h
@@ -245,6 +245,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
 			   int flags, int have_old,
+			   const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -260,6 +261,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   int flags,
+			   const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -274,6 +276,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
 			   int flags, int have_old,
+			   const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -283,7 +286,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * why the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err);
+			   struct strbuf *err);
 
 /*
  * Free an existing transaction.
diff --git a/sequencer.c b/sequencer.c
index f6f1536..edad040 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -285,8 +285,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	transaction = ref_transaction_begin();
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn, &err) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+				   0, !unborn, sb.buf, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_rollback(transaction);
 		error("%s", err.buf);
 		strbuf_release(&sb);
diff --git a/walker.c b/walker.c
index cbe5686..0403feb 100644
--- a/walker.c
+++ b/walker.c
@@ -291,12 +291,12 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		sprintf(ref_name, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, ref_name,
 					   &sha1[20 * i], NULL,
-					   0, 0, &err))
+					   0, 0,
+					   msg ? msg : "fetch (unknown)", &err))
 			goto rollback_and_fail;
 	}
 
-	if (ref_transaction_commit(transaction, msg ? msg : "fetch (unknown)",
-				   &err)) {
+	if (ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		goto rollback_and_fail;
 	}
-- 
2.0.0.rc3.477.gffe78a2
