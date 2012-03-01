From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t4011: modernise style
Date: Wed, 29 Feb 2012 18:14:14 -0800
Message-ID: <1330568057-27304-2-git-send-email-gitster@pobox.com>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 03:14:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2vXN-0003tv-EA
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 03:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757311Ab2CACOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 21:14:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab2CACOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 21:14:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A050B7D4F
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Vaz9
	jN2GyhMoS1sDA9G3mPLQqNc=; b=mMHgdgWGZANIq+VhxFL3EqxE3XbEaw5tYx4g
	+3DW3iunSM/RMIvS3BPsMMov66aAwo45tL06m6VtMLRu97Bf1dsurq/QO9/5aCB6
	qKaZ9pMMYMrB/LlYS5xq1DEx8u4DILVoywnDp6QQ++D6gBmQmugC95Jit0wRd2xM
	WeM9D+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qrHnZR
	o0a9rIx6cbdyOCoWXx9GQjgrRewBunT/lRxdcdA+vwLFjDSrjdgVzDitmqDAzg++
	HWV+HnxLwzR13osLUtTwzRccI+l2IUbSw+4rdsaU4hOU5VY3rloVJsloiaLP727u
	CZwn1lUh/6bnVsp+0f7UrFZfYBCmlp7Qewjd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D707D4E
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3F367D4C for
 <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:20 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.350.g74d65
In-Reply-To: <1330568057-27304-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 419196AC-6344-11E1-80A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191886>

Match the style to more modern test scripts, namely:

 - The first line of each test has prereq, title and opening sq for the
   script body.  This makes the test shorter while reducing the need for
   backquotes.

 - Be prepared for the case in which the previous test may have failed.
   If a test wants to start from not having "frotz" that the previous test
   may have created, write "rm -f frotz", not "rm frotz".

 - Prepare the expected output inside your own test.

 - The order of comparison to check the result is "diff expected actual",
   so that the output will show how the output from the git you just broke
   is different from what is expected.

 - Write no SP between redirection '>' (or '<' for that matter) and the
   filename.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * replaces the one I posted earlier (one block that prepares the expected
   result was in a wrong test).

 t/t4011-diff-symlink.sh |  168 +++++++++++++++++++++++------------------------
 1 file changed, 82 insertions(+), 86 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 408a19c..cb47ec1 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -9,85 +9,81 @@ test_description='Test diff of symlinks.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-cat > expected << EOF
-diff --git a/frotz b/frotz
-new file mode 120000
-index 0000000..7c465af
---- /dev/null
-+++ b/frotz
-@@ -0,0 +1 @@
-+xyzzy
-\ No newline at end of file
-EOF
-
-test_expect_success SYMLINKS \
-    'diff new symlink' \
-    'ln -s xyzzy frotz &&
-    git update-index &&
-    tree=$(git write-tree) &&
-    git update-index --add frotz &&
-    GIT_DIFF_OPTS=--unified=0 git diff-index -M -p $tree > current &&
-    compare_diff_patch current expected'
-
-test_expect_success SYMLINKS \
-    'diff unchanged symlink' \
-    'tree=$(git write-tree) &&
-    git update-index frotz &&
-    test -z "$(git diff-index --name-only $tree)"'
-
-cat > expected << EOF
-diff --git a/frotz b/frotz
-deleted file mode 120000
-index 7c465af..0000000
---- a/frotz
-+++ /dev/null
-@@ -1 +0,0 @@
--xyzzy
-\ No newline at end of file
-EOF
-
-test_expect_success SYMLINKS \
-    'diff removed symlink' \
-    'mv frotz frotz2 &&
-    git diff-index -M -p $tree > current &&
-    compare_diff_patch current expected'
+test_expect_success SYMLINKS 'diff new symlink' '
+	cat >expected <<-\EOF &&
+	diff --git a/frotz b/frotz
+	new file mode 120000
+	index 0000000..7c465af
+	--- /dev/null
+	+++ b/frotz
+	@@ -0,0 +1 @@
+	+xyzzy
+	\ No newline at end of file
+	EOF
+	ln -s xyzzy frotz &&
+	git update-index &&
+	tree=$(git write-tree) &&
+	git update-index --add frotz &&
+	GIT_DIFF_OPTS=--unified=0 git diff-index -M -p $tree >current &&
+	compare_diff_patch expected current
+'
 
-cat > expected << EOF
-diff --git a/frotz b/frotz
-EOF
+test_expect_success SYMLINKS 'diff unchanged symlink'  '
+	tree=$(git write-tree) &&
+	git update-index frotz &&
+	test -z "$(git diff-index --name-only $tree)"
+'
 
-test_expect_success SYMLINKS \
-    'diff identical, but newly created symlink' \
-    'ln -s xyzzy frotz &&
-    git diff-index -M -p $tree > current &&
-    compare_diff_patch current expected'
+test_expect_success SYMLINKS 'diff removed symlink' '
+	cat >expected <<-\EOF &&
+	diff --git a/frotz b/frotz
+	deleted file mode 120000
+	index 7c465af..0000000
+	--- a/frotz
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-xyzzy
+	\ No newline at end of file
+	EOF
+	mv frotz frotz2 &&
+	git diff-index -M -p $tree >current &&
+	compare_diff_patch expected current
+'
 
-cat > expected << EOF
-diff --git a/frotz b/frotz
-index 7c465af..df1db54 120000
---- a/frotz
-+++ b/frotz
-@@ -1 +1 @@
--xyzzy
-\ No newline at end of file
-+yxyyz
-\ No newline at end of file
-EOF
+test_expect_success SYMLINKS 'diff identical, but newly created symlink' '
+	cat >expected <<-\EOF &&
+	diff --git a/frotz b/frotz
+	EOF
+	ln -s xyzzy frotz &&
+	git diff-index -M -p $tree >current &&
+	compare_diff_patch expected current
+'
 
-test_expect_success SYMLINKS \
-    'diff different symlink' \
-    'rm frotz &&
-    ln -s yxyyz frotz &&
-    git diff-index -M -p $tree > current &&
-    compare_diff_patch current expected'
+test_expect_success SYMLINKS 'diff different symlink' '
+	cat >expected <<-\EOF &&
+	diff --git a/frotz b/frotz
+	index 7c465af..df1db54 120000
+	--- a/frotz
+	+++ b/frotz
+	@@ -1 +1 @@
+	-xyzzy
+	\ No newline at end of file
+	+yxyyz
+	\ No newline at end of file
+	EOF
+	rm -f frotz &&
+	ln -s yxyyz frotz &&
+	git diff-index -M -p $tree >current &&
+	compare_diff_patch expected current
+'
 
-test_expect_success SYMLINKS \
-    'diff symlinks with non-existing targets' \
-    'ln -s narf pinky &&
-    ln -s take\ over brain &&
-    test_must_fail git diff --no-index pinky brain > output 2> output.err &&
-    grep narf output &&
-    ! grep error output.err'
+test_expect_success SYMLINKS 'diff symlinks with non-existing targets' '
+	ln -s narf pinky &&
+	ln -s take\ over brain &&
+	test_must_fail git diff --no-index pinky brain >output 2>output.err &&
+	grep narf output &&
+	! test -s output.err
+'
 
 test_expect_success SYMLINKS 'setup symlinks with attributes' '
 	echo "*.bin diff=bin" >>.gitattributes &&
@@ -96,19 +92,19 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
 	git add -N file.bin link.bin
 '
 
-cat >expect <<'EOF'
-diff --git a/file.bin b/file.bin
-index e69de29..d95f3ad 100644
-Binary files a/file.bin and b/file.bin differ
-diff --git a/link.bin b/link.bin
-index e69de29..dce41ec 120000
---- a/link.bin
-+++ b/link.bin
-@@ -0,0 +1 @@
-+file.bin
-\ No newline at end of file
-EOF
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
+	cat >expect <<-\EOF &&
+	diff --git a/file.bin b/file.bin
+	index e69de29..d95f3ad 100644
+	Binary files a/file.bin and b/file.bin differ
+	diff --git a/link.bin b/link.bin
+	index e69de29..dce41ec 120000
+	--- a/link.bin
+	+++ b/link.bin
+	@@ -0,0 +1 @@
+	+file.bin
+	\ No newline at end of file
+	EOF
 	git config diff.bin.binary true &&
 	git diff file.bin link.bin >actual &&
 	test_cmp expect actual
-- 
1.7.9.2.350.g74d65
