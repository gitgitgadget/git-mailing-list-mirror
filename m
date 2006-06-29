From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFH] Racy GIT (part #3)
Date: Thu, 29 Jun 2006 14:50:27 -0700
Message-ID: <7v7j2zpr6k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 23:52:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4R9-0002oV-Iv
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbWF2VvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932908AbWF2Vue
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:50:34 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39842 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932933AbWF2Vu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 17:50:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629215028.OAQN19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 17:50:28 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22914>

Does everybody have "cp -p" to preserve the file timestamps on
his/her platform?  I am assuming this is safe (it is in POSIX),
but please raise hand if that is not a case for you.

-- >8 --
Commit 29e4d3635709778bcc808dbad0477efad82f8d7e fixed the
underlying update-index races but git-commit was not careful
enough to preserve the index file timestamp when copying the
index file.  This caused t3402 test to occasionally fail.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 7e50cf3..22c4ce8 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -29,7 +29,7 @@ THIS_INDEX="$GIT_DIR/index"
 NEXT_INDEX="$GIT_DIR/next-index$$"
 rm -f "$NEXT_INDEX"
 save_index () {
-	cp "$THIS_INDEX" "$NEXT_INDEX"
+	cp -p "$THIS_INDEX" "$NEXT_INDEX"
 }
 
 report () {
-- 
1.4.1.rc2.g3257-dirty
