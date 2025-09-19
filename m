Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CC225397
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244186; cv=none; b=qfgU6SuElkAB03E5VFbPSkv6tby3z2TOHMIBRsCjCbtQsJQDc3r0rdhMwLKGeiTgFQyYoUQOKVybusWFG6FzsvWlKrepO9WOPzLyRwnFBzVVbxnI49Vj+OTMiQrg3cmnURqWwUB8RQdkoZP0KhLTUOBTcOjH7dyiozseykQkF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244186; c=relaxed/simple;
	bh=wFkgWXhtxBwQ7a8rSgfBfMmfp9jHkAADUfXnLLChS+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8zB1DEPXZPmMkxoyLzeC+klfEI73+hhdYiI7UW+9Rupz6uIh6lRS+3gHg+9HTWXzX93wDYalPRPlbcbk2jklwCax3yU0Nxe/aToKBYatrT/760RndHLLzxE1bjpeiqQw4jVIQZjlP0JjjAWhFAwaBzPaFDCwjAput2qsJKaz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ulARYH9z; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ulARYH9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=wFkgWXhtxBwQ7a8rSgfBfMmfp9jHkAADUfXnLLChS+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ulARYH9zhJS2ve+gQ8A69hNlqJmfuZSV1BMkOPI5HbosA2kQ6iLDRMnAoq3Q4W0i9
	 Nc4cbyi4G/KsogLD596TEFFHVTvFw5/kjdkx+JcJ2lbCWAyte+CDPQeS8u+eIvW6i7
	 n1Kn0djfbw5/UVqY30yQoy08CjD9cehKIC/5FQwspu/xJZfjt9j/qaocNWARTXJqRZ
	 yJMn2fGpd9UyTmdOrptETZpkMgOiIbzPeiMFSau83rRAfzMp71k77ENkfmFPY+SPyc
	 SDSaH4glSg/O6ofllWD3k1kUhf+0xgKRfvF5QVr8llZudnNYIwQ+7qK9CYQVvsY39J
	 OgtVxuchVdSepm7Ax/eJjLNHJSB6ibNcXpuCT7GKqcN/17oclbMw5z1ERIMgOPN2Tx
	 gmYuhrKtyfXLMFhVnqd/oEhRx8pafueeiXq5Om75EG1cLVzJP/Pey7obY0C7r2KFeO
	 /NAu7QTTsabs3oQ+sC5v961nI2WUC1z9B+8z4ppsyDGjjPb4UrG
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5E5182019A;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 8/9] Allow specifying compatibility hash
Date: Fri, 19 Sep 2025 01:09:10 +0000
Message-ID: <20250919010911.649831-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20250919010911.649831-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to specify a compatibility hash for testing interactions for
SHA-256 repositories where we have SHA-1 compatibility enabled.  Allow
the user to specify this scenario in the test suite by setting
GIT_TEST_DEFAULT_HASH to "sha256:sha1".

Note that this will get passed into GIT_DEFAULT_HASH, which Git itself
does not presently support.  However, we will support this in a future
commit.

Since we'll now want to know the value for a specific version, let's add
the ability to specify either the storage hash (in this case, SHA-256)
or the compatibility hash (SHA-1).  We use a different value for the
compatibility hash that will be enabled for all repositories
(test_repo_compat_hash_algo) versus the one that is used individually in
some tests (test_compat_hash_algo), since we want to still run those
individual tests without requiring that the testsuite be run fully in a
compatibility mode.

Finally, in this scenario, we can no longer rely on having broken
objects work since we lack compatibility mappings to rewrite objects in
the repository.  Add a prerequisite, BROKEN_OBJECTS, that checks to see
if creating deliberately broken objects is possible, so that we can
disable these tests if not.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 9 +++++++--
 t/test-lib.sh           | 7 +++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a28de7b19b..52d7759bf5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1708,11 +1708,16 @@ test_set_hash () {
 # Detect the hash algorithm in use.
 test_detect_hash () {
 	case "${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}" in
-	"sha256")
+	*:*)
+	    test_hash_algo="${GIT_TEST_DEFAULT_HASH%%:*}"
+	    test_compat_hash_algo="${GIT_TEST_DEFAULT_HASH##*:}"
+	    test_repo_compat_hash_algo="$test_compat_hash_algo"
+	    ;;
+	sha256)
 	    test_hash_algo=sha256
 	    test_compat_hash_algo=sha1
 	    ;;
-	*)
+	sha1)
 	    test_hash_algo=sha1
 	    test_compat_hash_algo=sha256
 	    ;;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 621cd31ae1..14c777e4e2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1917,6 +1917,13 @@ test_lazy_prereq DEFAULT_HASH_ALGORITHM '
 test_lazy_prereq DEFAULT_REPO_FORMAT '
 	test_have_prereq SHA1,REFFILES
 '
+# BROKEN_OBJECTS is a test if we can write deliberately broken objects and
+# expect them to work.  When running using SHA-256 mode with SHA-1
+# compatibility, we cannot write such objects because there's no SHA-1
+# compatibility value for a nonexistent object.
+test_lazy_prereq BROKEN_OBJECTS '
+	test -z "$test_repo_compat_hash_algo"
+'
 
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
