From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] Allow file removal when "git commit --all" is used.
Date: Thu, 18 Aug 2005 00:59:37 -0700
Message-ID: <7v64u3k74m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 18 10:05:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5fJN-0002Mr-MD
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 09:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVHRH7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 03:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVHRH7j
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 03:59:39 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3829 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932128AbVHRH7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 03:59:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050818075937.GDPA7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 03:59:37 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After you deleted files from your working tree, automatic
git-update-cache used when the "--all" flag is given to "git
commit" barfs because it lacks the --remove flag.

It can be argued that this is a feature; people should be
careful and something with a grave consequence like removing
files should be done manually, in which case the current
behaviour may be OK.

The patch is for people who thinks the user who uses the "--all"
flag deserves the danger that comes with the convenience.

Comments?

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -88,13 +88,13 @@ esac
 case "$all,$#" in
 t,*)
 	git-diff-files --name-only -z |
-	xargs -0 git-update-cache -q --
+	xargs -0 git-update-cache -q --remove --
 	;;
 ,0)
 	;;
 *)
 	git-diff-files --name-only -z "$@" |
-	xargs -0 git-update-cache -q --
+	xargs -0 git-update-cache -q --remove --
 	;;
 esac || exit 1
 git-update-cache -q --refresh || exit 1
