From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] t4015: modernise style
Date: Tue, 26 May 2015 12:46:21 -0700
Message-ID: <1432669584-342-2-git-send-email-gitster@pobox.com>
References: <xmqq1ti3kz5v.fsf@gitster.dls.corp.google.com>
 <1432669584-342-1-git-send-email-gitster@pobox.com>
Cc: Christian Brabandt <cblists@256bit.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 21:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxKo4-0001jY-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbbEZTqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:46:30 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33376 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbEZTq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:46:28 -0400
Received: by iebgx4 with SMTP id gx4so100419022ieb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7/W8cseEGzKx758Z1/dnmqigVt0wSjyEipugbGkFvTI=;
        b=FEbdTor7J5FxD2Tv87Vu4TRenP5GLYvygoNnXL1yqJ6+VQm8mpmSCxBkmPLwygju79
         +IdAkq3LOIYLvom0szXYLFnNfOQ7WG+RW1WDEYgbcZC57a8DjL/47EI/KfMWht1XnomD
         pp4rkG3h11A21j2k6/zRq08mqBr2q3DcfknoHnw2aPveUfNHLv7/xGWC0eQWZna61n7J
         I66IDFPk/kO8pBkSZlYOyWRFAYHPRN0PGqMrWFLl+38O684N8+zbQ2fO76n4URSftVWO
         cLtftgA4Xi9x1lG/xi/Zfkn4NPoQUbGYPd9JVrkv1Si9Uqdaq+uDoUmEYUTCIN27vTT6
         3drA==
X-Received: by 10.107.136.38 with SMTP id k38mr34813890iod.56.1432669587677;
        Tue, 26 May 2015 12:46:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id i85sm9428947iod.41.2015.05.26.12.46.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 12:46:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.1-511-gc1146d5
In-Reply-To: <1432669584-342-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269971>

Move the preparatory steps that create the expected output inside
the test bodies, remove unnecessary blank lines before and after the
test bodies, and drop SP between redirection operator and its target.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4015-diff-whitespace.sh | 411 +++++++++++++++++++--------------------------
 1 file changed, 173 insertions(+), 238 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 604a838..0bfc7ff 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -9,138 +9,144 @@ test_description='Test special whitespace in diff engine.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-# Ray Lehtiniemi's example
+test_expect_success "Ray Lehtiniemi's example" '
+	cat <<-\EOF >x &&
+	do {
+	   nothing;
+	} while (0);
+	EOF
+	git update-index --add x &&
 
-cat << EOF > x
-do {
-   nothing;
-} while (0);
-EOF
+	cat <<-\EOF >x &&
+	do
+	{
+	   nothing;
+	}
+	while (0);
+	EOF
 
-git update-index --add x
+	cat <<-\EOF >expect &&
+	diff --git a/x b/x
+	index adf3937..6edc172 100644
+	--- a/x
+	+++ b/x
+	@@ -1,3 +1,5 @@
+	-do {
+	+do
+	+{
+	    nothing;
+	-} while (0);
+	+}
+	+while (0);
+	EOF
 
-cat << EOF > x
-do
-{
-   nothing;
-}
-while (0);
-EOF
+	git diff >out &&
+	test_cmp expect out &&
 
-cat << EOF > expect
-diff --git a/x b/x
-index adf3937..6edc172 100644
---- a/x
-+++ b/x
-@@ -1,3 +1,5 @@
--do {
-+do
-+{
-    nothing;
--} while (0);
-+}
-+while (0);
-EOF
+	git diff -w >out &&
+	test_cmp expect out &&
 
-git diff > out
-test_expect_success "Ray's example without options" 'test_cmp expect out'
+	git diff -b >out &&
+	test_cmp expect out
+'
 
-git diff -w > out
-test_expect_success "Ray's example with -w" 'test_cmp expect out'
+test_expect_success 'another test, without options' '
+	tr Q "\015" <<-\EOF >x &&
+	whitespace at beginning
+	whitespace change
+	whitespace in the middle
+	whitespace at end
+	unchanged line
+	CR at endQ
+	EOF
 
-git diff -b > out
-test_expect_success "Ray's example with -b" 'test_cmp expect out'
+	git update-index x &&
 
-tr 'Q' '\015' << EOF > x
-whitespace at beginning
-whitespace change
-whitespace in the middle
-whitespace at end
-unchanged line
-CR at endQ
-EOF
+	tr "_" " " <<-\EOF >x &&
+	_	whitespace at beginning
+	whitespace 	 change
+	white space in the middle
+	whitespace at end__
+	unchanged line
+	CR at end
+	EOF
 
-git update-index x
+	tr "Q_" "\015 " <<-\EOF >expect &&
+	diff --git a/x b/x
+	index d99af23..22d9f73 100644
+	--- a/x
+	+++ b/x
+	@@ -1,6 +1,6 @@
+	-whitespace at beginning
+	-whitespace change
+	-whitespace in the middle
+	-whitespace at end
+	+ 	whitespace at beginning
+	+whitespace 	 change
+	+white space in the middle
+	+whitespace at end__
+	 unchanged line
+	-CR at endQ
+	+CR at end
+	EOF
 
-tr '_' ' ' << EOF > x
-	whitespace at beginning
-whitespace 	 change
-white space in the middle
-whitespace at end__
-unchanged line
-CR at end
-EOF
+	git diff >out &&
+	test_cmp expect out &&
 
-tr 'Q_' '\015 ' << EOF > expect
-diff --git a/x b/x
-index d99af23..8b32fb5 100644
---- a/x
-+++ b/x
-@@ -1,6 +1,6 @@
--whitespace at beginning
--whitespace change
--whitespace in the middle
--whitespace at end
-+	whitespace at beginning
-+whitespace 	 change
-+white space in the middle
-+whitespace at end__
- unchanged line
--CR at endQ
-+CR at end
-EOF
-git diff > out
-test_expect_success 'another test, without options' 'test_cmp expect out'
+	>expect &&
+	git diff -w >out &&
+	test_cmp expect out &&
+
+	git diff -w -b >out &&
+	test_cmp expect out &&
+
+	git diff -w --ignore-space-at-eol >out &&
+	test_cmp expect out &&
+
+	git diff -w -b --ignore-space-at-eol >out &&
+	test_cmp expect out &&
 
-cat << EOF > expect
-EOF
-git diff -w > out
-test_expect_success 'another test, with -w' 'test_cmp expect out'
-git diff -w -b > out
-test_expect_success 'another test, with -w -b' 'test_cmp expect out'
-git diff -w --ignore-space-at-eol > out
-test_expect_success 'another test, with -w --ignore-space-at-eol' 'test_cmp expect out'
-git diff -w -b --ignore-space-at-eol > out
-test_expect_success 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'
-
-tr 'Q_' '\015 ' << EOF > expect
-diff --git a/x b/x
-index d99af23..8b32fb5 100644
---- a/x
-+++ b/x
-@@ -1,6 +1,6 @@
--whitespace at beginning
-+	whitespace at beginning
- whitespace 	 change
--whitespace in the middle
-+white space in the middle
- whitespace at end__
- unchanged line
- CR at end
-EOF
-git diff -b > out
-test_expect_success 'another test, with -b' 'test_cmp expect out'
-git diff -b --ignore-space-at-eol > out
-test_expect_success 'another test, with -b --ignore-space-at-eol' 'test_cmp expect out'
-
-tr 'Q_' '\015 ' << EOF > expect
-diff --git a/x b/x
-index d99af23..8b32fb5 100644
---- a/x
-+++ b/x
-@@ -1,6 +1,6 @@
--whitespace at beginning
--whitespace change
--whitespace in the middle
-+	whitespace at beginning
-+whitespace 	 change
-+white space in the middle
- whitespace at end__
- unchanged line
- CR at end
-EOF
-git diff --ignore-space-at-eol > out
-test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect out'
+
+	tr "Q_" "\015 " <<-\EOF >expect &&
+	diff --git a/x b/x
+	index d99af23..22d9f73 100644
+	--- a/x
+	+++ b/x
+	@@ -1,6 +1,6 @@
+	-whitespace at beginning
+	+_	whitespace at beginning
+	 whitespace 	 change
+	-whitespace in the middle
+	+white space in the middle
+	 whitespace at end__
+	 unchanged line
+	 CR at end
+	EOF
+	git diff -b >out &&
+	test_cmp expect out &&
+
+	git diff -b --ignore-space-at-eol >out &&
+	test_cmp expect out &&
+
+	tr "Q_" "\015 " <<-\EOF >expect &&
+	diff --git a/x b/x
+	index d99af23..22d9f73 100644
+	--- a/x
+	+++ b/x
+	@@ -1,6 +1,6 @@
+	-whitespace at beginning
+	-whitespace change
+	-whitespace in the middle
+	+_	whitespace at beginning
+	+whitespace 	 change
+	+white space in the middle
+	 whitespace at end__
+	 unchanged line
+	 CR at end
+	EOF
+	git diff --ignore-space-at-eol >out &&
+	test_cmp expect out
+'
 
 test_expect_success 'ignore-blank-lines: only new lines' '
 	test_seq 5 >x &&
@@ -489,291 +495,219 @@ test_expect_success 'ignore-blank-lines: mix changes and blank lines' '
 '
 
 test_expect_success 'check mixed spaces and tabs in indent' '
-
 	# This is indented with SP HT SP.
-	echo " 	 foo();" > x &&
+	echo " 	 foo();" >x &&
 	git diff --check | grep "space before tab in indent"
-
 '
 
 test_expect_success 'check mixed tabs and spaces in indent' '
-
 	# This is indented with HT SP HT.
-	echo "	 	foo();" > x &&
+	echo "	 	foo();" >x &&
 	git diff --check | grep "space before tab in indent"
-
 '
 
 test_expect_success 'check with no whitespace errors' '
-
 	git commit -m "snapshot" &&
-	echo "foo();" > x &&
+	echo "foo();" >x &&
 	git diff --check
-
 '
 
 test_expect_success 'check with trailing whitespace' '
-
-	echo "foo(); " > x &&
+	echo "foo(); " >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'check with space before tab in indent' '
-
 	# indent has space followed by hard tab
-	echo " 	foo();" > x &&
+	echo " 	foo();" >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success '--check and --exit-code are not exclusive' '
-
 	git checkout x &&
 	git diff --check --exit-code
-
 '
 
 test_expect_success '--check and --quiet are not exclusive' '
-
 	git diff --check --quiet
-
 '
 
 test_expect_success 'check staged with no whitespace errors' '
-
-	echo "foo();" > x &&
+	echo "foo();" >x &&
 	git add x &&
 	git diff --cached --check
-
 '
 
 test_expect_success 'check staged with trailing whitespace' '
-
-	echo "foo(); " > x &&
+	echo "foo(); " >x &&
 	git add x &&
 	test_must_fail git diff --cached --check
-
 '
 
 test_expect_success 'check staged with space before tab in indent' '
-
 	# indent has space followed by hard tab
-	echo " 	foo();" > x &&
+	echo " 	foo();" >x &&
 	git add x &&
 	test_must_fail git diff --cached --check
-
 '
 
 test_expect_success 'check with no whitespace errors (diff-index)' '
-
-	echo "foo();" > x &&
+	echo "foo();" >x &&
 	git add x &&
 	git diff-index --check HEAD
-
 '
 
 test_expect_success 'check with trailing whitespace (diff-index)' '
-
-	echo "foo(); " > x &&
+	echo "foo(); " >x &&
 	git add x &&
 	test_must_fail git diff-index --check HEAD
-
 '
 
 test_expect_success 'check with space before tab in indent (diff-index)' '
-
 	# indent has space followed by hard tab
-	echo " 	foo();" > x &&
+	echo " 	foo();" >x &&
 	git add x &&
 	test_must_fail git diff-index --check HEAD
-
 '
 
 test_expect_success 'check staged with no whitespace errors (diff-index)' '
-
-	echo "foo();" > x &&
+	echo "foo();" >x &&
 	git add x &&
 	git diff-index --cached --check HEAD
-
 '
 
 test_expect_success 'check staged with trailing whitespace (diff-index)' '
-
-	echo "foo(); " > x &&
+	echo "foo(); " >x &&
 	git add x &&
 	test_must_fail git diff-index --cached --check HEAD
-
 '
 
 test_expect_success 'check staged with space before tab in indent (diff-index)' '
-
 	# indent has space followed by hard tab
-	echo " 	foo();" > x &&
+	echo " 	foo();" >x &&
 	git add x &&
 	test_must_fail git diff-index --cached --check HEAD
-
 '
 
 test_expect_success 'check with no whitespace errors (diff-tree)' '
-
-	echo "foo();" > x &&
+	echo "foo();" >x &&
 	git commit -m "new commit" x &&
 	git diff-tree --check HEAD^ HEAD
-
 '
 
 test_expect_success 'check with trailing whitespace (diff-tree)' '
-
-	echo "foo(); " > x &&
+	echo "foo(); " >x &&
 	git commit -m "another commit" x &&
 	test_must_fail git diff-tree --check HEAD^ HEAD
-
 '
 
 test_expect_success 'check with space before tab in indent (diff-tree)' '
-
 	# indent has space followed by hard tab
-	echo " 	foo();" > x &&
+	echo " 	foo();" >x &&
 	git commit -m "yet another" x &&
 	test_must_fail git diff-tree --check HEAD^ HEAD
-
 '
 
 test_expect_success 'check trailing whitespace (trailing-space: off)' '
-
 	git config core.whitespace "-trailing-space" &&
-	echo "foo ();   " > x &&
+	echo "foo ();   " >x &&
 	git diff --check
-
 '
 
 test_expect_success 'check trailing whitespace (trailing-space: on)' '
-
 	git config core.whitespace "trailing-space" &&
-	echo "foo ();   " > x &&
+	echo "foo ();   " >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'check space before tab in indent (space-before-tab: off)' '
-
 	# indent contains space followed by HT
 	git config core.whitespace "-space-before-tab" &&
-	echo " 	foo ();" > x &&
+	echo " 	foo ();" >x &&
 	git diff --check
-
 '
 
 test_expect_success 'check space before tab in indent (space-before-tab: on)' '
-
 	# indent contains space followed by HT
 	git config core.whitespace "space-before-tab" &&
-	echo " 	foo ();   " > x &&
+	echo " 	foo ();   " >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'check spaces as indentation (indent-with-non-tab: off)' '
-
 	git config core.whitespace "-indent-with-non-tab" &&
-	echo "        foo ();" > x &&
+	echo "        foo ();" >x &&
 	git diff --check
-
 '
 
 test_expect_success 'check spaces as indentation (indent-with-non-tab: on)' '
-
 	git config core.whitespace "indent-with-non-tab" &&
-	echo "        foo ();" > x &&
+	echo "        foo ();" >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'ditto, but tabwidth=9' '
-
 	git config core.whitespace "indent-with-non-tab,tabwidth=9" &&
 	git diff --check
-
 '
 
 test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab: on)' '
-
 	git config core.whitespace "indent-with-non-tab" &&
-	echo "	                foo ();" > x &&
+	echo "	                foo ();" >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'ditto, but tabwidth=10' '
-
 	git config core.whitespace "indent-with-non-tab,tabwidth=10" &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'ditto, but tabwidth=20' '
-
 	git config core.whitespace "indent-with-non-tab,tabwidth=20" &&
 	git diff --check
-
 '
 
 test_expect_success 'check tabs as indentation (tab-in-indent: off)' '
-
 	git config core.whitespace "-tab-in-indent" &&
-	echo "	foo ();" > x &&
+	echo "	foo ();" >x &&
 	git diff --check
-
 '
 
 test_expect_success 'check tabs as indentation (tab-in-indent: on)' '
-
 	git config core.whitespace "tab-in-indent" &&
-	echo "	foo ();" > x &&
+	echo "	foo ();" >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'check tabs and spaces as indentation (tab-in-indent: on)' '
-
 	git config core.whitespace "tab-in-indent" &&
-	echo "	                foo ();" > x &&
+	echo "	                foo ();" >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'ditto, but tabwidth=1 (must be irrelevant)' '
-
 	git config core.whitespace "tab-in-indent,tabwidth=1" &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'check tab-in-indent and indent-with-non-tab conflict' '
-
 	git config core.whitespace "tab-in-indent,indent-with-non-tab" &&
-	echo "foo ();" > x &&
+	echo "foo ();" >x &&
 	test_must_fail git diff --check
-
 '
 
 test_expect_success 'check tab-in-indent excluded from wildcard whitespace attribute' '
-
 	git config --unset core.whitespace &&
-	echo "x whitespace" > .gitattributes &&
-	echo "	  foo ();" > x &&
+	echo "x whitespace" >.gitattributes &&
+	echo "	  foo ();" >x &&
 	git diff --check &&
 	rm -f .gitattributes
-
 '
 
 test_expect_success 'line numbers in --check output are correct' '
-
-	echo "" > x &&
-	echo "foo(); " >> x &&
+	echo "" >x &&
+	echo "foo(); " >>x &&
 	git diff --check | grep "x:2:"
-
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (1)' '
@@ -878,26 +812,27 @@ test_expect_success 'setup diff colors' '
 	git config color.diff.commit yellow &&
 	git config color.diff.whitespace "normal red" &&
 
-	git config core.autocrlf false
+	git config core.autocrlf false &&
+
+	cat >expected <<-\EOF
+	<BOLD>diff --git a/x b/x<RESET>
+	<BOLD>index 9daeafb..2874b91 100644<RESET>
+	<BOLD>--- a/x<RESET>
+	<BOLD>+++ b/x<RESET>
+	<CYAN>@@ -1 +1,4 @@<RESET>
+	 test<RESET>
+	<GREEN>+<RESET><GREEN>{<RESET>
+	<GREEN>+<RESET><BRED>	<RESET>
+	<GREEN>+<RESET><GREEN>}<RESET>
+	EOF
 '
-cat >expected <<\EOF
-<BOLD>diff --git a/x b/x<RESET>
-<BOLD>index 9daeafb..2874b91 100644<RESET>
-<BOLD>--- a/x<RESET>
-<BOLD>+++ b/x<RESET>
-<CYAN>@@ -1 +1,4 @@<RESET>
- test<RESET>
-<GREEN>+<RESET><GREEN>{<RESET>
-<GREEN>+<RESET><BRED>	<RESET>
-<GREEN>+<RESET><GREEN>}<RESET>
-EOF
 
 test_expect_success 'diff that introduces a line with only tabs' '
 	git config core.whitespace blank-at-eol &&
 	git reset --hard &&
-	echo "test" > x &&
+	echo "test" >x &&
 	git commit -m "initial" x &&
-	echo "{NTN}" | tr "NT" "\n\t" >> x &&
+	echo "{NTN}" | tr "NT" "\n\t" >>x &&
 	git -c color.diff=always diff | test_decode_color >current &&
 	test_cmp expected current
 '
-- 
2.4.1-511-gc1146d5
