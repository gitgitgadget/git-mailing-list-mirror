From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make "git pull" and "git fetch" default to origin
Date: Sat, 20 Aug 2005 11:25:30 -0700
Message-ID: <7v64u0mpnp.fsf@assigned-by-dhcp.cox.net>
References: <7vvf20o4sp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 20 20:26:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Y2B-0003tv-R7
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 20:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVHTSZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 14:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVHTSZd
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 14:25:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:4595 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932671AbVHTSZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 14:25:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820182531.FGOD1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 14:25:31 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Amos Waterland sent in a patch for the pre-multi-head aware
version of "git pull" to do this, but the code changed quite a
bit since then.  If there is no argument given to pull from, and
if "origin" makes sense, default to fetch/pull from "origin"
instead of barfing.

[jc: besides, the patch by Amos broke the non-default case where
explicit refspecs are specified, and did not make sure we know
what "origin" means before defaulting to it.]

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-fetch-script |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

6d8fcdbf772f4fc4ec7ae67630b52bc8a07d7b6d
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -8,7 +8,10 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x4
 append=
 case "$#" in
 0)
-	die "Where do you want to fetch from?" ;;
+	test -f "$GIT_DIR/branches/origin" ||
+		test -f "$GIT_DIR/remotes/origin" ||
+			die "Where do you want to fetch from?"
+	set origin ;;
 *)
 	case "$1" in
 	-a|--a|--ap|--app|--appe|--appen|--append)
