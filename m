From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix "git-diff-script A B"
Date: Mon, 22 Aug 2005 18:07:28 -0700
Message-ID: <7vzmr9zcj3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 23 03:09:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7NGH-0006jz-3l
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 03:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVHWBHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVHWBHa
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 21:07:30 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42984 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751309AbVHWBHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 21:07:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823010728.EACN550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 Aug 2005 21:07:28 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When "git-diff-script A..B" notation was introduced, it ended up breaking
the traditional two revisions notation.

[jc: there are other issues with the current "git diff" I would like to
 address, but they would be left to later rounds.  For example, -M and -p flags
 should not be hardcoded default, and it shouldn't be too hard to rewrite
 the script without using shell arrays.]

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-diff-script |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

30e852431bd6b6f8395646749c5baa8cfca88b51
diff --git a/git-diff-script b/git-diff-script
--- a/git-diff-script
+++ b/git-diff-script
@@ -8,8 +8,14 @@ case "${#rev[*]}" in
 1)
 	git-diff-cache -M -p "$@";;
 2)
-	begin=$(echo "${rev[1]}" | tr -d '^')
-	end="${rev[0]}"
+	case "${rev[1]}" in
+	^?*)
+		begin=$(echo "${rev[1]}" | tr -d '^')
+		end="${rev[0]}" ;;
+	*)
+		begin="${rev[0]}"
+		end="${rev[1]}"	;;
+	esac
 	git-diff-tree -M -p $flags $begin $end $files;;
 *)
 	echo "I don't understand"
