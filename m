From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/10] t/t3701-add-interactive.sh: change from skip_all=* to prereq skip
Date: Fri, 13 Aug 2010 20:40:05 +0000
Message-ID: <1281732013-18284-3-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok146-0007V9-4r
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762Ab0HMUk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:40:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42436 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab0HMUky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:40:54 -0400
Received: by wwj40 with SMTP id 40so3432930wwj.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZVyOjWgQuobL7PVShSjvcxsGGwg1blgFXWIJDwSuT60=;
        b=QFyImOQ7bE/8e6ZmHxyU2fjAP/HDVHaUtvpMPn9qoW4DFnGrenooUsykhG6vipIJCY
         kf5VV53zVFH/+jJtqWeIfrZmGj40TC7m3Piq+ZPeTizrVYzPZy8a1jjw2q13Cg9w5cWV
         oXC1EB48L50UMWhHzi/AVXZw7zfaedqKLTKAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=O+DN0eFdeWSpbN8du+D5x2bh3fM/pTgefVIwvho4nYQPPFlLg7qsHexy9lWBmW0YD0
         WyR2B1Zt0b4Pf3gj6fmbt+wQYrRIMfX2SOlfwonrsecOSnVNyXIttlaqhWEio3rXJH/9
         GfUeeNToDs30pKv/8bHf2CROnbBrNwN8MbQIY=
Received: by 10.227.129.12 with SMTP id m12mr1946833wbs.102.1281732053324;
        Fri, 13 Aug 2010 13:40:53 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.40.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:40:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153499>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t3701-add-interactive.sh |  104 +++++++++++++++++++++++++++++-------=
-------
 1 files changed, 70 insertions(+), 34 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 75ec90b..d6327e7 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -4,21 +4,18 @@ test_description=3D'add -i basic tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
-if ! test_have_prereq PERL; then
-	skip_all=3D'skipping git add -i tests, perl not available'
-	test_done
-fi
-
-test_expect_success 'setup (initial)' '
+test_expect_success PERL 'setup (initial)' '
 	echo content >file &&
 	git add file &&
 	echo more >>file &&
 	echo lines >>file
 '
-test_expect_success 'status works (initial)' '
+test_expect_success PERL 'status works (initial)' '
 	git add -i </dev/null >output &&
 	grep "+1/-0 *+2/-0 file" output
 '
+
+test_expect_success PERL 'setup expected' '
 cat >expected <<EOF
 new file mode 100644
 index 0000000..d95f3ad
@@ -27,19 +24,21 @@ index 0000000..d95f3ad
 @@ -0,0 +1 @@
 +content
 EOF
-test_expect_success 'diff works (initial)' '
+'
+
+test_expect_success PERL 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
 	test_cmp expected diff
 '
-test_expect_success 'revert works (initial)' '
+test_expect_success PERL 'revert works (initial)' '
 	git add file &&
 	(echo r; echo 1) | git add -i &&
 	git ls-files >output &&
 	! grep . output
 '
=20
-test_expect_success 'setup (commit)' '
+test_expect_success PERL 'setup (commit)' '
 	echo baseline >file &&
 	git add file &&
 	git commit -m commit &&
@@ -48,10 +47,12 @@ test_expect_success 'setup (commit)' '
 	echo more >>file &&
 	echo lines >>file
 '
-test_expect_success 'status works (commit)' '
+test_expect_success PERL 'status works (commit)' '
 	git add -i </dev/null >output &&
 	grep "+1/-0 *+2/-0 file" output
 '
+
+test_expect_success PERL 'setup expected' '
 cat >expected <<EOF
 index 180b47c..b6f2c08 100644
 --- a/file
@@ -60,60 +61,79 @@ index 180b47c..b6f2c08 100644
  baseline
 +content
 EOF
-test_expect_success 'diff works (commit)' '
+'
+
+test_expect_success PERL 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
 	test_cmp expected diff
 '
-test_expect_success 'revert works (commit)' '
+test_expect_success PERL 'revert works (commit)' '
 	git add file &&
 	(echo r; echo 1) | git add -i &&
 	git add -i </dev/null >output &&
 	grep "unchanged *+3/-0 file" output
 '
=20
+
+test_expect_success PERL 'setup expected' '
 cat >expected <<EOF
 EOF
-cat >fake_editor.sh <<EOF
-EOF
-chmod a+x fake_editor.sh
-test_set_editor "$(pwd)/fake_editor.sh"
-test_expect_success 'dummy edit works' '
+'
+
+test_expect_success PERL 'setup fake editor' '
+	cat >fake_editor.sh <<EOF
+	EOF
+	chmod a+x fake_editor.sh &&
+	test_set_editor "$(pwd)/fake_editor.sh" &&
+'
+
+test_expect_success PERL 'dummy edit works' '
 	(echo e; echo a) | git add -p &&
 	git diff > diff &&
 	test_cmp expected diff
 '
=20
+test_expect_success PERL 'setup patch' '
 cat >patch <<EOF
 @@ -1,1 +1,4 @@
  this
 +patch
--doesn't
+-does not
  apply
 EOF
-echo "#!$SHELL_PATH" >fake_editor.sh
-cat >>fake_editor.sh <<\EOF
+'
+
+test_expect_success PERL 'setup fake editor' '
+	echo "#!$SHELL_PATH" >fake_editor.sh &&
+	cat >>fake_editor.sh <<\EOF &&
 mv -f "$1" oldpatch &&
 mv -f patch "$1"
 EOF
-chmod a+x fake_editor.sh
-test_set_editor "$(pwd)/fake_editor.sh"
-test_expect_success 'bad edit rejected' '
+	chmod a+x fake_editor.sh &&
+	test_set_editor "$(pwd)/fake_editor.sh"
+'
+
+test_expect_success PERL 'bad edit rejected' '
 	git reset &&
 	(echo e; echo n; echo d) | git add -p >output &&
 	grep "hunk does not apply" output
 '
=20
+test_expect_success PERL 'setup patch' '
 cat >patch <<EOF
 this patch
 is garbage
 EOF
-test_expect_success 'garbage edit rejected' '
+'
+
+test_expect_success PERL 'garbage edit rejected' '
 	git reset &&
 	(echo e; echo n; echo d) | git add -p >output &&
 	grep "hunk does not apply" output
 '
=20
+test_expect_success PERL 'setup patch' '
 cat >patch <<EOF
 @@ -1,0 +1,0 @@
  baseline
@@ -121,6 +141,9 @@ cat >patch <<EOF
 +newcontent
 +lines
 EOF
+'
+
+test_expect_success PERL 'setup expected' '
 cat >expected <<EOF
 diff --git a/file b/file
 index b5dd6c9..f910ae9 100644
@@ -133,13 +156,15 @@ index b5dd6c9..f910ae9 100644
 +more
  lines
 EOF
-test_expect_success 'real edit works' '
+'
+
+test_expect_success PERL 'real edit works' '
 	(echo e; echo n; echo d) | git add -p &&
 	git diff >output &&
 	test_cmp expected output
 '
=20
-test_expect_success 'skip files similarly as commit -a' '
+test_expect_success PERL 'skip files similarly as commit -a' '
 	git reset &&
 	echo file >.gitignore &&
 	echo changed >file &&
@@ -153,7 +178,7 @@ test_expect_success 'skip files similarly as commit=
 -a' '
 '
 rm -f .gitignore
=20
-test_expect_success FILEMODE 'patch does not affect mode' '
+test_expect_success PERL,FILEMODE 'patch does not affect mode' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -162,7 +187,7 @@ test_expect_success FILEMODE 'patch does not affect=
 mode' '
 	git diff file | grep "new mode"
 '
=20
-test_expect_success FILEMODE 'stage mode but not hunk' '
+test_expect_success PERL,FILEMODE 'stage mode but not hunk' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -172,7 +197,7 @@ test_expect_success FILEMODE 'stage mode but not hu=
nk' '
 '
=20
=20
-test_expect_success FILEMODE 'stage mode and hunk' '
+test_expect_success PERL,FILEMODE 'stage mode and hunk' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
@@ -184,13 +209,14 @@ test_expect_success FILEMODE 'stage mode and hunk=
' '
=20
 # end of tests disabled when filemode is not usable
=20
-test_expect_success 'setup again' '
+test_expect_success PERL 'setup again' '
 	git reset --hard &&
 	test_chmod +x file &&
 	echo content >>file
 '
=20
 # Write the patch file with a new line at the top and bottom
+test_expect_success PERL 'setup patch' '
 cat >patch <<EOF
 index 180b47c..b6f2c08 100644
 --- a/file
@@ -201,7 +227,10 @@ index 180b47c..b6f2c08 100644
  content
 +lastline
 EOF
+'
+
 # Expected output, similar to the patch but w/ diff at the top
+test_expect_success PERL 'setup expected' '
 cat >expected <<EOF
 diff --git a/file b/file
 index b6f2c08..61b9053 100755
@@ -213,8 +242,10 @@ index b6f2c08..61b9053 100755
  content
 +lastline
 EOF
+'
+
 # Test splitting the first patch, then adding both
-test_expect_success 'add first line works' '
+test_expect_success PERL 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	(echo s; echo y; echo y) | git add -p file &&
@@ -222,6 +253,7 @@ test_expect_success 'add first line works' '
 	test_cmp expected diff
 '
=20
+test_expect_success PERL 'setup expected' '
 cat >expected <<EOF
 diff --git a/non-empty b/non-empty
 deleted file mode 100644
@@ -231,7 +263,9 @@ index d95f3ad..0000000
 @@ -1 +0,0 @@
 -content
 EOF
-test_expect_success 'deleting a non-empty file' '
+'
+
+test_expect_success PERL 'deleting a non-empty file' '
 	git reset --hard &&
 	echo content >non-empty &&
 	git add non-empty &&
@@ -242,13 +276,15 @@ test_expect_success 'deleting a non-empty file' '
 	test_cmp expected diff
 '
=20
+test_expect_success PERL 'setup expected' '
 cat >expected <<EOF
 diff --git a/empty b/empty
 deleted file mode 100644
 index e69de29..0000000
 EOF
+'
=20
-test_expect_success 'deleting an empty file' '
+test_expect_success PERL 'deleting an empty file' '
 	git reset --hard &&
 	> empty &&
 	git add empty &&
--=20
1.7.2.1.338.gf2379
