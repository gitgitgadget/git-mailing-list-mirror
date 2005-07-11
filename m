From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/6] git-gnu-progs: parameterize git
Date: Mon, 11 Jul 2005 06:14:38 -0400
Message-ID: <20050711101428.10318.90621.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 12:15:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrvJO-0008Ue-LH
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 12:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVGKKOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGKKOp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 06:14:45 -0400
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:18565 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261584AbVGKKOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 06:14:38 -0400
Received: (qmail 19961 invoked from network); 11 Jul 2005 10:14:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=RvcW1GKLR6UhCTcxvm4ElvDOrtM75MsUyq8fz8kMyorThpuvey7UqAlqu8BgUi4AETRgmALNNYnoFOwb0YZXVXPahDZ7cK2dLRpikl+gjHoD1wU7QVxPjHzo3tphQr8+BeB9zwXXv6rl8cRqDj2oP8jv2opuhhz6iCT7dqdMh88=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp111.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 10:14:37 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Patch git so that the utilities 'cp' 'stat' 'xargs' and 'date' are configurable.  Git requires the gnu versions of these tools, and on some BSD derived systems, the gnu versions of these tools have a different name.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 git-clone-script |    4 +++-
 git-prune-script |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -5,6 +5,8 @@
 # 
 # Clone a repository into a different directory that does not yet exist.
 
+CP=cp
+
 usage() {
 	echo >&2 "* git clone [-l] <repo> <dir>"
 	exit 1
@@ -68,7 +70,7 @@ yes,yes)
 		l=l
 	fi &&
 	rm -f "$D/.git/objects/sample" &&
-	cp -r$l "$repo/objects" "$D/.git/" || exit 1
+	${CP} -r$l "$repo/objects" "$D/.git/" || exit 1
 
 	# Make a duplicate of refs and HEAD pointer
 	HEAD=
diff --git a/git-prune-script b/git-prune-script
--- a/git-prune-script
+++ b/git-prune-script
@@ -1,5 +1,7 @@
 #!/bin/sh
 
+XARGS=xargs
+
 . git-sh-setup-script || die "Not a git archive"
 
 dryrun=
@@ -20,6 +22,6 @@ sed -ne '/unreachable /{
     s|\(..\)|\1/|p
 }' | {
 	cd "$GIT_OBJECT_DIRECTORY" || exit
-	xargs -r $dryrun rm -f
+	${XARGS} -r $dryrun rm -f
 }
 
