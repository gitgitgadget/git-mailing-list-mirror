From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 22/39] dump_marks(): remove a redundant call to rollback_lock_file()
Date: Fri, 26 Sep 2014 12:08:22 +0200
Message-ID: <1411726119-31598-23-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTH-0004Bi-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbaIZKJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:29 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58133 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755131AbaIZKJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:27 -0400
X-AuditID: 12074412-f792e6d000005517-bf-54253b561328
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 57.68.21783.65B35245; Fri, 26 Sep 2014 06:09:26 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM7013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:25 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1A2zVg0x2PdTwaLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7owDO3axF0xnq/j8bj9zA2M7axcj
	J4eEgInE05lzmSBsMYkL99azdTFycQgJXGaU6DxymxHC2cQk8fbdEmaQKjYBXYlFPc1gHSIC
	ahIT2w6xgBQxCyxmkphwaBMbSEJYIFxi7q3vYA0sAqoSc/4+A4vzCrhKTPt6mQ1inZzEht3/
	GUFsTqB44/ZrYLaQgItEy/rJLBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s
	0UtNKd3ECAlHoR2M60/KHWIU4GBU4uG9sU4lRIg1say4MvcQoyQHk5Io7xcL1RAhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIrx3jIByvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotg
	sjIcHEoSvFZWQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiILwbGB0iKB2iv
	B0g7b3FBYi5QFKL1FKMxR0vT214mjnWd3/qZhFjy8vNSpcR5j1gClQqAlGaU5sEtgiWiV4zi
	QH8L8/qCDOQBJjG4ea+AVjEBrVI6ogyyqiQRISXVwLjre/eSxt3l33P10j9KGfzoy1ypzFjJ
	+2b+1SN6ScZ7+KsmLuuWU+P3cT/Op6q+KTaBudi6gfE4c9n32dYr++vZvpv1LJB+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257512>

When commit_lock_file() fails, it now always calls
rollback_lock_file() internally, so there is no need to call that
function here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 487f1f8..61ac7e0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1832,10 +1832,8 @@ static void dump_marks(void)
 	}
 
 	if (commit_lock_file(&mark_lock)) {
-		int saved_errno = errno;
-		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to commit marks file %s: %s",
-			export_marks_file, strerror(saved_errno));
+			export_marks_file, strerror(errno));
 		return;
 	}
 }
-- 
2.1.0
