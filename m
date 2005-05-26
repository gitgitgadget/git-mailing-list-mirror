From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Test case portability fix.
Date: Wed, 25 May 2005 19:11:31 -0700
Message-ID: <7vr7fug2i4.fsf@assigned-by-dhcp.cox.net>
References: <20050525111711.GA27492@vrfy.org>
	<Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
	<20050525183546.GA4241@vrfy.org>
	<7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
	<20050525222622.GA8552@vrfy.org>
	<Pine.LNX.4.58.0505251544250.2307@ppc970.osdl.org>
	<7v1x7uj4i3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 04:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db7ok-00052B-9B
	for gcvg-git@gmane.org; Thu, 26 May 2005 04:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVEZCLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 22:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVEZCLh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 22:11:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45811 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261405AbVEZCLe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 22:11:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526021131.YFLB12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 22:11:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is the remainder of testcase fix by Mark Allen to make them
work on his Darwin box.  I was using "xargs -r" (GNU) where it
was not needed, sed -ne '/^\(author\|committer\)/s|>.*|>|p'
where some sed does not know what to do with '\|', and also
"cmp - file" to compare standard input with a file, which his
cmp does not support.

Author: Mark Allen <mrallen1@yahoo.com>
Author-Date: 
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

t/t0000-basic.sh                 |    2 +-
t/t0110-environment-names-old.sh |    6 ++----
2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -84,7 +84,7 @@ do
 done
 test_expect_success \
     'adding various types of objects with git-update-cache --add.' \
-    'find path* ! -type d -print0 | xargs -0 -r git-update-cache --add'
+    'find path* ! -type d -print0 | xargs -0 git-update-cache --add'
 
 # Show them and see that matches what we expect.
 test_expect_success \
diff --git a/t/t0110-environment-names-old.sh b/t/t0110-environment-names-old.sh
--- a/t/t0110-environment-names-old.sh
+++ b/t/t0110-environment-names-old.sh
@@ -86,8 +86,7 @@ committer A U Thor <author@example.xz>
 EOF
 test_expect_success \
     'verify old AUTHOR variables were used correctly in commit' \
-    'sed -ne '\''/^\(author\|committer\)/s|>.*|>|p'\'' current |
-     cmp - expected'
+    'sed -ne '\''/^\(author\)/s|>.*|>|p'\'' -e'\''/^\(committer\)/s|>.*|>|p'\''\    current > out && cmp out expected'
 
 unset GIT_DIR
 test_expect_success \
@@ -128,7 +127,6 @@ committer R O Htua <rohtua@example.xz>
 EOF
 test_expect_success \
     'verify new AUTHOR variables were used correctly in commit.' \
-    'sed -ne '\''/^\(author\|committer\)/s|>.*|>|p'\'' current |
-     cmp - expected'
+    'sed -ne '\''/^\(author\)/s|>.*|>|p'\'' -e'\''/^\(committer\)/s|>.*|>|p'\''\    current > out && cmp out expected'
 
 test_done
------------------------------------------------

