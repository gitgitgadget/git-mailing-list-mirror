From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4] refs.c: use a stringlist for repack_without_refs
Date: Wed, 19 Nov 2014 13:59:59 -0800
Message-ID: <1416434399-2303-1-git-send-email-sbeller@google.com>
References: <1416434088-1472-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 19 23:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrDIN-00085N-H8
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 23:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933448AbaKSWAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 17:00:07 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33419 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbaKSWAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 17:00:02 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so1758471igd.13
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 14:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z6TcPRY6Rj0kO7NebqDh14FmWoIWA/RgfS1R9USYhw4=;
        b=Fg0K/HVfJmbn+5w9MPoEgDd6ZAT/ML+/h/6RoQm/hRoj35Lm5rKuPA6OmzUi0MYXvn
         NqcYowj5CU+ZnSYQPrEjv2trqjSoR2RCy4WK8X7lmhqNR1e9JShlh+ozQKjyB7OFpdz1
         OG50UvbCpR/16WPpUZ473nK0b6DAyGQU49vYhBncl+SJMFBFO3UK57BJ5ThgSBAWgyQE
         BwFMMa8i3/Jro2g38sRXX8lzw27KBhux0EpZ271F42PyIw4zultKQdUZjXwNcYqi5I41
         FwojVy5RgNTIpsHlOkG/BIeR9gNkm/mxWotr9z4rFpupCZ37xdR0a23tUG3RYsGlipCw
         53zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z6TcPRY6Rj0kO7NebqDh14FmWoIWA/RgfS1R9USYhw4=;
        b=LRsFCOsdaGBC6kZ6rZ40tv/W6IhnBtTjBDsxv4QV394n6CsAY2ltbli274mcvA93gQ
         mGrFsKVvD/qwVdkvyjMQ9ocC0YiKSRncqONiv0b20cjMANzSAx+Sj+ug+NPITvZ28Gj9
         pwcl4n3sZq8RCWR19wz7Zv5pzsTAdwf0oYr2yosFZ63vbb6fe/GsHa2OmdgtfRVxPGif
         3/qyK+wLXvxjVP2RbjwMQjt4uWaFaG+qxkPzUN5HUShrnZWCLRtkyPc7OMgYTzIE6w4q
         2b2eJdOm67JcTDpakA8HMq6jLj6htTszs6YFZJbX34HLQAs2wOBQQjSmA+X60KWfvhT4
         WcVg==
X-Gm-Message-State: ALoCoQmeAyPV/1EfyHAlggmEPxKnhnZn7QvzSIzFcknzzSdLuJv4H0TbK+WZ3uOOqtHxNz5B/zb8
X-Received: by 10.50.164.193 with SMTP id ys1mr5759698igb.38.1416434402075;
        Wed, 19 Nov 2014 14:00:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:7876:7c52:1268:8374])
        by mx.google.com with ESMTPSA id 36sm268641iok.3.2014.11.19.14.00.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 14:00:01 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.13.g0786cdb
In-Reply-To: <1416434088-1472-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

This patch doesn't intend any functional changes. It is just
a refactoring, which replaces a char** array by a stringlist
in the function repack_without_refs.
This is easier to read and maintain as it delivers the same
functionality with less lines of code and less pointers.

[sb: ported this patch from a larger patch series to the master branch,
added documentary comments in refs.h]

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Changes to version 1:
 * removed the double blank line
 * rename delete_refs_list to delete_refs
 * add back comments dropped by accident
 * use STRING_LIST_INIT_NODUP instead of the _DUP version in ref_transaction_commit
 * add documentary comments on the repack_without_refs function
 * user string_list_append instead of string_list_insert as it follows the previous
   behavior more closely.
 * put back the early exit of the loop in repack_without_refs
   
Changes to version 2:
 * fixed commit message (comments after the three dashes)
 * fixed the curiosity Junio pointed out as it was just wrong code.
   Now it actually builds a list of all states.stale.items[i].util items.
   
Changes in version 3:

 * reword commit message
 * sort delete_refs before passing it to warn_dangling_symrefs
 * change the comments (get back the one jrn complained about) 
   in repack_without_refs
 * use the suggestion of jonathan for documenting repack_without_refs in the
   header. Add a note about the arguments.

Changes in version 4:
 * I lied, when saying I had all the nits from Jonathan. 
   I messed up the documentation in the header.
   This includes the documentary comment in the header.
   
---
 builtin/remote.c | 32 ++++++++++++--------------------
 refs.c           | 38 ++++++++++++++++++++------------------
 refs.h           | 11 +++++++++--
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..b37ed3d 100644
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
 
+	for (i = 0; i < states.stale.nr; i++)
+		string_list_append(&delete_refs, states.stale.items[i].util);
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
@@ -1361,8 +1352,9 @@ static int prune_remote(const char *remote, int dry_run)
 			       abbrev_ref(refname, "refs/remotes/"));
 	}
 
-	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
-	string_list_clear(&delete_refs_list, 0);
+	sort_string_list(&delete_refs);
+	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs);
+	string_list_clear(&delete_refs, 0);
 
 	free_remote_ref_states(&states);
 	return result;
diff --git a/refs.c b/refs.c
index 5ff457e..ebcd90f 100644
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
 
 	/* Avoid locking if we have nothing to do */
-	if (i == n)
-		return 0; /* no refname exists in packed refs */
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
index 2bc3556..5a0cd21 100644
--- a/refs.h
+++ b/refs.h
@@ -163,8 +163,15 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
-			       struct strbuf *err);
+/*
+ * Remove the refs listed in 'without' from the packed-refs file.
+ * On error, packed-refs will be unchanged, the return value is
+ * nonzero, and a message about the error is written to the 'err'
+ * strbuf.
+ *
+ * The refs in 'without' may have any order, the err buffer must not be ommited.
+ */
+extern int repack_without_refs(struct string_list *without, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.2.0.rc2.13.g0786cdb
