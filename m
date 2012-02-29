From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t4011: modernise style
Date: Wed, 29 Feb 2012 15:45:26 -0800
Message-ID: <7vipipqk4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 00:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2tDD-000728-E7
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 00:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab2B2Xpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 18:45:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab2B2Xp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 18:45:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49DB7688A;
	Wed, 29 Feb 2012 18:45:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	BbFSxdNgKo14S9ve7LoHjtP6VE=; b=ILKV4jTKY64mEsiJEVdcdRzD1P4LaCB1S
	WjtprO9w5nZ8DWw99LMykziEVdFHCcOrJwJFY09YFDvPovGEQzk5ORd2NN0H/5v3
	2dkqOutpekftoIb6uSef08NDX80RfRROF5imdbJkjC2IxRZSIpB6SeKJ/K/itpZV
	zA8TPSu7Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WWy
	/XEJFIGJUkXUr4N08qUPePDZ7/2jGbGwTCQ/2e2NysZ72WY+MOgt06YyVF0UsbM5
	6mMGqt3vQULpF2dH1UQqH3hx09WFSgXZ7rwYBvsYNH9lK4b1MrMsi0PS+zhXtWkd
	tqJBO3E49cSslLiGmY6PySMmTzv5f+du6hJlZ+OU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 425F46889;
	Wed, 29 Feb 2012 18:45:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7638A6888; Wed, 29 Feb 2012
 18:45:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74F9766E-632F-11E1-A56A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191863>

Match the style to more modern test scripts, namely:

 - The first line of each test has prereq, title and opening sq for the
   script body.  This makes the test shorter while reducing the need for
   backquotes.

 - Be prepared for the case the previous test may have failed.  If a test
   wants to start from not having 'frotz' that the previous test may have
   created, write "rm -f frotz", not "rm frotz".

 - Prepare the expected output inside your own test.

 - The order of comparison to check the result is "diff expected actual",
   so that the output will show how the output from the git you just broke
   is different from what is expected.

 - Write no SP between redirection '>' (or '<' for that matter) and the
   filename.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Just what I happened to have noticed today.

 t/t4011-diff-symlink.sh |  168 +++++++++++++++++++++++------------------------
 1 file changed, 82 insertions(+), 86 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 408a19c..0e1216f 100755
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
