From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/11] ref_transaction_delete(): remove "have_old" parameter
Date: Sun,  8 Feb 2015 17:13:59 +0100
Message-ID: <1423412045-15616-6-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUVC-0002pO-4h
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbbBHQOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:14:24 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56863 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755001AbbBHQOY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:14:24 -0500
X-AuditID: 12074412-f79e46d0000036b4-08-54d78b5faca3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F6.A9.14004.F5B87D45; Sun,  8 Feb 2015 11:14:23 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9l9014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:22 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqBvffT3E4OxhEYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZK78tZy24J18xefMctgbGJxJdjJwcEgImEr/ObWaDsMUkLtxbD2Rz
	cQgJXGaU2PX6NBOEc4JJYuHuc8wgVWwCuhKLepqZQGwRATWJiW2HWEBsZoHVTBJb74JNEhbw
	kVj99QwriM0ioCoxe85UsBpeAReJXbO2MkJsk5M4f/wn2ExOAVeJJW96wWwhoJo9t3qZJjDy
	LmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREmZCOxjXn5Q7xCjAwajE
	w2sgcz1EiDWxrLgy9xCjJAeTkijv0XCgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeRYevhQjx
	piRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwGnYBDRUsSk1PrUjLzClB
	SDNxcIIM55ISKU7NS0ktSiwtyYgHxUZ8MTA6QFI8QHs7O4HaeYsLEnOBohCtpxgVpcR5/4Mk
	BEASGaV5cGNhyeMVozjQl8K8miDbeYCJB677FdBgJqDBi5deARlckoiQkmpgLFVezpNfdVRu
	4uKJt2UznwsWr8ial3Zoyqq8GYxBux+Hr3xh+fuF751z5pe4L8q+Ewmw8dL5vfhP15c/286V
	eJ1r/H7RYKLElCX79thvklzvfMjgkel+lhsXpznLbfXpOrG3RCQrXSJmZ/GP6g3G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263515>

Instead, if old_sha1 is non-NULL, verify it; otherwise, don't.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/receive-pack.c |  3 +--
 builtin/update-ref.c   |  5 +++--
 refs.c                 | 11 ++++++-----
 refs.h                 |  6 +++---
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 71be82e..b08806d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -933,8 +933,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
 					   old_sha1,
-					   0, old_sha1 != NULL,
-					   "push", &err)) {
+					   0, "push", &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
 			return "failed to delete";
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index f0db7a3..76b8aef 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -265,8 +265,9 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, msg, &err))
+	if (ref_transaction_delete(transaction, refname,
+				   have_old ? old_sha1 : NULL,
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
diff --git a/refs.c b/refs.c
index 6beafcf..6bd6581 100644
--- a/refs.c
+++ b/refs.c
@@ -2577,7 +2577,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, NULL, &err) ||
+				   REF_ISPRUNING, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -2754,8 +2754,9 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    ref_transaction_delete(transaction, refname,
+				   (sha1 && !is_null_sha1(sha1)) ? sha1 : NULL,
+				   delopt, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
@@ -3697,11 +3698,11 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err)
 {
 	return ref_transaction_update(transaction, refname,
-				      null_sha1, have_old ? old_sha1 : NULL,
+				      null_sha1, old_sha1,
 				      flags, msg, err);
 }
 
diff --git a/refs.h b/refs.h
index f05ac89..ee612da 100644
--- a/refs.h
+++ b/refs.h
@@ -295,8 +295,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Add a reference deletion to transaction.  If have_old is true, then
- * old_sha1 holds the value that the reference should have had before
+ * Add a reference deletion to transaction.  If old_sha1 is non-NULL, then
+ * it holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
  * Function returns 0 on success and non-zero on failure. A failure to delete
  * means that the transaction as a whole has failed and will need to be
@@ -305,7 +305,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
-- 
2.1.4
