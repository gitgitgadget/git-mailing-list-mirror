From: Jeff King <peff@peff.net>
Subject: [PATCH 04/25] t: fix trivial &&-chain breakage
Date: Fri, 20 Mar 2015 06:07:15 -0400
Message-ID: <20150320100714.GD12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtps-0000ne-Iu
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbbCTKHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:07:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:35674 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751401AbbCTKHR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:07:17 -0400
Received: (qmail 5598 invoked by uid 102); 20 Mar 2015 10:07:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:07:17 -0500
Received: (qmail 21453 invoked by uid 107); 20 Mar 2015 10:07:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:07:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:07:15 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265878>

These are tests which are missing a link in their &&-chain,
but during a setup phase. We may fail to notice failure in
commands that build the test environment, but these are
typically not expected to fail at all (but it's still good
to double-check that our test environment is what we
expect).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/annotate-tests.sh                    |  2 +-
 t/t0000-basic.sh                       |  4 ++--
 t/t0011-hashmap.sh                     |  2 +-
 t/t0201-gettext-fallbacks.sh           |  4 ++--
 t/t1006-cat-file.sh                    |  2 +-
 t/t3010-ls-files-killed-modified.sh    |  2 +-
 t/t3404-rebase-interactive.sh          |  2 +-
 t/t3405-rebase-malformed.sh            |  4 ++--
 t/t3425-rebase-topology-merges.sh      |  4 ++--
 t/t3600-rm.sh                          |  4 ++--
 t/t4014-format-patch.sh                |  2 +-
 t/t4041-diff-submodule-option.sh       | 10 ++++++----
 t/t4049-diff-stat-count.sh             |  6 +++---
 t/t4054-diff-bogus-tree.sh             |  2 +-
 t/t5500-fetch-pack.sh                  |  2 +-
 t/t5510-fetch.sh                       |  2 +-
 t/t5526-fetch-submodules.sh            | 10 +++++-----
 t/t5531-deep-submodule-push.sh         |  2 +-
 t/t5533-push-cas.sh                    |  4 ++--
 t/t5541-http-push-smart.sh             |  2 +-
 t/t5550-http-fetch-dumb.sh             |  2 +-
 t/t5551-http-fetch-smart.sh            |  2 +-
 t/t6000-rev-list-misc.sh               |  4 ++--
 t/t6006-rev-list-format.sh             |  2 +-
 t/t6022-merge-rename.sh                |  6 +++---
 t/t6036-recursive-corner-cases.sh      |  2 +-
 t/t6111-rev-list-treesame.sh           |  2 +-
 t/t6200-fmt-merge-msg.sh               |  2 +-
 t/t7004-tag.sh                         |  2 +-
 t/t7006-pager.sh                       |  2 +-
 t/t7009-filter-branch-null-sha1.sh     |  2 +-
 t/t7400-submodule-basic.sh             |  4 ++--
 t/t7406-submodule-update.sh            |  2 +-
 t/t7508-status.sh                      |  8 ++++----
 t/t7510-signed-commit.sh               |  2 +-
 t/t7600-merge.sh                       |  2 +-
 t/t7612-merge-verify-signatures.sh     |  2 +-
 t/t8003-blame-corner-cases.sh          |  8 ++++----
 t/t8008-blame-formats.sh               |  2 +-
 t/t9001-send-email.sh                  |  2 +-
 t/t9300-fast-import.sh                 |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh |  2 +-
 t/t9903-bash-prompt.sh                 |  2 +-
 43 files changed, 70 insertions(+), 68 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 071e4d7..f5c0175 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -405,7 +405,7 @@ test_expect_success 'setup -L :regex' '
 	mv hello.c hello.orig &&
 	echo "#include <stdio.h>" >hello.c &&
 	cat hello.orig >>hello.c &&
-	tr Q "\\t" >>hello.c <<-\EOF
+	tr Q "\\t" >>hello.c <<-\EOF &&
 	void mail()
 	{
 	Qputs("mail");
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f10ba4a..79b9074 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -253,7 +253,7 @@ test_expect_success 'test --verbose' '
 	test_expect_success "failing test" false
 	test_done
 	EOF
-	mv test-verbose/out test-verbose/out+
+	mv test-verbose/out test-verbose/out+ &&
 	grep -v "^Initialized empty" test-verbose/out+ >test-verbose/out &&
 	check_sub_test_lib_test test-verbose <<-\EOF
 	> expecting success: true
@@ -974,7 +974,7 @@ test_expect_success 'writing this tree with --missing-ok' '
 
 ################################################################
 test_expect_success 'git read-tree followed by write-tree should be idempotent' '
-	rm -f .git/index
+	rm -f .git/index &&
 	git read-tree $tree &&
 	test -f .git/index &&
 	newtree=$(git write-tree) &&
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index f97c805..9c217d9 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -218,7 +218,7 @@ test_expect_success 'grow / shrink' '
 	echo size >> in &&
 	echo 64 51 >> expect &&
 	echo put key52 value52 >> in &&
-	echo NULL >> expect
+	echo NULL >> expect &&
 	echo size >> in &&
 	echo 256 52 >> expect &&
 	for n in $(test_seq 12)
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 00c6d3d..90da1c7 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -50,7 +50,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate v
 
 test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate variables with spaces' '
     cmdline="git am" &&
-    export cmdline;
+    export cmdline &&
     printf "When you have resolved this problem, run git am --resolved." >expect &&
     eval_gettext "When you have resolved this problem, run \$cmdline --resolved." >actual &&
     test_i18ncmp expect actual
@@ -58,7 +58,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate v
 
 test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate variables with spaces and quotes' '
     cmdline="git am" &&
-    export cmdline;
+    export cmdline &&
     printf "When you have resolved this problem, run \"git am --resolved\"." >expect &&
     eval_gettext "When you have resolved this problem, run \"\$cmdline --resolved\"." >actual &&
     test_i18ncmp expect actual
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index a72e700..ab36b1e 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -274,7 +274,7 @@ test_expect_success 'setup blobs which are likely to delta' '
 '
 
 test_expect_success 'confirm that neither loose blob is a delta' '
-	cat >expect <<-EOF
+	cat >expect <<-EOF &&
 	$_z40
 	$_z40
 	EOF
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index ea6a678..62fce10 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -62,7 +62,7 @@ test_expect_success 'git update-index --add to add various paths.' '
 			cd submod$i && git commit --allow-empty -m "empty $i"
 		) || break
 	done &&
-	git update-index --add submod[12]
+	git update-index --add submod[12] &&
 	(
 		cd submod1 &&
 		git commit --allow-empty -m "empty 1 (updated)"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index edad20d..eed76cc 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1007,7 +1007,7 @@ test_expect_success 'rebase -i with --strategy and -X' '
 '
 
 test_expect_success 'rebase -i error on commits with \ in message' '
-	current_head=$(git rev-parse HEAD)
+	current_head=$(git rev-parse HEAD) &&
 	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
 	test_commit TO-REMOVE will-conflict old-content &&
 	test_commit "\temp" will-conflict new-content dummy &&
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index 19eddad..ff8c360 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 	git add file1 file2 &&
 	test_tick &&
 	git commit -m "Initial commit" &&
-	git branch diff-in-message
+	git branch diff-in-message &&
 
 	git checkout -b multi-line-subject &&
 	cat F >file2 &&
@@ -36,7 +36,7 @@ test_expect_success setup '
 
 	git checkout diff-in-message &&
 	echo "commit log message containing a diff" >G &&
-	echo "" >>G
+	echo "" >>G &&
 	cat G >file2 &&
 	git add file2 &&
 	git diff --cached >>G &&
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 1d195fb..846f85c 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup of non-linear-history' '
 	test_commit c &&
 	git checkout b &&
 	test_commit d &&
-	test_commit e
+	test_commit e &&
 
 	git checkout c &&
 	test_commit g &&
@@ -33,7 +33,7 @@ test_expect_success 'setup of non-linear-history' '
 	cherry_pick gp g &&
 	test_commit i &&
 	git checkout b &&
-	test_commit f
+	test_commit f &&
 
 	git checkout d &&
 	test_commit n &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b0db89b..1962989 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -183,7 +183,7 @@ test_expect_success 'refuse to remove cached empty file with modifications' '
 
 test_expect_success 'remove intent-to-add file without --force' '
 	echo content >intent-to-add &&
-	git add -N intent-to-add
+	git add -N intent-to-add &&
 	git rm --cached intent-to-add
 '
 
@@ -201,7 +201,7 @@ test_expect_success 'Recursive without -r fails' '
 '
 
 test_expect_success 'Recursive with -r but dirty' '
-	echo qfwfq >>frotz/nitfol
+	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 256affc..c39e500 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -802,7 +802,7 @@ test_expect_success '--no-signature suppresses format.signaturefile ' '
 '
 
 test_expect_success '--signature-file overrides format.signaturefile' '
-	cat >other-mail-signature <<-\EOF
+	cat >other-mail-signature <<-\EOF &&
 	Use this other signature instead of mail-signature.
 	EOF
 	test_config format.signaturefile mail-signature &&
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index ff61341..2d9731b 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -528,10 +528,12 @@ test_expect_success 'diff --submodule with objects referenced by alternates' '
 		sha1_before=$(git rev-parse --short HEAD)
 		echo b >b &&
 		git add b &&
-		git commit -m b
-		sha1_after=$(git rev-parse --short HEAD)
-		echo "Submodule sub $sha1_before..$sha1_after:
-  > b" >../expected
+		git commit -m b &&
+		sha1_after=$(git rev-parse --short HEAD) &&
+		{
+			echo "Submodule sub $sha1_before..$sha1_after:" &&
+			echo "  > b"
+		} >../expected
 	) &&
 	(cd super &&
 		(cd sub &&
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 5b594e8..a341217 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -18,7 +18,7 @@ test_expect_success 'mode-only change show as a 0-line change' '
 	test_chmod +x b d &&
 	echo a >a &&
 	echo c >c &&
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	 a | 1 +
 	 b | 0
 	 ...
@@ -33,7 +33,7 @@ test_expect_success 'binary changes do not count in lines' '
 	echo a >a &&
 	echo c >c &&
 	cat "$TEST_DIRECTORY"/test-binary-1.png >d &&
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	 a | 1 +
 	 c | 1 +
 	 ...
@@ -55,7 +55,7 @@ test_expect_success 'exclude unmerged entries from total file count' '
 	done |
 	git update-index --index-info &&
 	echo d >d &&
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	 a | 1 +
 	 b | 1 +
 	 ...
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index 0843c87..1d6efab 100755
--- a/t/t4054-diff-bogus-tree.sh
+++ b/t/t4054-diff-bogus-tree.sh
@@ -16,7 +16,7 @@ test_expect_success 'create bogus tree' '
 test_expect_success 'create tree with matching file' '
 	echo bar >foo &&
 	git add foo &&
-	good_tree=$(git write-tree)
+	good_tree=$(git write-tree) &&
 	blob=$(git rev-parse :foo)
 '
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index bd37f04..692d717 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -414,7 +414,7 @@ test_expect_success 'setup tests for the --stdin parameter' '
 	do
 		git tag $head $head
 	done &&
-	cat >input <<-\EOF
+	cat >input <<-\EOF &&
 	refs/heads/C
 	refs/heads/A
 	refs/heads/D
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d3fa2c9..0ba9db0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -596,7 +596,7 @@ test_configured_prune () {
 			test_unconfig remote.origin.prune &&
 			git fetch &&
 			git rev-parse --verify refs/remotes/origin/newbranch
-		)
+		) &&
 
 		# now remove it
 		git branch -d newbranch &&
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index ca5b027..a4532b0 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -216,7 +216,7 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 	head2=$(git rev-parse --short HEAD) &&
 	echo "Fetching submodule submodule" > expect.out.sub &&
 	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.sub
+	echo "   $head1..$head2  master     -> origin/master" >>expect.err.sub &&
 	head -2 expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
@@ -315,7 +315,7 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 		) &&
 		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
-		git commit -m "new deepsubmodule"
+		git commit -m "new deepsubmodule" &&
 		head2=$(git rev-parse --short HEAD) &&
 		echo "From $pwd/submodule" > ../expect.err.sub &&
 		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
@@ -337,7 +337,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	head2=$(git rev-parse --short HEAD) &&
 	tail -2 expect.err > expect.err.deepsub &&
 	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err
+	echo "   $head1..$head2  master     -> origin/master" >>expect.err &&
 	cat expect.err.sub >> expect.err &&
 	cat expect.err.deepsub >> expect.err &&
 	(
@@ -387,7 +387,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2
+	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
 	head -2 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
@@ -415,7 +415,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2
+	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
 	head -2 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 445bb5f..6507487 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -104,7 +104,7 @@ test_expect_success 'push fails when commit on multiple branches if one branch h
 '
 
 test_expect_success 'push succeeds if submodule has no remote and is on the first superproject commit' '
-	git init --bare a
+	git init --bare a &&
 	git clone a a1 &&
 	(
 		cd a1 &&
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index ba20d83..dccf8a6 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -159,7 +159,7 @@ test_expect_success 'cover everything with default force-with-lease (protected)'
 	(
 		cd src &&
 		git branch naster master^
-	)
+	) &&
 	git ls-remote src refs/heads/\* >expect &&
 	(
 		cd dst &&
@@ -174,7 +174,7 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
 	(
 		cd src &&
 		git branch naster master^
-	)
+	) &&
 	(
 		cd dst &&
 		git fetch &&
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d2c681e..47cee53 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -158,7 +158,7 @@ test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
 	# create a dissimilarly-named remote ref so that git is unable to match the
 	# two refs (viz. local, remote) unless an explicit refspec is provided.
-	git push origin master:retsam
+	git push origin master:retsam &&
 
 	echo "change changed" > path2 &&
 	git commit -a -m path2 --amend &&
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 2731ad4..61e087e 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup repository' '
 	git config push.default matching &&
 	echo content1 >file &&
 	git add file &&
-	git commit -m one
+	git commit -m one &&
 	echo content2 >file &&
 	git add file &&
 	git commit -m two
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index ef2feea..cf0a6ea 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -83,7 +83,7 @@ test_expect_success 'clone http repository' '
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-	git push public
+	git push public &&
 	(cd clone && git pull) &&
 	test_cmp file clone/file
 '
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 2602086..7911ed9 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -42,7 +42,7 @@ test_expect_success 'rev-list --objects with pathspecs and copied files' '
 	test_tick &&
 	git commit -m that &&
 
-	ONE=$(git rev-parse HEAD:one)
+	ONE=$(git rev-parse HEAD:one) &&
 	git rev-list --objects HEAD two >output &&
 	grep "$ONE two/three" output &&
 	! grep one output
@@ -85,7 +85,7 @@ test_expect_success 'rev-list can show index objects' '
 	#   - we do not show the root tree; since we updated the index, it
 	#     does not have a valid cache tree
 	#
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	8e4020bb5a8d8c873b25de15933e75cc0fc275df one
 	d9d3a7417b9605cfd88ee6306b28dadc29e6ab08 only-in-index
 	9200b628cf9dc883a85a7abc8d6e6730baee589c two
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a02a45a..2b7c0f0 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -45,7 +45,7 @@ test_expect_success 'setup' '
 	head2=$(git rev-parse --verify HEAD) &&
 	head2_short=$(git rev-parse --verify --short $head2) &&
 	tree2=$(git rev-parse --verify HEAD:) &&
-	tree2_short=$(git rev-parse --verify --short $tree2)
+	tree2_short=$(git rev-parse --verify --short $tree2) &&
 	git config --unset i18n.commitEncoding
 '
 
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index a89dfbe..05ebba7 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -685,7 +685,7 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 	git add -A &&
 	git commit -mA &&
 
-	git checkout -b side
+	git checkout -b side &&
 	git rm -rf df &&
 	git commit -mB &&
 
@@ -716,7 +716,7 @@ test_expect_success 'setup avoid unnecessary update, modify/delete' '
 	git add -A &&
 	git commit -mA &&
 
-	git checkout -b side
+	git checkout -b side &&
 	git rm -f file &&
 	git commit -m "Delete file" &&
 
@@ -745,7 +745,7 @@ test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
 	git add -A &&
 	git commit -mA &&
 
-	git checkout -b side
+	git checkout -b side &&
 	cp file newfile &&
 	git add -A &&
 	git commit -m "Add file copy" &&
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b43d031..8923b04 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -86,7 +86,7 @@ test_expect_success 'setup criss-cross + rename merges with basic modification'
 	rm -rf .git &&
 	git init &&
 
-	ten="0 1 2 3 4 5 6 7 8 9"
+	ten="0 1 2 3 4 5 6 7 8 9" &&
 	for i in $ten
 	do
 		echo line $i in a sample file
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 88b84df..45e3673 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -58,7 +58,7 @@ test_expect_success setup '
 
 	git checkout master &&
 	test_tick && git merge --no-ff fiddler-branch &&
-	note K
+	note K &&
 
 	test_commit "file=Part 1" file "Part 1" L &&
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 54b5744..2e2fb0e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -194,7 +194,7 @@ test_expect_success '--log=5 with custom comment character' '
 '
 
 test_expect_success 'merge.log=0 disables shortlog' '
-	echo "Merge branch ${apos}left${apos}" >expected
+	echo "Merge branch ${apos}left${apos}" >expected &&
 	git -c merge.log=0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 35c805a..347d3be 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1180,7 +1180,7 @@ test_expect_success 'message in editor has initial comment: first line' '
 test_expect_success \
 	'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
-	>rest.expect
+	>rest.expect &&
 	sed -e 1d -e '/^#/d' <actual >rest.actual &&
 	test_cmp rest.expect rest.actual
 '
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index da958a8..947b690 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -396,7 +396,7 @@ test_expect_success TTY 'command-specific pager overrides core.pager' '
 	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
-	test_config core.pager "exit 1"
+	test_config core.pager "exit 1" &&
 	test_config pager.log "sed s/^/foo:/ >actual" &&
 	test_terminal git log --format=%s -1 &&
 	test_cmp expect actual
diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7009-filter-branch-null-sha1.sh
index a997f7a..c27f90f 100755
--- a/t/t7009-filter-branch-null-sha1.sh
+++ b/t/t7009-filter-branch-null-sha1.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup: a commit with a bogus null sha1 in the tree' '
 	{
 		git ls-tree HEAD &&
 		printf "160000 commit $_z40\\tbroken\\n"
-	} >broken-tree
+	} >broken-tree &&
 	echo "add broken entry" >msg &&
 
 	tree=$(git mktree <broken-tree) &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5811a98..540771c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -766,7 +766,7 @@ test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
 		git submodule status >expect
-	)
+	) &&
 	mv addtest addtest2 &&
 	(
 		cd addtest2 &&
@@ -987,7 +987,7 @@ test_expect_success 'submodule with UTF-8 name' '
 
 test_expect_success 'submodule add clone shallow submodule' '
 	mkdir super &&
-	pwd=$(pwd)
+	pwd=$(pwd) &&
 	(
 		cd super &&
 		git init &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 29d3d2c..dda3929 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -754,7 +754,7 @@ test_expect_success SYMLINKS 'submodule update can handle symbolic links in pwd'
 
 test_expect_success 'submodule update clone shallow submodule' '
 	git clone cloned super3 &&
-	pwd=$(pwd)
+	pwd=$(pwd) &&
 	(cd super3 &&
 	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 	 mv -f .gitmodules.tmp .gitmodules &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 6b16bcb..0f9ad4c 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -431,7 +431,7 @@ test_expect_success 'status -s -uno' '
 '
 
 test_expect_success 'status -s (status.showUntrackedFiles no)' '
-	git config status.showuntrackedfiles no
+	git config status.showuntrackedfiles no &&
 	git status -s >output &&
 	test_cmp expect output
 '
@@ -465,7 +465,7 @@ EOF
 '
 
 test_expect_success 'status (status.showUntrackedFiles normal)' '
-	test_config status.showuntrackedfiles normal
+	test_config status.showuntrackedfiles normal &&
 	git status >output &&
 	test_i18ncmp expect output
 '
@@ -485,7 +485,7 @@ test_expect_success 'status -s -unormal' '
 '
 
 test_expect_success 'status -s (status.showUntrackedFiles normal)' '
-	git config status.showuntrackedfiles normal
+	git config status.showuntrackedfiles normal &&
 	git status -s >output &&
 	test_cmp expect output
 '
@@ -520,7 +520,7 @@ EOF
 '
 
 test_expect_success 'status (status.showUntrackedFiles all)' '
-	test_config status.showuntrackedfiles all
+	test_config status.showuntrackedfiles all &&
 	git status >output &&
 	test_i18ncmp expect output
 '
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 474dab3..fc1ff45 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -42,7 +42,7 @@ test_expect_success GPG 'create signed commits' '
 	git tag seventh-unsigned &&
 
 	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
-	git tag seventh-signed
+	git tag seventh-signed &&
 
 	echo 8 >file && test_tick && git commit -a -m eighth -SB7227189 &&
 	git tag eighth-signed-alt
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b164621..75c50ee 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -133,7 +133,7 @@ test_expect_success 'setup' '
 	test_tick &&
 	git commit -m "commit 3" &&
 	git tag c3 &&
-	c3=$(git rev-parse HEAD)
+	c3=$(git rev-parse HEAD) &&
 	git reset --hard "$c0" &&
 	create_merge_msgs
 '
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index 21a0bf8..8ae69a6 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -29,7 +29,7 @@ test_expect_success GPG 'create signed commits' '
 
 	git checkout -b side-untrusted &&
 	echo 3 >baz && git add baz &&
-	test_tick && git commit -SB7227189 -m "untrusted on side"
+	test_tick && git commit -SB7227189 -m "untrusted on side" &&
 
 	git checkout master
 '
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 2a3469b..32895e5 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -26,7 +26,7 @@ test_expect_success setup '
 	cat one >uno &&
 	mv two dos &&
 	cat one >>tres &&
-	echo DEF >>mouse
+	echo DEF >>mouse &&
 	git add uno dos tres mouse &&
 	test_tick &&
 	GIT_AUTHOR_NAME=Second git commit -a -m Second &&
@@ -153,15 +153,15 @@ test_expect_success 'blame path that used to be a directory' '
 '
 
 test_expect_success 'blame to a commit with no author name' '
-  TREE=`git rev-parse HEAD:`
-  cat >badcommit <<EOF
+  TREE=`git rev-parse HEAD:` &&
+  cat >badcommit <<EOF &&
 tree $TREE
 author <noname> 1234567890 +0000
 committer David Reiss <dreiss@facebook.com> 1234567890 +0000
 
 some message
 EOF
-  COMMIT=`git hash-object -t commit -w badcommit`
+  COMMIT=`git hash-object -t commit -w badcommit` &&
   git --no-pager blame $COMMIT -- uno >/dev/null
 '
 
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index d15f8b3..29f84a6 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -5,7 +5,7 @@ test_description='blame output in various formats on a simple case'
 
 test_expect_success 'setup' '
 	echo a >file &&
-	git add file
+	git add file &&
 	test_tick &&
 	git commit -m one &&
 	echo b >>file &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0513055..37caa18 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1325,7 +1325,7 @@ test_expect_success $PREREQ 'sendemail.transferencoding=7bit fails on 8bit data'
 
 test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEncoding' '
 	clean_fake_sendmail &&
-	git config sendemail.transferEncoding 8bit
+	git config sendemail.transferEncoding 8bit &&
 	test_must_fail git send-email \
 		--transfer-encoding=7bit \
 		--smtp-server="$(pwd)/fake.sendmail" \
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6bd5a00..584b538 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1132,7 +1132,7 @@ test_expect_success \
 	 compare_diff_raw expect actual'
 
 test_expect_success PIPE 'N: read and copy directory' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
 	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
 	EOF
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index e74b9ab..f9f078e 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -297,7 +297,7 @@ test_expect_success 'setup incomplete lines' '
 	echo "Dominus regit me," >file &&
 	echo "incomplete line" | tr -d "\\012" >>file &&
 	git commit -a -m "Change incomplete line" &&
-	git tag incomplete_lines_chg
+	git tag incomplete_lines_chg &&
 	echo "Dominus regit me," >file &&
 	git commit -a -m "Remove incomplete line" &&
 	git tag incomplete_lines_rem
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 51ecd3e..0c6acdd 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -166,7 +166,7 @@ test_expect_success 'prompt - inside bare repository' '
 '
 
 test_expect_success 'prompt - interactive rebase' '
-	printf " (b1|REBASE-i 2/3)" >expected
+	printf " (b1|REBASE-i 2/3)" >expected &&
 	write_script fake_editor.sh <<-\EOF &&
 		echo "exec echo" >"$1"
 		echo "edit $(git log -1 --format="%h")" >>"$1"
-- 
2.3.3.520.g3cfbb5d
