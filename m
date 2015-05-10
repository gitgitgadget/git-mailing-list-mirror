From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/8] write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
Date: Sun, 10 May 2015 04:45:32 +0200
Message-ID: <1431225937-10456-4-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 05:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHUl-0004o6-2v
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 05:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbbEJDBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 23:01:25 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54621 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752081AbbEJDBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 23:01:25 -0400
X-Greylist: delayed 929 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2015 23:01:24 EDT
X-AuditID: 12074411-f79fa6d000006b8a-2a-554ec6610d92
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id CE.78.27530.166CE455; Sat,  9 May 2015 22:45:54 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxb015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:52 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqJt0zC/UoGkHs0XXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLxZk3jYwObB5/339g8liwqdTjWe8eRo+Ll5Q9Fj/w8vi8SS6ALYrb
	JimxpCw4Mz1P3y6BO2Pa8lfsBSv5K+Z9XsPSwNjJ08XIySEhYCLx8E0DE4QtJnHh3nq2LkYu
	DiGBy4wSVzfPYwFJCAkcZ5KY9UMLxGYT0JVY1NMM1MDBISLgJdE2sxiknlmgl1Hi0eJXjCBx
	YYE4iZsX+UDKWQRUJRqmnwKbzyvgIvHw8mp2iF1yEueP/2QGsTkFXCVun5nLDLHKRaJxaRPL
	BEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFCAkxwB+OMk3KHGAU4
	GJV4eD9s8wsVYk0sK67MPcQoycGkJMprsxAoxJeUn1KZkVicEV9UmpNafIhRgoNZSYT35Hqg
	HG9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgjf2KFCjYFFqempFWmZO
	CUKaiYMTZDiXlEhxal5KalFiaUlGPCgu4ouBkQGS4gHaWwnSzltckJgLFIVoPcWoKCXO2waS
	EABJZJTmwY2FpY1XjOJAXwrzdoNU8QBTDlz3K6DBTECD/xb7gAwuSURISTUwSgmX8R0ov9sr
	/08++YHzJq4r2dLb/XImWj2dWctfqOn18/Vjk0Jbg8jJFVP+8Hq5H8rfJa7xKIjzh67z/Zku
	e7YYGNeu+un9N3J67qebB/brKDxnsmk9LbXi4vtT3HNOl5xe+3LLDB6jnonJr8// 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268722>

This is the first step towards separating the checking and writing of
the new reference value to committing the change.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 6664423..9e40c35 100644
--- a/refs.c
+++ b/refs.c
@@ -3048,23 +3048,15 @@ int is_branch(const char *refname)
 }
 
 /*
- * Write sha1 into the ref specified by the lock. Make sure that errno
- * is sane on error.
+ * Write sha1 into the open lockfile, then close the lockfile. On
+ * errors, rollback the lockfile and set errno to reflect the problem.
  */
-static int write_ref_sha1(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+static int write_ref_to_lockfile(struct ref_lock *lock,
+				 const unsigned char *sha1)
 {
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock) {
-		errno = EINVAL;
-		return -1;
-	}
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
-		unlock_ref(lock);
-		return 0;
-	}
 	o = parse_object(sha1);
 	if (!o) {
 		error("Trying to write ref %s with nonexistent object %s",
@@ -3089,6 +3081,28 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = save_errno;
 		return -1;
 	}
+	return 0;
+}
+
+/*
+ * Write sha1 into the ref specified by the lock. Make sure that errno
+ * is sane on error.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
+	const unsigned char *sha1, const char *logmsg)
+{
+	if (!lock) {
+		errno = EINVAL;
+		return -1;
+	}
+	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
+		unlock_ref(lock);
+		return 0;
+	}
+
+	if (write_ref_to_lockfile(lock, sha1))
+		return -1;
+
 	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-- 
2.1.4
