From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 16/39] remove_lock_file(): call rollback_lock_file()
Date: Fri, 26 Sep 2014 12:08:16 +0200
Message-ID: <1411726119-31598-17-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSZm-0002QB-0y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbaIZKQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:28 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56882 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755185AbaIZKQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:26 -0400
X-AuditID: 1207440f-f79156d000006a5c-84-54253b4c7ffd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 83.ED.27228.C4B35245; Fri, 26 Sep 2014 06:09:16 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM1013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:15 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1PWxVg0x+DrfwqLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyOk7fZCjrZKnqeRTYwfmbpYuTk
	kBAwkfh5eTk7hC0mceHeerYuRi4OIYHLjBJNe/8xQzibmCTunnvNClLFJqArsainmQnEFhFQ
	k5jYdogFpIhZYDGTxIRDm4DaOTiEBdwl1rwPB6lhEVCVuH3hNlgvr4CrxK7HUxghtslJbNj9
	H8zmBIo3br8GZgsJuEi0rJ/MMoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwS
	vdSU0k2MkFDk38HYtV7mEKMAB6MSD++NdSohQqyJZcWVuYcYJTmYlER5v1iohgjxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4b1jBJTjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwWlkBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL1c
	IO28xQWJuUBRiNZTjMYcLU1ve5k41nV+62cSYsnLz0uVEuc9YglUKgBSmlGaB7cIloReMYoD
	/S3MKwIykAeYwODmvQJaxQS0SumIMsiqkkSElFQDI8+zMPae2QlTa6WEZnYmT/KKCvJ0nz/j
	bBejZ1nJ1iK+9brJWWdX2SSumLxiQt+PJUKuOausXyRmH/8qxnilcF7prLNWeQ9W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257531>

It does just what we need.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index a8f32e5..f8205f6 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -53,12 +53,8 @@ static void remove_lock_file(void)
 	pid_t me = getpid();
 
 	while (lock_file_list) {
-		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0]) {
-			if (lock_file_list->fd >= 0)
-				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->filename);
-		}
+		if (lock_file_list->owner == me)
+			rollback_lock_file(lock_file_list);
 		lock_file_list = lock_file_list->next;
 	}
 }
-- 
2.1.0
