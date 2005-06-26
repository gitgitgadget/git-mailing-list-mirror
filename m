From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] git-ssh-pull: commit-id consistency
Date: Sun, 26 Jun 2005 21:45:47 +0200
Message-ID: <20050626214547.A29432@tin.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 21:42:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmd1H-0006D3-8c
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 21:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVFZTsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 15:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVFZTsp
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 15:48:45 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:11920 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261635AbVFZTqi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 15:46:38 -0400
Received: from tin.liacs.nl (tin.liacs.nl [132.229.44.20])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5QJjl8I012807;
	Sun, 26 Jun 2005 21:45:52 +0200
Received: (from sverdool@localhost)
	by tin.liacs.nl (8.11.6/8.9.3) id j5QJjls29493;
	Sun, 26 Jun 2005 21:45:47 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I thought about keeping the check for a leading dot or slash,
but then I figured that you'd get an error from the other
side pretty quickly.

skimo
--
In contrast to other plumbing tools, git-ssh-pu{sh,ll} only
allow a very restrictive form of commit-id filenames.
This patch removes this restriction.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit 00437f1bafcb710bb809cd2e87cdaeae340a67b8
tree 480e77cde9afbd0b0abd33e3f272288739b01a7e
parent 641e1cac73acd67d0b1830dfd7196bca58dffbf2
author Sven Verdoolaege <skimo@kotnet.org> Sun, 26 Jun 2005 19:41:44 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Sun, 26 Jun 2005 19:41:44 +0200

 pull.c     |    7 ++-----
 ssh-push.c |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -152,11 +152,8 @@ static int interpret_target(char *target
 {
 	if (!get_sha1_hex(target, sha1))
 		return 0;
-	if (!check_ref_format(target)) {
-		if (!fetch_ref(target, sha1)) {
-			return 0;
-		}
-	}
+	if (!fetch_ref(target, sha1))
+		return 0;
 	return -1;
 }
 
diff --git a/ssh-push.c b/ssh-push.c
--- a/ssh-push.c
+++ b/ssh-push.c
@@ -74,7 +74,7 @@ int serve_ref(int fd_in, int fd_out)
 			return -1;
 		posn++;
 	} while (ref[posn - 1]);
-	if (get_ref_sha1(ref, sha1))
+	if (get_sha1(ref, sha1))
 		remote = -1;
 	write(fd_out, &remote, 1);
 	if (remote)
