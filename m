From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH 3/6] Make diff -w handle trailing-spaces on incomplete
 lines.
Date: Wed, 19 Aug 2009 18:07:18 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191725440.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <cover.1250719760.git.git@tbfowler.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:07:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduFw-0006LI-Vx
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbZHSXHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZHSXHl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:07:41 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:44776 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbZHSXHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 19:07:40 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MduFq-0002xI-9V; Wed, 19 Aug 2009 18:07:42 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <cover.1250719760.git.git@tbfowler.name>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126592>

  - When processing trailing spaces with --ignore-all-space a diff
    would be found whenever one side had 0 spaces and either (or both)
    sides was an incomplete line.  xdl_recmatch should process the
    full length of the record instead of assuming both sides have a
    terminator.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 xdiff/xutils.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index c6512a53b08a8c9039614738310aa2786f4fbb1c..1f28f4fb4e0a8fdc6c9aa1904cf0362dd1e7b977 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -191,14 +191,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	int i1, i2;
 
 	if (flags & XDF_IGNORE_WHITESPACE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
+		for (i1 = i2 = 0; i1 <= s1 && i2 <= s2; ) {
 			if (isspace(l1[i1]))
-				while (isspace(l1[i1]) && i1 < s1)
+				while (isspace(l1[i1]) && i1 <= s1)
 					i1++;
 			if (isspace(l2[i2]))
-				while (isspace(l2[i2]) && i2 < s2)
+				while (isspace(l2[i2]) && i2 <= s2)
 					i2++;
-			if (i1 < s1 && i2 < s2 && l1[i1++] != l2[i2++])
+			if (i1 <= s1 && i2 <= s2 && l1[i1++] != l2[i2++])
 				return 0;
 		}
 		return (i1 >= s1 && i2 >= s2);
-- 
1.6.4.172.g5c0d0.dirty
