Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4521482E8
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494705; cv=none; b=iRpxSQU9MFeU9xu++jj7m1Ig83d+sc9b2z9fYrIuHzXPv1Nrlm/yKWKf4PxGOk6MLw7zOu3ovpDKOi95cbjZnjsc7QWRGjV1OAJOLL0zNaZNW0hx+MODZZPfxsl5i+xDb4D8iRcdJt69r3O/k7G90xnU6yOZ6XgEsdDSfAmYg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494705; c=relaxed/simple;
	bh=aQ5sbBO/8X4Qgm2rM2hC1j8TVjaydh2fXdtLYBq4vTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKPdX83UeWVdv5FIqS3eMTmdfNfviaz8c5bkzWqnAv6sF9uc3lP3zdONxSi4ZrQzF5W5Bew63ZYZUMi+K9SI6nqJ/ZPw60FlVidds3rIqqJ/pYAq0R3ANrZU7RVinRsK8iSuBGSHamzICA8MFNc5fwfagXewhroC3f3C1wtzgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mg30BtvI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mg30BtvI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=aQ5sbBO/8X4Qgm2rM2hC1j8TVjaydh2fXdtLYBq4vTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=mg30BtvIH0wmwMT5TBdwf9aGsfQ+TpSjqKEW9BleDqqBZaq5fYZf40cD77DEFMjQe
	 bIvE5OF9seKvx+4jcnxKoitxLdZt9oY6TiQ1Wl4S/98joZZ2Mk08JeTwJIOIO4HhKf
	 BWfBAnrFs+nkY1gfO1HZ6Lw9HJdalqRsKOZb6hnTiXXlCh8dhtq2wOjorjhL7ggJWy
	 3B5ZYyDZ/IE/4wG4VXxAAfNxjbIJ8Db1WHKU3BYeVIonBXmCHuJYC/eZOhJ+L1fGKL
	 YGmO9kodFCP7HbolVF4BN/AkVXlZlgLvR5HYNRzDUYyHE7Qk8nNiDFHiqPPda0drEs
	 Zp8B5FwLBz0O61rRtNQGgbyr46G4i/zAvymRFhz63AZJox09B2T2iHA5LbYTaYxFkR
	 WmAbaUHo2UfHp5rB86uFiDNfk7S/ZHjW/+TDVGWhKj+HOe1/p6cgu3/ZW+LfbM6b/V
	 cPWxC6+38zgln17DMT6JzshhLMaNzsyY87JylFW4R5CH13gm5JG
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5A3E5200C7;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 01/16] repository: require Rust support for interoperability
Date: Sat,  7 Feb 2026 20:04:31 +0000
Message-ID: <20260207200446.2837699-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
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
index 46a7c99930..9ebbb7afd8 100644
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
@@ -183,13 +184,18 @@ void repo_set_hash_algo(struct repository *repo, int hash_algo)
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
index 0eee3bb878..22ea305387 100755
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
@@ -1236,7 +1261,10 @@ test_expect_success 'batch-check with a submodule' '
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
index 022dae02e4..a5406793f7 100755
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
index 0fb76f7d11..209498a0eb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1891,6 +1891,10 @@ test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
 
+test_lazy_prereq RUST '
+	test "$(build_option rust)" = enabled
+'
+
 test_lazy_prereq TIME_IS_64BIT 'test-tool date is64bit'
 test_lazy_prereq TIME_T_IS_64BIT 'test-tool date time_t-is64bit'
 
