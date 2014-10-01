From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 35/38] get_locked_file_path(): new function
Date: Wed,  1 Oct 2014 12:28:39 +0200
Message-ID: <1412159322-2622-36-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAS-0002pF-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbaJAK3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:51 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42567 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743AbaJAK3t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:49 -0400
X-AuditID: 12074414-f79446d000001f1d-af-542bd79dbe11
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AA.61.07965.D97DB245; Wed,  1 Oct 2014 06:29:49 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6Y026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:48 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1J17XTvEYN0XaYuuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDMOXNrAVHBFvKJvUhdrA2ObcBcj
	B4eEgInEn/+6XYycQKaYxIV769m6GLk4hAQuM0p8eDWDBcI5ziQx78BBJpAqNgFdiUU9zWC2
	iICaxMS2Q2BFzAKLmSQmHNrEBpIQFrCT2LBkFyPIBhYBVYnP53NBwrwCLhIH3k1mhdgmJ7Fh
	939GEJsTKL78cjMLiC0k4Cyx485XpgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro
	5WaW6KWmlG5ihISiyA7GIyflDjEKcDAq8fAqJGiHCLEmlhVX5h5ilORgUhLlXXQJKMSXlJ9S
	mZFYnBFfVJqTWnyIUYKDWUmEN/sAUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFq
	EUxWhoNDSYKX4RpQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB
	2usM0s5bXJCYCxSFaD3FqMuxrvNbP5MQS15+XqqUOG8mSJEASFFGaR7cCljiecUoDvSxMG84
	SBUPMGnBTXoFtIQJaEnyGrAlJYkIKakGxtaHL1XOBwhlMfRaLjVrXfe67Z3Tt7dZp3dUi0rH
	xbT9+TV58bYjxr8djTTMundvlngZ6Pxj/rbHinWBzpV3hBcXs5QY8c7epOasNMnu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257717>

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
index a3cb69b..d4484d1 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -143,6 +143,11 @@ hold_lock_file_for_append::
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
index 7ea4e81..d19e57f 100644
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
index c10eaff..e40c47e 100644
--- a/refs.c
+++ b/refs.c
@@ -2606,9 +2606,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
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
