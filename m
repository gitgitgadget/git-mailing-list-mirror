From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Cleanup prepare_packed_git_one to reuse install_packed_git.
Date: Thu, 1 Feb 2007 15:52:22 -0500
Message-ID: <20070201205222.GA19009@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:52:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCiv0-0000Pg-Ar
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422942AbXBAUw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbXBAUw1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:52:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43553 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422942AbXBAUw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:52:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCiun-0005Jk-0v; Thu, 01 Feb 2007 15:52:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1226920FBAE; Thu,  1 Feb 2007 15:52:23 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38397>

There is little point in having the linked list insertion code
appearing in install_packed_git, and then again just 30 lines
further down in the same file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 498665e..a42f94a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -790,8 +790,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		p = add_packed_git(path, len + namelen, local);
 		if (!p)
 			continue;
-		p->next = packed_git;
-		packed_git = p;
+		install_packed_git(p);
 	}
 	closedir(dir);
 }
-- 
1.5.0.rc3.1.ge4b0e
