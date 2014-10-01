From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 20/38] api-lockfile: document edge cases
Date: Wed,  1 Oct 2014 12:28:24 +0200
Message-ID: <1412159322-2622-21-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHA7-0002ef-F6
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbaJAK3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:25 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58232 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579AbaJAK3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:24 -0400
X-AuditID: 1207440e-f79da6d0000002fc-bc-542bd783819f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 85.F9.00764.387DB245; Wed,  1 Oct 2014 06:29:23 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6J026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:22 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1G2+rh1i0H3CxqLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oydq7eyFFwUqfj39gdTA+NPgS5G
	Tg4JAROJHYdOsULYYhIX7q1n62Lk4hASuMwosaihjx3COc4ksWnfXiaQKjYBXYlFPc1gtoiA
	msTEtkMsIEXMAouZJCYc2gTUzsEhLGAtMemvAkgNi4CqxJ/pO9lAbF4BF4mrqx5DbZOT2LD7
	PyOIzQkUX365mQXEFhJwlthx5yvTBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVy
	M0v0UlNKNzFCgpFvB2P7eplDjAIcjEo8vAoJ2iFCrIllxZW5hxglOZiURHkXXQIK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuHNPgCU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2C
	ycpwcChJ8DJcA2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VGfDEwOkBSPEB7
	nUHaeYsLEnOBohCtpxh1OdZ1futnEmLJy89LlRLnzQQpEgApyijNg1sBSz2vGMWBPhbmlQap
	4gGmLbhJr4CWMAEtSV4DtqQkESEl1cAYLXzgl/PREi8N6SVpEhKX1vZcfh/SsJVtq3Pv96tH
	W2YFBk1w4Zres99Da8KvTxr1a7/s8xZZFbHL7l+RKC/jpjSBLbOkw/66zo5MFzFT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257708>

* Document the behavior of commit_lock_file() when it fails, namely
  that it rolls back the lock_file object and sets errno
  appropriately.

* Document the behavior of rollback_lock_file() when called for a
  lock_file object that has already been committed or rolled back,
  namely that it is a NOOP.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index d3bf940..9805da0 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -100,6 +100,10 @@ unable_to_lock_die::
 
 	Emit an appropriate error message and `die()`.
 
+Similarly, `commit_lock_file` and `close_lock_file` return 0 on
+success. On failure they set `errno` appropriately, do their best to
+roll back the lockfile, and return -1.
+
 
 Flags
 -----
@@ -144,18 +148,22 @@ commit_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
 	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`, close the file descriptor and
+	`hold_lock_file_for_append`, close the file descriptor, and
 	rename the lockfile to its final destination. Return 0 upon
-	success or a negative value on failure to `close(2)` or
-	`rename(2)`. It is a bug to call `commit_lock_file()` for a
-	`lock_file` object that is not currently locked.
+	success. On failure, roll back the lock file and return -1,
+	with `errno` set to the value from the failing call to
+	`close(2)` or `rename(2)`. It is a bug to call
+	`commit_lock_file` for a `lock_file` object that is not
+	currently locked.
 
 rollback_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
 	earlier call to `hold_lock_file_for_update` or
 	`hold_lock_file_for_append`, close the file descriptor and
-	remove the lockfile.
+	remove the lockfile. It is a NOOP to call
+	`rollback_lock_file()` for a `lock_file` object that has
+	already been committed or rolled back.
 
 close_lock_file::
 
@@ -163,7 +171,7 @@ close_lock_file::
 	earlier call to `hold_lock_file_for_update` or
 	`hold_lock_file_for_append`, and close the file descriptor.
 	Return 0 upon success. On failure to `close(2)`, return a
-	negative value and rollback the lock file. Usually
+	negative value and roll back the lock file. Usually
 	`commit_lock_file` or `rollback_lock_file` should eventually
 	be called if `close_lock_file` succeeds.
 
-- 
2.1.0
