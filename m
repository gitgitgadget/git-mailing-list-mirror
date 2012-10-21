From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/8] longest_ancestor_length(): use string_list_split()
Date: Sun, 21 Oct 2012 07:57:33 +0200
Message-ID: <1350799057-13846-5-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYo-0006i8-Lj
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab2JUF6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:30 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:42213 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387Ab2JUF62 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:28 -0400
X-AuditID: 1207440c-b7f616d00000270b-30-50838f04abac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 84.7F.09995.40F83805; Sun, 21 Oct 2012 01:58:28 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wr013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:26 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqMvS3xxgcOkkp8WRN0+YLbqudDNZ
	NPReYbZ4Mvcus8XRUxYWt1fMZ7ZY/+4qswO7x9/3H5g83rT3MnrsnHWX3ePhqy52j4uXlD0+
	b5ILYIvitklKLCkLzkzP07dL4M54udy5YBJPxbRZjawNjIc4uxg5OSQETCTWPT/KBGGLSVy4
	t56ti5GLQ0jgMqPEq533WSGcM0wS/ZuWglWxCehKLOppBrNFBNQkJrYdYgEpYha4wyix8Mob
	ZpCEsICXxJeFM1lAbBYBVYk7e3eygdi8Ai4S+1unQa1TlPjxfQ1YPaeAq8SVZXPAaoSAanZu
	fM84gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQgOPZwfhtncwh
	RgEORiUeXkbr5gAh1sSy4srcQ4ySHExKorwveoFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHh3
	CwLleFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvKl9QI2CRanpqRVp
	mTklCGkmDk4QwQWygQdogytIIW9xQWJucWY6RNEpRkUpcV4jkIQASCKjNA9uACw1vGIUB/pH
	mNcLpIoHmFbgul8BDWYCGmzO3QgyuCQRISXVwFj8oYinq3fT5QNpaptfPj7nxs78Y7N/5LkX
	YfefTy+eVTTjtsmDYI7VAXsMD66rnPbWbkety12dyQpsB5nmugvFFFmn2Z4KNL7yTYDrRKyL
	T9mhOu2P+3mntjJv7pr0u9NihjCfvUJYi2Gf2LQ7kteZTV3VgruXXLp+vXWGKtsU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208110>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/path.c b/path.c
index cbbdf7d..f455e8e 100644
--- a/path.c
+++ b/path.c
@@ -12,6 +12,7 @@
  */
 #include "cache.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -582,20 +583,22 @@ int normalize_path_copy(char *dst, const char *src)
  */
 int longest_ancestor_length(const char *path, const char *prefix_list)
 {
+	struct string_list prefixes = STRING_LIST_INIT_DUP;
 	char buf[PATH_MAX+1];
-	const char *ceil, *colon;
-	int len, max_len = -1;
+	int i, max_len = -1;
 
 	if (prefix_list == NULL || !strcmp(path, "/"))
 		return -1;
 
-	for (colon = ceil = prefix_list; *colon; ceil = colon+1) {
-		for (colon = ceil; *colon && *colon != PATH_SEP; colon++);
-		len = colon - ceil;
+	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
+
+	for (i = 0; i < prefixes.nr; i++) {
+		const char *ceil = prefixes.items[i].string;
+		int len = strlen(ceil);
+
 		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
 			continue;
-		strlcpy(buf, ceil, len+1);
-		if (normalize_path_copy(buf, buf) < 0)
+		if (normalize_path_copy(buf, ceil) < 0)
 			continue;
 		len = strlen(buf);
 		if (len > 0 && buf[len-1] == '/')
@@ -608,6 +611,7 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 		}
 	}
 
+	string_list_clear(&prefixes, 0);
 	return max_len;
 }
 
-- 
1.7.11.3
