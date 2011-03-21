From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 07/10] Good testcases
Date: Mon, 21 Mar 2011 12:31:01 -0600
Message-ID: <1300732264-9638-8-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmm-0000RW-Dz
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab1CUSY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:56 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CUSYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:52 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so5223921vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=lkatfAWfIP5Y+POOAtQLOHixwxq2qx82IK9a15K1OGo=;
        b=rl+ZdglvWWj+tWbIHRK/4Yr9xUXYpU0GKTjrobCWQLExy2Uec+1K0U5oFYFZpTs6MX
         q3H7KinhKyWFI8HosrFbneS3NQk5eMWbg/yxCpugelklMOCUyk3kf3j4KD6JIhGPHnSs
         /kxH0mScq8sJ32z2etR5vfvxJXeYzVqJobhNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wWsrk9T3Qx1kH+VLNeREEiuaDvzZjcayHSs7KJufXXnRdran02D0bIalv4p69f5KaT
         58c6qx8QYPrPxilQXPxK++iv3qOUPu796BkwpSAlWgKskqr+7PWY1+cuzT6mEg0uWmJ+
         9CSkxFyjIwUsYb/JHZ1Ebtx5GZMNX85HEOki0=
Received: by 10.220.117.67 with SMTP id p3mr1275689vcq.89.1300731891650;
        Mon, 21 Mar 2011 11:24:51 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.49
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169633>

---
 t/temp1.sh |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/temp2.sh |   86 +++++++++++++++++++++++++++++++++++
 t/temp3.sh |   72 +++++++++++++++++++++++++++++
 t/temp4.sh |   96 +++++++++++++++++++++++++++++++++++++++
 t/temp5.sh |   35 ++++++++++++++
 t/temp6.sh |   55 ++++++++++++++++++++++
 t/temp7.sh |   34 ++++++++++++++
 t/temp8.sh |   37 +++++++++++++++
 8 files changed, 561 insertions(+), 0 deletions(-)
 create mode 100644 t/temp1.sh
 create mode 100755 t/temp2.sh
 create mode 100755 t/temp3.sh
 create mode 100755 t/temp4.sh
 create mode 100755 t/temp5.sh
 create mode 100755 t/temp6.sh
 create mode 100755 t/temp7.sh
 create mode 100755 t/temp8.sh

diff --git a/t/temp1.sh b/t/temp1.sh
new file mode 100644
index 0000000..d7075f5
--- /dev/null
+++ b/t/temp1.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+
+test_description='recursive merge corner cases: d/f conflict (via add/add) + criss-cross merge'
+
+. ./test-lib.sh
+
+#
+# Let's make it a bit more coplicated:
+#   Commit A: Neither file 'a' nor directory 'a/' exist.
+#   Commit B: Introduce 'a'
+#   Commit C: Introduce 'a/file'
+# Two different later cases:
+#   Commit D1:  Merge B & C, keeping 'a' and deleting 'a/'
+#   Commit E1: Merge B & C, deleting 'a' but keeping 'a/file'
+#
+#   Commit D2:  Merge B & C, keeping a modified 'a' and deleting 'a/'
+#   Commit E2: Merge B & C, deleting 'a' but keeping a modified 'a/file'
+# Finally, someone goes to merge D1&E1 or D1&E2 or D2&E1.  What happens?
+#
+#      B   D1 or D2
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E1 or E2
+#
+
+test_expect_success 'setup differently handled merges of directory/file conflict' '
+	>irrelevant-file &&
+	git add irrelevant-file &&
+	test_tick &&
+	git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	mkdir a &&
+	echo 10 >a/file &&
+	git add a/file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo 5 >a &&
+	git add a &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	git clean -f &&
+	rm -rf a/ &&
+	echo 5 >a &&
+	git add a &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git clean -f &&
+	echo 10 >a/file &&
+	git add a/file &&
+	git rm --cached a &&
+	test_tick &&
+	git commit -m E1 &&
+	git tag E1 &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git clean -f &&
+	printf "10\n11\n" >a/file &&
+	git add a/file &&
+	git rm --cached a &&
+	test_tick &&
+	git commit -m E2 &&
+	git tag E2
+'
+
+test_expect_success 'git detects conflict and handles merge of D & E1 correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E1^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :3:a/file) = $(git rev-parse C:a/file)
+'
+
+test_expect_failure 'git detects conflict and handles merge of E1 & D correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout E1^0 &&
+
+	test_must_fail git merge -s recursive D^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :2:a/file) = $(git rev-parse C:a/file)
+'
+
+test_expect_success 'git detects conflict and handles merge of D & E2 correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E2^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :3:a/file) = $(git rev-parse E1:a/file)
+	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
+'
+
+test_expect_success 'git detects conflict and handles merge of E2 & D correctly' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+	git checkout E2^0 &&
+
+	test_must_fail git merge -s recursive D^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :2:a/file) = $(git rev-parse E1:a/file)
+	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
+'
+
+test_done
diff --git a/t/temp2.sh b/t/temp2.sh
new file mode 100755
index 0000000..46a8c93
--- /dev/null
+++ b/t/temp2.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='recursive merge corner case: content conflict + criss-cross merge'
+
+. ./test-lib.sh
+
+#
+# Let's make a really contrived but simple criss-cross merge case:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: file with contents 'A\n'
+#   Commit B: file with contents 'B\n'
+#   Commit C: file with contents 'C\n'
+#   Commit D: file with contents 'D\n'
+#   Commit E: file with contents:
+#      <<<<<<< Temporary merge branch 1
+#      C
+#      =======
+#      B
+#      >>>>>>> Temporary merge branch 2
+#
+# Now, when we merge commits D & E, does git detect the conflict?
+
+test_expect_success 'setup differently handled merges of content conflict' '
+	echo A >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	echo C >file &&
+	git add file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo B >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	echo D >file &&
+	git add file &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	cat <<EOF >file &&
+<<<<<<< Temporary merge branch 1
+C
+=======
+B
+>>>>>>> Temporary merge branch 2
+EOF
+	git add file &&
+	test_tick &&
+	git commit -m E &&
+	git tag E
+'
+
+test_expect_success 'git detects conflict merging D & E' '
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:file) = $(git rev-parse D:file) &&
+	test $(git rev-parse :3:file) = $(git rev-parse E:file)
+'
+
+test_done
diff --git a/t/temp3.sh b/t/temp3.sh
new file mode 100755
index 0000000..3f4ceb1
--- /dev/null
+++ b/t/temp3.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='recursive merge corner case: delete/modify + criss-cross merge'
+
+. ./test-lib.sh
+
+#
+# Standard setup:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: file with contents 'A\n'
+#   Commit B: file with contents 'B\n'
+#   Commit C: file not present
+#   Commit D: file with contents 'B\n'
+#   Commit E: file not present
+#
+# Now, when we merge commits D & E, does git detect the conflict?
+
+test_expect_success 'setup differently handled merges of content conflict' '
+	echo A >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	git rm file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo B >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	echo B >file &&
+	git add file &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git rm file &&
+	test_tick &&
+	git commit -m E &&
+	git tag E
+'
+
+test_expect_success 'git detects conflict merging D & E' '
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+
+	test $(git rev-parse :1:file) = $(git rev-parse B:file) &&
+	test $(git rev-parse :2:file) = $(git rev-parse B:file)
+'
+
+test_done
diff --git a/t/temp4.sh b/t/temp4.sh
new file mode 100755
index 0000000..2014f5b
--- /dev/null
+++ b/t/temp4.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='recursive merge rename+content merge+D/F conflict'
+
+. ./test-lib.sh
+
+# Examples where rename/directory conflicts can cause changes to the file
+# not on the same side of history as the rename to be dropped.
+
+test_expect_success 'setup content merge + rename/directory conflict' '
+	printf "1\n2\n3\n4\n5\n6\n" >file &&
+	git add file &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b right &&
+	echo 7 >>file &&
+	mkdir newfile &&
+	echo junk >newfile/realfile &&
+	git add file newfile/realfile &&
+	test_tick &&
+	git commit -m right &&
+
+	git checkout -b left-conflict base &&
+	echo 8 >>file &&
+	git add file &&
+	git mv file newfile &&
+	test_tick &&
+	git commit -m left &&
+
+	git checkout -b left-clean base &&
+	echo 0 >newfile &&
+	cat file >>newfile &&
+	git add newfile &&
+	git rm file &&
+	test_tick &&
+	git commit -m left
+'
+
+test_expect_success 'rename/directory conflict + clean content merge' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left-clean^0 &&
+
+	test_must_fail git merge -s recursive right^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	echo 0 >expect &&
+	git cat-file -p base:file >>expect &&
+	echo 7 >>expect &&
+	test_cmp expect newfile~HEAD &&
+
+	test $(git rev-parse :2:newfile) = $(git hash-object expect) &&
+
+	test -f newfile/realfile &&
+	test -f newfile~HEAD
+'
+
+test_expect_success 'rename/directory conflict + content merge conflict' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left-conflict^0 &&
+
+	test_must_fail git merge -s recursive right^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	git cat-file -p left:newfile >left &&
+	git cat-file -p base:file    >base &&
+	git cat-file -p right:file   >right &&
+	test_must_fail git merge-file \
+		-L "HEAD:newfile" \
+		-L "" \
+		-L "right^0:file" \
+		left base right &&
+	test_cmp left newfile~HEAD &&
+
+	test $(git rev-parse :1:newfile) = $(git rev-parse base:file) &&
+	test $(git rev-parse :2:newfile) = $(git rev-parse left:newfile) &&
+	test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
+
+	test -f newfile/realfile &&
+	test -f newfile~HEAD
+'
+
+test_done
diff --git a/t/temp5.sh b/t/temp5.sh
new file mode 100755
index 0000000..bc50780
--- /dev/null
+++ b/t/temp5.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description="Does git preserve Gollum's precious artifact?"
+
+. ./test-lib.sh
+
+test_expect_success 'setup abbreviated storyline' '
+	echo "A pretty inscription" >ring &&
+	git add ring &&
+	test_tick &&
+	git commit -m beginning &&
+
+	git branch people &&
+	git checkout -b rename-the-ring &&
+	git mv ring one-ring-to-rule-them-all &&
+	test_tick &&
+	git commit -m fullname &&
+
+	git checkout people &&
+	git rm ring &&
+	echo gollum >owner &&
+	git add owner &&
+	test_tick &&
+	git commit -m track-people-instead-of-objects &&
+	echo "Myyy PRECIOUSSS" >ring
+'
+
+test_expect_success 'Does git preserve the ring?' '
+	test_must_fail git merge -s recursive rename-the-ring &&
+
+	# Make sure git did not delete an untracked file
+	test -f ring
+'
+
+test_done
diff --git a/t/temp6.sh b/t/temp6.sh
new file mode 100755
index 0000000..da00050
--- /dev/null
+++ b/t/temp6.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='recursive merge rename+content merge+D/F conflict goes away'
+
+. ./test-lib.sh
+
+# Examples where rename/directory conflicts can cause changes to the file
+# not on the same side of history as the rename to be dropped.
+
+test_expect_success 'setup content merge + rename/directory conflict' '
+	mkdir sub &&
+	printf "1\n2\n3\n4\n5\n6\n" >sub/file &&
+	git add sub/file &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b right &&
+	echo 7 >>sub/file &&
+	git add sub/file &&
+	test_tick &&
+	git commit -m right &&
+
+	git checkout -b left base &&
+	echo 0 >newfile &&
+	cat sub/file >>newfile &&
+	git rm sub/file &&
+	mv newfile sub &&
+	git add sub &&
+	test_tick &&
+	git commit -m left
+'
+
+test_expect_success 'disappearing rename/directory conf.+clean content merge' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left^0 &&
+
+	git merge -s recursive right^0 &&
+
+	test 1 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	echo 0 >expect &&
+	git cat-file -p base:sub/file >>expect &&
+	echo 7 >>expect &&
+	test_cmp expect sub &&
+
+	test -f sub
+'
+
+test_done
diff --git a/t/temp7.sh b/t/temp7.sh
new file mode 100755
index 0000000..0cb5946
--- /dev/null
+++ b/t/temp7.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description="File renamed identically on both sides + re-add source name"
+
+. ./test-lib.sh
+
+test_expect_success 'setup rename/rename/add resolvable conflict' '
+	>a &&
+	git add a &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b one base &&
+	git mv a b &&
+	test_tick &&
+	git commit -m one &&
+
+	git checkout -b two base &&
+	git mv a b &&
+	echo important-info >a &&
+	test_tick &&
+	git commit -m two
+'
+
+test_expect_success 'merge include important info in new a' '
+	git checkout two^0 &&
+	git merge -s recursive one^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l)
+'
+
+test_done
diff --git a/t/temp8.sh b/t/temp8.sh
new file mode 100755
index 0000000..0736639
--- /dev/null
+++ b/t/temp8.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description="Rename/rename/add conflict"
+
+. ./test-lib.sh
+
+test_expect_success 'setup rename/rename (1to2) + add conflict' '
+	echo stuff >a &&
+	git add a &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b one base &&
+	git mv a b &&
+	echo precious-data >c &&
+	git add c &&
+	test_tick &&
+	git commit -m one &&
+
+	git checkout -b two base &&
+	git mv a c &&
+	echo important-info >b &&
+	git add b &&
+	test_tick &&
+	git commit -m two
+'
+
+test_expect_success 'merge maintains important data from one:c and two:b' '
+	git checkout two^0 &&
+	test_must_fail git merge -s recursive one^0 &&
+
+	test 2 -eq $(git ls-files -u b | wc -l) &&
+	test 2 -eq $(git ls-files -u c | wc -l)
+'
+
+test_done
-- 
1.7.4
