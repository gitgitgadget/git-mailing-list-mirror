From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/12] ref_transaction_update(): remove "have_old" parameter
Date: Thu, 12 Feb 2015 12:12:15 +0100
Message-ID: <1423739543-1025-5-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhS-00045M-Gr
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbbBLLMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:45 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53847 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755594AbbBLLMj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:39 -0500
X-AuditID: 1207440d-f79976d000005643-61-54dc8aa547e3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 34.B7.22083.5AA8CD45; Thu, 12 Feb 2015 06:12:37 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7X003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:36 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLu0606IwaEmfYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZHxqXMxdsCqi42tXO3sD4xq6LkZNDQsBE4uXeSWwQtpjEhXvrgWwu
	DiGBy4wSh9ZeYIJwTjBJfF+5gx2kik1AV2JRTzMTiC0ioCYxse0QC4jNLLCaSWLrXbBJwgL+
	EjPv/mYFsVkEVCUennsE1MvBwSvgLLHjRibEMjmJ88d/MoPYnAIuEu8uNTCC2EJAJbvatrBO
	YORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkyHh3MP5fJ3OIUYCD
	UYmHN8D4TogQa2JZcWXuIUZJDiYlUV6uVqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7fJqAc
	b0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCV6oTqFGwKDU9tSItM6cE
	Ic3EwQkynEtKpDg1LyW1KLG0JCMeFBnxxcDYAEnxAO0VA2nnLS5IzAWKQrSeYlSUEuc1AEkI
	gCQySvPgxsJSxytGcaAvhXnngVTxANMOXPcroMFMQIMnzrgNMrgkESEl1cDI36w2XcXG66J0
	TuvjJcsvPTXy5DE2XXEjzU6t7HWp23rlxyHJd6J3XTdXildPTm3wXvRzf5yr+VLTPp2tWt/6
	VlnmTpd1tLz6WdLa+F6l7GG92P6dVf/8J7rt857xa46L+RqjFaEHdG5d6juhsfWX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263717>

Instead, verify the reference's old value if and only if old_sha1 is
non-NULL.

ref_transaction_delete() will get the same treatment in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 branch.c               |  5 +++--
 builtin/commit.c       |  2 +-
 builtin/fetch.c        |  6 ++++--
 builtin/receive-pack.c |  2 +-
 builtin/replace.c      |  2 +-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   |  7 ++++---
 fast-import.c          |  6 +++---
 refs.c                 | 18 ++++++++----------
 refs.h                 |  6 +++---
 sequencer.c            |  2 +-
 walker.c               |  2 +-
 12 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/branch.c b/branch.c
index 4bab55a..b002435 100644
--- a/branch.c
+++ b/branch.c
@@ -284,8 +284,9 @@ void create_branch(const char *head,
 
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, msg, &err) ||
+		    ref_transaction_update(transaction, ref.buf,
+					   sha1, forcing ? NULL : null_sha1,
+					   0, msg, &err) ||
 		    ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
diff --git a/builtin/commit.c b/builtin/commit.c
index 7f46713..8afb0ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1767,7 +1767,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head
 				   ? current_head->object.sha1 : NULL,
-				   0, !!current_head, sb.buf, &err) ||
+				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7b84d35..719bf4f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -416,8 +416,10 @@ static int s_update_ref(const char *action,
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
-				   ref->old_sha1, 0, check_old, msg, &err))
+	    ref_transaction_update(transaction, ref->name,
+				   ref->new_sha1,
+				   check_old ? ref->old_sha1 : NULL,
+				   0, msg, &err))
 		goto fail;
 
 	ret = ref_transaction_commit(transaction, &err);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e0ce78e..0be50e9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -971,7 +971,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_update(transaction,
 					   namespaced_name,
 					   new_sha1, old_sha1,
-					   0, 1, "push",
+					   0, "push",
 					   &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
diff --git a/builtin/replace.c b/builtin/replace.c
index 85d39b5..54bf01a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -172,7 +172,7 @@ static int replace_object_sha1(const char *object_ref,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, 1, NULL, &err) ||
+				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 6dc85a9..4194b9a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -733,7 +733,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, 1, NULL, &err) ||
+				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2497ba4..beb583e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -198,8 +198,9 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg, &err))
+	if (ref_transaction_update(transaction, refname,
+				   new_sha1, have_old ? old_sha1 : NULL,
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -297,7 +298,7 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, 1, msg, &err))
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
diff --git a/fast-import.c b/fast-import.c
index d0bd285..1e72bfb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1716,7 +1716,7 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, msg, &err) ||
+				   0, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -1756,8 +1756,8 @@ static void dump_tags(void)
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
-		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
-					   NULL, 0, 0, msg, &err)) {
+		if (ref_transaction_update(transaction, ref_name.buf,
+					   t->sha1, NULL, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
diff --git a/refs.c b/refs.c
index 6cfc07f..95ebd35 100644
--- a/refs.c
+++ b/refs.c
@@ -3654,7 +3654,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3664,9 +3664,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
-	if (have_old && !old_sha1)
-		die("BUG: have_old is true but old_sha1 is NULL");
-
 	if (!is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		strbuf_addf(err, "refusing to update ref with bad name %s",
@@ -3676,7 +3673,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
-	if (have_old) {
+	if (old_sha1) {
 		hashcpy(update->old_sha1, old_sha1);
 		flags |= REF_HAVE_OLD;
 	}
@@ -3693,7 +3690,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	return ref_transaction_update(transaction, refname, new_sha1,
-				      null_sha1, flags, 1, msg, err);
+				      null_sha1, flags, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
@@ -3702,8 +3699,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	return ref_transaction_update(transaction, refname, null_sha1,
-				      old_sha1, flags, have_old, msg, err);
+	return ref_transaction_update(transaction, refname,
+				      null_sha1, have_old ? old_sha1 : NULL,
+				      flags, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
@@ -3715,8 +3713,8 @@ int update_ref(const char *action, const char *refname,
 
 	t = ref_transaction_begin(&err);
 	if (!t ||
-	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, action, &err) ||
+	    ref_transaction_update(t, refname, sha1, oldval,
+				   flags, action, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
diff --git a/refs.h b/refs.h
index 9bf2148..f05ac89 100644
--- a/refs.h
+++ b/refs.h
@@ -265,8 +265,8 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or null_sha1 if it should
- * be deleted.  If have_old is true, then old_sha1 holds the value
- * that the reference should have had before the update, or zeros if
+ * be deleted.  If old_sha1 is non-NULL, then it the value
+ * that the reference should have had before the update, or null_sha1 if
  * it must not have existed beforehand.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
@@ -276,7 +276,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
diff --git a/sequencer.c b/sequencer.c
index 77a1266..32aa05e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -252,7 +252,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn ? null_sha1 : from,
-				   0, 1, sb.buf, &err) ||
+				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
diff --git a/walker.c b/walker.c
index 483da4e..58ffeca 100644
--- a/walker.c
+++ b/walker.c
@@ -299,7 +299,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, refname.buf,
-					   &sha1[20 * i], NULL, 0, 0,
+					   &sha1[20 * i], NULL, 0,
 					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
-- 
2.1.4
