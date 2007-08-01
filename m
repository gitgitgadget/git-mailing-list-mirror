From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix rebase interactive to allow specifying branch to rebase along with the base
Date: Thu, 2 Aug 2007 00:32:41 +0200
Message-ID: <20070801223241.GB2911@steel.home>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site> <20070712222640.GA30532@steel.home> <Pine.LNX.4.64.0708011654510.14781@racer.site> <20070801214556.GA2911@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 00:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMkO-0006uk-1E
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbXHAWcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbXHAWcs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:32:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:39491 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbXHAWcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:32:47 -0400
Received: from tigra.home (Fae16.f.strato-dslnet.de [195.4.174.22])
	by post.webmailer.de (fruni mo12) (RZmta 10.3)
	with ESMTP id N01b00j71LsD3I ; Thu, 2 Aug 2007 00:32:41 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 72EF3277BD;
	Thu,  2 Aug 2007 00:32:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5849CC21D; Thu,  2 Aug 2007 00:32:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070801214556.GA2911@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3urCQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54490>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Alex Riesen, Wed, Aug 01, 2007 23:45:56 +0200:
>     $ git rebase -i base branch
>     /usr/local/bin/git-rebase--interactive: 482: cannot create /home/user/projects/tmp/.git/.dotest-merge/output: Directory nonexistent
>     cat: /home/user/projects/tmp/.git/.dotest-merge/output: No such file or directory
>     Invalid branchname: branch

Oh... Sometimes I can *very* slow. I believe it is as simple as that

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 061cd0a..b42dee8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -404,6 +404,7 @@ do
 		esac
 
 		require_clean_work_tree
+		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 
 		if test ! -z "$2"
 		then
@@ -418,7 +419,6 @@ do
 
 		test -z "$ONTO" && ONTO=$UPSTREAM
 
-		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 		: > "$DOTEST"/interactive || die "Could not mark as interactive"
 		git symbolic-ref HEAD > "$DOTEST"/head-name ||
 			die "Could not get HEAD"
-- 
1.5.3.rc3.123.ge9877
