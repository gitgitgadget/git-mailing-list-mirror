From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Tests: read-tree -m test updates.
Date: Wed, 08 Jun 2005 02:08:54 -0700
Message-ID: <7vwtp5b4gp.fsf_-_@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
	<7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
	<20050606054356.GB3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
	<20050606064456.GC3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org>
	<7vekbgufra.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506060730510.1876@ppc970.osdl.org>
	<7vy89ns354.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506061312520.1876@ppc970.osdl.org>
	<Pine.LNX.4.58.0506061403170.1876@ppc970.osdl.org>
	<7vekbfnot9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506061453400.1876@ppc970.osdl.org>
	<7vy89mlmsv.fsf_-_@assigned-by-dhcp.cox.net>
	<7vis0qk2jo.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506070808180.2286@ppc970.osdl.o
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 11:06:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfwV1-0002ZL-3c
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 11:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVFHJJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 05:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVFHJJI
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 05:09:08 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26586 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262147AbVFHJIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 05:08:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050608090855.MHWE26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 05:08:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v7jh5ct1b.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 07 Jun 2005 22:32:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This updates t1000 (basic 3-way merge test) to check the merge
results for both successful cases (earlier one checked the
result for only one of them).  Also fixes typos in t1002 that
broke '&&' chain, potentially missing a test failure before the
chain got broken.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/t1000-read-tree-m-3way.sh   |   58 ++++++++++++++++++++---------------------
 t/t1002-read-tree-m-u-2way.sh |    4 +--
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -77,34 +77,6 @@ In addition:
 ################################################################
 # Try merging and showing the various diffs
 
-# The tree is dirty at this point.
-test_expect_failure \
-    '3-way merge with git-read-tree -m' \
-    "git-read-tree -m $tree_O $tree_A $tree_B"
-
-# This is done on an empty work directory, which is the normal
-# merge person behaviour.
-test_expect_success \
-    '3-way merge with git-read-tree -m' \
-    "rm -fr [NDMALTS][NDMALTSF] Z &&
-     rm .git/index &&
-     git-read-tree -m $tree_O $tree_A $tree_B"
-
-# This starts out with the first head, which is the normal
-# patch submitter behaviour.
-test_expect_success \
-    '3-way merge with git-read-tree -m' \
-    "git-read-tree $tree_A &&
-     git-checkout-cache -f -u -a &&
-     git-read-tree -m $tree_O $tree_A $tree_B"
-
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-test_expect_success \
-    'git-ls-files --stage of the merge result' \
-    'git-ls-files --stage >current- &&
-     sed -e "s/ $_x40 / X /" <current- >current'
-
 cat >expected <<\EOF
 100644 X 2	AA
 100644 X 3	AA
@@ -154,8 +126,34 @@ cat >expected <<\EOF
 100644 X 0	Z/NN
 EOF
 
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
+# The tree is dirty at this point.
+test_expect_failure \
+    '3-way merge with git-read-tree -m, dirty cache' \
+    "git-read-tree -m $tree_O $tree_A $tree_B"
+
+# This is done on an empty work directory, which is the normal
+# merge person behaviour.
+test_expect_success \
+    '3-way merge with git-read-tree -m, empty cache' \
+    "rm -fr [NDMALTS][NDMALTSF] Z &&
+     rm .git/index &&
+     git-read-tree -m $tree_O $tree_A $tree_B &&
+     git-ls-files --stage |
+     sed -e 's/ $_x40 / X /' >current &&
+     diff -u expected current"
+
+# This starts out with the first head, which is the normal
+# patch submitter behaviour.
 test_expect_success \
-    'validate merge result' \
-    'diff current expected'
+    '3-way merge with git-read-tree -m, match H' \
+    "git-read-tree $tree_A &&
+     git-checkout-cache -f -u -a &&
+     git-read-tree -m $tree_O $tree_A $tree_B &&
+     git-ls-files --stage |
+     sed -e 's/ $_x40 / X /' >current &&
+     diff -u expected current"
 
 test_done
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -93,7 +93,7 @@ test_expect_success \
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
      sha1sum -c M.sha1 &&
-     : dirty index should have prevented -u from checking it out.
+     : dirty index should have prevented -u from checking it out. &&
      echo yomin yomin >yomin1 &&
      diff yomin yomin1 &&
      rm -f yomin1'
@@ -122,7 +122,7 @@ test_expect_success \
      diff --unified=0 M.out 7.out &&
      check_cache_at frotz dirty &&
      if sha1sum -c M.sha1; then false; else :; fi &&
-     : dirty index should have prevented -u from checking it out.
+     : dirty index should have prevented -u from checking it out. &&
      echo frotz frotz >frotz1 &&
      diff frotz frotz1 &&
      rm -f frotz1'
------------

