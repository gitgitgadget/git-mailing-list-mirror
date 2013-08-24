From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t/t3701-add-interactive.sh: Add PERL prerequisite
Date: Sat, 24 Aug 2013 13:13:32 -0700
Message-ID: <20130824201332.GC2960@elie.Belkin>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
 <1377316906-70338-3-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sat Aug 24 22:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDKDY-0002KP-Dg
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 22:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab3HXUNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 16:13:38 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55615 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab3HXUNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 16:13:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1948869pab.29
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y5wR5ADNw2lIXArjtO8YQ8FexRI0fshQM8Vn2s9JRng=;
        b=q8FU2gIHkcG+fUKC9ZsOhlENmoW12agOJookkjDAxird5d7PCBUr0fOq15QggW/uRv
         6qOv4KHDGwglwN0QzNCcJqqrLyxM+no1ztljboxXjmhmeMz6pbyMmVLzuZUcTI7qMZ2u
         WiQ167XO8NHzrLDwB0o+sxwB7Zvxb1+PIg7rH6gI57+oRP2uBHGq5x2txaSzplfBpzsB
         LPRnJv+ZyKfT94W5OQ9/1AK8RbKa/1nGMQ5UUSSpEwlqMrRq5TkxkvnWdz0YwD6n5SUv
         Bq8Y1h0pdI7nEP1bnK0Lz+o6aFxhIY0ZvSqzhcp0WHvxLocQI78f79G5srOJ2JHPgH9b
         mTlg==
X-Received: by 10.67.3.34 with SMTP id bt2mr5972312pad.3.1377375217116;
        Sat, 24 Aug 2013 13:13:37 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id jf4sm7877508pbb.19.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 13:13:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377316906-70338-3-git-send-email-draenog@pld-linux.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232890>

Kacper Kornet wrote:

> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -330,7 +330,7 @@ test_expect_success PERL 'split hunk "add -p (edit)"' '
>  	! grep "^+15" actual
>  '
>  
> -test_expect_success 'patch mode ignores unmerged entries' '
> +test_expect_success PERL 'patch mode ignores unmerged entries' '

Mph.  This is a symptom of f0459319 (change from skip_all=* to prereq
skip, 2010-08-13), which hurt maintainability without much upside to
balance it.

I wonder if it would be easier to do something like the following
instead.

-- >8 --
Subject: add -i test: use skip_all instead of repeated PERL prerequisite

It is too easy to forget to add the PERL prerequisite for new
"add -i" tests, especially given that many people do not test with
NO_PERL so the missing prereq is not always noticed quickly.

The test had used the skip_all mechanism since 1b19ccd2 (2009-04-03)
but switched to explicit PERL prereqs in f0459319 (2010-10-13) in hope
of helping people see how many tests were skipped, perhaps to motivate
them to tweak their platform or tests to improve test coverage.  That
didn't pan out much in practice, so let's move back to the simpler
skip_all method.

Reported-by: Kacper Kornet <draenog@pld-linux.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3701-add-interactive.sh | 76 +++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 9fab25cc..9dc91d09 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -4,18 +4,24 @@ test_description='add -i basic tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
 
-test_expect_success PERL 'setup (initial)' '
+if ! test_have_prereq PERL
+then
+	skip_all='skipping add -i tests, perl not available'
+	test_done
+fi
+
+test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
 	echo more >>file &&
 	echo lines >>file
 '
-test_expect_success PERL 'status works (initial)' '
+test_expect_success 'status works (initial)' '
 	git add -i </dev/null >output &&
 	grep "+1/-0 *+2/-0 file" output
 '
 
-test_expect_success PERL 'setup expected' '
+test_expect_success 'setup expected' '
 cat >expected <<EOF
 new file mode 100644
 index 0000000..d95f3ad
@@ -26,19 +32,19 @@ index 0000000..d95f3ad
 EOF
 '
 
-test_expect_success PERL 'diff works (initial)' '
+test_expect_success 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
 	test_cmp expected diff
 '
-test_expect_success PERL 'revert works (initial)' '
+test_expect_success 'revert works (initial)' '
 	git add file &&
 	(echo r; echo 1) | git add -i &&
 	git ls-files >output &&
 	! grep . output
 '
 
-test_expect_success PERL 'setup (commit)' '
+test_expect_success 'setup (commit)' '
 	echo baseline >file &&
 	git add file &&
 	git commit -m commit &&
@@ -47,12 +53,12 @@ test_expect_success PERL 'setup (commit)' '
 	echo more >>file &&
 	echo lines >>file
 '
-test_expect_success PERL 'status works (commit)' '
+test_expect_success 'status works (commit)' '
 	git add -i </dev/null >output &&
 	grep "+1/-0 *+2/-0 file" output
 '
 
-test_expect_success PERL 'setup expected' '
+test_expect_success 'setup expected' '
 cat >expected <<EOF
 index 180b47c..b6f2c08 100644
 --- a/file
@@ -63,12 +69,12 @@ index 180b47c..b6f2c08 100644
 EOF
 '
 
-test_expect_success PERL 'diff works (commit)' '
+test_expect_success 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
 	test_cmp expected diff
 '
-test_expect_success PERL 'revert works (commit)' '
+test_expect_success 'revert works (commit)' '
 	git add file &&
 	(echo r; echo 1) | git add -i &&
 	git add -i </dev/null >output &&
@@ -76,24 +82,24 @@ test_expect_success PERL 'revert works (commit)' '
 '
 
 
-test_expect_success PERL 'setup expected' '
+test_expect_success 'setup expected' '
 cat >expected <<EOF
 EOF
 '
 
-test_expect_success PERL 'setup fake editor' '
+test_expect_success 'setup fake editor' '
 	>fake_editor.sh &&
 	chmod a+x fake_editor.sh &&
 	test_set_editor "$(pwd)/fake_editor.sh"
 '
 
-test_expect_success PERL 'dummy edit works' '
+test_expect_success 'dummy edit works' '
 	(echo e; echo a) | git add -p &&
 	git diff > diff &&
 	test_cmp expected diff
 '
 
-test_expect_success PERL 'setup patch' '
+test_expect_success 'setup patch' '
 cat >patch <<EOF
 @@ -1,1 +1,4 @@
  this
@@ -103,7 +109,7 @@ cat >patch <<EOF
 EOF
 '
 
-test_expect_success PERL 'setup fake editor' '
+test_expect_success 'setup fake editor' '
 	echo "#!$SHELL_PATH" >fake_editor.sh &&
 	cat >>fake_editor.sh <<\EOF &&
 mv -f "$1" oldpatch &&
@@ -113,26 +119,26 @@ EOF
 	test_set_editor "$(pwd)/fake_editor.sh"
 '
 
-test_expect_success PERL 'bad edit rejected' '
+test_expect_success 'bad edit rejected' '
 	git reset &&
 	(echo e; echo n; echo d) | git add -p >output &&
 	grep "hunk does not apply" output
 '
 
-test_expect_success PERL 'setup patch' '
+test_expect_success 'setup patch' '
 cat >patch <<EOF
 this patch
 is garbage
 EOF
 '
 
-test_expect_success PERL 'garbage edit rejected' '
+test_expect_success 'garbage edit rejected' '
 	git reset &&
 	(echo e; echo n; echo d) | git add -p >output &&
 	grep "hunk does not apply" output
 '
 
-test_expect_success PERL 'setup patch' '
+test_expect_success 'setup patch' '
 cat >patch <<EOF
 @@ -1,0 +1,0 @@
  baseline
@@ -142,7 +148,7 @@ cat >patch <<EOF
 EOF
 '
 
-test_expect_success PERL 'setup expected' '
+test_expect_success 'setup expected' '
 cat >expected <<EOF
 diff --git a/file b/file
 index b5dd6c9..f910ae9 100644
@@ -157,13 +163,13 @@ index b5dd6c9..f910ae9 100644
 EOF
 '
 
-test_expect_success PERL 'real edit works' '
+test_expect_success 'real edit works' '
 	(echo e; echo n; echo d) | git add -p &&
 	git diff >output &&
 	test_cmp expected output
 '
 
-test_expect_success PERL 'skip files similarly as commit -a' '
+test_expect_success 'skip files similarly as commit -a' '
 	git reset &&
 	echo file >.gitignore &&
 	echo changed >file &&
@@ -177,7 +183,7 @@ test_expect_success PERL 'skip files similarly as commit -a' '
 '
 rm -f .gitignore
 
-test_expect_success PERL,FILEMODE 'patch does not affect mode' '
+test_expect_success FILEMODE 'patch does not affect mode' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -186,7 +192,7 @@ test_expect_success PERL,FILEMODE 'patch does not affect mode' '
 	git diff file | grep "new mode"
 '
 
-test_expect_success PERL,FILEMODE 'stage mode but not hunk' '
+test_expect_success FILEMODE 'stage mode but not hunk' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -196,7 +202,7 @@ test_expect_success PERL,FILEMODE 'stage mode but not hunk' '
 '
 
 
-test_expect_success PERL,FILEMODE 'stage mode and hunk' '
+test_expect_success FILEMODE 'stage mode and hunk' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -208,14 +214,14 @@ test_expect_success PERL,FILEMODE 'stage mode and hunk' '
 
 # end of tests disabled when filemode is not usable
 
-test_expect_success PERL 'setup again' '
+test_expect_success 'setup again' '
 	git reset --hard &&
 	test_chmod +x file &&
 	echo content >>file
 '
 
 # Write the patch file with a new line at the top and bottom
-test_expect_success PERL 'setup patch' '
+test_expect_success 'setup patch' '
 cat >patch <<EOF
 index 180b47c..b6f2c08 100644
 --- a/file
@@ -229,7 +235,7 @@ EOF
 '
 
 # Expected output, similar to the patch but w/ diff at the top
-test_expect_success PERL 'setup expected' '
+test_expect_success 'setup expected' '
 cat >expected <<EOF
 diff --git a/file b/file
 index b6f2c08..61b9053 100755
@@ -244,7 +250,7 @@ EOF
 '
 
 # Test splitting the first patch, then adding both
-test_expect_success PERL 'add first line works' '
+test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	(echo s; echo y; echo y) | git add -p file &&
@@ -252,7 +258,7 @@ test_expect_success PERL 'add first line works' '
 	test_cmp expected diff
 '
 
-test_expect_success PERL 'setup expected' '
+test_expect_success 'setup expected' '
 cat >expected <<EOF
 diff --git a/non-empty b/non-empty
 deleted file mode 100644
@@ -264,7 +270,7 @@ index d95f3ad..0000000
 EOF
 '
 
-test_expect_success PERL 'deleting a non-empty file' '
+test_expect_success 'deleting a non-empty file' '
 	git reset --hard &&
 	echo content >non-empty &&
 	git add non-empty &&
@@ -275,7 +281,7 @@ test_expect_success PERL 'deleting a non-empty file' '
 	test_cmp expected diff
 '
 
-test_expect_success PERL 'setup expected' '
+test_expect_success 'setup expected' '
 cat >expected <<EOF
 diff --git a/empty b/empty
 deleted file mode 100644
@@ -283,7 +289,7 @@ index e69de29..0000000
 EOF
 '
 
-test_expect_success PERL 'deleting an empty file' '
+test_expect_success 'deleting an empty file' '
 	git reset --hard &&
 	> empty &&
 	git add empty &&
@@ -294,7 +300,7 @@ test_expect_success PERL 'deleting an empty file' '
 	test_cmp expected diff
 '
 
-test_expect_success PERL 'split hunk setup' '
+test_expect_success 'split hunk setup' '
 	git reset --hard &&
 	for i in 10 20 30 40 50 60
 	do
@@ -310,7 +316,7 @@ test_expect_success PERL 'split hunk setup' '
 	done >test
 '
 
-test_expect_success PERL 'split hunk "add -p (edit)"' '
+test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
 	# 1. Broken version results in a patch that does not apply and
-- 
1.8.4.rc4
