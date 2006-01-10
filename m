From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] GIT-VERSION-GEN: detect dirty tree and mark the version accordingly.
Date: Mon, 09 Jan 2006 18:53:15 -0800
Message-ID: <7vlkxobxpg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 10 03:53:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew9dX-0005wd-B7
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 03:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWAJCxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 21:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAJCxT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 21:53:19 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10454 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750838AbWAJCxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 21:53:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110025225.HBVD15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 21:52:25 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14401>

If we are building from a working tree with local modifications,
mark the version accordingly.

Deliberately uses '-' to prevent RPM from being built from such
a tree.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is a useful precaution and should be safe, so planned to
   go into 1.1.1.

 GIT-VERSION-GEN |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

339b684aa42ac80964ef0d9049445dad7f83848c
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index c878819..cb393b5 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -11,6 +11,14 @@ set)
 	;;
 esac
 
+dirty=$(sh -c 'git-diff-files --name-only HEAD' 2>/dev/null) || dirty=
+case "$dirty" in
+'')
+	;;
+*)
+	VN="$VN-dirty" ;;
+esac
+
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
-- 
1.1.0
