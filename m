From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 21/39] api-lockfile: document edge cases
Date: Fri, 26 Sep 2014 12:08:21 +0200
Message-ID: <1411726119-31598-22-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:10:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTt-0004ly-AE
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbaIZKKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:10:22 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61745 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755784AbaIZKJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:25 -0400
X-AuditID: 12074414-f79446d000001f1d-d0-54253b543e1a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.0F.07965.45B35245; Fri, 26 Sep 2014 06:09:24 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM6013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:23 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1A2xVg0x+LDM2qLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozFC/uYCs6IVOx5MJO5gfG7QBcj
	J4eEgInE3OVTmSFsMYkL99azdTFycQgJXGaU+Pb4FytIQkhgE5PE7HYZEJtNQFdiUU8zE4gt
	IqAmMbHtEAtIA7PAYiaJCYc2sYEkhAWsJVZu+csIYrMIqEosbvoONohXwFXi4N2JjBDb5CQ2
	7P4PZnMCxRu3X2OEWOYi0bJ+MssERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIz
	S/RSU0o3MUKCUWQH45GTcocYBTgYlXh4b6xTCRFiTSwrrsw9xCjJwaQkyvvFQjVEiC8pP6Uy
	I7E4I76oNCe1+BCjBAezkgjvHSOgHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQi
	mKwMB4eSBK+VFVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg24ouB0QGS4gHa
	6wHSzltckJgLFIVoPcWoy7Gu81s/kxBLXn5eqpQ47xFLoCIBkKKM0jy4FbDU84pRHOhjYd7j
	IKN4gGkLbtIroCVMQEuUjiiDLClJREhJNTDOup67Xo/ZkftAR21zsA6v/aRZM7Mzj9n7xZlt
	WMfJ7KIitIsl2ck3qMxz24r4uKaj/ns6FtveO2aflHDxtLVtM+vJT707Nx7m6sxe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257521>

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
index 7f04db2..d7882df 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -99,6 +99,10 @@ unable_to_lock_die::
 
 	Emit an appropriate error message and `die()`.
 
+Similarly, `commit_lock_file` and `close_lock_file` return 0 on
+success. On failure they set `errno` appropriately, do their best to
+roll back the lockfile, and return -1.
+
 
 Flags
 -----
@@ -143,18 +147,22 @@ commit_lock_file::
 
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
 
@@ -162,6 +170,6 @@ close_lock_file::
 	earlier call to `hold_lock_file_for_update` or
 	`hold_lock_file_for_append`, and close the file descriptor.
 	Return 0 upon success. On failure to `close(2)`, return a
-	negative value and rollback the lock file. Usually
+	negative value and roll back the lock file. Usually
 	`commit_lock_file` or `rollback_lock_file` should eventually
 	be called if `close_lock_file` succeeds.
-- 
2.1.0
