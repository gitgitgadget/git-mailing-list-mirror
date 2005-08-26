From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Define a shell function to check tree cleanness.
Date: Fri, 26 Aug 2005 01:03:40 -0700
Message-ID: <7vhdddgm5f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 26 10:32:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8ZBh-0002SI-3c
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 10:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVHZIDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 04:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVHZIDm
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 04:03:42 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20194 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964963AbVHZIDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 04:03:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826080340.HDVC7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 04:03:40 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7780>

This would be used in places where we require a clean tree, such
as reverting and rebasing.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-sh-setup-script |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

1de6046ded332e2278320be314f7a5e31a431e14
diff --git a/git-sh-setup-script b/git-sh-setup-script
--- a/git-sh-setup-script
+++ b/git-sh-setup-script
@@ -11,6 +11,17 @@ die() {
 	exit 1
 }
 
+check_clean_tree() {
+    dirty1_=`git-update-cache -q --refresh` && {
+    dirty2_=`git-diff-cache --name-only --cached HEAD`
+    case "$dirty2_" in '') : ;; *) (exit 1) ;; esac
+    } || {
+	echo >&2 "$dirty1_"
+	echo "$dirty2_" | sed >&2 -e 's/^/modified: /'
+	(exit 1)
+    }
+}
+
 [ -d "$GIT_DIR" ] &&
 [ -d "$GIT_DIR/refs" ] &&
 [ -d "$GIT_OBJECT_DIRECTORY" ] &&
