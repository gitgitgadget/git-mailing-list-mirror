From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH-v2/RFC 5/6] xutils: fix ignore-space-at-eol on incomplete line
Date: Sat, 22 Aug 2009 22:49:16 -0500
Message-ID: <1250999357-10827-5-git-send-email-git@tbfowler.name>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
Cc: Johannes.Schindelin@gmx.de, Thell Fowler <git@tbfowler.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 05:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf45z-0006Jw-C3
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 05:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470AbZHWDtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 23:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933456AbZHWDts
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 23:49:48 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:43341 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933467AbZHWDtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 23:49:45 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=localhost.localdomain)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mf45T-0004jt-Lk; Sat, 22 Aug 2009 22:49:47 -0500
X-Mailer: git-send-email 1.6.4.176.g556a4
In-Reply-To: <1250999285-10683-1-git-send-email-git@tbfowler.name>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126836>

  - Allow xdl_recmatch to process to the eof.

  Resolves issue with --ignore-space-at-eol processing where an
  incomplete line terminated processing early before a final check
  could be done on the other side.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 xdiff/xutils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 54bb235..3e26488 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -229,7 +229,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 		}
 		return (i1 >= s1 && i2 >= s2);
 	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
+		for (i1 = i2 = 0; i1 <= s1 && i2 <= s2; ) {
 			if (l1[i1] != l2[i2]) {
 				while (i1 < s1 && isspace(l1[i1]))
 					i1++;
-- 
1.6.4.176.g556a4
