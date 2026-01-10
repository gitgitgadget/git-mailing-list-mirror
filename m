Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110C1DFD8B
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008010; cv=none; b=W/pr9v+B5snTbznKpL3FfE7FSGFMtakDwOCylSPxPxEWUMYjk0IvxOYMBNkKzN47VfzUrf4aBpQs5mFXxlIIzokvWl7uZ+NELj9I2QtzotoJUPP4/CP46umEfw3vtxFM+x8jcr2ZKsrDaJmgRQx9zRa4PN52bUg90HsSx58g4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008010; c=relaxed/simple;
	bh=gizBgdVu7ygo8QKHahQx5JCX2PyR8TH2zAw+FDk7axo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cx0sDjzOpscPx3lV0vf58cw9jS/qpgfs6EwPFpNcaJYlkVBkui61a4gfSlDUpdOjjVmjy2XlRPNETo+U9MdQhwFxEHSC+tKepzuEkGLkrnNeELXa/4jtuOrjLixX0txzhx/Ffvud6C4BG71vNM3WqcVDbuXI44+vQZ78kf4f+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=ga28T5xq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="ga28T5xq"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1veNe0-005Yf0-V4; Sat, 10 Jan 2026 02:19:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From;
	bh=HnAFpgyhVNQhy+oGu88Zu9aQNvn+ytXn7xr5MYVlfXA=; b=ga28T5xq7Y/9sFW+ISiIuyBKaz
	xHAUuyIBy1sZ6Z1vdXYYX+SIodluXjWwc+WJ8/9zDn6EY8SLxaTmUobWyz0HhOtQ7PZeCTwUjSXDi
	VaBF9hAefR4bXZhIz83hGhEqHxEdo9VXwa5rFoUwittAiuEx3aUZDgaa/4RRifXmYxgGapB+zdkDw
	LBleNsmpa9g47QvEqd1PqUdlX/DD62VGmFhspc8h+Ey7EudSmOPWE8T1/i56evgG+fSKt8xDPY+k5
	5n4nUWmJUgDS7/lptly42dBOb7lIqVscrcSWwUHMn6k7Yqp9EjYEbVxz3O1FV6iySGaXjYu1ObpDb
	+jSgpanA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1veNe0-00045Z-JD; Sat, 10 Jan 2026 02:19:56 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1veNdn-004Ium-UJ; Sat, 10 Jan 2026 02:19:44 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org
Cc: george@mail.dietrich.pub,
	Phillip Wood <phillip.wood123@gmail.com>,
	zach.fetters@apollographql.com,
	Colin Stagner <ask+git@howdoi.land>
Subject: [PATCH] contrib/subtree: detect rewritten subtree commits
Date: Fri,  9 Jan 2026 19:18:11 -0600
Message-ID: <20260110011811.788219-1-ask+git@howdoi.land>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

    git subtree split --prefix P

detects splits that are outside of path prefix `P` and prunes
them from history graph processing. This improves the performance
of repeated `split --rejoin` with many different prefixes.

Both before and after 83f9dad7d6 (contrib/subtree: fix split with
squashed subtrees, 2025-09-09), the pruning logic does not detect
**rebased** or **cherry-picked** git-subtree commits. If `split`
encounters any of these commits, the split output may have
incomplete history.

All commits authored by

    git subtree merge [--squash] --prefix Q

have a first or second parent that has *only* subtree commits
as ancestors. When splitting a completely different path `P/`,
it is safe to ignore:

1. the merged tree
2. the subtree parent
3. *all* of that parent's ancestry, which applies only to
   path `Q/` and not `P/`.

But this relationship no longer holds if the git-subtree commit
is rebased or otherwise reauthored. After a rebase, the former
git-subtree commit will have other unrelated commits as ancestors.
Ignoring these commits may exclude the history of `P/`,
leading to incomplete `subtree split` output.

The pruning logic relies solely on the `git-subtree-*:` trailers
to detect git-subtree commits, which it blindly accepts without
further validation. The split logic also takes its time about
being wrong: `cmd_split()` execs a `git show` for *every* commit
in the split range… twice. This is inefficient in a shell script.

Add a "reality check" to ignore rebased or rewritten commits:

* Rewrites of non-merge commits cannot be detected, so the new
  detector no longer looks for them.

* Merges carry a `git-subtree-mainline:` trailer with the hash of
  the **first parent**. If this hash differs, or if the "merge"
  commit no longer has multiple parents, a rewrite has occurred.

To increase speed, package this logic in a new method,
`find_other_splits()`. Perform the check up-front by iterating
over a single `git log`. Add ignored subtrees to:

1. the `notree` cache, which excludes them from the `split` history

2. a `prune` negative refs list. The negative refs prevent
   recursing into other subtrees. Since there are potentially a
   *lot* of these, cache them on disk and use rev-list's
   `--stdin` mode.

Reported-by: George <george@mail.dietrich.pub>

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---

Notes:
    * cs/subtree-split-detect-rewritten:
      "git subtree" (in contrib/) did not correctly split history
      containing rebased git-subtree commits. This has been fixed.
    
    This patch is intended for maint.
    
    See-also: <176677910605.6.2281395015810449820.1087545551@dietrich.pub>

 contrib/subtree/git-subtree.sh     | 141 +++++++++++++++++++----------
 contrib/subtree/t/t7900-subtree.sh |  83 +++++++++++++++--
 2 files changed, 169 insertions(+), 55 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..3ebe88cbea 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -325,6 +325,12 @@ check_parents () {
 	done
 }
 
+# Usage: get_notree REV
+get_notree () {
+	assert test $# = 1
+	test -r "$cachedir/notree/$1"
+}
+
 # Usage: set_notree REV
 set_notree () {
 	assert test $# = 1
@@ -511,6 +517,71 @@ find_existing_splits () {
 	done || exit $?
 }
 
+# Usage: find_other_splits DIR REV UNREVS...
+#
+# Scan history in REV UNREVS for other `git subtree split --rejoin`
+# merge commits belonging to prefixes outside of DIR. These
+# "other splits" don't contribute to DIR and can be ignored.
+#
+# If any such rejoins are found,
+#
+#   * emit their second-parent as an UNREV, avoiding a
+#     potentially costly history traversal
+#
+#   * mark the merge commit as "notree" to ignore it
+find_other_splits () {
+	assert test $# -ge 2
+	dir="${1%/}"
+	rev="$2"
+	shift 2
+	debug "Looking for other splits with dir != $dir..."
+
+	git log \
+		--grep '^git-subtree-mainline:' \
+		--no-patch \
+		--no-show-signature \
+		--format='hash: %H%nparents: %P%n%(trailers:key=git-subtree-dir,key=git-subtree-mainline,key=git-subtree-split)%nEND' \
+		"$rev" ${@:+"$@"} |
+	while read -r key val
+	do
+		case "$key" in
+		hash:)
+			commit_hash="${val}"
+			commit_parents=
+			subtree_dir=
+			subtree_mainline=
+			subtree_split=
+			;;
+		parents:)
+			commit_parents="${val}" ;;
+		git-subtree-dir:)
+			subtree_dir="${val%/}/" ;;
+		git-subtree-mainline:)
+			subtree_mainline="${val}" ;;
+		git-subtree-split:)
+			subtree_split="${val}" ;;
+		END)
+			# verify:
+			# * all git-subtree-* trailers are present
+			# * this subtree is outside of $dir
+			# * the first parent is the git-subtree-mainline:
+			# * the commit has at least two parents
+			if test -n "${subtree_dir}" &&
+				test -n "${subtree_split}" &&
+				test -n "${subtree_mainline}" &&
+				test "${subtree_dir}" = "${subtree_dir#"${dir}/"}" &&
+				test "${commit_parents}" != "${commit_parents#"$subtree_mainline "}" &&
+				rev_exists "${commit_hash}^2"
+			then
+				debug "find_other_splits excluding dir=$subtree_dir merged in ${commit_hash}"
+				echo "^${commit_hash}^2"
+				set_notree "${commit_hash}"
+			fi
+			;;
+		esac
+	done
+}
+
 # Usage: copy_commit REV TREE FLAGS_STR
 copy_commit () {
 	assert test $# = 3
@@ -785,42 +856,6 @@ ensure_valid_ref_format () {
 		die "fatal: '$1' does not look like a ref"
 }
 
-# Usage: should_ignore_subtree_split_commit REV
-#
-# Check if REV is a commit from another subtree and should be
-# ignored from processing for splits
-should_ignore_subtree_split_commit () {
-	assert test $# = 1
-
-	git show \
-		--no-patch \
-		--no-show-signature \
-		--format='%(trailers:key=git-subtree-dir,key=git-subtree-mainline)' \
-		"$1" |
-	(
-	have_mainline=
-	subtree_dir=
-
-	while read -r trailer val
-	do
-		case "$trailer" in
-		git-subtree-dir:)
-			subtree_dir="${val%/}" ;;
-		git-subtree-mainline:)
-			have_mainline=y ;;
-		esac
-	done
-
-	if test -n "${subtree_dir}" &&
-		test -z "${have_mainline}" &&
-		test "${subtree_dir}" != "$arg_prefix"
-	then
-		return 0
-	fi
-	return 1
-	)
-}
-
 # Usage: process_split_commit REV PARENTS
 process_split_commit () {
 	assert test $# = 2
@@ -994,31 +1029,39 @@ cmd_split () {
 	fi
 
 	unrevs="$(find_existing_splits "$dir" "$rev" "$repository")" || exit $?
+	(find_other_splits >"$cachedir/prune" "$dir" "$rev" $unrevs) || exit $?
 
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
-	grl='git rev-list --topo-order --reverse --parents $rev $unrevs'
-	revmax=$(eval "$grl" | wc -l)
+	revmax="$(git rev-list \
+		<"$cachedir/prune" \
+		--topo-order \
+		--reverse \
+		--parents \
+		--stdin \
+		--count \
+		"$rev" \
+		$unrevs
+	)"
 	revcount=0
 	createcount=0
 	extracount=0
-	eval "$grl" |
+	git rev-list \
+		<"$cachedir/prune" \
+		--topo-order \
+		--reverse \
+		--parents \
+		--stdin \
+		"$rev" \
+		$unrevs |
 	while read rev parents
 	do
-		if should_ignore_subtree_split_commit "$rev"
+		if get_notree "$rev"
 		then
 			continue
 		fi
-		parsedparents=''
-		for parent in $parents
-		do
-			if ! should_ignore_subtree_split_commit "$parent"
-			then
-				parsedparents="$parsedparents$parent "
-			fi
-		done
-		process_split_commit "$rev" "$parsedparents"
+		process_split_commit "$rev" "$parents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new) || exit $?
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 316dc5269e..4db3a6eff3 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -411,8 +411,9 @@ test_expect_success 'split sub dir/ with --rejoin' '
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
-		git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
-		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
+		git subtree split --prefix="sub dir" --annotate="*" -b spl --rejoin &&
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''" &&
+		test "$(git rev-list --count spl)" -eq 5
 	)
 '
 
@@ -442,18 +443,25 @@ test_expect_success 'split with multiple subtrees' '
 	git -C "$test_count" subtree add --prefix=subADir FETCH_HEAD &&
 	git -C "$test_count" fetch ./subB HEAD &&
 	git -C "$test_count" subtree add --prefix=subBDir FETCH_HEAD &&
+	test "$(git -C "$test_count" rev-list --count main)" -eq 7 &&
 	test_create_commit "$test_count" subADir/main-subA1 &&
 	test_create_commit "$test_count" subBDir/main-subB1 &&
 	git -C "$test_count" subtree split --prefix=subADir \
-		--squash --rejoin -m "Sub A Split 1" &&
+		--squash --rejoin -m "Sub A Split 1" -b a1 &&
+	test "$(git -C "$test_count" rev-list --count main..a1)" -eq 1 &&
 	git -C "$test_count" subtree split --prefix=subBDir \
-		--squash --rejoin -m "Sub B Split 1" &&
+		--squash --rejoin -m "Sub B Split 1" -b b1 &&
+	test "$(git -C "$test_count" rev-list --count main..b1)" -eq 1 &&
 	test_create_commit "$test_count" subADir/main-subA2 &&
 	test_create_commit "$test_count" subBDir/main-subB2 &&
 	git -C "$test_count" subtree split --prefix=subADir \
-		--squash --rejoin -m "Sub A Split 2" &&
+		--squash --rejoin -m "Sub A Split 2" -b a2 &&
+	test "$(git -C "$test_count" rev-list --count main..a2)" -eq 2 &&
+	test "$(git -C "$test_count" rev-list --count a1..a2)" -eq 1 &&
 	test "$(git -C "$test_count" subtree split --prefix=subBDir \
-		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
+		--squash --rejoin -d -m "Sub B Split 1" -b b2 2>&1 | grep -w "\[1\]")" = "" &&
+	test "$(git -C "$test_count" rev-list --count main..b2)" -eq 2 &&
+	test "$(git -C "$test_count" rev-list --count b1..b2)" -eq 1
 '
 
 # When subtree split-ing a directory that has other subtree
@@ -477,6 +485,7 @@ do
 			test_path_is_file subA/file1.t &&
 			test_path_is_file subA/subB/file2.t &&
 			git subtree split --prefix=subA --branch=bsplit &&
+			test "$(git rev-list --count bsplit)" -eq 2 &&
 			git checkout bsplit &&
 			test_path_is_file file1.t &&
 			test_path_is_file subB/file2.t &&
@@ -489,6 +498,7 @@ do
 				--prefix=subA/subB mksubtree &&
 			test_path_is_file subA/subB/file3.t &&
 			git subtree split --prefix=subA --branch=bsplit &&
+			test "$(git rev-list --count bsplit)" -eq 3 &&
 			git checkout bsplit &&
 			test_path_is_file file1.t &&
 			test_path_is_file subB/file2.t &&
@@ -497,6 +507,67 @@ do
 	'
 done
 
+# Usually,
+#
+#    git subtree merge -P subA --squash f00...
+#
+# makes two commits, in this order:
+#
+# 1. Squashed 'subA/' content from commit f00...
+# 2. Merge commit (1) as 'subA'
+#
+# Commit 1 updates the subtree but does *not* rewrite paths.
+# Commit 2 rewrites all trees to start with `subA/`
+#
+# Commit 1 either has no parents or depends only on other
+# "Squashed 'subA/' content" commits.
+#
+# For merge without --squash, subtree produces just one commit:
+# a merge commit with git-subtree trailers.
+#
+# In either case, if the user rebases these commits, they will
+# still have the git-subtree-* trailers… but will NOT have
+# the layout described above.
+#
+# Test that subsequent `git subtree split` are not confused by this.
+test_expect_success 'split with rebased subtree commit' '
+	subtree_test_create_repo "$test_count" &&
+	(
+		cd "$test_count" &&
+		test_commit file0 &&
+		test_create_subtree_add \
+			. mksubtree subA file1 --squash &&
+		test_path_is_file subA/file1.t &&
+		mkdir subB &&
+		test_commit subB/bfile &&
+		git commit --amend -F - <<'EOF' &&
+Squashed '\''subB/'\'' content from commit '\''badf00da911bbe895347b4b236f5461d55dc9877'\''
+
+Simulate a cherry-picked or rebased subtree commit.
+
+git-subtree-dir: subB
+git-subtree-split: badf00da911bbe895347b4b236f5461d55dc9877
+EOF
+		test_commit subA/file2 &&
+		test_commit subB/bfile2 &&
+		git commit --amend -F - <<'EOF' &&
+Split '\''subB/'\'' into commit '\''badf00da911bbe895347b4b236f5461d55dc9877'\''
+
+Simulate a cherry-picked or rebased subtree commit.
+
+git-subtree-dir: subB
+git-subtree-mainline: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+git-subtree-split: badf00da911bbe895347b4b236f5461d55dc9877
+EOF
+		git subtree split --prefix=subA --branch=bsplit &&
+		git checkout bsplit &&
+		test_path_is_file file1.t &&
+		test_path_is_file file2.t &&
+		test "$(last_commit_subject)" = "subA/file2" &&
+		test "$(git rev-list --count bsplit)" -eq 2
+	)
+'
+
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
 	test_create_commit "$test_count" main1 &&

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0

