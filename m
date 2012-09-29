From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/9] longest_ancestor_length(): use string_list_split()
Date: Sat, 29 Sep 2012 08:15:57 +0200
Message-ID: <1348899362-4057-5-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqLy-0002Qb-9I
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297Ab2I2GQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:30 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:48225 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757946Ab2I2GQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:28 -0400
X-AuditID: 12074414-b7f846d0000008b8-30-5066923b7af3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.04.02232.B3296605; Sat, 29 Sep 2012 02:16:27 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G741026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:26 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqGs9KS3AYPoBdYuuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M54
	udy5YBJPxbRZjawNjIc4uxg5OCQETCQatpV2MXICmWISF+6tZ+ti5OIQErjMKLHj6BlWCOcs
	k8SL9gWMIFVsAroSi3qamUBsEQE1iYlth1hAipgFJjFK9Gx4wA6SEBbwkjj04hRYA4uAqsSO
	no/MIDavgLPEota7jBDrFCV+fF8DFucUcJH43TOdFcQWAqp5tPcO6wRG3gWMDKsY5RJzSnN1
	cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQsJIZAfjkZNyhxgFOBiVeHi1jqcGCLEmlhVX
	5h5ilORgUhLl/TwhLUCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG9GMVA5b0piZVVqUT5MSpqD
	RUmc99tidT8hgfTEktTs1NSC1CKYrAwHh5IEr+FEoKGCRanpqRVpmTklCGkmDk4QwQWygQdo
	gy1IIW9xQWJucWY6RNEpRkUpcV4RkIQASCKjNA9uACziXzGKA/0jzCsEUsUDTBZw3a+ABjMB
	DV66KQlkcEkiQkqqgdHn2dl9DK+L5ObrnLcqvqm64/Z3lfMXe93MPjjxsp/fdmVaxmrp7d7m
	HZM+2Z458X2Cs+oDZ6n/fHZnwhIja7r8K3jn93CW/F86W277LVOJa9MkhXWNHZKkroQccuf/
	oTHzwy7xE2sa96btSn6t9Fk5zG6F34b1W7a8X3pXoSJY7vtGlSbt0gIlluKMREMt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206637>


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
