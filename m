From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 36/39] get_locked_file_path(): new function
Date: Fri, 26 Sep 2014 12:08:36 +0200
Message-ID: <1411726119-31598-37-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSau-0003aa-C0
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbaIZKRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:17:34 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47279 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753813AbaIZKRb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:17:31 -0400
X-AuditID: 1207440d-f797f6d000000a4a-f8-54253b6ccc1b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 43.6E.02634.C6B35245; Fri, 26 Sep 2014 06:09:48 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lML013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:47 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1M2xVg0xeLnK1KLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozLW1+yFlwRr3gz6xRzA2ObcBcj
	J4eEgInEr+lfWSBsMYkL99azdTFycQgJXGaUmP1jBzNIQkhgE5PE+YYwEJtNQFdiUU8zE4gt
	IqAmMbHtEAtIA7PAYiaJCYc2sYEkhAXsJCYu2sYIYrMIqErcWdYK1sAr4Crx4P90JohtchIb
	dv8Hq+EEijduv8YIscxFomX9ZJYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVm
	luilppRuYoQEI+8Oxv/rZA4xCnAwKvHw3linEiLEmlhWXJl7iFGSg0lJlPeLhWqIEF9Sfkpl
	RmJxRnxRaU5q8SFGCQ5mJRHeO0ZAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQi
	mKwMB4eSBG+RFVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg24ouB0QGS4gHa
	2w7SzltckJgLFIVoPcWoy7Gu81s/kxBLXn5eqpQ47xFLoCIBkKKM0jy4FbDU84pRHOhjYV5f
	kFE8wLQFN+kV0BImoCVKR5RBlpQkIqSkGhhFF2yP3H90EkvdsahEJ4N0UcEdG3e/+n3rzhSr
	Sfpdq8Unckc/qX+lOjXhc6qoRIGG577cu6W914vubJ3L0GzgJ6Qj+4Tn9tHDn4J3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257542>

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
index 64b250f..74b67c2 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -142,6 +142,11 @@ hold_lock_file_for_append::
 	the existing contents of the file (if any) to the lockfile and
 	position its write pointer at the end of the file.
 
+get_locked_file_path::
+
+	Return the path of the file that is locked by the specified
+	lock_file object. The caller must free the memory.
+
 commit_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
diff --git a/cache.h b/cache.h
index ca64a42..0f1201e 100644
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
index 0a8c3c8..c51c6ec 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -257,6 +257,15 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
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
