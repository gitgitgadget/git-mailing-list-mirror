From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 38/39] Move read_index() definition to read-cache.c
Date: Fri, 26 Sep 2014 12:08:38 +0200
Message-ID: <1411726119-31598-39-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:10:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTk-0004d2-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbaIZKJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:59 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61435 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755454AbaIZKJw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:52 -0400
X-AuditID: 12074413-f79ed6d000002501-00-54253b70a904
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 75.C9.09473.07B35245; Fri, 26 Sep 2014 06:09:52 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMN013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:50 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1C2wVg0xuHOM1aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyHF/+zFzRyVXy7s5S5gbGDo4uR
	g0NCwESi7bFlFyMnkCkmceHeerYuRi4OIYHLjBJ7W7cxQjibmCSmT+xjAqliE9CVWNTTDGaL
	CKhJTGw7xAJSxCywmEliwqFNbCAJYQE3iWlL5oEVsQioSkw//5IZxOYVcJXYOXUlM8Q6OYkN
	u/8zgticQPHG7dfAbCEBF4mW9ZNZJjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66X
	m1mil5pSuokREozCOxh3nZQ7xCjAwajEw3tjnUqIEGtiWXFl7iFGSQ4mJVHeLxaqIUJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeO8YAeV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8Fy2BGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRFfDIwOkBQP
	0F4uK5C9xQWJuUBRiNZTjLoc6zq/9TMJseTl56VKifMeAdkhAFKUUZoHtwKWel4xigN9LMx7
	A6SKB5i24Ca9AlrCBLRE6YgyyJKSRISUVAOjWduKZJWIWg0+j29zV3twFBra/1799uiztl2T
	toitSvM4Nm9SxP9wNu2bVx7o+pk9OP5t3iur2bPDnNf4utdsLdV0y+JsXh0rdTTw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257522>

lockfile.c contains the general API for locking any file. Code
specifically about the index file doesn't belong here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c   | 8 --------
 read-cache.c | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index b2f5d36..63f4e94 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -340,14 +340,6 @@ int commit_lock_file(struct lock_file *lk)
 	return err;
 }
 
-int hold_locked_index(struct lock_file *lk, int die_on_error)
-{
-	return hold_lock_file_for_update(lk, get_index_file(),
-					 die_on_error
-					 ? LOCK_DIE_ON_ERROR
-					 : 0);
-}
-
 void rollback_lock_file(struct lock_file *lk)
 {
 	if (!lk->active)
diff --git a/read-cache.c b/read-cache.c
index e887e23..9f137e7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1367,6 +1367,14 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
+int hold_locked_index(struct lock_file *lk, int die_on_error)
+{
+	return hold_lock_file_for_update(lk, get_index_file(),
+					 die_on_error
+					 ? LOCK_DIE_ON_ERROR
+					 : 0);
+}
+
 int read_index(struct index_state *istate)
 {
 	return read_index_from(istate, get_index_file());
-- 
2.1.0
