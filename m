From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make tests more portable
Date: Wed, 25 May 2005 17:07:33 -0700
Message-ID: <7vsm0ahmt6.fsf@assigned-by-dhcp.cox.net>
References: <20050525045229.29706.qmail@web41205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Allen <mrallen1@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 02:06:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db5t6-0001vc-Dy
	for gcvg-git@gmane.org; Thu, 26 May 2005 02:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVEZAHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVEZAHp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 20:07:45 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21200 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261620AbVEZAHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 20:07:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526000733.UXBR550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 20:07:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050525045229.29706.qmail@web41205.mail.yahoo.com> (Mark
 Allen's message of "Tue, 24 May 2005 21:52:28 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is the remainder of testcase fix by Mark Allen to make them
work on his Darwin box.  I was using "xargs -r" (GNU) where it
was not needed, sed -ne '/^\(author\|committer\)/s|>.*|>|p'
where his sed does not know what to do with '\|', and "cmp -
file" to compare standard input with a file, which his cmp does
not support.

Another problem his patch fixed has been merged in the tip of
your git.git already.

Author: Mark Allen <mrallen1@yahoo.com>
Author-Date: Tue, 24 May 2005 21:52:28 -0700
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

