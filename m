From: George Papanikolaou <g3orge.app@gmail.com>
Subject: [PATCH] builtin/apply.c: fuzzy_matchlines:trying to fix some inefficiencies
Date: Thu, 20 Mar 2014 11:35:03 +0200
Message-ID: <1395308103-16018-1-git-send-email-g3orge.app@gmail.com>
Cc: git@vger.kernel.org, George Papanikolaou <g3orge.app@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 20 10:33:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQZLS-0001xD-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 10:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbaCTJc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 05:32:57 -0400
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:36722 "EHLO
	poseidon.ceid.upatras.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978AbaCTJc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 05:32:56 -0400
Received: from mail.ceid.upatras.gr (mail.ceid.upatras.gr [10.1.0.174])
	by poseidon.ceid.upatras.gr (Postfix) with ESMTP id 7008A8038A;
	Thu, 20 Mar 2014 11:32:51 +0200 (EET)
Received: from localhost (ppp089210130219.access.hol.gr [89.210.130.219])
	(Authenticated sender: papanikge)
	by mail.ceid.upatras.gr (Postfix) with ESMTPSA id 18DCD1FF84;
	Thu, 20 Mar 2014 11:32:50 +0200 (EET)
X-Mailer: git-send-email 1.9.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,UNPARSEABLE_RELAY autolearn=no version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mtax.ceid.upatras.gr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244527>

Hi again guys,
I forgot to add the signed-of line to the tiny patch I sent earlier for GSOC.
Any ideas about the changes?
Thanks...

Signed-off-by: George Papanikolaou <g3orge.app@gmail.com>
---
 builtin/apply.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..df2435f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -294,20 +294,16 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 	const char *last2 = s2 + n2 - 1;
 	int result = 0;
 
+	/* early return if both lines are empty */
+	if ((s1 > last1) && (s2 > last2))
+		return 1;
+
 	/* ignore line endings */
 	while ((*last1 == '\r') || (*last1 == '\n'))
 		last1--;
 	while ((*last2 == '\r') || (*last2 == '\n'))
 		last2--;
 
-	/* skip leading whitespace */
-	while (isspace(*s1) && (s1 <= last1))
-		s1++;
-	while (isspace(*s2) && (s2 <= last2))
-		s2++;
-	/* early return if both lines are empty */
-	if ((s1 > last1) && (s2 > last2))
-		return 1;
 	while (!result) {
 		result = *s1++ - *s2++;
 		/*
@@ -315,18 +311,15 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 		 * both buffers because we don't want "a b" to match
 		 * "ab"
 		 */
-		if (isspace(*s1) && isspace(*s2)) {
-			while (isspace(*s1) && s1 <= last1)
-				s1++;
-			while (isspace(*s2) && s2 <= last2)
-				s2++;
-		}
+		while (isspace(*s1) && s1 <= last1)
+			s1++;
+		while (isspace(*s2) && s2 <= last2)
+			s2++;
 		/*
 		 * If we reached the end on one side only,
 		 * lines don't match
 		 */
-		if (
-		    ((s2 > last2) && (s1 <= last1)) ||
+		if (((s2 > last2) && (s1 <= last1)) ||
 		    ((s1 > last1) && (s2 <= last2)))
 			return 0;
 		if ((s1 > last1) && (s2 > last2))
-- 
1.9.0
