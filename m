From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/4] strbuf_split*(): rename "delim" parameter to "terminator"
Date: Sun,  4 Nov 2012 07:46:53 +0100
Message-ID: <1352011614-29334-4-git-send-email-mhagger@alum.mit.edu>
References: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 07:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUtzo-0006Ts-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 07:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab2KDGrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 01:47:33 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53396 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032Ab2KDGrb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 01:47:31 -0500
X-AuditID: 1207440f-b7fde6d00000095c-20-50960f825413
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.F2.02396.28F06905; Sun,  4 Nov 2012 01:47:30 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA46lFQr027771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 01:47:29 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqNvEPy3A4N06CYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xtspu1kL
	mkUqTt7Sa2B8x9/FyMEhIWAicfxzZRcjJ5ApJnHh3no2EFtI4DKjxMrjOV2MXED2GSaJa5Pe
	MYIk2AR0JRb1NDOB2CICshLfD28EizML5EosfnebHcQWFvCTmPaikRXEZhFQlVi8o4kZxOYV
	cJE4+XoCM8QyOYkPex6B1XMKuErcO3WABWKxi8TF28tYJjDyLmBkWMUol5hTmqubm5iZU5ya
	rFucnJiXl1qka6KXm1mil5pSuokREjr8Oxi71sscYhTgYFTi4V24bGqAEGtiWXFl7iFGSQ4m
	JVHer5zTAoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8G75DFTOm5JYWZValA+TkuZgURLnVV+i
	7ickkJ5YkpqdmlqQWgSTleHgUJLg3cMHNFSwKDU9tSItM6cEIc3EwQkiuEA28ABtOABSyFtc
	kJhbnJkOUXSKUVFKnHc7SEIAJJFRmgc3ABblrxjFgf4RhmjnASYIuO5XQIOZgAZvvzQFZHBJ
	IkJKqoExpnuZ9S4D6YTZXF75XsfeB3WuX/njtHCzY12l8MGaJ/vZ79vYe/o3rpX9oHmBv9bM
	76OF23dVmZ/zFri5h3uvSH6QuET87JG1dbtnBLx5nvOrXMqzujLmaXu/u+Nbc8ZrN8qOGDBN
	e7aC98q2lRWcAnf26R7huxf+6fq0jQXlKqfu/WIyadZXYinOSDTUYi4qTgQAzD15 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209011>

The word "delimiter" suggests that the argument separates the
substrings, whereas in fact (1) the delimiter characters are included
in the output, and (2) if the input string ends with the delimiter,
then the output does not include a final empty string.  So rename the
"delim" arguments of the strbuf_split() family of functions to
"terminator", which is more suggestive of how it is used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 strbuf.c |  5 +++--
 strbuf.h | 15 ++++++++-------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index c7cd529..05d0693 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -106,7 +106,8 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-struct strbuf **strbuf_split_buf(const char *str, size_t slen, int delim, int max)
+struct strbuf **strbuf_split_buf(const char *str, size_t slen,
+				 int terminator, int max)
 {
 	struct strbuf **ret = NULL;
 	size_t nr = 0, alloc = 0;
@@ -115,7 +116,7 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen, int delim, int ma
 	while (slen) {
 		int len = slen;
 		if (max <= 0 || nr + 1 < max) {
-			const char *end = memchr(str, delim, slen);
+			const char *end = memchr(str, terminator, slen);
 			if (end)
 				len = end - str + 1;
 		}
diff --git a/strbuf.h b/strbuf.h
index be941ee..c896a47 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -45,20 +45,21 @@ extern void strbuf_ltrim(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 extern struct strbuf **strbuf_split_buf(const char *, size_t,
-					int delim, int max);
+					int terminator, int max);
 static inline struct strbuf **strbuf_split_str(const char *str,
-					       int delim, int max)
+					       int terminator, int max)
 {
-	return strbuf_split_buf(str, strlen(str), delim, max);
+	return strbuf_split_buf(str, strlen(str), terminator, max);
 }
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
-						int delim, int max)
+						int terminator, int max)
 {
-	return strbuf_split_buf(sb->buf, sb->len, delim, max);
+	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
-static inline struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
+static inline struct strbuf **strbuf_split(const struct strbuf *sb,
+					   int terminator)
 {
-	return strbuf_split_max(sb, delim, 0);
+	return strbuf_split_max(sb, terminator, 0);
 }
 extern void strbuf_list_free(struct strbuf **);
 
-- 
1.8.0
