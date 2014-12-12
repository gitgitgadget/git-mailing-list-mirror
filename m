From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/24] lock_any_ref_for_update(): inline function
Date: Fri, 12 Dec 2014 09:57:01 +0100
Message-ID: <1418374623-5566-23-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2q-0004eU-8J
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbaLLI5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:44 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61207 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965094AbaLLI5m (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:42 -0500
X-AuditID: 12074413-f79f26d0000030e7-29-548aae05895e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 63.1C.12519.50EAA845; Fri, 12 Dec 2014 03:57:41 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nW023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:40 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqMu6rivEYPEfY4uuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xscPP5kK7gpW/Hy6mLWBcSFfFyMnh4SAicT0c0eYIGwxiQv31rN1MXJxCAlc
	ZpS49/8OG0hCSOAYk8Tef3YgNpuArsSinmawBhEBNYmJbYdYQGxmgROMErMbQkBsYQEXia41
	DWBxFgFViVN7ehhBbF6g+I9PB5i7GDmAlslJbF3nDRLmBApfbHnCArHKWWLrik7WCYy8CxgZ
	VjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbopaaUbmKEBJbwDsZdJ+UOMQpwMCrx8L5I
	7QoRYk0sK67MPcQoycGkJMr7fTJQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv3yigHG9KYmVV
	alE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgvfoGqBGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFBcxBcDIwMkxQO0l20tyN7igsRcoChE6ylGRSlx3tMgcwVAEhml
	eXBjYeniFaM40JfCvIYg7TzAVAPX/QpoMBPQ4OVbOkAGlyQipKQaGM3z5t1m/uNUJv/4qf7Z
	sn+t+7jYzjFMyKk3US/q3tA/d9LxvXYhX+x0n2/Zr3n7Lcf+WZFp9ySzhDKOXX32jc/vcDLz
	NJMjRlP2hX1fvHll6/nX3JXzbmnIVebcm/qBq8xcoPvOZXnp9J18R5+eu1CYU9y4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261332>

Inline the function at its one remaining caller (which is within
refs.c) and remove it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +--------
 refs.h | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 618ef9c..166c0f6 100644
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
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
diff --git a/refs.h b/refs.h
index 4bb58b9..28e7834 100644
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
