From: Jeff King <peff@peff.net>
Subject: [PATCH 02/25] t: fix severe &&-chain breakage
Date: Fri, 20 Mar 2015 06:06:15 -0400
Message-ID: <20150320100614.GB12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:06:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtos-0008NQ-KU
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbbCTKGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:06:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:35668 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751987AbbCTKGR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:06:17 -0400
Received: (qmail 5551 invoked by uid 102); 20 Mar 2015 10:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:06:17 -0500
Received: (qmail 21412 invoked by uid 107); 20 Mar 2015 10:06:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:06:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:06:15 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265876>

These are tests which are missing a link in their &&-chain,
in a location which causes a significant portion of the test
to be missed (e.g., the test effectively does nothing, or
consists of a long string of actions and output comparisons,
and we throw away the exit code of at least one part of the
string).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1300-repo-config.sh            |  2 +-
 t/t1403-show-ref.sh               | 10 +++++-----
 t/t1700-split-index.sh            |  2 +-
 t/t3600-rm.sh                     |  2 +-
 t/t4047-diff-dirstat.sh           |  2 +-
 t/t4104-apply-boundary.sh         |  4 ++--
 t/t4202-log.sh                    |  2 +-
 t/t5100-mailinfo.sh               |  2 +-
 t/t5510-fetch.sh                  |  2 +-
 t/t5540-http-push-webdav.sh       |  2 +-
 t/t5551-http-fetch-smart.sh       |  2 +-
 t/t6036-recursive-corner-cases.sh |  2 +-
 t/t9300-fast-import.sh            |  2 +-
 t/t9902-completion.sh             |  2 +-
 14 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 938fc8b..bc0b392 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -677,7 +677,7 @@ test_expect_success 'invalid unit' '
 	echo 1auto >expect &&
 	git config aninvalid.unit >actual &&
 	test_cmp expect actual &&
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in .git/config: invalid unit
 	EOF
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 3e500ed..7e10bcf 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -28,7 +28,7 @@ test_expect_success 'show-ref' '
 
 	>expect &&
 
-	test_must_fail git show-ref D >actual
+	test_must_fail git show-ref D >actual &&
 	test_cmp expect actual
 '
 
@@ -62,7 +62,7 @@ test_expect_success 'show-ref --verify' '
 	test_must_fail git show-ref --verify tags/A >actual &&
 	test_cmp expect actual &&
 
-	test_must_fail git show-ref --verify D >actual
+	test_must_fail git show-ref --verify D >actual &&
 	test_cmp expect actual
 '
 
@@ -78,7 +78,7 @@ test_expect_success 'show-ref --verify -q' '
 	test_must_fail git show-ref --verify -q tags/A >actual &&
 	test_cmp expect actual &&
 
-	test_must_fail git show-ref --verify -q D >actual
+	test_must_fail git show-ref --verify -q D >actual &&
 	test_cmp expect actual
 '
 
@@ -105,10 +105,10 @@ test_expect_success 'show-ref -d' '
 	test_cmp expect actual &&
 
 	git show-ref -d refs/heads/master >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
 
 	git show-ref -d --verify refs/heads/master >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
 
 	>expect &&
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 94fb473..a55f5bc 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -182,7 +182,7 @@ test_expect_success 'unify index, two files remain' '
 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
 EOF
-	test_cmp ls-files.expect ls-files.actual
+	test_cmp ls-files.expect ls-files.actual &&
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<EOF &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index e00d7d2..b0db89b 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -170,7 +170,7 @@ test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	test_must_fail git ls-files --error-unmatch foo
+	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
 
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 0d50dce..3b8b792 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -374,7 +374,7 @@ test_expect_success 'later options override earlier options:' '
 	git diff --dirstat=files,10,cumulative,changes,noncumulative,3 -M HEAD^..HEAD >actual_diff_dirstat_M &&
 	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
 	git diff --dirstat=files,10,cumulative,changes,noncumulative,3 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
-	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC &&
 	git diff --dirstat=files --dirstat=10 --dirstat=cumulative --dirstat=changes --dirstat=noncumulative -X3 HEAD^..HEAD >actual_diff_dirstat &&
 	test_cmp expect_diff_dirstat actual_diff_dirstat &&
 	git diff --dirstat=files --dirstat=10 --dirstat=cumulative --dirstat=changes --dirstat=noncumulative -X3 -M HEAD^..HEAD >actual_diff_dirstat_M &&
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index c617c2a..c97aad1 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -78,8 +78,8 @@ test_expect_success setup '
 		echo $i
 	done >victim &&
 	cat victim >del-z-expect &&
-	git diff victim >del-z-patch.with
-	git diff --unified=0 >del-z-patch.without &&
+	git diff victim >del-z-patch.with &&
+	git diff --unified=0 >del-z-patch.without
 
 	: done
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f2b290..a22ac7c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -481,7 +481,7 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline --no-decorate >actual &&
 	test_cmp expect.none actual &&
 	git log --oneline --decorate >actual &&
-	test_cmp expect.short actual
+	test_cmp expect.short actual &&
 
 	test_unconfig log.decorate &&
 	git log --pretty=raw >expect.raw &&
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 60df10f..e97cfb2 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -34,7 +34,7 @@ do
 		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--no-inbody-headers
 		then
 			check_mailinfo $mail --no-inbody-headers
-		fi
+		fi &&
 		if test -f "$TEST_DIRECTORY"/t5100/msg$mail--message-id
 		then
 			check_mailinfo $mail --message-id
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d78f320..d3fa2c9 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -124,7 +124,7 @@ test_expect_success 'fetch --prune handles overlapping refspecs' '
 	git rev-parse origin/master &&
 	git rev-parse origin/pr/42 &&
 
-	git config --unset-all remote.origin.fetch
+	git config --unset-all remote.origin.fetch &&
 	git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
 	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
 
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 8d7b3c5..88ff5a4 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -169,7 +169,7 @@ test_expect_failure 'push to password-protected repository (no user in URL)' '
 	test_commit pw-nouser &&
 	set_askpass user@host pass@host &&
 	git push "$HTTPD_URL/auth/dumb/test_repo.git" HEAD &&
-	expect_askpass both user@host
+	expect_askpass both user@host &&
 	git rev-parse --verify HEAD >expect &&
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
 		rev-parse --verify HEAD >actual &&
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6cbc12d..eae20d9 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -169,7 +169,7 @@ test_expect_success 'GIT_SMART_HTTP can disable smart http' '
 '
 
 test_expect_success 'invalid Content-Type rejected' '
-	test_must_fail git clone $HTTPD_URL/broken_smart/repo.git 2>actual
+	test_must_fail git clone $HTTPD_URL/broken_smart/repo.git 2>actual &&
 	grep "not valid:" actual
 '
 
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index a86087b..b43d031 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -533,7 +533,7 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 
 	test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
 	test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
-	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file)
+	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
 	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 
 	test -f a~D^0
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c538e0a..6bd5a00 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2228,7 +2228,7 @@ test_expect_success 'R: feature import-marks-if-exists' '
 	>expect &&
 
 	git fast-import --import-marks-if-exists=not_io.marks \
-			--export-marks=io.marks <<-\EOF
+			--export-marks=io.marks <<-\EOF &&
 	feature import-marks-if-exists=io.marks
 	EOF
 	test_cmp expect io.marks
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7a883d1..4a14a58 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -568,7 +568,7 @@ test_expect_success 'complete files' '
 	test_completion "git commit " "modified" &&
 
 	: TODO .gitignore should not be here &&
-	test_completion "git ls-files " <<-\EOF
+	test_completion "git ls-files " <<-\EOF &&
 	.gitignore
 	dir
 	modified
-- 
2.3.3.520.g3cfbb5d
