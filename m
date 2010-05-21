From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 5/7] Add support for case insensitive directory and file lookups to git log
Date: Thu, 20 May 2010 22:50:33 -0600
Message-ID: <1274417435-2344-6-git-send-email-jjensen@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:50:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCE-0007X7-Bm
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab0EUEuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:50:51 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39245 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab0EUEut (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:49 -0400
Received: (qmail 28926 invoked by uid 399); 20 May 2010 22:50:49 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE
	autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:48 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAMMMMMM; 20 May 2010 22:50:48 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147432>

This patch also affects any other commands that use tree-diff.c.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
---
 tree-diff.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index fe9f52c..5110980 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "dir.h"
 
 static char *malloc_base(const char *base, int baselen, const char *path, int pathlen)
 {
@@ -114,7 +115,7 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 
 		if (baselen >= matchlen) {
 			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
+			if (strncmp_icase(base, match, matchlen))
 				continue;
 
 			/*
@@ -131,7 +132,7 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 		}
 
 		/* Does the base match? */
-		if (strncmp(base, match, baselen))
+		if (strncmp_icase(base, match, baselen))
 			continue;
 
 		match += baselen;
@@ -147,7 +148,7 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 			 * Does match sort strictly earlier than path
 			 * with their common parts?
 			 */
-			m = strncmp(match, path,
+			m = strncmp_icase(match, path,
 				    (matchlen < pathlen) ? matchlen : pathlen);
 			if (m < 0)
 				continue;
@@ -183,7 +184,7 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 			 * we cheated and did not do strncmp(), so we do
 			 * that here.
 			 */
-			m = strncmp(match, path, pathlen);
+			m = strncmp_icase(match, path, pathlen);
 
 		/*
 		 * If common part matched earlier then it is a hit,
-- 
1.7.1.1930.gca7dd4
