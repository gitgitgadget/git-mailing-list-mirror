From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 35/35] get_locked_file_path(): new function
Date: Tue, 16 Sep 2014 21:33:56 +0200
Message-ID: <1410896036-12750-36-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:35:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyX4-0000Yo-Il
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbaIPTfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:35:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52832 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755165AbaIPTfK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:35:10 -0400
X-AuditID: 12074413-f79ed6d000002501-f6-541890edf9ae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 49.BC.09473.DE098145; Tue, 16 Sep 2014 15:35:09 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcd001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:35:08 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqPt2gkSIwYNOPYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOaL9zlLVgl3jFq3v7mRsYPwl1MXJySAiYSFyaf5gd
	whaTuHBvPVsXIxeHkMBlRokLTe1MIAkhgRNMEpvmMoLYbAK6Eot6mplAikQE2hgldl3czAri
	MAt0M0q8P3EarENYwE5iYfcVsA4WAVWJo6++sIHYvAKuEvs+rWWDWCcnsWH3f6AaDg5OoPjX
	fQUgppCAi8TBu34TGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJ
	O+EdjLtOyh1iFOBgVOLh9XgkHiLEmlhWXJl7iFGSg0lJlPdft0SIEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHeH75AOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBC8f
	ML6EBItS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/QXm2Qdt7igsRc
	oChE6ylGXY51nd/6mYRY8vLzUqXEeW36gYoEQIoySvPgVsCSzCtGcaCPhSFG8QATFNykV0BL
	mICWnO0RA1lSkoiQkmpgXHHSOdVlg63jvsMfRGzPfNmS8sN2dnrBIuMCqfm7Pm4SWj99mhH3
	1NMfJ7HNeLp0dndd3qvYzRemzLKMqnF4Lhqqw3J8xYy9K8O/mRvqifP/vD0n/ayO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257158>

Add a function to return the path of the file that is locked by a
lock_file object. This reduces the knowledge that callers have to have
about the lock_file layout.

Suggested-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 5 +++++
 cache.h                                  | 1 +
 lockfile.c                               | 9 +++++++++
 refs.c                                   | 4 +---
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 40cd524..22f1b5c 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -52,6 +52,11 @@ hold_lock_file_for_append::
 	lockfile and its write pointer is positioned at the end of the
 	file before returning.
 
+get_locked_file_path::
+
+	Return the path of the file that is locked by the specified
+	lock_file object. The caller must free the memory.
+
 unable_to_lock_error::
 
 	Emit an error describing that there was an error locking the
diff --git a/cache.h b/cache.h
index d610fab..4bbaffa 100644
--- a/cache.h
+++ b/cache.h
@@ -590,6 +590,7 @@ extern void unable_to_lock_message(const char *path, int err,
 extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern char *get_locked_file_path(struct lock_file *);
 extern int commit_lock_file_to(struct lock_file *, const char *path);
 extern int commit_lock_file(struct lock_file *);
 extern int reopen_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 0b63554..42cea0a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -274,6 +274,15 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
+char *get_locked_file_path(struct lock_file *lk)
+{
+	if (!lk->active)
+		die("BUG: get_locked_file_path() called for unlocked object");
+	if (lk->filename.len <= LOCK_SUFFIX_LEN)
+		die("BUG: get_locked_file_path() called for malformed lock object");
+	return xmemdupz(lk->filename.buf, lk->filename.len - LOCK_SUFFIX_LEN);
+}
+
 int close_lock_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
diff --git a/refs.c b/refs.c
index 525ce4b..5842dd0 100644
--- a/refs.c
+++ b/refs.c
@@ -2556,9 +2556,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 		 * loose.  The loose file name is the same as the
 		 * lockfile name, minus ".lock":
 		 */
-		char *loose_filename = xmemdupz(
-				lock->lk->filename.buf,
-				lock->lk->filename.len - LOCK_SUFFIX_LEN);
+		char *loose_filename = get_locked_file_path(lock->lk);
 		int err = unlink_or_warn(loose_filename);
 		free(loose_filename);
 		if (err && errno != ENOENT)
-- 
2.1.0
