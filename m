From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Adjust to git-init-db creating $GIT_OBJECT_DIRECTORY/pack
Date: Mon, 27 Jun 2005 19:37:12 -0700
Message-ID: <7vmzpbyzon.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<7vwtofi6jk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
	<7vslz3yzwf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 04:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn5sN-0001Pz-4u
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 04:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVF1Chr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 22:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVF1Chr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 22:37:47 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63900 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262377AbVF1ChR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 22:37:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628023713.HSQD17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Jun 2005 22:37:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vslz3yzwf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 27 Jun 2005 19:32:32 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some tests expected the directory not to exist by default.
Updated git-init-db prepares it properly so adjust tests to
match that behaviour.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/t0000-basic.sh       |    6 +++---
 t/t5300-pack-object.sh |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

de500ab0379e4db18d1511cbe91ace106eee7830
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -28,11 +28,11 @@ test_expect_success \
     '.git/objects should be empty after git-init-db in an empty repo.' \
     'cmp -s /dev/null should-be-empty' 
 
-# also it should have 256 subdirectories.  257 is counting "objects"
+# also it should have 257 subdirectories.  258 is counting "objects"
 find .git/objects -type d -print >full-of-directories
 test_expect_success \
-    '.git/objects should have 256 subdirectories.' \
-    'test $(wc -l < full-of-directories) = 257'
+    '.git/objects should have 257 subdirectories.' \
+    'test $(wc -l < full-of-directories) = 258'
 
 ################################################################
 # Basics of the basics
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -99,7 +99,6 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     mkdir .git2/objects/pack &&
      cp test-1.pack test-1.idx .git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
------------
