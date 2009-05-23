From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] t4007: modernize the style
Date: Sat, 23 May 2009 12:24:36 -0700
Message-ID: <1243106678-6343-4-git-send-email-gitster@pobox.com>
References: <1243106678-6343-1-git-send-email-gitster@pobox.com>
 <1243106678-6343-2-git-send-email-gitster@pobox.com>
 <1243106678-6343-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wqk-0002Cd-Im
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbZEWTYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbZEWTYs
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbZEWTYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 873A31914C
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E57141914B for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:45 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106678-6343-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6032A49A-47CF-11DE-A464-B4FDD46C8AFF-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119793>

This is one of the oldest scripts; update it to match more modern style.
Notably, we should:

 - Put the test title on the same line as the "test_expect_success", and
   end the line with a single-quote to begin the body of the test which is
   one multi-line string; and

 - Run as many commands inside test_expect_success, not outside, to catch
   unexpected breakages.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4007-rename-3.sh |   69 +++++++++++++++++++++++---------------------------
 1 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index 42072d7..25e7a83 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -9,32 +9,31 @@ test_description='Rename interaction with pathspec.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    'prepare reference tree' \
-    'mkdir path0 path1 &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
-     git update-index --add path0/COPYING &&
-    tree=$(git write-tree) &&
-    echo $tree'
-
-test_expect_success \
-    'prepare work tree' \
-    'cp path0/COPYING path1/COPYING &&
-     git update-index --add --remove path0/COPYING path1/COPYING'
+test_expect_success 'prepare reference tree' '
+	mkdir path0 path1 &&
+	cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+	git update-index --add path0/COPYING &&
+	tree=$(git write-tree) &&
+	echo $tree
+'
+
+test_expect_success 'prepare work tree' '
+	cp path0/COPYING path1/COPYING &&
+	git update-index --add --remove path0/COPYING path1/COPYING
+'
 
 # In the tree, there is only path0/COPYING.  In the cache, path0 and
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
 # Comparing the full tree with cache should tell us so.
 
-git diff-index -C --find-copies-harder $tree >current
-
 cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
 EOF
 
-test_expect_success \
-    'validate the result (#1)' \
-    'compare_diff_raw current expected'
+test_expect_success 'copy detection' '
+	git diff-index -C --find-copies-harder $tree >current &&
+	compare_diff_raw current expected
+'
 
 # In the tree, there is only path0/COPYING.  In the cache, path0 and
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
@@ -42,49 +41,45 @@ test_expect_success \
 # path1/COPYING suddenly appearing from nowhere, not detected as
 # a copy from path0/COPYING.
 
-git diff-index -C $tree path1 >current
-
 cat >expected <<\EOF
 :000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	path1/COPYING
 EOF
 
-test_expect_success \
-    'validate the result (#2)' \
-    'compare_diff_raw current expected'
-
-test_expect_success \
-    'tweak work tree' \
-    'rm -f path0/COPYING &&
-     git update-index --remove path0/COPYING'
+test_expect_success 'copy, limited to a subtree' '
+	git diff-index -C --find-copies-harder $tree path1 >current &&
+	compare_diff_raw current expected
+'
 
+test_expect_success 'tweak work tree' '
+	rm -f path0/COPYING &&
+	git update-index --remove path0/COPYING
+'
 # In the tree, there is only path0/COPYING.  In the cache, path0 does
 # not have COPYING anymore and path1 has COPYING which is a copy of
 # path0/COPYING.  Showing the full tree with cache should tell us about
 # the rename.
 
-git diff-index -C $tree >current
-
 cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
 EOF
 
-test_expect_success \
-    'validate the result (#3)' \
-    'compare_diff_raw current expected'
+test_expect_success 'rename detection' '
+	git diff-index -C --find-copies-harder $tree >current &&
+	compare_diff_raw current expected
+'
 
 # In the tree, there is only path0/COPYING.  In the cache, path0 does
 # not have COPYING anymore and path1 has COPYING which is a copy of
 # path0/COPYING.  When we say we care only about path1, we should just
 # see path1/COPYING appearing from nowhere.
 
-git diff-index -C $tree path1 >current
-
 cat >expected <<\EOF
 :000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	path1/COPYING
 EOF
 
-test_expect_success \
-    'validate the result (#4)' \
-    'compare_diff_raw current expected'
+test_expect_success 'rename, limited to a subtree' '
+	git diff-index -C --find-copies-harder $tree path1 >current &&
+	compare_diff_raw current expected
+'
 
 test_done
-- 
1.6.3.1.145.gb74d77
