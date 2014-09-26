From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 04/39] rollback_lock_file(): do not clear filename redundantly
Date: Fri, 26 Sep 2014 12:08:04 +0200
Message-ID: <1411726119-31598-5-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:10:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSU9-000526-Ul
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbaIZKJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:02 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58124 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754372AbaIZKI6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:08:58 -0400
X-AuditID: 12074412-f792e6d000005517-a1-54253b39a870
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D4.68.21783.93B35245; Fri, 26 Sep 2014 06:08:57 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLn013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:08:56 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1LW0Vg0xWL5Fy6LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyvG76wF7SzVjzYt425gbGXpYuR
	k0NCwERi2qytrBC2mMSFe+vZQGwhgcuMEv2TgrsYuYDsTUwSzxdvYgRJsAnoSizqaWYCsUUE
	1CQmth1iASliFljMJDHh0CawbmGBQInJ67vAprIIqErMO9sL1swr4CJxZcdaqG1yEht2/weL
	cwq4SjRuv8YIsdlFomX9ZJYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluil
	ppRuYoQEo9AOxvUn5Q4xCnAwKvHw3linEiLEmlhWXJl7iFGSg0lJlPeLhWqIEF9SfkplRmJx
	RnxRaU5q8SFGCQ5mJRHeO0ZAOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZ
	Dg4lCV4rK6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBsxBcDowMkxQO01wOk
	nbe4IDEXKArReorRmKOl6W0vE8e6zm/9TEIsefl5qVLivEcsgUoFQEozSvPgFsHS0CtGcaC/
	hXl9QQbyAFMY3LxXQKuYgFYpHVEGWVWSiJCSamCUi/oewWQQpmqg9+CH8qptbK6sd/cWfb/6
	t+Ze4JS/pzad3+TJpbfwssb/ex99+eccDCy4vudLZGOylWH6J+dr+c8u/t8Xk2Dx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257525>

It is only necessary to clear the lock_file's filename field if it was
not already clear.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index d02c3bf..5330d6a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -280,6 +280,6 @@ void rollback_lock_file(struct lock_file *lk)
 		if (lk->fd >= 0)
 			close(lk->fd);
 		unlink_or_warn(lk->filename);
+		lk->filename[0] = 0;
 	}
-	lk->filename[0] = 0;
 }
-- 
2.1.0
