Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B6C433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 01:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhLMBir (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 20:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhLMBim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 20:38:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA85C061751
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso10637460wmr.5
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUgiUezVjgv5Exj73bJOYWPxKbb+dQZQsK4hcwYZGy0=;
        b=naPV966b5TQD5QhidBsZTiPyKPHEpPDpfk+VVwCilfak6SGBrn25VNVCI7d0q+k2Te
         Qxac+bXc6hDMaWCWr1rzqxSfWvCQwNV+U8NLU1R7v4c7I6TQVGj818/zZY5mbdos6th9
         E0uUrL82e5lc60oR5yMLodklXK2G7xqR2CgfufWRNt9+7MXs1K4mLV566EH+LDWdZlJ9
         wjnyk5J0uHHip4Zla52YbY8qNiK8WtkontlxwyCgBv2xkDUVSFgPihCtNP4G+ohT15Jv
         l8QpAS8l7bDnxjzjPVlQg6bwcpYcBKRc+bnOwBoNRX+6yfsQSVEMUo84lpFG/ZNAJa1o
         gAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUgiUezVjgv5Exj73bJOYWPxKbb+dQZQsK4hcwYZGy0=;
        b=aQwCFBEJW8J6dz3ukiGDVCDyn6K32GoKRtzgWF64gNftL4F7zIDD1zg7kE/VJIEpNG
         8p/AY2dgovr1nc5kFPD7L4lM+7uAG/hySYdGVT//QLps8++yWJZM1BruUCO20nQyCpm7
         umm/21tqKHFYnit2aUrhlpVGe75dsljq9d2kpnrNwhLNzgC+ImPzVj1QYroOo8hTk/f9
         pi2rL8zbspWr2YawBUWtuUMGInX8mFrbCtJMKUiSjCgA0lBVnDInHSAODBCaf29lLyo0
         NiGBt7PQJ0FDqorCNqXrR2JEssre9vuvE1OdbJRe6pwXRXWDesW+IXzqKN2/quKoSrTI
         s5uA==
X-Gm-Message-State: AOAM531Ai54YdgNwIF8ZGU64343Cgolc5n1BB1KR964n051GKgoKQNd/
        hASn9fw2/UJGK1XaRCnRUA6IFoaSUdEE0g==
X-Google-Smtp-Source: ABdhPJzS+efNpreaiB4BrrgVYeHUIIHh3jyiCc+l5Tdlha4hT+hK5AwAxUft+vgqrM5GfTrnnacFkA==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr34270419wmj.76.1639359519504;
        Sun, 12 Dec 2021 17:38:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm11571303wrs.59.2021.12.12.17.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 17:38:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/3] t1510: remove need for "test_untraceable", retain coverage
Date:   Mon, 13 Dec 2021 02:38:34 +0100
Message-Id: <patch-v4-1.3-9e7b089dc50-20211213T013559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1024.g573f2f4b767
In-Reply-To: <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com> <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the tests checking whether stderr is empty added in
4868b2ea17b (Subject: setup: officially support --work-tree without
--git-dir, 2011-01-19) work portably on all POSIX shells, instead
suppressing the trace output with "test_untraceable" on shells that
aren't bash.

The tests that used the "try_repo" helper wanted to check whether git
commands invoked therein would emit anything on stderr. To do this
they invoked the function and redirected the stderr to a "message"
file.

In 58275069288 (t1510-repo-setup: mark as untraceable with '-x',
2018-02-24) these were made to use "test_untraceable" introduced in
5fc98e79fc0 (t: add means to disable '-x' tracing for individual test
scripts, 2018-02-24).

It is better to have the "try_repo" function itself start with a
"test_when_finished 'rm stderr'", and then redirect the stderr output
from git commands it invokes via its helpers to a "stderr" file.

This means that if we have a failure it'll be closer to the source of
the problem, and most importantly isn't incompatible with "-x" on
shells that aren't "bash".

We also need to split those tests that had two "try_repo" invocations
into different tests, which'll further help to narrow down any
potential failures. This wasn't strictly necessary (an artifact of the
use of "test_when_finished"), but the pattern enforces better test
hygiene.

The functions it calls might change directories, so we pass an
absolute "$stderr_log_path" around. We also need to change a "$(pwd)"
to "$PWD" in test_repo(), on e.g. "dash" that interpolation will be
traced and part of the "2>>" redirection.

1. https://lore.kernel.org/git/YbMiK1wHzBfYvK2a@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1510-repo-setup.sh | 85 +++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 591505a39c0..fc94d8b49be 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -40,9 +40,6 @@ A few rules for repo setup:
     prefix is NULL.
 "
 
-# This test heavily relies on the standard error of nested function calls.
-test_untraceable=UnfortunatelyYes
-
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
@@ -62,7 +59,7 @@ test_repo () {
 			export GIT_WORK_TREE
 		fi &&
 		rm -f trace &&
-		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
+		GIT_TRACE_SETUP="$PWD/trace" git symbolic-ref HEAD >/dev/null 2>>"$stderr_log_path" &&
 		grep '^setup: ' trace >result &&
 		test_cmp expected result
 	)
@@ -72,7 +69,7 @@ maybe_config () {
 	file=$1 var=$2 value=$3 &&
 	if test "$value" != unset
 	then
-		git config --file="$file" "$var" "$value"
+		git config --file="$file" "$var" "$value" 2>>"$stderr_log_path"
 	fi
 }
 
@@ -80,7 +77,7 @@ setup_repo () {
 	name=$1 worktreecfg=$2 gitfile=$3 barecfg=$4 &&
 	sane_unset GIT_DIR GIT_WORK_TREE &&
 
-	git -c init.defaultBranch=initial init "$name" &&
+	git -c init.defaultBranch=initial init "$name" 2>>"$stderr_log_path" &&
 	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
 	maybe_config "$name/.git/config" core.bare "$barecfg" &&
 	mkdir -p "$name/sub/sub" &&
@@ -210,10 +207,14 @@ run_wt_tests () {
 #	(git dir) (work tree) (cwd) (prefix)	<-- from subdir
 try_repo () {
 	name=$1 worktreeenv=$2 gitdirenv=$3 &&
+	stderr_log_path="$PWD/stderr" &&
+
+	test_when_finished "rm \"$stderr_log_path\"" &&
 	setup_repo "$name" "$4" "$5" "$6" &&
 	shift 6 &&
 	try_case "$name" "$worktreeenv" "$gitdirenv" \
 		"$1" "$2" "$3" "$4" &&
+	test_must_be_empty "$stderr_log_path" &&
 	shift 4 &&
 	case "$gitdirenv" in
 	/* | ?:/* | unset) ;;
@@ -221,7 +222,8 @@ try_repo () {
 		gitdirenv=../$gitdirenv ;;
 	esac &&
 	try_case "$name/sub" "$worktreeenv" "$gitdirenv" \
-		"$1" "$2" "$3" "$4"
+		"$1" "$2" "$3" "$4" &&
+	test_must_be_empty "$stderr_log_path"
 }
 
 # Bit 0 = GIT_WORK_TREE
@@ -234,15 +236,13 @@ try_repo () {
 test_expect_success '#0: nonbare repo, no explicit configuration' '
 	try_repo 0 unset unset unset "" unset \
 		.git "$here/0" "$here/0" "(null)" \
-		.git "$here/0" "$here/0" sub/ 2>message &&
-	test_must_be_empty message
+		.git "$here/0" "$here/0" sub/
 '
 
 test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
 	try_repo 1 "$here" unset unset "" unset \
 		"$here/1/.git" "$here" "$here" 1/ \
-		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
-	test_must_be_empty message
+		"$here/1/.git" "$here" "$here" 1/sub/
 '
 
 test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
@@ -268,19 +268,20 @@ test_expect_success '#4: core.worktree without GIT_DIR set is accepted' '
 	mkdir -p 4/sub sub &&
 	try_case 4 unset unset \
 		.git "$here/4/sub" "$here/4" "(null)" \
-		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)" 2>message &&
-	test_must_be_empty message
+		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)"
 '
 
-test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
+test_expect_success '#5.1: core.worktree + GIT_WORK_TREE is accepted' '
 	# or: you cannot intimidate away the lack of GIT_DIR setting
 	try_repo 5 "$here" unset "$here/5" "" unset \
 		"$here/5/.git" "$here" "$here" 5/ \
-		"$here/5/.git" "$here" "$here" 5/sub/ 2>message &&
+		"$here/5/.git" "$here" "$here" 5/sub/
+'
+
+test_expect_success '#5.2: core.worktree + GIT_WORK_TREE is accepted' '
 	try_repo 5a .. unset "$here/5a" "" unset \
 		"$here/5a/.git" "$here" "$here" 5a/ \
-		"$here/5a/.git" "$here/5a" "$here/5a" sub/ &&
-	test_must_be_empty message
+		"$here/5a/.git" "$here/5a" "$here/5a" sub/
 '
 
 test_expect_success '#6: setting GIT_DIR brings core.worktree to life' '
@@ -376,8 +377,7 @@ test_expect_success '#9: GIT_WORK_TREE accepted with gitfile' '
 	mkdir -p 9/wt &&
 	try_repo 9 wt unset unset gitfile unset \
 		"$here/9.git" "$here/9/wt" "$here/9" "(null)" \
-		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)" 2>message &&
-	test_must_be_empty message
+		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)"
 '
 
 test_expect_success '#10: GIT_DIR can point to gitfile' '
@@ -402,16 +402,14 @@ run_wt_tests 11 gitfile
 test_expect_success '#12: core.worktree with gitfile is accepted' '
 	try_repo 12 unset unset "$here/12" gitfile unset \
 		"$here/12.git" "$here/12" "$here/12" "(null)" \
-		"$here/12.git" "$here/12" "$here/12" sub/ 2>message &&
-	test_must_be_empty message
+		"$here/12.git" "$here/12" "$here/12" sub/
 '
 
 test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
 	# or: you cannot intimidate away the lack of GIT_DIR setting
 	try_repo 13 non-existent-too unset non-existent gitfile unset \
 		"$here/13.git" "$here/13/non-existent-too" "$here/13" "(null)" \
-		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)" 2>message &&
-	test_must_be_empty message
+		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)"
 '
 
 # case #14.
@@ -549,8 +547,7 @@ test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (ba
 	mkdir -p 17b/.git/wt/sub &&
 
 	try_case 17a/.git "$here/17a" unset \
-		"$here/17a/.git" "$here/17a" "$here/17a" .git/ \
-		2>message &&
+		"$here/17a/.git" "$here/17a" "$here/17a" .git/ &&
 	try_case 17a/.git/wt "$here/17a" unset \
 		"$here/17a/.git" "$here/17a" "$here/17a" .git/wt/ &&
 	try_case 17a/.git/wt/sub "$here/17a" unset \
@@ -565,14 +562,16 @@ test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (ba
 
 	try_repo 17c "$here/17c" unset unset "" true \
 		.git "$here/17c" "$here/17c" "(null)" \
-		"$here/17c/.git" "$here/17c" "$here/17c" sub/ 2>message &&
-	test_must_be_empty message
+		"$here/17c/.git" "$here/17c" "$here/17c" sub/
 '
 
-test_expect_success '#18: bare .git named by GIT_DIR has no worktree' '
+test_expect_success '#18.1: bare .git named by GIT_DIR has no worktree' '
 	try_repo 18 unset .git unset "" true \
 		.git "(null)" "$here/18" "(null)" \
-		../.git "(null)" "$here/18/sub" "(null)" &&
+		../.git "(null)" "$here/18/sub" "(null)"
+'
+
+test_expect_success '#18.2: bare .git named by GIT_DIR has no worktree' '
 	try_repo 18b unset "$here/18b/.git" unset "" true \
 		"$here/18b/.git" "(null)" "$here/18b" "(null)" \
 		"$here/18b/.git" "(null)" "$here/18b/sub" "(null)"
@@ -590,12 +589,11 @@ test_expect_success '#20a: core.worktree without GIT_DIR accepted (inside .git)'
 	setup_repo 20a "$here/20a" "" unset &&
 	mkdir -p 20a/.git/wt/sub &&
 	try_case 20a/.git unset unset \
-		"$here/20a/.git" "$here/20a" "$here/20a" .git/ 2>message &&
+		"$here/20a/.git" "$here/20a" "$here/20a" .git/ &&
 	try_case 20a/.git/wt unset unset \
 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/ &&
 	try_case 20a/.git/wt/sub unset unset \
-		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/ &&
-	test_must_be_empty message
+		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/
 '
 
 test_expect_success '#20b/c: core.worktree and core.bare conflict' '
@@ -625,10 +623,9 @@ test_expect_success '#21: setup, core.worktree warns before overriding core.bare
 		cd 21/.git &&
 		GIT_WORK_TREE="$here/21" &&
 		export GIT_WORK_TREE &&
-		git status >/dev/null
-	) 2>message &&
-	test_must_be_empty message
-
+		git status 2>message &&
+		test_must_be_empty message
+	)
 '
 run_wt_tests 21
 
@@ -742,14 +739,16 @@ test_expect_success '#24: bare repo has no worktree (gitfile case)' '
 test_expect_success '#25: GIT_WORK_TREE accepted if GIT_DIR unset (bare gitfile case)' '
 	try_repo 25 "$here/25" unset unset gitfile true \
 		"$here/25.git" "$here/25" "$here/25" "(null)"  \
-		"$here/25.git" "$here/25" "$here/25" "sub/" 2>message &&
-	test_must_be_empty message
+		"$here/25.git" "$here/25" "$here/25" "sub/"
 '
 
-test_expect_success '#26: bare repo has no worktree (GIT_DIR -> gitfile case)' '
+test_expect_success '#26.1: bare repo has no worktree (GIT_DIR -> gitfile case)' '
 	try_repo 26 unset "$here/26/.git" unset gitfile true \
 		"$here/26.git" "(null)" "$here/26" "(null)" \
-		"$here/26.git" "(null)" "$here/26/sub" "(null)" &&
+		"$here/26.git" "(null)" "$here/26/sub" "(null)"
+'
+
+test_expect_success '#26.2: bare repo has no worktree (GIT_DIR -> gitfile case)' '
 	try_repo 26b unset .git unset gitfile true \
 		"$here/26b.git" "(null)" "$here/26b" "(null)" \
 		"$here/26b.git" "(null)" "$here/26b/sub" "(null)"
@@ -779,9 +778,9 @@ test_expect_success '#29: setup' '
 		cd 29 &&
 		GIT_WORK_TREE="$here/29" &&
 		export GIT_WORK_TREE &&
-		git status
-	) 2>message &&
-	test_must_be_empty message
+		git status 2>message &&
+		test_must_be_empty message
+	)
 '
 run_wt_tests 29 gitfile
 
-- 
2.34.1.1024.g573f2f4b767

