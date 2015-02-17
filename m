From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/13] ref_transaction_delete(): remove "have_old" parameter
Date: Tue, 17 Feb 2015 18:00:16 +0100
Message-ID: <1424192423-27979-7-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:00:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlW0-0003mH-7U
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbbBQRAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:46 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62409 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234AbbBQRAn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:43 -0500
X-AuditID: 12074413-f79f26d0000030e7-1a-54e373b91a1d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 33.5B.12519.9B373E45; Tue, 17 Feb 2015 12:00:42 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXb000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:40 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLur+HGIwYwQi64r3UwWDb1XmC3e
	3lzCaHF7xXxmi+4pbxktevs+sVps3tzO4sDu8ff9ByaPnbPusnss2FTqcfGSssfnTXIBrFHc
	NkmJJWXBmel5+nYJ3BmdV5ayFpxQqJjZtpGpgXG/ZBcjJ4eEgInE5A9/WSBsMYkL99azdTFy
	cQgJXGaUePhnIzNIQkjgOJPEp7k6IDabgK7Eop5mJhBbREBNYmLbIbBmZoHVTBJb7wI1c3AI
	C/hL/JrqARJmEVCVmPmhnw3E5hVwkZh7oRlql5zE+eM/wcZzCrhKLPu1jB1ilYvE/I7ZTBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAkw4R2Mu07KHWIU4GBU
	4uG1mPAoRIg1say4MvcQoyQHk5IoLycwPIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8AalAOV4
	UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8bUVAjYJFqempFWmZOSUI
	aSYOTpDhXFIixal5KalFiaUlGfGguIgvBkYGSIoHaG8WSDtvcUFiLlAUovUUo6KUOG8KSEIA
	JJFRmgc3FpY2XjGKA30pzLsOpIoHmHLgul8BDWYCGjz/zyOQwSWJCCmpBsap98xtJz7tzZo3
	VfpgxqQNx3c+fZ97P2/jc4mZ7LF/hTb8uXnx+JWE6uNq35waMszele1RKzjGY9ve8f33ajf/
	LOPZsrZ7/JYnd0d4WtpZJM99nlBZmDr/0++z/G0v9rBqTUku/73xuV3bw9fTWrpl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263958>

Instead, verify the reference's old value if and only if old_sha1 is
non-NULL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c |  3 +--
 builtin/update-ref.c   |  5 +++--
 refs.c                 | 11 ++++++-----
 refs.h                 |  6 +++---
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0be50e9..70e9ce5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -953,8 +953,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
index 1ad6ce1..226995f 100644
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
index e88817c..e3c4ab5 100644
--- a/refs.c
+++ b/refs.c
@@ -2576,7 +2576,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, NULL, &err) ||
+				   REF_ISPRUNING, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -2753,8 +2753,9 @@ int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flag
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, sha1, flags,
-				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    ref_transaction_delete(transaction, refname,
+				   (sha1 && !is_null_sha1(sha1)) ? sha1 : NULL,
+				   flags, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
@@ -3696,11 +3697,11 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   unsigned int flags, int have_old, const char *msg,
+			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
 	return ref_transaction_update(transaction, refname,
-				      null_sha1, have_old ? old_sha1 : NULL,
+				      null_sha1, old_sha1,
 				      flags, msg, err);
 }
 
diff --git a/refs.h b/refs.h
index dced4c9..100731d 100644
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
-			   unsigned int flags, int have_old, const char *msg,
+			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
-- 
2.1.4
