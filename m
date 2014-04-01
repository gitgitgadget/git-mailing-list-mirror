From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/22] lockfile: define a constant LOCK_SUFFIX_LEN
Date: Tue,  1 Apr 2014 17:58:19 +0200
Message-ID: <1396367910-7299-12-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16Q-0001sB-6w
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaDAP7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:01 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55028 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751886AbaDAP6x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:53 -0400
X-AuditID: 1207440c-f79656d000003eba-54-533ae23ca39d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 63.36.16058.C32EA335; Tue,  1 Apr 2014 11:58:52 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbF027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:51 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqGvzyCrY4OhBa4uuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xfeZ0loK9XBXbO5YxNjBO4ehi5OSQEDCRaFj7lx3CFpO4cG89WxcjF4eQwGVGiTM9
	D9ghnGNMEt8OHACrYhPQlVjU08wEYosIqElMbDvEAmIzC6RIvPq7C8wWFnCSaL/whBHEZhFQ
	lZhx7jCYzSvgInFk4k0WiG1yElN+LwCbyQkUv/RgDyuILSTgLHH6zWLmCYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBBXPDsZv62QOMQpwMCrx8B44bxUsxJpY
	VlyZe4hRkoNJSZT3x12gEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeWTeBcrwpiZVVqUX5MClp
	DhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd7pD4AaBYtS01Mr0jJzShDSTBycIMO5pESK
	U/NSUosSS0sy4kGxEV8MjA6QFA/Q3kcg7bzFBYm5QFGI1lOMilLivCwgCQGQREZpHtxYWKp4
	xSgO9KUw7yaQKh5gmoHrfgU0mAloMPc6sMEliQgpqQbGZZYrHXcWPS2d3rpA++Bzk0OKzw6/
	rTzNI2CyY/W1S7c3Pm+wXHA1j09a/ucduVtlbwO1G5ljGk5M8ZG5ElWxLsXk77rgzYWp2ust
	P8scLxTPeHb2W068cY/Ukdvvkk6mKN3UXPR42nZz68VW7Cn59eVmCXdlLlg9ncfn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245604>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 4a9ceda..4e3ada8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -178,14 +178,17 @@ static char *resolve_symlink(char *p, size_t s)
 	return p;
 }
 
+/* We append ".lock" to the filename to derive the lockfile name: */
+#define LOCK_SUFFIX_LEN 5
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
-	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
+	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
+	 * room for adding ".lock" for the lock file name:
 	 */
-	static const size_t max_path_len = sizeof(lk->filename) - 5;
+	static const size_t max_path_len = sizeof(lk->filename) -
+		                           LOCK_SUFFIX_LEN;
 
 	if (!lock_file_list) {
 		/* One-time initialization */
@@ -301,7 +304,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - 5; /* .lock */
+	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
 	result_file[i] = 0;
 	if (rename(lk->filename, result_file))
 		return -1;
-- 
1.9.0
