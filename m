From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 15/15] t3040 (subprojects-basic): modernize style
Date: Thu,  8 Dec 2011 01:06:51 +0530
Message-ID: <1323286611-4806-16-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNKU-0001Ov-0W
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758225Ab1LGTiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757749Ab1LGTiu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:50 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mWLPmUhb28xQdxquCGBh6Xzo/pxbnvTxENo9Pnup8jw=;
        b=upCwqtLbl3kQNOk94rraxYPmXkE4A/JatF8cM7ih+RkDAMVKsROB6ifFRaCkwljH1C
         189pX8AaHofFq3tW3S2qXhculZwDgI5dp73lhobvh8o+HkmOAAfMt8XeuvHT554h15bu
         DIU/mMIGgufL1B122/00QSkhdHTK9N35zjh48=
Received: by 10.231.49.147 with SMTP id v19mr4700438ibf.64.1323286730386;
        Wed, 07 Dec 2011 11:38:50 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:49 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186496>

Put the opening quote starting each test on the same line as the
test_expect_* invocation.  While at it:

- Indent the file with tabs, not spaces.

- Guard commands that prepare test input for individual tests in the
  same test_expect_success, so that their scope is clearer and errors
  at that stage can be caught.

- Use <<\-EOF in preference to <<EOF to save readers the trouble of
  looking for variable interpolations.

- Include "setup" in the titles of test assertions that prepare for
  later ones to make it more obvious which tests can be skipped.

- Chain commands with &&.  Breaks in a test assertion's && chain can
  potentially hide failures from earlier commands in the chain.

- Use test_expect_code() in preference to checking the exit status of
  various statements by hand.

Inspired-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3040-subprojects-basic.sh |  144 +++++++++++++++++++++---------------------
 1 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index f6973e9..0a4ff6d 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -3,81 +3,81 @@
 test_description='Basic subproject functionality'
 . ./test-lib.sh
 
-test_expect_success 'Super project creation' \
-    ': >Makefile &&
-    git add Makefile &&
-    git commit -m "Superproject created"'
-
-
-cat >expected <<EOF
-:000000 160000 00000... A	sub1
-:000000 160000 00000... A	sub2
-EOF
-test_expect_success 'create subprojects' \
-    'mkdir sub1 &&
-    ( cd sub1 && git init && : >Makefile && git add * &&
-    git commit -q -m "subproject 1" ) &&
-    mkdir sub2 &&
-    ( cd sub2 && git init && : >Makefile && git add * &&
-    git commit -q -m "subproject 2" ) &&
-    git update-index --add sub1 &&
-    git add sub2 &&
-    git commit -q -m "subprojects added" &&
-    git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
-    test_cmp expected current'
-
-git branch save HEAD
-
-test_expect_success 'check if fsck ignores the subprojects' \
-    'git fsck --full'
-
-test_expect_success 'check if commit in a subproject detected' \
-    '( cd sub1 &&
-    echo "all:" >>Makefile &&
-    echo "	true" >>Makefile &&
-    git commit -q -a -m "make all" ) && {
-        git diff-files --exit-code
-	test $? = 1
-    }'
-
-test_expect_success 'check if a changed subproject HEAD can be committed' \
-    'git commit -q -a -m "sub1 changed" && {
-	git diff-tree --exit-code HEAD^ HEAD
-	test $? = 1
-    }'
-
-test_expect_success 'check if diff-index works for subproject elements' \
-    'git diff-index --exit-code --cached save -- sub1
-    test $? = 1'
-
-test_expect_success 'check if diff-tree works for subproject elements' \
-    'git diff-tree --exit-code HEAD^ HEAD -- sub1
-    test $? = 1'
-
-test_expect_success 'check if git diff works for subproject elements' \
-    'git diff --exit-code HEAD^ HEAD
-    test $? = 1'
-
-test_expect_success 'check if clone works' \
-    'git ls-files -s >expected &&
-    git clone -l -s . cloned &&
-    ( cd cloned && git ls-files -s ) >current &&
-    test_cmp expected current'
-
-test_expect_success 'removing and adding subproject' \
-    'git update-index --force-remove -- sub2 &&
-    mv sub2 sub3 &&
-    git add sub3 &&
-    git commit -q -m "renaming a subproject" && {
-	git diff -M --name-status --exit-code HEAD^ HEAD
-	test $? = 1
-    }'
+test_expect_success 'setup: create superproject' '
+	: >Makefile &&
+	git add Makefile &&
+	git commit -m "Superproject created"
+'
+
+test_expect_success 'setup: create subprojects' '
+	mkdir sub1 &&
+	( cd sub1 && git init && : >Makefile && git add * &&
+	git commit -q -m "subproject 1" ) &&
+	mkdir sub2 &&
+	( cd sub2 && git init && : >Makefile && git add * &&
+	git commit -q -m "subproject 2" ) &&
+	git update-index --add sub1 &&
+	git add sub2 &&
+	git commit -q -m "subprojects added" &&
+	git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
+	git branch save HEAD &&
+	cat >expected <<-\EOF &&
+	:000000 160000 00000... A	sub1
+	:000000 160000 00000... A	sub2
+	EOF
+	test_cmp expected current
+'
+
+test_expect_success 'check if fsck ignores the subprojects' '
+	git fsck --full
+'
+
+test_expect_success 'check if commit in a subproject detected' '
+	( cd sub1 &&
+	echo "all:" >>Makefile &&
+	echo "	true" >>Makefile &&
+	git commit -q -a -m "make all" ) &&
+	test_expect_code 1 git diff-files --exit-code
+'
+
+test_expect_success 'check if a changed subproject HEAD can be committed' '
+	git commit -q -a -m "sub1 changed" &&
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD
+'
+
+test_expect_success 'check if diff-index works for subproject elements' '
+	test_expect_code 1 git diff-index --exit-code --cached save -- sub1
+'
+
+test_expect_success 'check if diff-tree works for subproject elements' '
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD -- sub1
+'
+
+test_expect_success 'check if git diff works for subproject elements' '
+	test_expect_code 1 git diff --exit-code HEAD^ HEAD
+'
+
+test_expect_success 'check if clone works' '
+	git ls-files -s >expected &&
+	git clone -l -s . cloned &&
+	( cd cloned && git ls-files -s ) >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'removing and adding subproject' '
+	git update-index --force-remove -- sub2 &&
+	mv sub2 sub3 &&
+	git add sub3 &&
+	git commit -q -m "renaming a subproject" &&
+	test_expect_code 1 git diff -M --name-status --exit-code HEAD^ HEAD
+'
 
 # the index must contain the object name the HEAD of the
 # subproject sub1 was at the point "save"
-test_expect_success 'checkout in superproject' \
-    'git checkout save &&
-    git diff-index --exit-code --raw --cached save -- sub1'
+test_expect_success 'checkout in superproject' '
+	git checkout save &&
+	git diff-index --exit-code --raw --cached save -- sub1
+'
 
 # just interesting what happened...
 # git diff --name-status -M save master
-- 
1.7.7.3
