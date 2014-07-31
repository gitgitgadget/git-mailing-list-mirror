From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/5] refs.c: replace the onerr argument in update_ref with a strbuf err
Date: Thu, 31 Jul 2014 14:25:06 -0700
Message-ID: <1406841910-3278-2-git-send-email-sahlberg@google.com>
References: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:25:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCxqm-0000Q8-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbaGaVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:25:19 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:39899 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbaGaVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:25:17 -0400
Received: by mail-oi0-f74.google.com with SMTP id a141so959362oig.5
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EW3YEPtLPFFQXJOJJGC3E0BhWqoUMqv5RqplCjqxvvM=;
        b=Z5A/Iz/IsMD708vs3LukHX9uutWy6CmNIOEypyFX/gjoJsxoZeP5PqCofZt8WO0HBa
         yjDPvmzhn5gW+cdgkTe8QHFRF4ns+oitCYz6sTyy/Ddbl2OH5zbG//JexsG+1cQNbnNh
         AzgbK+9sUAzqYbKicK9t16AZyplBA7X+GnSAKdxsx3139ZUBbXQZwIQw5JL/U2xK6A84
         PQomwQ9ZWa/fs8RBdWRmr5+5B9iOtQQeCcqqiYGyG0l8HCB3TFJAht4FlvF6rIs4OU/7
         iescitKELbXOkhl8E/qKDoCJ2BJbusTC0aMx/VrFYVNdrlc4Z+17pNrN5bbujsiOwjY1
         nlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EW3YEPtLPFFQXJOJJGC3E0BhWqoUMqv5RqplCjqxvvM=;
        b=jn0IqkOOwK4XH0tY3O6aUjc77v4sSxs75ex000KD6BLNMSD4U8OVQnMNMM4VF8Fc1o
         KeMTEsvPcCG6T/tk6OMLm0wbNrDXHbYYGNPIUgrQMU+w47AUE44sEgcFvXzC+VQ+/l/i
         sqQvTfPdZoOtRpUCxyKIiur8OlHrV4ndrX5ktIhr0/VUnXTB2xCp8M8ujPOXLmYmgLk+
         ErLgP7ActrNU9962D5iTw1C7Yomx/8Dwjm3vmOv9CnmgTCqkq4EG8xp33JNZA1xvdGZ4
         HGvi+fzhKfXRbwH+WI6u091TiUU/SdN0Ny8F3Fzc/F/1TNtQiOc+1jKQCl2Z3HBucWXL
         O4lg==
X-Gm-Message-State: ALoCoQn4c8/4L/TrSY1xTbB599qb0e1GnAegb6vrUSI0vq8TCp9iRmACax5asfcvDRYi6slYMhLI
X-Received: by 10.42.35.142 with SMTP id q14mr979041icd.6.1406841916396;
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id e2si51082igg.3.2014.07.31.14.25.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D5B5231C60C;
	Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7268BE055C; Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g70700c9
In-Reply-To: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254602>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c   |  7 +++++--
 builtin/clone.c      | 23 +++++++++++++++--------
 builtin/merge.c      | 20 +++++++++++++-------
 builtin/notes.c      | 24 ++++++++++++++----------
 builtin/reset.c      | 12 ++++++++----
 builtin/update-ref.c |  7 +++++--
 notes-cache.c        |  2 +-
 notes-utils.c        |  5 +++--
 refs.c               | 14 +++-----------
 refs.h               | 10 ++--------
 transport-helper.c   |  7 ++++++-
 transport.c          |  9 ++++++---
 12 files changed, 81 insertions(+), 59 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 808c58f..a9ec5be 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -580,6 +580,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
+	struct strbuf err = STRBUF_INIT;
+
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
@@ -617,8 +619,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
-		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
+			       REF_NODEREF, &err))
+			die("%s", err.buf);
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
 				detach_advice(new->name);
diff --git a/builtin/clone.c b/builtin/clone.c
index 7737e12..99e23cf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -521,6 +521,7 @@ static void write_remote_refs(const struct ref *local_refs)
 static void write_followtags(const struct ref *refs, const char *msg)
 {
 	const struct ref *ref;
+	struct strbuf err = STRBUF_INIT;
 	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -528,8 +529,9 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (!has_sha1_file(ref->old_sha1))
 			continue;
-		update_ref(msg, ref->name, ref->old_sha1,
-			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg, ref->name, ref->old_sha1,
+			       NULL, 0, &err))
+			die("%s", err.buf);
 	}
 }
 
@@ -592,28 +594,33 @@ static void update_remote_refs(const struct ref *refs,
 static void update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
+	struct strbuf err = STRBUF_INIT;
+
 	if (our && starts_with(our->name, "refs/heads/")) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
 			const char *head = skip_prefix(our->name, "refs/heads/");
-			update_ref(msg, "HEAD", our->old_sha1, NULL, 0,
-				   UPDATE_REFS_DIE_ON_ERR);
+			if (update_ref(msg, "HEAD", our->old_sha1, NULL, 0,
+				       &err))
+				die("%s", err.buf);
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(our->old_sha1);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		update_ref(msg, "HEAD", c->object.sha1,
-			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg, "HEAD", c->object.sha1,
+			       NULL, REF_NODEREF, &err))
+			die("%s", err.buf);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
 		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
-		update_ref(msg, "HEAD", remote->old_sha1,
-			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+	  if (update_ref(msg, "HEAD", remote->old_sha1,
+			 NULL, REF_NODEREF, &err))
+		die("%s", err.buf);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 428ca24..17dda64 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -396,9 +396,11 @@ static void finish(struct commit *head_commit,
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
-			update_ref(reflog_message.buf, "HEAD",
-				new_head, head, 0,
-				UPDATE_REFS_DIE_ON_ERR);
+			struct strbuf err = STRBUF_INIT;
+			if (update_ref(reflog_message.buf, "HEAD",
+				       new_head, head, 0,
+				       &err))
+				die("%s", err.buf);
 			/*
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
@@ -1093,6 +1095,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	unsigned char head_sha1[20];
 	struct commit *head_commit;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	const char *head_arg;
 	int flag, i, ret = 0, head_subsumed;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
@@ -1221,8 +1224,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
 		read_empty(remote_head->object.sha1, 0);
-		update_ref("initial pull", "HEAD", remote_head->object.sha1,
-			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref("initial pull", "HEAD", remote_head->object.sha1,
+			       NULL, 0, &err))
+			die("%s", err.buf);
 		goto done;
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
@@ -1338,8 +1342,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.sha1,
-		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	if (update_ref("updating ORIG_HEAD", "ORIG_HEAD",
+		       head_commit->object.sha1,
+		       NULL, 0, &err))
+		die("%s", err.buf);
 
 	if (remoteheads && !common)
 		; /* No common ancestors found. We need a real merge. */
diff --git a/builtin/notes.c b/builtin/notes.c
index 820c341..f508fbd 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -675,6 +675,7 @@ static int merge_abort(struct notes_merge_options *o)
 static int merge_commit(struct notes_merge_options *o)
 {
 	struct strbuf msg = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	unsigned char sha1[20], parent_sha1[20];
 	struct notes_tree *t;
 	struct commit *partial;
@@ -715,10 +716,10 @@ static int merge_commit(struct notes_merge_options *o)
 	format_commit_message(partial, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insert(&msg, 0, "notes: ", 7);
-	update_ref(msg.buf, o->local_ref, sha1,
-		   is_null_sha1(parent_sha1) ? NULL : parent_sha1,
-		   0, UPDATE_REFS_DIE_ON_ERR);
-
+	if (update_ref(msg.buf, o->local_ref, sha1,
+		       is_null_sha1(parent_sha1) ? NULL : parent_sha1,
+		       0, &err))
+		die("%s", err.buf);
 	free_notes(t);
 	strbuf_release(&msg);
 	ret = merge_abort(o);
@@ -729,6 +730,7 @@ static int merge_commit(struct notes_merge_options *o)
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	unsigned char result_sha1[20];
 	struct notes_tree *t;
 	struct notes_merge_options o;
@@ -809,14 +811,16 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	result = notes_merge(&o, t, result_sha1);
 
-	if (result >= 0) /* Merge resulted (trivially) in result_sha1 */
+	if (result >= 0) {/* Merge resulted (trivially) in result_sha1 */
 		/* Update default notes ref with new commit */
-		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
-			   0, UPDATE_REFS_DIE_ON_ERR);
-	else { /* Merge has unresolved conflicts */
+		if (update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
+			       0, &err))
+			die("%s", err.buf);
+	} else { /* Merge has unresolved conflicts */
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
-		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
-			   0, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
+			       0, &err))
+			die("%s", err.buf);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
diff --git a/builtin/reset.c b/builtin/reset.c
index f368266..0e8775d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -244,6 +244,7 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 {
 	int update_ref_status;
 	struct strbuf msg = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	unsigned char *orig = NULL, sha1_orig[20],
 		*old_orig = NULL, sha1_old_orig[20];
 
@@ -252,13 +253,16 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 	if (!get_sha1("HEAD", sha1_orig)) {
 		orig = sha1_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
+		if (update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, &err))
+			error("%s", err.buf);
+		strbuf_release(&err);
 	} else if (old_orig)
 		delete_ref("ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0,
-				       UPDATE_REFS_MSG_ON_ERR);
+	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, &err);
+	if (update_ref_status)
+		error("%s", err.buf);
+	strbuf_release(&err);
 	strbuf_release(&msg);
 	return update_ref_status;
 }
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index d62871d..062a29c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -349,6 +349,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -406,6 +407,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
 	else
-		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
-				  flags, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
+			       flags, &err))
+			die("%s", err.buf);
+	return 0;
 }
diff --git a/notes-cache.c b/notes-cache.c
index 97dfd63..882b56d 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -62,7 +62,7 @@ int notes_cache_write(struct notes_cache *c)
 	if (commit_tree(&msg, tree_sha1, NULL, commit_sha1, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
-		       0, UPDATE_REFS_QUIET_ON_ERR) < 0)
+		       0, NULL) < 0)
 		return -1;
 
 	return 0;
diff --git a/notes-utils.c b/notes-utils.c
index a0b1d7b..805bc31 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -33,6 +33,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char commit_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (!t)
 		t = &default_notes_tree;
@@ -48,8 +49,8 @@ void commit_notes(struct notes_tree *t, const char *msg)
 
 	create_notes_commit(t, NULL, &buf, commit_sha1);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
-	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0,
-		   UPDATE_REFS_DIE_ON_ERR);
+	if (update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, &err))
+		die("%s", err.buf);
 
 	strbuf_release(&buf);
 }
diff --git a/refs.c b/refs.c
index 46a9595..65eee72 100644
--- a/refs.c
+++ b/refs.c
@@ -3549,7 +3549,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
-	       int flags, enum action_on_err onerr)
+	       int flags, struct strbuf *e)
 {
 	struct ref_transaction *t;
 	struct strbuf err = STRBUF_INIT;
@@ -3562,16 +3562,8 @@ int update_ref(const char *action, const char *refname,
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		transaction_free(t);
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
+		if (e)
+			strbuf_addf(e, str, refname, err.buf);
 		strbuf_release(&err);
 		return 1;
 	}
diff --git a/refs.h b/refs.h
index 54dbe4b..dee9a98 100644
--- a/refs.h
+++ b/refs.h
@@ -202,12 +202,6 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
  */
 extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
 
-enum action_on_err {
-	UPDATE_REFS_MSG_ON_ERR,
-	UPDATE_REFS_DIE_ON_ERR,
-	UPDATE_REFS_QUIET_ON_ERR
-};
-
 /*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling transaction_free().
@@ -332,8 +326,8 @@ void transaction_free(struct ref_transaction *transaction);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-		const unsigned char *sha1, const unsigned char *oldval,
-		int flags, enum action_on_err onerr);
+	       const unsigned char *sha1, const unsigned char *oldval,
+	       int flags, struct strbuf *err);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
diff --git a/transport-helper.c b/transport-helper.c
index 270ae28..d46624a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -733,6 +733,7 @@ static int push_update_refs_status(struct helper_data *data,
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
+	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
 	for (;;) {
@@ -756,7 +757,11 @@ static int push_update_refs_status(struct helper_data *data,
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (!private)
 			continue;
-		update_ref("update by helper", private, ref->new_sha1, NULL, 0, 0);
+		if (update_ref("update by helper", private, ref->new_sha1,
+			       NULL, 0, &err))
+			error("%s", err.buf);
+		strbuf_release(&err);
+
 		free(private);
 	}
 	strbuf_release(&buf);
diff --git a/transport.c b/transport.c
index f40e950..a3b7f48 100644
--- a/transport.c
+++ b/transport.c
@@ -607,6 +607,7 @@ int transport_refs_pushed(struct ref *ref)
 void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
 {
 	struct refspec rs;
+	struct strbuf err = STRBUF_INIT;
 
 	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
 		return;
@@ -619,9 +620,11 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (ref->deletion) {
 			delete_ref(rs.dst, NULL, 0);
-		} else
-			update_ref("update by push", rs.dst,
-					ref->new_sha1, NULL, 0, 0);
+		} else if (update_ref("update by push", rs.dst,
+				      ref->new_sha1, NULL, 0, &err))
+			error("%s", err.buf);
+
+		strbuf_release(&err);
 		free(rs.dst);
 	}
 }
-- 
2.0.1.523.g70700c9
