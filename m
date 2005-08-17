From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-commit: pass explicit path to git-diff-files.
Date: Tue, 16 Aug 2005 22:34:44 -0700
Message-ID: <7vu0hp2kjv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 17 07:35:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5GZk-0005cW-Gs
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 07:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVHQFer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 01:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVHQFer
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 01:34:47 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4017 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750862AbVHQFeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 01:34:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817053444.IFSG7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 01:34:44 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When running "git commit" with explicit path arguments, allow it to
take directory name.  This makes "git commit Documentation/" to commit
everything that is changed under Documentation/ directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-commit-script |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

cf2997f54cd650443368374dc0c5bcceab5b481c
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -88,9 +88,14 @@ esac
 case "$all" in
 t)
 	git-diff-files --name-only -z |
-	xargs -0 git-update-cache -q -- || exit 1 ;;
-esac
-git-update-cache -q --refresh -- "$@" || exit 1
+	xargs -0 git-update-cache -q --
+	;;
+*)
+	git-diff-files --name-only -z "$@" |
+	xargs -0 git-update-cache -q --
+	;;
+esac || exit 1
+git-update-cache -q --refresh || exit 1
 
 case "$verify" in
 t)
