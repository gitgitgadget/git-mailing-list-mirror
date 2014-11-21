From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/6] repack_without_refs(): make the refnames argument a string_list
Date: Fri, 21 Nov 2014 15:09:08 +0100
Message-ID: <1416578950-23210-5-git-send-email-mhagger@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:09:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrotv-0000Ji-K8
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235AbaKUOJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:09:25 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50000 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757904AbaKUOJX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:09:23 -0500
X-AuditID: 12074414-f797f6d000004084-a3-546f47920f5f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 11.8B.16516.2974F645; Fri, 21 Nov 2014 09:09:22 -0500 (EST)
Received: from michael.fritz.box (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALE9EqS000733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:09:21 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqDvJPT/E4PM/GYuuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6MySeWMha8MK442z2DtYHxqWYXIyeHhICJxII53YwQtpjEhXvr2boYuTiEBC4z
	Smy+uw3KOc4kcbDlJzNIFZuArsSinmYmEFtEwEvi1LoZzCBFzALzGSVmr5sJNkpYIETi7YxX
	QEUcHCwCqhIHvnuCmLwCLhLvplSAmBICchJb13mDFHMKuEo8XdHHDmILCdRIXOnbzjaBkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJCwEtnBeOSk3CFGAQ5GJR7e
	FYvzQoRYE8uKK3MPMUpyMCmJ8sZb54cI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuEtFwbK8aYk
	VlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8N5yBWoULEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB8VFfDEwMkBSPEB7/4O08xYXJOYCRSFaTzHqcvxb/qGXSYgl
	Lz8vVUqcl8cNqEgApCijNA9uBSyJvGIUB/pYmHcXyCgeYAKCm/QKaAkT0JK/S3NBlpQkIqSk
	GhgLvmg7JzwQnj/9u/OMTZ+7ddT55CrLuruXR6dGLfFaF1h1+F6SWJplQgVT4Ik+3gTZBfHb
	uAOEw38dCyg+tm0Sp9SkkGg9+5Ym7mKlRZN5/7fP0uN4Ny30VeHz3k3vatxsfay4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the callers have string_lists available already, whereas two of
them had to read data out of a string_list into an array of strings
just to call this function. So change repack_without_refs() to take
the list of refnames to omit as a string_list, and change the callers
accordingly.

Suggested-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 14 ++------------
 refs.c           | 38 ++++++++++++++++++++------------------
 refs.h           | 11 ++++++++++-
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7d5c8d2..63a6709 100644
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
@@ -1317,7 +1312,6 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0, i;
 	struct ref_states states;
 	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
-	const char **delete_refs;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1336,19 +1330,16 @@ static int prune_remote(const char *remote, int dry_run)
 		  ? states.remote->url[0]
 		  : _("(no URL)"));
 
-	delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
 
-		delete_refs[i] = refname;
 		string_list_append(&delete_refs_list, refname);
 	}
 	sort_string_list(&delete_refs_list);
 
 	if (!dry_run) {
 		struct strbuf err = STRBUF_INIT;
-		if (repack_without_refs(delete_refs, states.stale.nr,
-					&err))
+		if (repack_without_refs(&delete_refs_list, &err))
 			result |= error("%s", err.buf);
 		strbuf_release(&err);
 	}
@@ -1369,7 +1360,6 @@ static int prune_remote(const char *remote, int dry_run)
 
 	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
 
-	free(delete_refs);
 	string_list_clear(&delete_refs_list, 0);
 	free_remote_ref_states(&states);
 	return result;
diff --git a/refs.c b/refs.c
index 5ff457e..b675e01 100644
--- a/refs.c
+++ b/refs.c
@@ -2639,22 +2639,25 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-int repack_without_refs(const char **refnames, int n, struct strbuf *err)
+int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
-	struct string_list_item *ref_to_delete;
-	int i, ret, removed = 0;
+	struct string_list_item *refname, *ref_to_delete;
+	int ret, needs_repacking = 0, removed = 0;
 
 	assert(err);
 
 	/* Look for a packed ref */
-	for (i = 0; i < n; i++)
-		if (get_packed_ref(refnames[i]))
+	for_each_string_list_item(refname, refnames) {
+		if (get_packed_ref(refname->string)) {
+			needs_repacking = 1;
 			break;
+		}
+	}
 
 	/* Avoid locking if we have nothing to do */
-	if (i == n)
+	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
@@ -2664,8 +2667,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
-	for (i = 0; i < n; i++)
-		if (remove_entry(packed, refnames[i]) != -1)
+	for_each_string_list_item(refname, refnames)
+		if (remove_entry(packed, refname->string) != -1)
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
index 2bc3556..90a4a40 100644
--- a/refs.h
+++ b/refs.h
@@ -163,7 +163,16 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
+/*
+ * Remove the refs listed in 'refnames' from the packed-refs file.
+ * On error, packed-refs will be unchanged, the return value is
+ * nonzero, and a message about the error is written to the 'err'
+ * strbuf.
+ *
+ * The refs in 'refnames' needn't be sorted. The err buffer must not be
+ * omitted.
+ */
+extern int repack_without_refs(struct string_list *refnames,
 			       struct strbuf *err);
 
 extern int ref_exists(const char *);
-- 
2.1.3
