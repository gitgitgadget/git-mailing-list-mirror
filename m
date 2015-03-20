From: Jeff King <peff@peff.net>
Subject: [PATCH 03/25] t: fix moderate &&-chain breakage
Date: Fri, 20 Mar 2015 06:06:44 -0400
Message-ID: <20150320100644.GC12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtpQ-0000Kh-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbbCTKGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:06:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:35671 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751401AbbCTKGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:06:46 -0400
Received: (qmail 5592 invoked by uid 102); 20 Mar 2015 10:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:06:46 -0500
Received: (qmail 21428 invoked by uid 107); 20 Mar 2015 10:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:06:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:06:44 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265877>

These are tests which are missing a link in their &&-chain,
but in a way that probably does not effect the outcome of
the test. Most of these are of the form:

  some_cmd >actual
  test_cmp expect actual

The main point of the test is to verify the output, and a
failure in some_cmd would probably be noticed by bogus
output. But it is good for the tests to also confirm that
"some_cmd" does not die unexpectedly after producing its
output.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0062-revision-walking.sh         |  2 +-
 t/t0201-gettext-fallbacks.sh        |  4 ++--
 t/t1300-repo-config.sh              |  2 +-
 t/t3001-ls-files-others-exclude.sh  |  2 +-
 t/t3010-ls-files-killed-modified.sh |  4 ++--
 t/t3404-rebase-interactive.sh       |  2 +-
 t/t4041-diff-submodule-option.sh    |  2 +-
 t/t4052-stat-output.sh              | 34 +++++++++++++++++-----------------
 t/t4212-log-corrupt.sh              |  2 +-
 t/t5551-http-fetch-smart.sh         |  2 +-
 t/t5709-clone-refspec.sh            |  2 +-
 t/t6028-merge-up-to-date.sh         |  2 +-
 t/t6132-pathspec-exclude.sh         | 28 ++++++++++++++--------------
 13 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
index 3d98eb8..113c728 100755
--- a/t/t0062-revision-walking.sh
+++ b/t/t0062-revision-walking.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'revision walking can be done twice' '
-	test-revision-walking run-twice > run_twice_actual
+	test-revision-walking run-twice >run_twice_actual &&
 	test_cmp run_twice_expected run_twice_actual
 '
 
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 5d80a98..00c6d3d 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -52,7 +52,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate v
     cmdline="git am" &&
     export cmdline;
     printf "When you have resolved this problem, run git am --resolved." >expect &&
-    eval_gettext "When you have resolved this problem, run \$cmdline --resolved." >actual
+    eval_gettext "When you have resolved this problem, run \$cmdline --resolved." >actual &&
     test_i18ncmp expect actual
 '
 
@@ -60,7 +60,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate v
     cmdline="git am" &&
     export cmdline;
     printf "When you have resolved this problem, run \"git am --resolved\"." >expect &&
-    eval_gettext "When you have resolved this problem, run \"\$cmdline --resolved\"." >actual
+    eval_gettext "When you have resolved this problem, run \"\$cmdline --resolved\"." >actual &&
     test_i18ncmp expect actual
 '
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index bc0b392..66dd286 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1165,7 +1165,7 @@ test_expect_failure 'adding a key into an empty section reuses header' '
 	Qkey = value
 	EOF
 
-	git config section.key value
+	git config section.key value &&
 	test_cmp expect .git/config
 '
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index b2798fe..3fc484e 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -294,7 +294,7 @@ one/a.1
 one/two/a.1
 three/a.1
 EOF
-	git ls-files -o -i --exclude "**/a.1" >actual
+	git ls-files -o -i --exclude "**/a.1" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 6d3b828..ea6a678 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -99,12 +99,12 @@ test_expect_success 'git ls-files -k to show killed files.' '
 '
 
 test_expect_success 'git ls-files -k output (w/o icase)' '
-	git ls-files -k >.output
+	git ls-files -k >.output &&
 	test_cmp .expected .output
 '
 
 test_expect_success 'git ls-files -k output (w/ icase)' '
-	git -c core.ignorecase=true ls-files -k >.output
+	git -c core.ignorecase=true ls-files -k >.output &&
 	test_cmp .expected .output
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 034eb35..edad20d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -950,7 +950,7 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	set_fake_editor &&
 	FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
 	FAKE_LINES="2 1" git rebase --edit-todo &&
-	git rebase --continue
+	git rebase --continue &&
 	test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index e432896..ff61341 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -539,7 +539,7 @@ test_expect_success 'diff --submodule with objects referenced by alternates' '
 			git checkout origin/master
 		) &&
 		git diff --submodule > ../actual
-	)
+	) &&
 	test_cmp expected actual
 '
 
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index b68afef..4a02b17 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -94,7 +94,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (big change)" '
-		COLUMNS=200 git $cmd $args >output
+		COLUMNS=200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -102,7 +102,7 @@ do
 	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
-		COLUMNS=200 git $cmd $args --graph >output
+		COLUMNS=200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -122,7 +122,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
-		COLUMNS=40 git $cmd $args >output
+		COLUMNS=40 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -130,7 +130,7 @@ do
 	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb not enough COLUMNS (big change)" '
-		COLUMNS=40 git $cmd $args --graph >output
+		COLUMNS=40 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -150,7 +150,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb statGraphWidth config" '
-		git -c diff.statGraphWidth=26 $cmd $args >output
+		git -c diff.statGraphWidth=26 $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -158,7 +158,7 @@ do
 	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb statGraphWidth config" '
-		git -c diff.statGraphWidth=26 $cmd $args --graph >output
+		git -c diff.statGraphWidth=26 $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -179,19 +179,19 @@ EOF
 while read cmd args
 do
 	test_expect_success "$cmd --stat=width with big change" '
-		git $cmd $args --stat=40 >output
+		git $cmd $args --stat=40 >output &&
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "$cmd --stat-width=width with big change" '
-		git $cmd $args --stat-width=40 >output
+		git $cmd $args --stat-width=40 >output &&
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "$cmd --stat-graph-width with big change" '
-		git $cmd $args --stat-graph-width=26 >output
+		git $cmd $args --stat-graph-width=26 >output &&
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
@@ -199,13 +199,13 @@ do
 	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --stat-width=width --graph with big change" '
-		git $cmd $args --stat-width=40 --graph >output
+		git $cmd $args --stat-width=40 --graph >output &&
 		grep " | " output >actual &&
 		test_cmp expect-graph actual
 	'
 
 	test_expect_success "$cmd --stat-graph-width --graph with big change" '
-		git $cmd $args --stat-graph-width=26 --graph >output
+		git $cmd $args --stat-graph-width=26 --graph >output &&
 		grep " | " output >actual &&
 		test_cmp expect-graph actual
 	'
@@ -265,7 +265,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (long filename)" '
-		COLUMNS=200 git $cmd $args >output
+		COLUMNS=200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -273,7 +273,7 @@ do
 	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
-		COLUMNS=200 git $cmd $args --graph >output
+		COLUMNS=200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -294,7 +294,7 @@ while read verb expect cmd args
 do
 	test_expect_success COLUMNS_CAN_BE_1 \
 		"$cmd $verb prefix greater than COLUMNS (big change)" '
-		COLUMNS=1 git $cmd $args >output
+		COLUMNS=1 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -303,7 +303,7 @@ do
 
 	test_expect_success COLUMNS_CAN_BE_1 \
 		"$cmd --graph $verb prefix greater than COLUMNS (big change)" '
-		COLUMNS=1 git $cmd $args --graph >output
+		COLUMNS=1 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -320,7 +320,7 @@ EOF
 test_expect_success 'merge --stat respects COLUMNS (big change)' '
 	git checkout -b branch HEAD^^ &&
 	COLUMNS=100 git merge --stat --no-ff master^ >output &&
-	grep " | " output >actual
+	grep " | " output >actual &&
 	test_cmp expect actual
 '
 
@@ -329,7 +329,7 @@ cat >expect <<'EOF'
 EOF
 test_expect_success 'merge --stat respects COLUMNS (long filename)' '
 	COLUMNS=100 git merge --stat --no-ff master >output &&
-	grep " | " output >actual
+	grep " | " output >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 67bd8ec..22aa8b7 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -61,7 +61,7 @@ test_expect_success 'unparsable dates produce sentinel value' '
 test_expect_success 'unparsable dates produce sentinel value (%ad)' '
 	commit=$(munge_author_date HEAD totally_bogus) &&
 	echo >expect &&
-	git log -1 --format=%ad $commit >actual
+	git log -1 --format=%ad $commit >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index eae20d9..ef2feea 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -209,7 +209,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
 	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
-	tail -3 cookies.txt > cookies_tail.txt
+	tail -3 cookies.txt >cookies_tail.txt &&
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
 
diff --git a/t/t5709-clone-refspec.sh b/t/t5709-clone-refspec.sh
index 6f1ea98..7ace253 100755
--- a/t/t5709-clone-refspec.sh
+++ b/t/t5709-clone-refspec.sh
@@ -147,7 +147,7 @@ test_expect_success '--single-branch with detached' '
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
-	)
+	) &&
 	# nothing
 	>expect &&
 	test_cmp expect actual
diff --git a/t/t6028-merge-up-to-date.sh b/t/t6028-merge-up-to-date.sh
index c518e9c..7763c1b 100755
--- a/t/t6028-merge-up-to-date.sh
+++ b/t/t6028-merge-up-to-date.sh
@@ -83,7 +83,7 @@ test_expect_success 'merge fast-forward octopus' '
 
 	git reset --hard c0 &&
 	test_tick &&
-	git merge c1 c2
+	git merge c1 c2 &&
 	expect=$(git rev-parse c2) &&
 	current=$(git rev-parse HEAD) &&
 	test "$expect" = "$current"
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 62049be..e1e1b1f 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -30,7 +30,7 @@ test_expect_success 'exclude only should error out' '
 '
 
 test_expect_success 't_e_i() exclude sub' '
-	git log --oneline --format=%s -- . ":(exclude)sub" >actual
+	git log --oneline --format=%s -- . ":(exclude)sub" >actual &&
 	cat <<EOF >expect &&
 sub2/file
 file
@@ -39,7 +39,7 @@ EOF
 '
 
 test_expect_success 't_e_i() exclude sub/sub/file' '
-	git log --oneline --format=%s -- . ":(exclude)sub/sub/file" >actual
+	git log --oneline --format=%s -- . ":(exclude)sub/sub/file" >actual &&
 	cat <<EOF >expect &&
 sub2/file
 sub/sub/sub/file
@@ -51,7 +51,7 @@ EOF
 '
 
 test_expect_success 't_e_i() exclude sub using mnemonic' '
-	git log --oneline --format=%s -- . ":!sub" >actual
+	git log --oneline --format=%s -- . ":!sub" >actual &&
 	cat <<EOF >expect &&
 sub2/file
 file
@@ -60,7 +60,7 @@ EOF
 '
 
 test_expect_success 't_e_i() exclude :(icase)SUB' '
-	git log --oneline --format=%s -- . ":(exclude,icase)SUB" >actual
+	git log --oneline --format=%s -- . ":(exclude,icase)SUB" >actual &&
 	cat <<EOF >expect &&
 sub2/file
 file
@@ -71,7 +71,7 @@ EOF
 test_expect_success 't_e_i() exclude sub2 from sub' '
 	(
 	cd sub &&
-	git log --oneline --format=%s -- :/ ":/!sub2" >actual
+	git log --oneline --format=%s -- :/ ":/!sub2" >actual &&
 	cat <<EOF >expect &&
 sub/sub/sub/file
 sub/file2
@@ -84,7 +84,7 @@ EOF
 '
 
 test_expect_success 't_e_i() exclude sub/*file' '
-	git log --oneline --format=%s -- . ":(exclude)sub/*file" >actual
+	git log --oneline --format=%s -- . ":(exclude)sub/*file" >actual &&
 	cat <<EOF >expect &&
 sub2/file
 sub/file2
@@ -94,7 +94,7 @@ EOF
 '
 
 test_expect_success 't_e_i() exclude :(glob)sub/*/file' '
-	git log --oneline --format=%s -- . ":(exclude,glob)sub/*/file" >actual
+	git log --oneline --format=%s -- . ":(exclude,glob)sub/*/file" >actual &&
 	cat <<EOF >expect &&
 sub2/file
 sub/sub/sub/file
@@ -106,7 +106,7 @@ EOF
 '
 
 test_expect_success 'm_p_d() exclude sub' '
-	git ls-files -- . ":(exclude)sub" >actual
+	git ls-files -- . ":(exclude)sub" >actual &&
 	cat <<EOF >expect &&
 file
 sub2/file
@@ -115,7 +115,7 @@ EOF
 '
 
 test_expect_success 'm_p_d() exclude sub/sub/file' '
-	git ls-files -- . ":(exclude)sub/sub/file" >actual
+	git ls-files -- . ":(exclude)sub/sub/file" >actual &&
 	cat <<EOF >expect &&
 file
 sub/file
@@ -127,7 +127,7 @@ EOF
 '
 
 test_expect_success 'm_p_d() exclude sub using mnemonic' '
-	git ls-files -- . ":!sub" >actual
+	git ls-files -- . ":!sub" >actual &&
 	cat <<EOF >expect &&
 file
 sub2/file
@@ -136,7 +136,7 @@ EOF
 '
 
 test_expect_success 'm_p_d() exclude :(icase)SUB' '
-	git ls-files -- . ":(exclude,icase)SUB" >actual
+	git ls-files -- . ":(exclude,icase)SUB" >actual &&
 	cat <<EOF >expect &&
 file
 sub2/file
@@ -147,7 +147,7 @@ EOF
 test_expect_success 'm_p_d() exclude sub2 from sub' '
 	(
 	cd sub &&
-	git ls-files -- :/ ":/!sub2" >actual
+	git ls-files -- :/ ":/!sub2" >actual &&
 	cat <<EOF >expect &&
 ../file
 file
@@ -160,7 +160,7 @@ EOF
 '
 
 test_expect_success 'm_p_d() exclude sub/*file' '
-	git ls-files -- . ":(exclude)sub/*file" >actual
+	git ls-files -- . ":(exclude)sub/*file" >actual &&
 	cat <<EOF >expect &&
 file
 sub/file2
@@ -170,7 +170,7 @@ EOF
 '
 
 test_expect_success 'm_p_d() exclude :(glob)sub/*/file' '
-	git ls-files -- . ":(exclude,glob)sub/*/file" >actual
+	git ls-files -- . ":(exclude,glob)sub/*/file" >actual &&
 	cat <<EOF >expect &&
 file
 sub/file
-- 
2.3.3.520.g3cfbb5d
