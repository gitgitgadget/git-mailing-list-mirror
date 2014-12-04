From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/23] lock_any_ref_for_update(): inline function
Date: Fri,  5 Dec 2014 00:08:34 +0100
Message-ID: <1417734515-11812-23-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWT-00033l-Li
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360AbaLDXJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:14 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45007 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933355AbaLDXJM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:12 -0500
X-AuditID: 1207440f-f792a6d000001284-02-5480e998c0c2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 31.99.04740.899E0845; Thu,  4 Dec 2014 18:09:12 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deJ027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:10 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqDvjZUOIwbVeDouuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFv8m1Fhs3tzO4sDu8ff9ByaPnbPusnss2FTqcfGSssfnTXIBrFHc
	NkmJJWXBmel5+nYJ3BnPG46xF/wUrNi/cg97A+M2vi5GTg4JAROJv/e/M0HYYhIX7q1n62Lk
	4hASuMwocXH+CyYI5xiTxN++lewgVWwCuhKLeprBOkQE1CRmrpoN1sEs8INR4nXDGmaQhLCA
	o8TqKR/ZQGwWAVWJbRfPgdm8Aq4SrZdvsnYxcgCtk5PYus4bJMwJFJ46s5URxBYScJF4tmkh
	+wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL9FJTSjcxQoKMfwdj13qZQ4wC
	HIxKPLwFu+tDhFgTy4orcw8xSnIwKYnynn3aECLEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNf4
	CFCONyWxsiq1KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTBW/oCqFGwKDU9tSIt
	M6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFBvxxcDoAEnxAO0tA2nnLS5IzAWKQrSeYlSUEue1
	BkkIgCQySvPgxsJSxytGcaAvhXktQap4gGkHrvsV0GAmoMFnG2pBBpckIqSkGhgXODpkisxj
	Xusr7tbku+poKdORuR0/b3uHXJ6QE/Zr6sz27Tqel3KvfUgLnte8fGP0m30rlJwT+gUWBz4P
	8vSPWRew1Zj3l057qkBGZu/x/1OOmx2f8NUo+MUt9Z5idz8rv48aLDyLWXwN4z69 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260822>

From: Ronnie Sahlberg <sahlberg@google.com>

Inline the function at its one remaining caller (which is within
refs.c) and remove it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +--------
 refs.h | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index c6ee775..f3564cf 100644
--- a/refs.c
+++ b/refs.c
@@ -2346,13 +2346,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *refname,
-					 const unsigned char *old_sha1,
-					 int flags, int *type_p)
-{
-	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
-}
-
 /*
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
@@ -4007,7 +4000,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * we take the lock for the ref itself to prevent it from
 	 * getting updated.
 	 */
-	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
diff --git a/refs.h b/refs.h
index 82611b5..174863d 100644
--- a/refs.h
+++ b/refs.h
@@ -181,8 +181,7 @@ extern int is_branch(const char *refname);
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /*
- * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
- * ref_transaction_create(), etc.
+ * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  * REF_DELETING: tolerate broken refs
@@ -191,12 +190,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  */
 #define REF_NODEREF	0x01
 #define REF_DELETING	0x02
-/*
- * This function sets errno to something meaningful on failure.
- */
-extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-						const unsigned char *old_sha1,
-						int flags, int *type_p);
 
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
-- 
2.1.3
