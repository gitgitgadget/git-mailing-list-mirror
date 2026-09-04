Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994BB4963B7
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554159; cv=none; b=tNBZArTfhJneOwwXhApAloKzoil2T9LJqcZ9PWt9/PgkYUfgcROf9OUPwcVNP+YG/VjLL8bUkJ0AAvVFPYcnqqJx2rrkyvvGDVr/P0hlnGC3R4NddCHSyEU/FIwonmtLdskovl6yhz/fIl4r9h7Ic0kPRYSHEiFSpuPkXENf1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554159; c=relaxed/simple;
	bh=pTfL3ivxtzCJFfY4/OqIhn1hDV1wOwJwFpI2jQR9sPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Txrp5B+wDcWTDjdrWBCg3FbZL9P8oZRUxX+AKtaOI/0S+vOmqX2ZJ2HIQbzlTrAL8ZzhrHoa9clfBZ/LW5wx/+WRP0ZvzoE13dp2utvaYmjjklA7tXuIY5jJaZ7N5rdRUYvZ65dU6rIlxgVu2/dvwh2Rlq86D+9s2vuTd0X5tR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2ww6S6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2ww6S6L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 701B4C2BCF4;
	Fri,  4 Sep 2026 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788554158;
	bh=pTfL3ivxtzCJFfY4/OqIhn1hDV1wOwJwFpI2jQR9sPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E2ww6S6Lzi+OqdEZNPBKinzWqDSYvi4GXXTi7MGConL+hfuG062wz9IcJ9/ztH9Pw
	 G0zawJ8K9lVPrggbkRj7prwLLKCCe/X0uAMOy31U2QOgcdkhVXggCVGJhFAUKOUayR
	 H+Ba6IyyTjR1pf/6J1i/ZQkQAIBnYnoa6yoEeHblpi5dJNTLlLniCT+XzdHPynJXTi
	 GgnugD7yKQFh3ZpioO5IIct9MAM9N8ar+hDKx0KPWuH0Pw7VnJhrpgXoRnK7NNK58Y
	 nESPZtyPoYYmmLOlr4er5qmBkXxUCziE70kE/TT1URjt+2VjsYW3f9dkn+7P7AbIWY
	 IfYwZAOErTZng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A9CC79F87;
	Fri,  4 Sep 2026 20:35:58 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Fri, 04 Sep 2026 16:35:53 -0400
Subject: [PATCH 2/2] Second batch of shell test migrations.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-file-tests-use-shell-functions-v1-2-b66f9cb4adbe@fastmail.com>
References: <20260904-file-tests-use-shell-functions-v1-0-b66f9cb4adbe@fastmail.com>
In-Reply-To: <20260904-file-tests-use-shell-functions-v1-0-b66f9cb4adbe@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20172;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=qifNi7mt5q2WVYN+K7QgQd+gqCoJGHKteHasYCpDeT8=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJma6+ZXbjnMOPX01+qbdv0HkW5JG2e9/Cb3cUPv58/Z
 /rPzO1e0VHKwiDGxSArpsjy/59A4yuWBxJ+Qe8+wcxhZQIZwsDFKQATWT+VkWHu270Hlyd8cU6W
 lS1azcsRmbJ0cULi0aP2PBclY36nmh1h+MPB/HZT39lb11ZeVFvnY7+GM9Tl102u+rMSG509J+i
 1WfIDAA==
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

---
 t/perf/p5302-pack-index.sh              |  2 +-
 t/t0007-git-var.sh                      |  2 +-
 t/t0081-find-pack.sh                    |  2 +-
 t/t1700-split-index.sh                  |  2 +-
 t/t2005-checkout-index-symlinks.sh      |  2 +-
 t/t3434-rebase-i18n.sh                  |  2 +-
 t/t3902-quoted.sh                       |  2 +-
 t/t4013-diff-various.sh                 |  2 +-
 t/t4016-diff-quote.sh                   |  2 +-
 t/t4252-am-options.sh                   |  2 +-
 t/t5000-tar-tree.sh                     |  2 +-
 t/t5100-mailinfo.sh                     |  6 +++---
 t/t5334-incremental-multi-pack-index.sh |  2 +-
 t/t5402-post-merge-hook.sh              |  2 +-
 t/t5500-fetch-pack.sh                   |  2 +-
 t/t5515-fetch-merge-logic.sh            |  4 ++--
 t/t5526-fetch-submodules.sh             |  8 ++++----
 t/t5601-clone.sh                        | 16 ++++++++--------
 t/t5702-protocol-v2.sh                  |  4 ++--
 t/t5710-promisor-remote-capability.sh   |  2 +-
 t/t6030-bisect-porcelain.sh             |  2 +-
 t/t7004-tag.sh                          |  4 ++--
 t/t7011-skip-worktree-reading.sh        |  2 +-
 t/t7409-submodule-detached-work-tree.sh |  2 +-
 t/t7450-bad-git-dotfiles.sh             |  6 +++---
 t/t7606-merge-custom.sh                 |  8 ++++----
 t/t7610-mergetool.sh                    |  6 +++---
 t/t9001-send-email.sh                   |  6 +++---
 t/t9804-git-p4-label.sh                 |  8 ++++----
 29 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 14c601bbf8..d3a3ea360f 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -9,7 +9,7 @@ test_perf_large_repo
 test_expect_success 'repack' '
 	git repack -ad &&
 	PACK=$(ls .git/objects/pack/*.pack | head -n1) &&
-	test -f "$PACK" &&
+	test_path_is_file "$PACK" &&
 	export PACK
 '
 
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..6a8fe69c08 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -156,7 +156,7 @@ test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
 test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
 	shellpath=$(git var GIT_SHELL_PATH) &&
 	case "$shellpath" in
-	[A-Z]:/*/sh.exe) test -f "$shellpath";;
+	[A-Z]:/*/sh.exe) test_path_is_file "$shellpath";;
 	*) return 1;;
 	esac
 '
diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index ff9d56fbf1..7d5082c487 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -32,7 +32,7 @@ test_expect_success 'repack everything into a single packfile' '
 		".git/objects/pack/pack-"*".pack") true ;;
 		*) false ;;
 	esac &&
-	test -f "$head_commit_pack" &&
+	test_path_is_file "$head_commit_pack" &&
 
 	# Everything is in the same pack
 	test "$head_commit_pack" = "$head_tree_pack" &&
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 887e72a5fa..8e973838d0 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -460,7 +460,7 @@ test_expect_success POSIXPERM,SANITY 'graceful handling when splitting index is
 		cd ro &&
 		test_commit initial &&
 		git update-index --split-index &&
-		test -f .git/sharedindex.*
+		test_path_is_file .git/sharedindex.*
 	) &&
 	cp ro/.git/index new-index &&
 	test_when_finished "chmod u+w ro/.git" &&
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index 91b08e0371..3ec071125f 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -19,7 +19,7 @@ echo "120000 $l	symlink" | git update-index --index-info'
 test_expect_success \
 'the checked-out symlink must be a file' '
 git checkout-index symlink &&
-test -f symlink'
+test_path_is_file symlink'
 
 test_expect_success 'the file must be the blob we added during the setup' '
 	echo "$l" >expect &&
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 0f93a239f8..8b217380f0 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -75,7 +75,7 @@ test_rebase_continue_update_encode () {
 		git commit -F "$TEST_DIRECTORY/t3434/$msgfile" &&
 		git config i18n.commitencoding $new &&
 		test_must_fail git rebase -m main &&
-		test -f .git/rebase-merge/message &&
+		test_path_is_file .git/rebase-merge/message &&
 		git stripspace -s <.git/rebase-merge/message >two.t &&
 		git add two.t &&
 		git rebase --continue &&
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 8660ec5cb0..ee0bfb6432 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -14,7 +14,7 @@ DQ='"'
 
 test_have_prereq MINGW ||
 echo foo 2>/dev/null > "Name and an${HT}HT"
-if ! test -f "Name and an${HT}HT"
+if test_path_is_missing "Name and an${HT}HT"
 then
 	# FAT/NTFS does not allow tabs in filenames
 	skip_all='Your filesystem does not allow tabs in filenames'
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index b7a382c881..e3a1eb89c5 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -235,7 +235,7 @@ do
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
 		} >"$actual" &&
-		if test -f "$expect"
+		if test_path_is_file "$expect"
 		then
 			process_diffs "$actual" >actual &&
 			process_diffs "$expect" >expect &&
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 876271d682..1226da6703 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -14,7 +14,7 @@ P2='pathname with SP'
 P3='pathname
 with LF'
 test_have_prereq !MINGW &&
-echo 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
+echo 2>/dev/null >"$P1" && test_path_is_file "$P1" && rm -f "$P1" || {
 	skip_all='Your filesystem does not allow tabs in filenames'
 	test_done
 }
diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
index c36c7e9017..617b850f55 100755
--- a/t/t4252-am-options.sh
+++ b/t/t4252-am-options.sh
@@ -64,7 +64,7 @@ test_expect_success 'apply to a funny path' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard initial &&
 	git am --directory="$with_sq" "$tm"/am-test-5-2 &&
-	test -f "$with_sq/file-5"
+	test_path_is_file "$with_sq/file-5"
 '
 
 test_expect_success 'am --reject' '
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3ad600c793..c99f90a212 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -34,7 +34,7 @@ test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
 		mkdir pax &&
 		cd pax &&
 		"$TAR" xf "$TEST_DIRECTORY"/t5000/pax.tar &&
-		test -f PaxHeaders.1791/file
+		test_path_is_file PaxHeaders.1791/file
 	)
 '
 
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e01078abe7..68d6c23175 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -34,15 +34,15 @@ do
 
 	test_expect_success $prereq "mailinfo $mail" '
 		check_mailinfo "$mail" "" &&
-		if test -f "$DATA/msg$mail--scissors"
+		if test_path_is_file "$DATA/msg$mail--scissors"
 		then
 			check_mailinfo "$mail" --scissors
 		fi &&
-		if test -f "$DATA/msg$mail--no-inbody-headers"
+		if test_path_is_file "$DATA/msg$mail--no-inbody-headers"
 		then
 			check_mailinfo "$mail" --no-inbody-headers
 		fi &&
-		if test -f "$DATA/msg$mail--message-id"
+		if test_path_is_file "$DATA/msg$mail--message-id"
 		then
 			check_mailinfo "$mail" --message-id
 		fi
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index f0b82b5f65..d9bad96f78 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -47,7 +47,7 @@ compare_results_with_midx 'non-incremental MIDX conversion'
 
 write_midx_layer () {
 	n=1
-	if test -f $midx_chain
+	if test_path_is_file $midx_chain
 	then
 		n="$(($(wc -l <$midx_chain) + 1))"
 	fi
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index c77aa56421..e43b19ac43 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -37,7 +37,7 @@ test_expect_success 'setup clone hooks' '
 
 test_expect_success 'post-merge does not run for up-to-date ' '
 	GIT_DIR=clone1/.git git merge $commit0 &&
-	! test -f clone1/.git/post-merge.args
+	test_path_is_missing clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge runs as expected ' '
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 6c1edf2117..5916e43565 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -317,7 +317,7 @@ test_expect_success 'turn shallow to complete repository' '
 		cd shallow &&
 		GIT_TRACE2_EVENT="$(pwd)/trace2_event" \
 			git fetch --unshallow &&
-		! test -f .git/shallow &&
+		test_path_is_missing .git/shallow &&
 		git fsck --full &&
 		test_grep \"fetch-info\".*\"shallows\":2 trace2_event &&
 		test_grep \"fetch-info\".*\"depth\":2147483647 trace2_event
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 8ac04d742c..a7d57b0e07 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -208,7 +208,7 @@ do
 			cat .git/FETCH_HEAD
 		} >"$actual_f" &&
 		git show-ref >"$actual_r" &&
-		if test -f "expect_f"
+		if test_path_is_file "expect_f"
 		then
 			test_cmp "expect_f" "$actual_f" &&
 			rm -f "$actual_f"
@@ -217,7 +217,7 @@ do
 			cp "$actual_f" "$expect_f"
 			false
 		fi &&
-		if test -f "expect_r"
+		if test_path_is_file "expect_r"
 		then
 			test_cmp "expect_r" "$actual_r" &&
 			rm -f "$actual_r"
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 7b3b7359da..a5b2fc8767 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -106,19 +106,19 @@ add_superproject_commits () {
 verify_fetch_result () {
 	ACTUAL_ERR=$1 &&
 	rm -f expect.err.combined &&
-	if test -f expect.err.super
+	if test_path_is_file expect.err.super
 	then
 		cat expect.err.super >>expect.err.combined
 	fi &&
-	if test -f expect.err.sub
+	if test_path_is_file expect.err.sub
 	then
 		cat expect.err.sub >>expect.err.combined
 	fi &&
-	if test -f expect.err.deep
+	if test_path_is_file expect.err.deep
 	then
 		cat expect.err.deep >>expect.err.combined
 	fi &&
-	if test -f expect.err.sub2
+	if test_path_is_file expect.err.sub2
 	then
 		cat expect.err.sub2 >>expect.err.combined
 	fi &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index b6167582a1..8387bca417 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -57,7 +57,7 @@ test_expect_success 'clone does not keep pack' '
 
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst &&
-	! test -f dst/file &&
+	test_path_is_missing dst/file &&
 	! (echo dst/.git/objects/pack/pack-* | grep "\.keep")
 
 '
@@ -66,15 +66,15 @@ test_expect_success 'clone checks out files' '
 
 	rm -fr dst &&
 	git clone src dst &&
-	test -f dst/file
+	test_path_is_file dst/file
 
 '
 
 test_expect_success 'clone respects GIT_WORK_TREE' '
 
 	GIT_WORK_TREE=worktree git clone src bare &&
-	test -f bare/config &&
-	test -f worktree/file
+	test_path_is_file bare/config &&
+	test_path_is_file worktree/file
 
 '
 
@@ -102,22 +102,22 @@ test_expect_success 'clone from hooks' '
 test_expect_success 'clone creates intermediate directories' '
 
 	git clone src long/path/to/dst &&
-	test -f long/path/to/dst/file
+	test_path_is_file long/path/to/dst/file
 
 '
 
 test_expect_success 'clone creates intermediate directories for bare repo' '
 
 	git clone --bare src long/path/to/bare/dst &&
-	test -f long/path/to/bare/dst/config
+	test_path_is_file long/path/to/bare/dst/config
 
 '
 
 test_expect_success 'clone --mirror' '
 
 	git clone --mirror src mirror &&
-	test -f mirror/HEAD &&
-	test ! -f mirror/file &&
+	test_path_is_file mirror/HEAD &&
+	test_path_is_missing mirror/file &&
 	FETCH="$(cd mirror && git config remote.origin.fetch)" &&
 	test "+refs/*:refs/*" = "$FETCH" &&
 	MIRROR="$(cd mirror && git config --bool remote.origin.mirror)" &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f05286de8..68fa8ebcf5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1261,8 +1261,8 @@ test_expect_success 'part of packfile response provided as URI' '
 			fi
 		fi || return 1
 	done &&
-	test -f hfound &&
-	test -f h2found &&
+	test_path_is_file hfound &&
+	test_path_is_file h2found &&
 
 	# Ensure that there are exactly 3 packfiles with associated .idx
 	ls http_child/.git/objects/pack/*.pack \
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 549acff23f..fa2455cf31 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -41,7 +41,7 @@ check_missing_objects () {
 	then
 		test "$3" = "$(cat missing.txt)"
 	else
-		test -f "$3" &&
+		test_path_is_file "$3" &&
 		sort <"$3" >expected_sorted &&
 		sort <missing.txt >actual_sorted &&
 		test_cmp expected_sorted actual_sorted
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a7588222a8..c44daa7856 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -851,7 +851,7 @@ test_expect_success 'optimized merge base checks' '
 	test_grep "merge base must be tested" my_bisect_log.txt &&
 	test_grep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
-	test -f ".git/BISECT_ANCESTORS_OK" &&
+	test_path_is_file ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" = $(git rev-parse --verify HEAD) &&
 	git bisect bad &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8c795d7218..09a9559c74 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -538,7 +538,7 @@ test_expect_success 'creating an annotated tag with -F - should succeed' '
 '
 
 test_expect_success 'trying to create a tag with a non-existing -F file should fail' '
-	! test -f nonexistingfile &&
+	test_path_is_missing nonexistingfile &&
 	! tag_exists notag &&
 	test_must_fail git tag -F nonexistingfile notag &&
 	! tag_exists notag
@@ -1099,7 +1099,7 @@ test_expect_success GPG 'git tag --no-sign configured tag.gpgsign skip GPG sign'
 '
 
 test_expect_success GPG 'trying to create a signed tag with non-existing -F file should fail' '
-	! test -f nonexistingfile &&
+	test_path_is_missing nonexistingfile &&
 	! tag_exists nosigtag &&
 	test_must_fail git tag -s -F nonexistingfile nosigtag &&
 	! tag_exists nosigtag
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 1ff2714cb4..4301960015 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -24,7 +24,7 @@ H sub/2
 EOF
 
 setup_absent() {
-	test -f 1 && rm 1
+	test_path_is_file 1 && rm 1
 	git update-index --remove 1 &&
 	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
index 374ed481e9..2b295bed6e 100755
--- a/t/t7409-submodule-detached-work-tree.sh
+++ b/t/t7409-submodule-detached-work-tree.sh
@@ -84,7 +84,7 @@ test_expect_success 'submodule on detached working pointed by core.worktree' '
 		git config core.worktree .. &&
 		git pull &&
 		git submodule update --init &&
-		test -f .vim/bundle/dupe/shoot.t
+		test_path_is_file .vim/bundle/dupe/shoot.t
 	)
 '
 
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 72c7f6f73b..f8a7b262f2 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -320,7 +320,7 @@ test_expect_success WINDOWS 'prevent git~1 squatting on Windows' '
 		# git~2 is an 8.3 short name, present only when 8.3 name
 		# generation is enabled. The "directory not empty" check
 		# above is the primary assertion.
-		if test -f squatting-clone/d/a/git~2
+		if test_path_is_file squatting-clone/d/a/git~2
 		then
 			test_grep ! gitdir squatting-clone/d/a/git~2
 		fi
@@ -409,8 +409,8 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
 	git -C repo commit -m submodule &&
 
 	git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone &&
-	! test -f "$PWD/bad-clone/sub/foo" &&
-	test -f $(printf "bad-clone/sub\r/post-checkout")
+	test_path_is_missing "$PWD/bad-clone/sub/foo" &&
+	test_path_is_file $(printf "bad-clone/sub\r/post-checkout")
 '
 
 test_done
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 0ae2f59b1d..67b01649e0 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -59,9 +59,9 @@ test_expect_success 'merge c2 with a custom strategy' '
 	test_cmp head.old first-parent &&
 	test_cmp second-parent.expected second-parent &&
 	test_cmp tree.expected tree &&
-	test -f c0.c &&
+	test_path_is_file c0.c &&
 	test_grep c1c1 c1.c &&
-	test -f c2.c
+	test_path_is_file c2.c
 '
 
 test_expect_success 'trivial merge with custom strategy' '
@@ -85,9 +85,9 @@ test_expect_success 'trivial merge with custom strategy' '
 	test_cmp head.old first-parent &&
 	test_cmp second-parent.expected second-parent &&
 	test_cmp tree.expected tree &&
-	test -f c0.c &&
+	test_path_is_file c0.c &&
 	! test -e c1.c &&
-	test -f c3.c
+	test_path_is_file c3.c
 '
 
 test_done
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 0128b14452..2cc3ea61c1 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -382,15 +382,15 @@ test_expect_success 'mergetool delete/delete conflict' '
 	git checkout -b test$test_count move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
-	! test -f a/a/file.txt &&
+	test_path_is_missing a/a/file.txt &&
 	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	echo m | git mergetool a/a/file.txt &&
-	test -f b/b/file.txt &&
+	test_path_is_file b/b/file.txt &&
 	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	! echo a | git mergetool a/a/file.txt &&
-	! test -f a/a/file.txt
+	test_path_is_missing a/a/file.txt
 '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 78db65189e..d1393ef197 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -26,7 +26,7 @@ test_expect_success $PREREQ 'Setup helper tool' '
 	write_script fake.sendmail <<-\EOF &&
 	shift
 	output=1
-	while test_path_is_file commandline$output
+	while test -f commandline$output
 	do
 		output=$(($output+1))
 	done
@@ -66,7 +66,7 @@ test_no_confirm () {
 
 # Exit immediately to prevent hang if a no-confirm test fails
 check_no_confirm () {
-	if test_path_is_missing no_confirm_okay
+	if ! test -f no_confirm_okay
 	then
 		say 'confirm test failed; skipping remaining tests to prevent hanging'
 		PREREQ="$PREREQ,CHECK_NO_CONFIRM"
@@ -2722,7 +2722,7 @@ test_expect_success $PREREQ 'invoke hook' '
 		false
 		;;
 	esac &&
-	test_path_is_file 0001-add-main.patch &&
+	test -f 0001-add-main.patch &&
 	grep "add main" "$1"
 	EOF
 
diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index 3236457106..f64a11f85f 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -59,9 +59,9 @@ test_expect_success 'basic p4 labels' '
 
 		cd main &&
 		git checkout tag_tag_f1_only &&
-		! test -f f2 &&
+		test_path_is_missing f2 &&
 		git checkout tag_tag_with\$_shell_char &&
-		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
+		test_path_is_file f1 && test_path_is_file f2 && test_path_is_file file_with_\$metachar &&
 
 		git show tag_long_label | grep -q "A Label second line"
 	)
@@ -100,11 +100,11 @@ test_expect_failure 'two labels on the same changelist' '
 
 		git checkout tag_tag_f1_1 &&
 		ls &&
-		test -f f1 &&
+		test_path_is_file f1 &&
 
 		git checkout tag_tag_f1_2 &&
 		ls &&
-		test -f f1
+		test_path_is_file f1
 	)
 '
 

-- 
2.53.0


