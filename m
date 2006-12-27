From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach git-gc to only repack local (not borrowed) objects.
Date: Wed, 27 Dec 2006 18:47:54 -0500
Message-ID: <20061227234753.GA16389@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 00:48:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GziV7-0000B6-Gd
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 00:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWL0Xr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 18:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWL0Xr6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 18:47:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33415 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbWL0Xr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 18:47:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GziUz-0005HK-Pu; Wed, 27 Dec 2006 18:47:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3399920FB65; Wed, 27 Dec 2006 18:47:54 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35486>

This feature was suggested by Martin Waitz on the git mailing list
and is actually the correct thing to do.  If the current repository
is borrowing objects from repository then this repository is not
usually considered to be maintaining the objects which are available
through that other repository's object database.  We really should
only repack objects which are stored directly in this repository,
so supply -l to git-repack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gc.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gc.sh b/git-gc.sh
index e55ed19..6de55f7 100755
--- a/git-gc.sh
+++ b/git-gc.sh
@@ -10,6 +10,6 @@ SUBDIRECTORY_OK=Yes
 
 git-pack-refs --prune &&
 git-reflog expire --all &&
-git-repack -a -d &&
+git-repack -a -d -l &&
 git-prune &&
 git-rerere gc || exit
-- 
1.4.4.3.gd2e4
