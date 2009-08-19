From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH 5/6] Make diff --ignore-space-at-eol handle incomplete
 lines.
Date: Wed, 19 Aug 2009 18:08:26 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191726280.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <cover.1250719760.git.git@tbfowler.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduH4-0006kl-1Y
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbZHSXIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZHSXIu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:08:50 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:45621 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbZHSXIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 19:08:49 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MduGx-00042w-7q; Wed, 19 Aug 2009 18:08:51 -0500
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126595>

  - When processing with --ignore-space-change a diff would be found
    whenever an incomplete line was encountered.  xdl_recmatch should
    process the full length of the record instead of assuming both
    sides have a terminator.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 xdiff/xutils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index e126de450c99fb1e557c2cfc0ffe54e8e3e80394..a8ed102d528bdb5d8f0839eb392b35dc1c534fba 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -216,7 +216,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 		}
 		return (i1 >= s1 && i2 >= s2);
 	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
+		for (i1 = i2 = 0; i1 <= s1 && i2 <= s2; ) {
 			if (l1[i1] != l2[i2]) {
 				while (i1 < s1 && isspace(l1[i1]))
 					i1++;
-- 
1.6.4.172.g5c0d0.dirty
