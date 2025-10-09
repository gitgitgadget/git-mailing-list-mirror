Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178128466A
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047001; cv=none; b=ZKMmHngIVePore7ZLoWb00jAKWcPGDZ1NQabBKFxX5ItqX7OQln8uLlh6urYM/C2mf9Aknz450LodvCIRu12KhyEiStHpPoi6w5TmECgUxu0HW/bjS0ZQYvEkaFi3AFunu3aJ31qGG/kyQQiRY0S3lT0RIHkFGSejovtL0dC48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047001; c=relaxed/simple;
	bh=gmGDpjYPbTlii/wE8tmQIPZxAMqcwxF/VJ05988nSiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Asv0zu66+z3tPXACHyPTGlVSkFbx4HZDvFDg2v4D2QVHfZZMtX+RKZ1khJd+sBnz0MqlEibTKo7bJjOLCAG8oztoTlUdQdVgaGgUa+ZYAn4n99Ol3cve/o2rC4MAEReB9cItCrCMbQ4gFTKEUDS4KwSyD1yP4xsJfDAUILxNtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Bd05J+br; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Bd05J+br"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=gmGDpjYPbTlii/wE8tmQIPZxAMqcwxF/VJ05988nSiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Bd05J+brOgtBThBvrqUXim0VmGcF2IYj1hR56cgAsduyKMZD4a0IU2qsI+PEjpXdS
	 51QpqHwmfPjujiywCBsXqn3pY03iS2j3e+vN/tanF5p15OEXTnTLqe3beboj7BOc/8
	 cUKRSXl8Ma/Y+rpGVXZqZIAsSZYoWZRzNrlup5cn2co4oXcvcr5y4tr8RTIsxZCdMq
	 Dwmh3fvXo6l4YqS/42zoKIsQj2yTBePRmnYigaa+T+cXZIkmjsenbrhC3OigFan5e7
	 pZuCeJQk8isnNUt5J662s67JIJJwCqY0zVsJXr/E/0w/PtaIR1R/TtQwCoXcj+6jRG
	 JH5eT91hvpD6qd345NQzf2bcFgsLXI+t5hYdz5K50Oi6XTdJ3nb+M+/uOqdAPq7aGY
	 cfiCpCU4xq06EbzpQRKocfUgWV8GDc2joJhZhtCyj++M1Z6s5nQeYnhIQm8oc69GbE
	 z4mYeKgbIY7rs+7npEBkCrOIFs54CS5ug641ON8Ik7c3nhdHSIz
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 96D4F201A2;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 8/9] t: allow specifying compatibility hash
Date: Thu,  9 Oct 2025 21:56:25 +0000
Message-ID: <20251009215626.3089287-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251009215626.3089287-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251009215626.3089287-1-sandals@crustytoothpaste.net>
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

In some cases, we'll need to adjust our test suite to work in a proper
way with a compatibility hash.  For example, in such a case, we'll only
use pack index v3, since v1 and v2 lack support for multiple algorithms.
Since we won't want to write those older formats, we'll need to skip
tests that do so.  Let's add a COMPAT_HASH prerequisite for this
purpose.

Finally, in this scenario, we can no longer rely on having broken
objects work since we lack compatibility mappings to rewrite objects in
the repository.  Add a prerequisite, BROKEN_OBJECTS, that we define in
terms of COMPAT_HASH and checks to see if creating deliberately broken
objects is possible, so that we can disable these tests if not.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh |  9 +++++++--
 t/test-lib.sh           | 13 +++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

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
index 621cd31ae1..9eb79324ee 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1917,6 +1917,19 @@ test_lazy_prereq DEFAULT_HASH_ALGORITHM '
 test_lazy_prereq DEFAULT_REPO_FORMAT '
 	test_have_prereq SHA1,REFFILES
 '
+# BROKEN_OBJECTS is a test whether we can write deliberately broken objects and
+# expect them to work.  When running using SHA-256 mode with SHA-1
+# compatibility, we cannot write such objects because there's no SHA-1
+# compatibility value for a nonexistent object.
+test_lazy_prereq BROKEN_OBJECTS '
+	! test_have_prereq COMPAT_HASH
+'
+
+# COMPAT_HASH is a test if we're operating in a repository with SHA-256 with
+# SHA-1 compatibility.
+test_lazy_prereq COMPAT_HASH '
+	test -n "$test_repo_compat_hash_algo"
+'
 
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
