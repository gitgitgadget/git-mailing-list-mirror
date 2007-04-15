From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct dir.c to compile on Solaris 9
Date: Sun, 15 Apr 2007 00:33:28 -0400
Message-ID: <20070415043328.GA17285@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 06:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcwQg-0001zV-Hz
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 06:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXDOEdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 00:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbXDOEdb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 00:33:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49919 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbXDOEdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 00:33:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HcwQc-0004ld-6G; Sun, 15 Apr 2007 00:33:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 63A0A20FBAE; Sun, 15 Apr 2007 00:33:28 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44487>

The compiler on my Solaris 9 system doesn't understand
the array initialization syntax used here in dir.c.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 dir.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 7426fde..038fd82 100644
--- a/dir.c
+++ b/dir.c
@@ -423,18 +423,17 @@ static int cmp_name(const void *p1, const void *p2)
  */
 static int simple_length(const char *match)
 {
-	const char special[256] = {
-		[0] = 1, ['?'] = 1,
-		['\\'] = 1, ['*'] = 1,
-		['['] = 1
-	};
 	int len = -1;
 
 	for (;;) {
 		unsigned char c = *match++;
 		len++;
-		if (special[c])
+		switch (c) {
+		case 0: case '?':
+		case '\\': case '*':
+		case '[':
 			return len;
+		}
 	}
 }
 
-- 
1.5.1.1.83.g2bfe3
