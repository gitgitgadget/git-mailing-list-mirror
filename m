From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/8] longest_ancestor_length(): use string_list_split()
Date: Wed, 26 Sep 2012 21:34:45 +0200
Message-ID: <1348688090-13648-4-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOg-0004jo-0r
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758186Ab2IZTfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:33 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:56058 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758302Ab2IZTfb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:31 -0400
X-AuditID: 12074414-b7f846d0000008b8-03-50635902960d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DF.F2.02232.20953605; Wed, 26 Sep 2012 15:35:30 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfh010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:29 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqMsUmRxg8OadtUXXlW4mi4beK8wW
	R09ZWNxeMZ/ZYv27q8wOrB5/339g8tg56y67x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGd8
	+76UreAud8X0Wc1MDYyzOLsYOTkkBEwkVhz4wQJhi0lcuLeerYuRi0NI4DKjxMTVbYwQzhkm
	icen9zKCVLEJ6Eos6mlmArFFBNQkJrYdYgEpYhaYxCjRs+EBexcjB4ewgLtEY5M8SA2LgKrE
	n9v/wXp5BVwkFs6fwg6xTVHix/c1zCA2p4CrxJcNF9hAbCGgmsOvbjFPYORdwMiwilEuMac0
	Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMkkER2MB45KXeIUYCDUYmH96NtcoAQa2JZ
	cWXuIUZJDiYlUV7rMKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5nWUkBQrwpiZVVqUX5MClp
	DhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErzLw4GGChalpqdWpGXmlCCkmTg4QQQXyAYe
	oA3xIIW8xQWJucWZ6RBFpxgVpcR5O0ESAiCJjNI8uAGwmH/FKA70jzDvHJAqHmC6gOt+BTSY
	CWjw0k0gpxeXJCKkpBoYw+b4OrLazoxanP+8lPuzz4ndV7vfntevK3Wd+Y9BLmr9Vs/w7sT2
	hY2HJHc3y2/puvW1Ilv7XvTyWa99vddzbGTfUVblbB7c7Dtx9uVTs3eHrVxrlhnFN+Pdmzj5
	nP/vd/85/OjcrvOTH+1MUrrx8X6d2ra7e8NqTY6oV2Rsnp0TNXmW6VE3bSWW4oxE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206436>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index cbbdf7d..969bc17 100644
--- a/path.c
+++ b/path.c
@@ -12,6 +12,7 @@
  */
 #include "cache.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -582,19 +583,22 @@ int normalize_path_copy(char *dst, const char *src)
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
+		memcpy(buf, ceil, len+1);
 		if (normalize_path_copy(buf, buf) < 0)
 			continue;
 		len = strlen(buf);
@@ -608,6 +612,7 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 		}
 	}
 
+	string_list_clear(&prefixes, 0);
 	return max_len;
 }
 
-- 
1.7.11.3
