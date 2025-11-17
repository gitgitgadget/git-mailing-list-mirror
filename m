Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EF34D396
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417790; cv=none; b=PxRZVtyicbhy73X3qJ/Uv/MU4BXe/2ZQ2u6qVuwxHozl043uvKB2750Yx4iJty43erkEuqf7TRAAgV07/lT2M7LsYFMbeGRKLRXj/FLso1Wf9dKoi6ibgbFOuGGd05eHd7mkAXhyCo1NIXuB4hI0fwppOxRfRkBCDzdmcqAuTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417790; c=relaxed/simple;
	bh=4WXTRREor0cYOCx1pq1LrrWnFFcEOqCox+CjKzvdSy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPKs4A9bLTNR9tkU0qo4NBUEBTlOh8q0oi0SIt7/ow7fuFf8TRnTAWlBwJydsT7o1soRvMOb+8m5BKDjG4Fr4pb4LAbyovS8nGl4MgX/DrgIX64M6+YtXCUFyP+nmGnHiIv9ADNL0fOlNqTBT0HOPYbATbFFQoztALOLUsaqhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=W9dzzWGt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="W9dzzWGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417785;
	bh=4WXTRREor0cYOCx1pq1LrrWnFFcEOqCox+CjKzvdSy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=W9dzzWGtAf2NtpLUCQeEabzZ5mcjLW+K/OUwvxzncVSLNC6/jc80RQNS+o21qF/Pr
	 uwucNejt695eBL8mVNBV7swhdpx1KTaTtd92rHmQCvkCQuCxDJBw/v0wSClaLGxgNb
	 lK1GIWmHndbP1a2vrqe5JdHGe/dsrBYtbo2LJbxNNELxHe9la8Y6TCY2Mi9ApfF6iQ
	 exPyxWIlUVK7qlQratFyWMCYGWyGcy/tSb2wp8KiaiL7Nyf+DFHHbSID1xjjLgbQA5
	 eyynzSUIN2mcG2jr4YLwhNm0JgSRKU2Bn2PrwvmytOaJpaikL071K9JVLjWpQp+8yp
	 ktumSw2y8828YIwLF2Pq7jGftLaxibHpqI9Olc30iPQI8Kv2Kg04NS8p+DtV86v7KI
	 ZWw1qBNXMPxttF+YHV6jntYnidKm7NaMvqObfF5VL0oBar/1gQLeb5T6bfPJCVsTff
	 /uYn9vDjt+AzCO90eRor2Cwu5em0vogvsMzFv1teOpQDNQiU4dn
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EEE0320188;
	Mon, 17 Nov 2025 22:16:25 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 01/15] repository: require Rust support for interoperability
Date: Mon, 17 Nov 2025 22:16:07 +0000
Message-ID: <20251117221621.2863243-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll be implementing some of our interoperability code, like the loose
object map, in Rust.  While the code currently compiles with the old
loose object map format, which is written entirely in C, we'll soon
replace that with the Rust-based implementation.

Require the use of Rust for compatibility mode and die if it is not
supported.  Because the repo argument is not used when Rust is missing,
cast it to void to silence the compiler warning, which we do not care
about.

Add a prerequisite in our tests, RUST, that checks if Rust functionality
is available and use it in the tests that handle interoperability.

This is technically a regression in functionality compared to our
existing state, but pack index v3 is not yet implemented and thus the
functionality is mostly quite broken, which is why we've recently marked
this functionality as experimental.  We don't believe anyone is getting
useful use out of the interoperability code in its current state, so no
actual users should be negatively impacted by this change.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 repository.c                      |  8 ++-
 t/t1006-cat-file.sh               | 82 +++++++++++++++++++++----------
 t/t1016-compatObjectFormat.sh     |  6 +++
 t/t1500-rev-parse.sh              |  2 +-
 t/t9305-fast-import-signatures.sh |  4 +-
 t/t9350-fast-export.sh            |  4 +-
 t/test-lib.sh                     |  4 ++
 7 files changed, 77 insertions(+), 33 deletions(-)

diff --git a/repository.c b/repository.c
index 6faf5c7398..186d2c1028 100644
--- a/repository.c
+++ b/repository.c
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "odb.h"
 #include "config.h"
+#include "gettext.h"
 #include "object.h"
 #include "lockfile.h"
 #include "path.h"
@@ -190,13 +191,18 @@ void repo_set_hash_algo(struct repository *repo, int hash_algo)
 	repo->hash_algo = &hash_algos[hash_algo];
 }
 
-void repo_set_compat_hash_algo(struct repository *repo, int algo)
+void repo_set_compat_hash_algo(struct repository *repo MAYBE_UNUSED, int algo)
 {
+#ifdef WITH_RUST
 	if (hash_algo_by_ptr(repo->hash_algo) == algo)
 		BUG("hash_algo and compat_hash_algo match");
 	repo->compat_hash_algo = algo ? &hash_algos[algo] : NULL;
 	if (repo->compat_hash_algo)
 		repo_read_loose_object_map(repo);
+#else
+	if (algo)
+		die(_("compatibility hash algorithm support requires Rust"));
+#endif
 }
 
 void repo_set_ref_storage_format(struct repository *repo,
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1f61b666a7..29a9503523 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -241,10 +241,16 @@ hello_content="Hello World"
 hello_size=$(strlen "$hello_content")
 hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
 
-test_expect_success "setup" '
+test_expect_success "setup part 1" '
 	git config core.repositoryformatversion 1 &&
-	git config extensions.objectformat $test_hash_algo &&
-	git config extensions.compatobjectformat $test_compat_hash_algo &&
+	git config extensions.objectformat $test_hash_algo
+'
+
+test_expect_success RUST 'compat setup' '
+	git config extensions.compatobjectformat $test_compat_hash_algo
+'
+
+test_expect_success 'setup part 2' '
 	echo_without_newline "$hello_content" > hello &&
 	git update-index --add hello &&
 	echo_without_newline "$hello_content" > "path with spaces" &&
@@ -273,9 +279,13 @@ run_blob_tests () {
     '
 }
 
-hello_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $hello_oid)
 run_blob_tests $hello_oid
-run_blob_tests $hello_compat_oid
+
+if test_have_prereq RUST
+then
+	hello_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $hello_oid)
+	run_blob_tests $hello_compat_oid
+fi
 
 test_expect_success '--batch-check without %(rest) considers whole line' '
 	echo "$hello_oid blob $hello_size" >expect &&
@@ -286,62 +296,76 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 '
 
 tree_oid=$(git write-tree)
-tree_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tree_oid)
 tree_size=$((2 * $(test_oid rawsz) + 13 + 24))
-tree_compat_size=$((2 * $(test_oid --hash=compat rawsz) + 13 + 24))
 tree_pretty_content="100644 blob $hello_oid	hello${LF}100755 blob $hello_oid	path with spaces${LF}"
-tree_compat_pretty_content="100644 blob $hello_compat_oid	hello${LF}100755 blob $hello_compat_oid	path with spaces${LF}"
 
 run_tests 'tree' $tree_oid "" $tree_size "" "$tree_pretty_content"
-run_tests 'tree' $tree_compat_oid "" $tree_compat_size "" "$tree_compat_pretty_content"
 run_tests 'blob' "$tree_oid:hello" "100644" $hello_size "" "$hello_content" $hello_oid
-run_tests 'blob' "$tree_compat_oid:hello" "100644" $hello_size "" "$hello_content" $hello_compat_oid
 run_tests 'blob' "$tree_oid:path with spaces" "100755" $hello_size "" "$hello_content" $hello_oid
-run_tests 'blob' "$tree_compat_oid:path with spaces" "100755" $hello_size "" "$hello_content" $hello_compat_oid
+
+if test_have_prereq RUST
+then
+	tree_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tree_oid)
+	tree_compat_size=$((2 * $(test_oid --hash=compat rawsz) + 13 + 24))
+	tree_compat_pretty_content="100644 blob $hello_compat_oid	hello${LF}100755 blob $hello_compat_oid	path with spaces${LF}"
+
+	run_tests 'tree' $tree_compat_oid "" $tree_compat_size "" "$tree_compat_pretty_content"
+	run_tests 'blob' "$tree_compat_oid:hello" "100644" $hello_size "" "$hello_content" $hello_compat_oid
+	run_tests 'blob' "$tree_compat_oid:path with spaces" "100755" $hello_size "" "$hello_content" $hello_compat_oid
+fi
 
 commit_message="Initial commit"
 commit_oid=$(echo_without_newline "$commit_message" | git commit-tree $tree_oid)
-commit_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $commit_oid)
 commit_size=$(($(test_oid hexsz) + 137))
-commit_compat_size=$(($(test_oid --hash=compat hexsz) + 137))
 commit_content="tree $tree_oid
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 $commit_message"
 
-commit_compat_content="tree $tree_compat_oid
+run_tests 'commit' $commit_oid "" $commit_size "$commit_content" "$commit_content"
+
+if test_have_prereq RUST
+then
+	commit_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $commit_oid)
+	commit_compat_size=$(($(test_oid --hash=compat hexsz) + 137))
+	commit_compat_content="tree $tree_compat_oid
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 $commit_message"
 
-run_tests 'commit' $commit_oid "" $commit_size "$commit_content" "$commit_content"
-run_tests 'commit' $commit_compat_oid "" $commit_compat_size "$commit_compat_content" "$commit_compat_content"
+	run_tests 'commit' $commit_compat_oid "" $commit_compat_size "$commit_compat_content" "$commit_compat_content"
+fi
 
 tag_header_without_oid="type blob
 tag hellotag
 tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 tag_header_without_timestamp="object $hello_oid
 $tag_header_without_oid"
-tag_compat_header_without_timestamp="object $hello_compat_oid
-$tag_header_without_oid"
 tag_description="This is a tag"
 tag_content="$tag_header_without_timestamp 0 +0000
 
-$tag_description"
-tag_compat_content="$tag_compat_header_without_timestamp 0 +0000
-
 $tag_description"
 
 tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
 
-tag_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tag_oid)
-tag_compat_size=$(strlen "$tag_compat_content")
-
 run_tests 'tag' $tag_oid "" $tag_size "$tag_content" "$tag_content"
-run_tests 'tag' $tag_compat_oid "" $tag_compat_size "$tag_compat_content" "$tag_compat_content"
+
+if test_have_prereq RUST
+then
+	tag_compat_header_without_timestamp="object $hello_compat_oid
+$tag_header_without_oid"
+	tag_compat_content="$tag_compat_header_without_timestamp 0 +0000
+
+$tag_description"
+
+	tag_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tag_oid)
+	tag_compat_size=$(strlen "$tag_compat_content")
+
+	run_tests 'tag' $tag_compat_oid "" $tag_compat_size "$tag_compat_content" "$tag_compat_content"
+fi
 
 test_expect_success "Reach a blob from a tag pointing to it" '
 	echo_without_newline "$hello_content" >expect &&
@@ -590,7 +614,8 @@ flush"
 }
 
 batch_tests $hello_oid $tree_oid $tree_size $commit_oid $commit_size "$commit_content" $tag_oid $tag_size "$tag_content"
-batch_tests $hello_compat_oid $tree_compat_oid $tree_compat_size $commit_compat_oid $commit_compat_size "$commit_compat_content" $tag_compat_oid $tag_compat_size "$tag_compat_content"
+
+test_have_prereq RUST && batch_tests $hello_compat_oid $tree_compat_oid $tree_compat_size $commit_compat_oid $commit_compat_size "$commit_compat_content" $tag_compat_oid $tag_compat_size "$tag_compat_content"
 
 
 test_expect_success FUNNYNAMES 'setup with newline in input' '
@@ -1226,7 +1251,10 @@ test_expect_success 'batch-check with a submodule' '
 	test_unconfig extensions.compatobjectformat &&
 	printf "160000 commit $(test_oid deadbeef)\tsub\n" >tree-with-sub &&
 	tree=$(git mktree <tree-with-sub) &&
-	test_config extensions.compatobjectformat $test_compat_hash_algo &&
+	if test_have_prereq RUST
+	then
+		test_config extensions.compatobjectformat $test_compat_hash_algo
+	fi &&
 
 	git cat-file --batch-check >actual <<-EOF &&
 	$tree:sub
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 0efce53f3a..92d48b96a1 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -8,6 +8,12 @@ test_description='Test how well compatObjectFormat works'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
+if ! test_have_prereq RUST
+then
+	skip_all='interoperability requires a Git built with Rust'
+	test_done
+fi
+
 # All of the follow variables must be defined in the environment:
 # GIT_AUTHOR_NAME
 # GIT_AUTHOR_EMAIL
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 7739ab611b..98c5a772bd 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -208,7 +208,7 @@ test_expect_success 'rev-parse --show-object-format in repo' '
 '
 
 
-test_expect_success 'rev-parse --show-object-format in repo with compat mode' '
+test_expect_success RUST 'rev-parse --show-object-format in repo with compat mode' '
 	mkdir repo &&
 	(
 		sane_unset GIT_DEFAULT_HASH &&
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
index c2b4271658..63c0a2b5c4 100755
--- a/t/t9305-fast-import-signatures.sh
+++ b/t/t9305-fast-import-signatures.sh
@@ -70,7 +70,7 @@ test_expect_success GPGSSH 'strip SSH signature with --signed-commits=strip' '
 	test_must_be_empty log
 '
 
-test_expect_success GPG 'setup a commit with dual OpenPGP signatures on its SHA-1 and SHA-256 formats' '
+test_expect_success RUST,GPG 'setup a commit with dual OpenPGP signatures on its SHA-1 and SHA-256 formats' '
 	# Create a signed SHA-256 commit
 	git init --object-format=sha256 explicit-sha256 &&
 	git -C explicit-sha256 config extensions.compatObjectFormat sha1 &&
@@ -91,7 +91,7 @@ test_expect_success GPG 'setup a commit with dual OpenPGP signatures on its SHA-
 	test_grep -E "^gpgsig-sha256 " out
 '
 
-test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=warn-strip' '
+test_expect_success RUST,GPG 'strip both OpenPGP signatures with --signed-commits=warn-strip' '
 	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
 	test_grep -E "^gpgsig sha1 openpgp" output &&
 	test_grep -E "^gpgsig sha256 openpgp" output &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 3d153a4805..784d68b6e5 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -972,7 +972,7 @@ test_expect_success 'fast-export handles --end-of-options' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'setup a commit with dual signatures on its SHA-1 and SHA-256 formats' '
+test_expect_success GPG,RUST 'setup a commit with dual signatures on its SHA-1 and SHA-256 formats' '
 	# Create a signed SHA-256 commit
 	git init --object-format=sha256 explicit-sha256 &&
 	git -C explicit-sha256 config extensions.compatObjectFormat sha1 &&
@@ -993,7 +993,7 @@ test_expect_success GPG 'setup a commit with dual signatures on its SHA-1 and SH
 	test_grep -E "^gpgsig-sha256 " out
 '
 
-test_expect_success GPG 'export and import of doubly signed commit' '
+test_expect_success GPG,RUST 'export and import of doubly signed commit' '
 	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
 	test_grep -E "^gpgsig sha1 openpgp" output &&
 	test_grep -E "^gpgsig sha256 openpgp" output &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef0ab7ec2d..3499a83806 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1890,6 +1890,10 @@ test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
 
+test_lazy_prereq RUST '
+	test "$(build_option rust)" = enabled
+'
+
 test_lazy_prereq TIME_IS_64BIT 'test-tool date is64bit'
 test_lazy_prereq TIME_T_IS_64BIT 'test-tool date time_t-is64bit'
 
