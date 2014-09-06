From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 15/32] remove_lock_file(): call rollback_lock_file()
Date: Sat,  6 Sep 2014 09:50:29 +0200
Message-ID: <1409989846-22401-16-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuG-0005AA-Js
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbaIFH7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:32 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49032 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbaIFH7V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:21 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:59:21 EDT
X-AuditID: 12074411-f79d86d000006a97-7c-540abd3389c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C8.7D.27287.33DBA045; Sat,  6 Sep 2014 03:52:19 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHE006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:18 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqGu8lyvEoOmEpEXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi86Or4wObB5/339g8nj4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3xv0vngXXWCs+rDvN1MB4lKWLkZNDQsBEYsGnS0wQtpjEhXvr2boY
	uTiEBC4zShzqugzlHGOSmPNtETNIFZuArsSinmYmkISIQBujxK6Lm1lBEswCKRIdz7sZQWxh
	AXeJRe/eAHVzcLAIqEr03o4ECfMKuErsuDCFFWKbnMSG3f/ByjmB4tObOsFsIQEXifaT/UwT
	GHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJM8EdjDNOyh1iFOBg
	VOLhLXDgChFiTSwrrsw9xCjJwaQkypu3HCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLdjMlCO
	NyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTB67IHqFGwKDU9tSItM6cE
	Ic3EwQkynEtKpDg1LyW1KLG0JCMeFBnxxcDYAEnxAO1lBWnnLS5IzAWKQrSeYjTmaGl628vE
	sa7zWz+TEEtefl6qlDgvE0ipAEhpRmke3CJYgnnFKA70tzCvGEgVDzA5wc17BbSKCWiVeTon
	yKqSRISUVAPjjt9Jzxgf39v6dJFUoP3EORt5ynj3yflF2vofLZipeu3imZn7TUTKF4j4ek7n
	rLZrlRaVnb5/tpVr0f54ttkbTB+/Fg87cs1GRfzmsyf/FoacCbtuuUdtVbKPerLV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256571>

It does just what we need.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 71786c9..dacfc28 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -63,12 +63,8 @@ static void remove_lock_file(void)
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
