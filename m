Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B431E2838
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062725; cv=none; b=Rym4l5zbLlBN+ZqCno0LYnHn12DiJgo3o3P2RiUUGJ4wa/6ehq6xTdqOADQvVYrBKCX7XSLVfoXrTCLEe0Ov48CTeGSDIro3pWpB7Odi2CLJKlO/BOxBoYBphpC2Ntrnr0+/VslFsSM3tUntbJGzByOqjB8lK72I5c+0+C2n5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062725; c=relaxed/simple;
	bh=8w2rr32uaTIaUd5N6C22VvzA02Qr1Euy5Zz3vV0y2eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGIIcUkVQBORHnZEjVYtp3zwl3CwbBj6XyJsnBQC/TipYJ89tONWm/5S6soCcZndNMSZJjOfraNlojzm/NPAL4DjhCFvmbdlPt+qetdG48d/kqeG6a8UD5ePKfYD/wgIeJKvH1c6P5e3KhkCsvgL/Nad+Srn78ZViStnkGA2iJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=iww9EHKK; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="iww9EHKK"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1uqG87-00HMrA-JA; Sun, 24 Aug 2025 21:11:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From; bh=haTaM7GV74opwtJKjfgtQfVojh/LXGxDF9XkE4h5Mlc=; b=iww9EH
	KKmgKMyJ2YnE7AzJ72ykf4KL69fK44rvreAnpcLTtL0odSwlC8qHFpaYB9nwowRBBBnXcF9uTeVZz
	fJVsz+pB206/Su5LDSDJz9F1BKjL5f7seeoPOlGWurcSjE1+u+iTjh4ZuCMVLux7seV1DIgAlAzf+
	43bXjvzWLevbRPsX94zby95bte3KgA17EHS22t7704SrjPPBQ3FOwWrWhWJMk3kLLy6a3WqxcrJrj
	tGeHB794+hAX/Yx6nuioMExWJfsLUnWdxuzeHXxf8I0g0vLIZ7p4U+C8NQk831KlTFyugE/hi768t
	bVvYyC+u7zFCeeGGPTr5RxW79sFw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1uqG87-0003zw-3j; Sun, 24 Aug 2025 21:11:51 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uqG7n-006W3J-9C; Sun, 24 Aug 2025 21:11:31 +0200
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Patrik Weiskircher <patrik@pspdfkit.com>,
	Colin Stagner <ask+git@howdoi.land>
Subject: [PATCH] contrib/subtree: fix split with squashed subtrees
Date: Sun, 24 Aug 2025 14:10:48 -0500
Message-ID: <20250824191048.1938340-1-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

98ba49ccc2 (subtree: fix split processing with multiple subtrees
present, 2023-12-01) increases the performance of

    git subtree split --prefix=subA

by ignoring subtree merges which are outside of `subA/`. It also
introduces a regression. Subtree merges that should be retained
are incorrectly ignored if they:

1. are nested under `subA/`; and
2. are merged with `--squash`.

For example, a subtree merged like:

    git subtree merge --squash --prefix=subA/subB "$rev"
    #                 ^^^^^^^^          ^^^^

is erroneously ignored during a split of `subA`. This causes
missing tree files and different commit hashes starting in
git v2.44.0-rc0.

The method:

    should_ignore_subtree_split_commit REV

should test only if REV is a subtree commit, but the combination of

    git log -1 --grep=...

actually searches all *parent* commits until a `--grep` match is
discovered. Limit these checks to the current REV only.

Tests now cover nested subtrees.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---

Notes:
    The unit test changes in t7900-subtree.sh demonstrate the bug.
    
    See also:
    
    * <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
    * <c9e8f54f-2594-4092-ae41-f1da73e97f6e@howdoi.land>

 contrib/subtree/git-subtree.sh     |  6 +--
 contrib/subtree/t/t7900-subtree.sh | 70 ++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 3fddba797c..139049351d 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -788,17 +788,17 @@ ensure_valid_ref_format () {
 # Usage: check if a commit from another subtree should be
 # ignored from processing for splits
 should_ignore_subtree_split_commit () {
 	assert test $# = 1
 	local rev="$1"
-	if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
+	if test -n "$(git log -1 --grep="git-subtree-dir:" "$rev^!")"
 	then
-		if test -z "$(git log -1 --grep="git-subtree-mainline:" $rev)" &&
-			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $rev)"
+		if test -z "$(git log -1 --grep="git-subtree-mainline:" "$rev^!")" &&
+			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" "$rev^!")"
 		then
 			return 0
 		fi
 	fi
 	return 1
 }
 
 # Usage: process_split_commit REV PARENTS
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3edbb33af4..1ddc213621 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -68,6 +68,34 @@ test_create_pre2_32_repo () {
 	git -C "$1-clone" replace HEAD^2 $new_commit
 }
 
+# test_create_subtree_add REPO ORPHAN PREFIX FILENAME ...
+#
+# Create a simple subtree on a new branch named ORPHAN in REPO.
+# The subtree is then merged into the current branch of REPO,
+# under PREFIX. The generated subtree has has one commit
+# with subject and tag FILENAME with a single file "FILENAME.t"
+#
+# When this method returns:
+# - the current branch of REPO will have file PREFIX/FILENAME.t
+# - REPO will have a branch named ORPHAN with subtree history
+#
+# additional arguments are forwarded to "subtree add"
+test_create_subtree_add () {
+	(
+		cd "$1" &&
+		orphan="$2" &&
+		prefix="$3" &&
+		filename="$4" &&
+		shift 4 &&
+		last="$(git branch --show-current)" &&
+		git checkout --orphan "$orphan" &&
+		git rm -rf . &&
+		test_commit "$filename" &&
+		git checkout "$last" &&
+		git subtree add --prefix="$prefix" "$@" "$orphan"
+	)
+}
+
 test_expect_success 'shows short help text for -h' '
 	test_expect_code 129 git subtree -h >out 2>err &&
 	test_must_be_empty err &&
@@ -426,6 +454,48 @@ test_expect_success 'split with multiple subtrees' '
 		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
 '
 
+# When subtree split-ing a directory that has other subtree
+# *merges* underneath it, the split must include those subtrees.
+# This test creates a nested subtree, `subA/subB`, and tests
+# that the tree is correct after a subtree split of `subA/`.
+# The test covers:
+# - An initial `subtree add`; and
+# - A follow-up `subtree merge`
+# both with and without `--squashed`.
+for is_squashed in '' 'y';
+do
+	test_expect_success "split keeps nested ${is_squashed:+--squash }subtrees that are part of the split" '
+		subtree_test_create_repo "$test_count" &&
+		(
+			cd "$test_count" &&
+			mkdir subA &&
+			test_commit subA/file1 &&
+			git branch -m main &&
+			test_create_subtree_add \
+				. mksubtree subA/subB file2 ${is_squashed:+--squash} &&
+			test -e subA/file1.t &&
+			test -e subA/subB/file2.t &&
+			git subtree split --prefix=subA --branch=bsplit &&
+			git checkout bsplit &&
+			test -e file1.t &&
+			test -e subB/file2.t &&
+			git checkout mksubtree &&
+			git branch -D bsplit &&
+			test_commit file3 &&
+			git checkout main &&
+			git subtree merge \
+				${is_squashed:+--squash} \
+				--prefix=subA/subB mksubtree &&
+			test -e subA/subB/file3.t &&
+			git subtree split --prefix=subA --branch=bsplit &&
+			git checkout bsplit &&
+			test -e file1.t &&
+			test -e subB/file2.t &&
+			test -e subB/file3.t
+		)
+	'
+done
+
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
 	test_create_commit "$test_count" main1 &&

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.43.0

