From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] t1300: style updates
Date: Tue, 23 Oct 2012 18:35:54 -0400
Message-ID: <20121023223554.GA17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:36:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn4z-0008Os-UE
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933498Ab2JWWf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:35:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51672 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab2JWWf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:35:57 -0400
Received: (qmail 23225 invoked by uid 107); 23 Oct 2012 22:36:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:36:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:35:54 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208262>

The t1300 test script is quite old, and does not use our
modern techniques or styles. This patch updates it in the
following ways:

  1. Use test_cmp instead of cmp (to make failures easier to
     debug).

  2. Use test_cmp instead of 'test $(command) = expected'.
     This makes failures much easier to debug, and also
     makes sure that $(command) exits appropriately.

  3. Write tests with the usual style of:

       test_expect_success 'test name' '
               test commands &&
	       ...
       '

     rather than one-liners, or using backslash-continuation.
     This is purely a style fixup.

There are still a few command happening outside of
test_expect invocations, but they are all innoccuous system
commands like "cat" and "cp". In an ideal world, each test
would be self sufficient and all commands would happen
inside test_expect, but it is not immediately obvious how
the grouping should work (some of the commands impact the
subsequent tests, and some of them are setting up and
modifying state that many tests depend on). This patch just
picks the low-hanging style fruit, and we can do more fixes
on top later.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1300-repo-config.sh | 185 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 113 insertions(+), 72 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index e127f35..e12dd4a 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -55,11 +55,13 @@ test_expect_success 'replace with non-match' \
 	test_cmp expect .git/config
 '
 
-test_expect_success 'replace with non-match' \
-	'git config core.penguin kingpin !blue'
+test_expect_success 'replace with non-match' '
+	git config core.penguin kingpin !blue
+'
 
-test_expect_success 'replace with non-match (actually matching)' \
-	'git config core.penguin "very blue" !kingpin'
+test_expect_success 'replace with non-match (actually matching)' '
+	git config core.penguin "very blue" !kingpin
+'
 
 cat > expect << EOF
 [core]
@@ -108,8 +110,9 @@ EOF
 lines
 EOF
 
-test_expect_success 'unset with cont. lines' \
-	'git config --unset beta.baz'
+test_expect_success 'unset with cont. lines' '
+	git config --unset beta.baz
+'
 
 cat > expect <<\EOF
 [alpha]
@@ -133,8 +136,9 @@ cp .git/config .git/config2
 
 cp .git/config .git/config2
 
-test_expect_success 'multiple unset' \
-	'git config --unset-all beta.haha'
+test_expect_success 'multiple unset' '
+	git config --unset-all beta.haha
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -145,7 +149,9 @@ EOF
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'multiple unset is correct' 'test_cmp expect .git/config'
+test_expect_success 'multiple unset is correct' '
+	test_cmp expect .git/config
+'
 
 cp .git/config2 .git/config
 
@@ -156,8 +162,9 @@ rm .git/config2
 
 rm .git/config2
 
-test_expect_success '--replace-all' \
-	'git config --replace-all beta.haha gamma'
+test_expect_success '--replace-all' '
+	git config --replace-all beta.haha gamma
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -169,7 +176,9 @@ EOF
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'all replaced' 'test_cmp expect .git/config'
+test_expect_success 'all replaced' '
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -200,7 +209,11 @@ test_expect_success 'really really mean test' '
 	test_cmp expect .git/config
 '
 
-test_expect_success 'get value' 'test alpha = $(git config beta.haha)'
+test_expect_success 'get value' '
+	echo alpha >expect &&
+	git config beta.haha >actual &&
+	test_cmp expect actual
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -231,18 +244,21 @@ test_expect_success 'ambiguous get' '
 	test_cmp expect .git/config
 '
 
-test_expect_success 'non-match' \
-	'git config --get nextsection.nonewline !for'
+test_expect_success 'non-match' '
+	git config --get nextsection.nonewline !for
+'
 
-test_expect_success 'non-match value' \
-	'test wow = $(git config --get nextsection.nonewline !for)'
+test_expect_success 'non-match value' '
+	test wow = $(git config --get nextsection.nonewline !for)
+'
 
 test_expect_success 'ambiguous get' '
 	test_must_fail git config --get nextsection.nonewline
 '
 
-test_expect_success 'get multivar' \
-	'git config --get-all nextsection.nonewline'
+test_expect_success 'get multivar' '
+	git config --get-all nextsection.nonewline
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -290,8 +306,9 @@ test_expect_success 'correct key' 'git config 123456.a123 987'
 
 test_expect_success 'correct key' 'git config 123456.a123 987'
 
-test_expect_success 'hierarchical section' \
-	'git config Version.1.2.3eX.Alpha beta'
+test_expect_success 'hierarchical section' '
+	git config Version.1.2.3eX.Alpha beta
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -307,7 +324,9 @@ EOF
 	Alpha = beta
 EOF
 
-test_expect_success 'hierarchical section value' 'test_cmp expect .git/config'
+test_expect_success 'hierarchical section value' '
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 beta.noindent=sillyValue
@@ -316,9 +335,10 @@ EOF
 version.1.2.3eX.alpha=beta
 EOF
 
-test_expect_success 'working --list' \
-	'git config --list > output && cmp output expect'
-
+test_expect_success 'working --list' '
+	git config --list > output &&
+	test_cmp expect output
+'
 cat > expect << EOF
 EOF
 
@@ -332,8 +352,9 @@ EOF
 nextsection.nonewline wow2 for me
 EOF
 
-test_expect_success '--get-regexp' \
-	'git config --get-regexp in > output && cmp output expect'
+test_expect_success '--get-regexp' '
+	git config --get-regexp in > output && test_cmp expect output
+'
 
 cat > expect << EOF
 wow2 for me
@@ -353,41 +374,47 @@ echo false > expect
 	variable =
 EOF
 
-test_expect_success 'get variable with no value' \
-	'git config --get novalue.variable ^$'
+test_expect_success 'get variable with no value' '
+	git config --get novalue.variable ^$
+'
 
-test_expect_success 'get variable with empty value' \
-	'git config --get emptyvalue.variable ^$'
+test_expect_success 'get variable with empty value' '
+	git config --get emptyvalue.variable ^$
+'
 
 echo novalue.variable > expect
 
-test_expect_success 'get-regexp variable with no value' \
-	'git config --get-regexp novalue > output &&
-	 cmp output expect'
+test_expect_success 'get-regexp variable with no value' '
+	git config --get-regexp novalue > output &&
+	 test_cmp expect output'
 
 echo 'novalue.variable true' > expect
 
-test_expect_success 'get-regexp --bool variable with no value' \
-	'git config --bool --get-regexp novalue > output &&
-	 cmp output expect'
+test_expect_success 'get-regexp --bool variable with no value' '
+	git config --bool --get-regexp novalue > output &&
+	test_cmp expect output
+'
 
 echo 'emptyvalue.variable ' > expect
 
-test_expect_success 'get-regexp variable with empty value' \
-	'git config --get-regexp emptyvalue > output &&
-	 cmp output expect'
+test_expect_success 'get-regexp variable with empty value' '
+	git config --get-regexp emptyvalue > output &&
+	test_cmp expect output
+'
 
 echo true > expect
 
-test_expect_success 'get bool variable with no value' \
-	'git config --bool novalue.variable > output &&
-	 cmp output expect'
+test_expect_success 'get bool variable with no value' '
+	git config --bool novalue.variable > output &&
+	test_cmp expect output
+'
 
 echo false > expect
 
-test_expect_success 'get bool variable with empty value' \
-	'git config --bool emptyvalue.variable > output &&
-	 cmp output expect'
+test_expect_success 'get bool variable with empty value' '
+	git config --bool emptyvalue.variable > output &&
+	test_cmp expect output
+'
 
 test_expect_success 'no arguments, but no crash' '
 	test_must_fail git config >output 2>&1 &&
@@ -427,8 +454,9 @@ test_expect_success 'new variable inserts into proper section' '
 	test_cmp expect .git/config
 '
 
-test_expect_success 'alternative GIT_CONFIG (non-existing file should fail)' \
-	'test_must_fail git config --file non-existing-config -l'
+test_expect_success 'alternative GIT_CONFIG (non-existing file should fail)' '
+	test_must_fail git config --file non-existing-config -l
+'
 
 cat > other-config << EOF
 [ein]
@@ -444,8 +472,10 @@ test_expect_success 'alternative GIT_CONFIG' '
 	test_cmp expect output
 '
 
-test_expect_success 'alternative GIT_CONFIG (--file)' \
-	'git config --file other-config -l > output && cmp output expect'
+test_expect_success 'alternative GIT_CONFIG (--file)' '
+	git config --file other-config -l > output &&
+	test_cmp expect output
+'
 
 test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
@@ -489,8 +519,9 @@ EOF
 weird
 EOF
 
-test_expect_success "rename section" \
-	"git config --rename-section branch.eins branch.zwei"
+test_expect_success 'rename section' '
+	git config --rename-section branch.eins branch.zwei
+'
 
 cat > expect << EOF
 # Hallo
@@ -503,17 +534,22 @@ test_expect_success "rename succeeded" "test_cmp expect .git/config"
 weird
 EOF
 
-test_expect_success "rename succeeded" "test_cmp expect .git/config"
+test_expect_success 'rename succeeded' '
+	test_cmp expect .git/config
+'
 
-test_expect_success "rename non-existing section" '
+test_expect_success 'rename non-existing section' '
 	test_must_fail git config --rename-section \
 		branch."world domination" branch.drei
 '
 
-test_expect_success "rename succeeded" "test_cmp expect .git/config"
+test_expect_success 'rename succeeded' '
+	test_cmp expect .git/config
+'
 
-test_expect_success "rename another section" \
-	'git config --rename-section branch."1 234 blabl/a" branch.drei'
+test_expect_success 'rename another section' '
+	git config --rename-section branch."1 234 blabl/a" branch.drei
+'
 
 cat > expect << EOF
 # Hallo
@@ -526,14 +562,17 @@ EOF
 weird
 EOF
 
-test_expect_success "rename succeeded" "test_cmp expect .git/config"
+test_expect_success 'rename succeeded' '
+	test_cmp expect .git/config
+'
 
 cat >> .git/config << EOF
 [branch "vier"] z = 1
 EOF
 
-test_expect_success "rename a section with a var on the same line" \
-	'git config --rename-section branch.vier branch.zwei'
+test_expect_success 'rename a section with a var on the same line' '
+	git config --rename-section branch.vier branch.zwei
+'
 
 cat > expect << EOF
 # Hallo
@@ -548,7 +587,9 @@ EOF
 	z = 1
 EOF
 
-test_expect_success "rename succeeded" "test_cmp expect .git/config"
+test_expect_success 'rename succeeded' '
+	test_cmp expect .git/config
+'
 
 test_expect_success 'renaming empty section name is rejected' '
 	test_must_fail git config --rename-section branch.zwei ""
@@ -562,7 +603,9 @@ EOF
   [branch "zwei"] a = 1 [branch "vier"]
 EOF
 
-test_expect_success "remove section" "git config --remove-section branch.zwei"
+test_expect_success 'remove section' '
+	git config --remove-section branch.zwei
+'
 
 cat > expect << EOF
 # Hallo
@@ -571,8 +614,9 @@ EOF
 weird
 EOF
 
-test_expect_success "section was removed properly" \
-	"test_cmp expect .git/config"
+test_expect_success 'section was removed properly' '
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [gitcvs]
@@ -583,7 +627,6 @@ test_expect_success 'section ending' '
 EOF
 
 test_expect_success 'section ending' '
-
 	rm -f .git/config &&
 	git config gitcvs.enabled true &&
 	git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
@@ -593,7 +636,6 @@ test_expect_success numbers '
 '
 
 test_expect_success numbers '
-
 	git config kilo.gram 1k &&
 	git config mega.ton 1m &&
 	k=$(git config --int --get kilo.gram) &&
@@ -607,7 +649,6 @@ test_expect_success 'invalid unit' '
 EOF
 
 test_expect_success 'invalid unit' '
-
 	git config aninvalid.unit "1auto" &&
 	s=$(git config aninvalid.unit) &&
 	test "z1auto" = "z$s" &&
@@ -616,7 +657,7 @@ test_expect_success 'invalid unit' '
 		echo config should have failed
 		false
 	fi &&
-	cmp actual expect
+	test_cmp actual expect
 '
 
 cat > expect << EOF
@@ -646,7 +687,7 @@ test_expect_success bool '
 	    git config --bool --get bool.true$i >>result
 	    git config --bool --get bool.false$i >>result
         done &&
-	cmp expect result'
+	test_cmp expect result'
 
 test_expect_success 'invalid bool (--get)' '
 
@@ -680,7 +721,7 @@ test_expect_success 'set --bool' '
 	git config --bool bool.false2 "" &&
 	git config --bool bool.false3 nO &&
 	git config --bool bool.false4 FALSE &&
-	cmp expect .git/config'
+	test_cmp expect .git/config'
 
 cat > expect <<\EOF
 [int]
@@ -695,7 +736,7 @@ test_expect_success 'set --int' '
 	git config --int int.val1 01 &&
 	git config --int int.val2 -1 &&
 	git config --int int.val3 5m &&
-	cmp expect .git/config'
+	test_cmp expect .git/config'
 
 cat >expect <<\EOF
 [bool]
@@ -844,7 +885,7 @@ test_expect_success 'value continued on next line' '
 
 test_expect_success 'value continued on next line' '
 	git config --list > result &&
-	cmp result expect
+	test_cmp result expect
 '
 
 cat > .git/config <<\EOF
-- 
1.8.0.3.g3456896
