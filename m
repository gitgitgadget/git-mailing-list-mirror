From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/7] Determine the start of the states outside of the pass loop
Date: Fri, 12 Aug 2011 23:43:08 +0200
Message-ID: <1313185390-19724-6-git-send-email-mhagger@alum.mit.edu>
References: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzWQ-0008JO-4s
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab1HLVoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:44:02 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40864 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab1HLVoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:44:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CLhCvK007606;
	Fri, 12 Aug 2011 23:43:52 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179253>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index f23f62a..a7d1aa9 100644
--- a/attr.c
+++ b/attr.c
@@ -192,7 +192,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 {
 	int namelen;
 	int num_attr;
-	const char *cp, *name;
+	const char *cp, *name, *states;
 	struct match_attr *res = NULL;
 	int pass;
 	int is_macro;
@@ -223,11 +223,13 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	else
 		is_macro = 0;
 
+	states = name + namelen;
+	states += strspn(states, blank);
+
 	for (pass = 0; pass < 2; pass++) {
 		/* pass 0 counts and allocates, pass 1 fills */
 		num_attr = 0;
-		cp = name + namelen;
-		cp = cp + strspn(cp, blank);
+		cp = states;
 		while (*cp) {
 			cp = parse_attr(src, lineno, cp,
 				pass ? &(res->state[num_attr]) : NULL);
-- 
1.7.6.8.gd2879
