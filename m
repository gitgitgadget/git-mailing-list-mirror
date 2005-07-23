From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/9] Cleanup: git-verify-tag-script
Date: Fri, 22 Jul 2005 17:29:50 -0700
Message-ID: <7vfyu6bc01.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 02:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7vQ-0000I7-Jz
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 02:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVGWAbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 20:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVGWAbD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 20:31:03 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:27383 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262249AbVGWA3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 20:29:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723002952.IFES7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 20:29:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>
Date: 1121545120 -0600

- Use git-rev-parse to allow sha1 tags references
- When the tag does not verify set an appropriate exit status
- Use git-sh-setup-script to verify the .git directory

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-verify-tag-script |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

c83d38d1dc23f205bb8758fe695b0b4b47601b2e
diff --git a/git-verify-tag-script b/git-verify-tag-script
--- a/git-verify-tag-script
+++ b/git-verify-tag-script
@@ -1,9 +1,8 @@
 #!/bin/sh
-GIT_DIR=${GIT_DIR:-.git}
+. git-sh-setup-script || die "Not a git archive"
 
-tag=$1
-[ -f "$GIT_DIR/refs/tags/$tag" ] && tag=$(cat "$GIT_DIR/refs/tags/$tag")
+tag=$(git-rev-parse $1) || exit 1
 
 git-cat-file tag $tag > .tmp-vtag || exit 1
-cat .tmp-vtag | sed '/-----BEGIN PGP/Q' | gpg --verify .tmp-vtag -
+cat .tmp-vtag | sed '/-----BEGIN PGP/Q' | gpg --verify .tmp-vtag - || exit 1
 rm -f .tmp-vtag
