From: mhagger@alum.mit.edu
Subject: [RFC 3/7] parse_refname_component(): accept a length parameter
Date: Tue,  1 May 2012 01:02:51 +0200
Message-ID: <1335826975-3093-4-git-send-email-mhagger@alum.mit.edu>
References: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzcu-0000Ul-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab2D3XDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41747 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab2D3XDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:11 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xbC028766;
	Tue, 1 May 2012 01:03:04 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196631>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index c293fd2..39008f2 100644
--- a/refs.c
+++ b/refs.c
@@ -29,16 +29,16 @@ static inline int bad_ref_char(int ch)
 }
 
 /*
- * Try to read one refname component from the front of refname.  Return
- * the length of the component found, or -1 if the component is not
- * legal.
+ * Try to read one refname component from the first refnamelen
+ * characters of refname.  Return the length of the component found,
+ * or -1 if the component is not legal.
  */
-static int check_refname_component(const char *refname, int flags)
+static int check_refname_component(const char *refname, int refnamelen, int flags)
 {
-	int i, len = strlen(refname);
+	int i;
 	char last = '\0';
 
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < refnamelen; i++) {
 		char ch = refname[i];
 		if (ch == '/')
 			break;
@@ -69,11 +69,12 @@ static int check_refname_component(const char *refname, int flags)
 
 int check_refname_format(const char *refname, int flags)
 {
+	int refnamelen = strlen(refname);
 	int component_len, component_count = 0;
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, flags);
+		component_len = check_refname_component(refname, refnamelen, flags);
 		if (component_len <= 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
 					refname[0] == '*' &&
@@ -90,6 +91,7 @@ int check_refname_format(const char *refname, int flags)
 			break;
 		/* Skip to next component. */
 		refname += component_len + 1;
+		refnamelen -= component_len + 1;
 	}
 
 	if (refname[component_len - 1] == '.')
-- 
1.7.10
