From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 17/39] commit_lock_file(): inline temporary variable
Date: Fri, 26 Sep 2014 12:08:17 +0200
Message-ID: <1411726119-31598-18-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSt-0003oZ-CR
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbaIZKJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:21 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61422 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755766AbaIZKJT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:19 -0400
X-AuditID: 12074413-f79ed6d000002501-e1-54253b4e521e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C2.C9.09473.E4B35245; Fri, 26 Sep 2014 06:09:18 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM2013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:17 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1PWzVg0x+LxZ2aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ox7u9axFnxkrdhw6DxTA+MTli5G
	Tg4JAROJ2/3n2CBsMYkL99YD2VwcQgKXGSXuzZvHDOFsYpI48/UdK0gVm4CuxKKeZiYQW0RA
	TWJi2yEWkCJmgcVMEhMObQIbJSzgLvHo+RVGEJtFQFXi0sllYA28Aq4SvYeOskOsk5PYsPs/
	WA0nULxx+zUwW0jARaJl/WSWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbo
	paaUbmKEhKPwDsZdJ+UOMQpwMCrx8N5YpxIixJpYVlyZe4hRkoNJSZT3i4VqiBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3jtGQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgTvRUugRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQdMQXA+MDJMUDtJfL
	CmRvcUFiLlAUovUUozFHS9PbXiaOdZ3f+pmEWPLy81KlxHmPgGwSACnNKM2DWwRLRK8YxYH+
	Fua9AVLFA0xicPNeAa1iAlqldEQZZFVJIkJKqoFxzvszVfv+VTm8m+TBOk107paw43elijwO
	3vvh5nuqPqotfO2uR2Hr1/B1OQpf1Nns0tez7xDzy+oXnRoRczmZHmRtMTNYq7Vj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257511>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f8205f6..e148227 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -300,12 +300,14 @@ int reopen_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-	size_t i;
+
 	if (close_lock_file(lk))
 		return -1;
+
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
-	result_file[i] = 0;
+	/* remove ".lock": */
+	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
+
 	if (rename(lk->filename, result_file))
 		return -1;
 	lk->filename[0] = 0;
-- 
2.1.0
