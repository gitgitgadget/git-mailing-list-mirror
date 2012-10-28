From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 4/8] longest_ancestor_length(): use string_list_split()
Date: Sun, 28 Oct 2012 17:16:23 +0100
Message-ID: <1351440987-26636-5-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVY2-0003KP-FW
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab2J1QRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:17:01 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:52132 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab2J1QRA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:17:00 -0400
X-AuditID: 12074413-b7f786d0000008bb-0d-508d5a7b4b5a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 37.A0.02235.B7A5D805; Sun, 28 Oct 2012 12:16:59 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJe002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:16:58 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqFsd1Rtg8GeahUXXlW4mi4beK8wW
	T+beZbY4esrC4vaK+cwWP1p6mC3Wv7vK7MDu8ff9ByaPnbPusns8fNXF7vGsdw+jx8VLyh6f
	N8kFsEVx2yQllpQFZ6bn6dslcGf8/f2PpaCfp+LT0gOsDYz7ObsYOTkkBEwkJk7fygZhi0lc
	uLceyObiEBK4zCjRsXwCC4Rzhkni9bPdzCBVbAK6Eot6mplAbBEBWYnvhzcyghQxC9xllJh0
	dCrYKGEBL4ldz56B2SwCqhINU14xgti8Ai4Si2b+Y4JYJyfxYc8j9i5GDg5OAVeJo/3OIGEh
	oJI/q94xTmDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11wvN7NELzWldBMjJOCEdzDu
	Oil3iFGAg1GJh/dSQU+AEGtiWXFl7iFGSQ4mJVFe5qDeACG+pPyUyozE4oz4otKc1OJDjBIc
	zEoivEu5gXK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneqZFAjYJF
	qempFWmZOSUIaSYOThDBBbKBB2jDOpBC3uKCxNzizHSIolOMilLivMcigBICIImM0jy4AbDU
	8IpRHOgfYd6NIO08wLQC1/0KaDAT0GAdPrDBJYkIKakGRu4f075t1fnO+o2tZ8m3jfvvRu+R
	X55gZrK99nyJWJWSf/+Bfa4r2v9zd5lmRnUEzDrdUXz0rLjd01fLDZ0Ns6/tW5/V3zLPL5el
	Mqw46+WxaiVhn6Tkfanvd9ar75r7tVrKqMT7tNbUrcJvTym2Nt/KtXrqd2Uy7yzm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208554>


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
1.8.0
