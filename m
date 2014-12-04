From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 21/23] refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
Date: Fri,  5 Dec 2014 00:08:33 +0100
Message-ID: <1417734515-11812-22-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwfdf-00078T-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933378AbaLDXQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:16:44 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52156 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933350AbaLDXQm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:16:42 -0500
X-AuditID: 12074412-f79e46d0000036b4-c3-5480e9964de5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 73.92.14004.699E0845; Thu,  4 Dec 2014 18:09:10 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deI027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:09 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqDvtZUOIQdMTbYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFv8m1Fhs3tzO4sDu8ff9ByaPnbPusnss2FTqcfGSssfnTXIBrFHc
	NkmJJWXBmel5+nYJ3Blzj55mLGgWrbi3/zxrA2OzYBcjB4eEgInEha+VXYycQKaYxIV769m6
	GLk4hAQuM0rMebwdyjnGJLG3fyE7SBWbgK7Eop5mJhBbREBNYuaq2WBFzAI/GCVeN6xhBpkq
	LBAu0f4xHMRkEVCVODcPbAGvgKvE7uOrWCD2yklsXecNEuYECk+d2coIYgsJuEg827SQfQIj
	7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIeEltINx/Um5Q4wCHIxK
	PLyFu+tDhFgTy4orcw8xSnIwKYnynn3aECLEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNf4CFCO
	NyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mCl+sFUKNgUWp6akVaZk4J
	QpqJgxNkOJeUSHFqXkpqUWJpSUY8KCrii4FxAZLiAdpbBtLOW1yQmAsUhWg9xagoJc5bD5IQ
	AElklObBjYUljVeM4kBfCvOWglTxABMOXPcroMFMQIPPNtSCDC5JREhJNTBWi/60+BQeXPi/
	P/uyep6v6cm6zGex75jtZoYE6ileON5TeELIaeqjx3Y28qImK+0r5sz28X1bLK7Ud3pF0BzZ
	KCe5WR26i7u4Qs4+UrssI+Lfs3kdE6el/bHTKq/+2imts1579NPDvsmTwx3v5QSo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260833>

From: Ronnie Sahlberg <sahlberg@google.com>

unlock|close|commit_ref can be made static since there are no more external
callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 5a12d37..c6ee775 100644
--- a/refs.c
+++ b/refs.c
@@ -2090,6 +2090,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	return 0;
 }
 
+static void unlock_ref(struct ref_lock *lock)
+{
+	/* Do not free lock->lk -- atexit() still looks at them */
+	if (lock->lk)
+		rollback_lock_file(lock->lk);
+	free(lock->ref_name);
+	free(lock->orig_ref_name);
+	free(lock);
+}
+
 /* This function should make sure errno is meaningful on error */
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
@@ -2888,7 +2898,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2896,7 +2906,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2904,16 +2914,6 @@ int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-void unlock_ref(struct ref_lock *lock)
-{
-	/* Do not free lock->lk -- atexit() still looks at them */
-	if (lock->lk)
-		rollback_lock_file(lock->lk);
-	free(lock->ref_name);
-	free(lock->orig_ref_name);
-	free(lock);
-}
-
 /*
  * copy the reflog message msg to buf, which has been allocated sufficiently
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
diff --git a/refs.h b/refs.h
index d777f76..82611b5 100644
--- a/refs.h
+++ b/refs.h
@@ -198,15 +198,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
 
-/** Close the file descriptor owned by a lock and return the status */
-extern int close_ref(struct ref_lock *lock);
-
-/** Close and commit the ref locked by the lock */
-extern int commit_ref(struct ref_lock *lock);
-
-/** Release any lock taken but not written. **/
-extern void unlock_ref(struct ref_lock *lock);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.1.3
