From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: use a stringlist for repack_without_refs
Date: Tue, 18 Nov 2014 17:08:28 -0800
Message-ID: <1416359308-14831-1-git-send-email-sbeller@google.com>
References: <20141118234500.GO6527@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: sahlberg@google.com, gitster@pobox.com, git@vger.kernel.org,
	jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 19 02:08:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqtl5-0000zH-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746AbaKSBIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:08:32 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:50763 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbaKSBIb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:08:31 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so8415796ier.4
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=becn1risYG0d2bS0o133qxncrzPtC8XxXVpzyFGgjE0=;
        b=B4LiKS13e9k1U9P29bCeuxVWVH7Jz6xJOPa2B21uT5tTLQg610UlPGNEofBW7Fv+Xf
         D7TVNgLrwojqyGAhsV5kmvq8JqaDnJyiQQV2IOFUkiaSio0upXvfW2854xHgSHCo3hsZ
         2h5FBv9AYh9MoYDb+Zw/GlCPk4Hyfarm3tj7/jpB8uZry/M/tEaCAlbxDlfV/P5yh4py
         F35uptIoH2Wb88FlM2ORlNYUOsR6QqanwMGb8TkSGJbWMkUZ2iLxUozvIXRygVM9+9iV
         oWFsLOW0O2+qKfBZEnBA1kvCJrGAPogTyN3Q2Mec+eOGSqcW1W37IlFHwX2YfRe+VskW
         alBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=becn1risYG0d2bS0o133qxncrzPtC8XxXVpzyFGgjE0=;
        b=T9PsZb1w4KOb/nd9q//NlVJMhBzk2R3MHJUh8XRqzf9DshHNbh/oOcB690KGthN16A
         AwF5B3YAMOaUdhD1PysSBqDjH0bso+f6sFoAmAiZx2lByOcJiIq9814qs1Xt6wrrjvDm
         AHj2h+u129ApBUPJ0d/+CJPTqMixeJxzgzeTAffKeE7a3m0sDpQlC3aRNzUPHHGO/A7m
         ax40lFz4f+lbLeBCwwXqk6gzXF0xoeE9KzuOwlBnLrVTPxP/BqXdSrcOZK26spZ0oXfU
         SNpw6M88TZoqpXBtpl7M6cMMGpJu8EFD1hSYbn0ogpN3LrCQtoROwN7o6aECA3qXFoXc
         CCMw==
X-Gm-Message-State: ALoCoQn1Kk07I90neeXja7mIa7xM4Qm/yj4HbhbtpeoanPStuv6AoJ2q4WtMBpDflUmVgqcYzAMq
X-Received: by 10.107.29.5 with SMTP id d5mr28287564iod.45.1416359310919;
        Tue, 18 Nov 2014 17:08:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d130:77f5:c37c:28a8])
        by mx.google.com with ESMTPSA id d140sm74889ioe.38.2014.11.18.17.08.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 17:08:30 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <20141118234500.GO6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch doesn't intend any functional changes. It is just
a refactoring, which replaces a char** array by a stringlist
in the function repack_without_refs.
This is easier to read and maintain as it delivers the same
functionality with less lines of code less pointers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>

-

This patch was heavily inspired by a part of the ref-transactions-rename
series[1], but people tend to dislike large series and this part is
relatively easy to take out and unrelated, so I'll send it as a single
patch.

[1] https://www.mail-archive.com/git@vger.kernel.org/msg60604.html

---
 builtin/remote.c | 31 +++++++++++--------------------
 refs.c           | 40 +++++++++++++++++++++-------------------
 refs.h           | 10 ++++++++--
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..5f5fa4c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -750,16 +750,11 @@ static int mv(int argc, const char **argv)
 static int remove_branches(struct string_list *branches)
 {
 	struct strbuf err = STRBUF_INIT;
-	const char **branch_names;
 	int i, result = 0;
 
-	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
-	for (i = 0; i < branches->nr; i++)
-		branch_names[i] = branches->items[i].string;
-	if (repack_without_refs(branch_names, branches->nr, &err))
+	if (repack_without_refs(branches, &err))
 		result |= error("%s", err.buf);
 	strbuf_release(&err);
-	free(branch_names);
 
 	for (i = 0; i < branches->nr; i++) {
 		struct string_list_item *item = branches->items + i;
@@ -1316,8 +1311,8 @@ static int prune_remote(const char *remote, int dry_run)
 {
 	int result = 0, i;
 	struct ref_states states;
-	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
-	const char **delete_refs;
+	struct string_list delete_refs = STRING_LIST_INIT_NODUP;
+	struct string_list_item *ref;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1325,6 +1320,9 @@ static int prune_remote(const char *remote, int dry_run)
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
+	for_each_string_list_item(ref, &delete_refs)
+		string_list_append(&delete_refs, ref->string);
+
 	if (states.stale.nr) {
 		printf_ln(_("Pruning %s"), remote);
 		printf_ln(_("URL: %s"),
@@ -1332,23 +1330,16 @@ static int prune_remote(const char *remote, int dry_run)
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
 
-		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-		for (i = 0; i < states.stale.nr; i++)
-			delete_refs[i] = states.stale.items[i].util;
 		if (!dry_run) {
 			struct strbuf err = STRBUF_INIT;
-			if (repack_without_refs(delete_refs, states.stale.nr,
-						&err))
+			if (repack_without_refs(&delete_refs, &err))
 				result |= error("%s", err.buf);
 			strbuf_release(&err);
 		}
-		free(delete_refs);
 	}
 
-	for (i = 0; i < states.stale.nr; i++) {
-		const char *refname = states.stale.items[i].util;
-
-		string_list_insert(&delete_refs_list, refname);
+	for_each_string_list_item(ref, &delete_refs) {
+		const char *refname = ref->string;
 
 		if (!dry_run)
 			result |= delete_ref(refname, NULL, 0);
@@ -1361,8 +1352,8 @@ static int prune_remote(const char *remote, int dry_run)
 			       abbrev_ref(refname, "refs/remotes/"));
 	}
 
-	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
-	string_list_clear(&delete_refs_list, 0);
+	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs);
+	string_list_clear(&delete_refs, 0);
 
 	free_remote_ref_states(&states);
 	return result;
diff --git a/refs.c b/refs.c
index 5ff457e..2f6e08b 100644
--- a/refs.c
+++ b/refs.c
@@ -2639,23 +2639,26 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-int repack_without_refs(const char **refnames, int n, struct strbuf *err)
+int repack_without_refs(struct string_list *without, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, ret, removed = 0;
+	int ret, needs_repacking = 0, removed = 0;
 
 	assert(err);
 
 	/* Look for a packed ref */
-	for (i = 0; i < n; i++)
-		if (get_packed_ref(refnames[i]))
+	for_each_string_list_item(ref_to_delete, without) {
+		if (get_packed_ref(ref_to_delete->string)) {
+			needs_repacking = 1;
 			break;
+		}
+	}
 
-	/* Avoid locking if we have nothing to do */
-	if (i == n)
-		return 0; /* no refname exists in packed refs */
+	/* No refname exists in packed refs */
+	if (!needs_repacking)
+		return 0;
 
 	if (lock_packed_refs(0)) {
 		unable_to_lock_message(git_path("packed-refs"), errno, err);
@@ -2664,8 +2667,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
-	for (i = 0; i < n; i++)
-		if (remove_entry(packed, refnames[i]) != -1)
+	for_each_string_list_item(ref_to_delete, without)
+		if (remove_entry(packed, ref_to_delete->string) != -1)
 			removed = 1;
 	if (!removed) {
 		/*
@@ -3738,10 +3741,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
-	const char **delnames;
+	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
+	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
+	struct string_list_item *ref_to_delete;
 
 	assert(err);
 
@@ -3753,9 +3757,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
-	/* Allocate work space */
-	delnames = xmalloc(sizeof(*delnames) * n);
-
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
@@ -3815,16 +3816,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
-				delnames[delnum++] = update->lock->ref_name;
+				string_list_append(&refs_to_delete,
+						   update->lock->ref_name);
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err)) {
+	if (repack_without_refs(&refs_to_delete, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	for_each_string_list_item(ref_to_delete, &refs_to_delete)
+		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
@@ -3833,7 +3835,7 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(delnames);
+	string_list_clear(&refs_to_delete, 0);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 2bc3556..69f88ef 100644
--- a/refs.h
+++ b/refs.h
@@ -163,8 +163,14 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
-			       struct strbuf *err);
+/*
+ * Repacks the refs pack file excluding the refs given
+ * without: The refs to be excluded from the new refs pack file,
+ *          May be unsorted
+ * err: String buffer, which will be used for reporting errors,
+ *      Must not be NULL
+ */
+extern int repack_without_refs(struct string_list *without, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.2.0.rc2.5.gf7b9fb2
