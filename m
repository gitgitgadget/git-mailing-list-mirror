Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FC64A8F
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382400; cv=none; b=jcp1AIlntEl/tgnb3ER2n+3ntGXnHkxQkW9HR237ASp2wVzBFvvM6OuztgWcBrm7akS9e38ZCg4n+bfbrhWFLtboqpLDnvLiFC+Rl1WrYA/qvubRa7M0JzV9uGMrtubcxsGIiVdgHsLQ7gK/y8G23fU6tH1vZdGMZWjmGO0SKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382400; c=relaxed/simple;
	bh=Ckv+cQIJhpHdUOCyanZo0Xn4vPJBY78tqJFOmFOZP98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6gKfR1dJVLicU9wZQrgSvXoaUOtybclT3EdHS/r9q66XiWuomUYOQYqSCdPuRqDvii/oOo1PiAMeA+36UQQH4qhbAoJzuqW81M17UcCsB5ehBRLuFDcW0jWKzD3Fyz5vcUJY5vqDF/ulmi8adGapC0Ul2OQmPg6Oud0t79WP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SlYzE/la; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SlYzE/la"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382394;
	bh=Ckv+cQIJhpHdUOCyanZo0Xn4vPJBY78tqJFOmFOZP98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=SlYzE/laQ96UN0shyp/jl/8uauaFfSzY9gzMtss/AY02qkBIz5vs6ySOVhG6s7H+e
	 eikrANj0amTxhzL36nDWI2YXxuPOC1veT/6xHght74VjSAl+ifgX5BxT870F2Ja+GC
	 4xzhvBVAZQNMt/wTupbhUPHAmli9NKOCfY7fsM3oL/4RKl1nAfQ/w0QH9UvKEYG6a/
	 1E4/sUkss0vyfAyieab+zSOpO1m7asnTWGxSk0u8+6GVdwubBa0hLYcA1VyoNKWJQ0
	 pMMLjfBon9TOGd0cYaVVrXt437q1m6zxi1g9ruDC1Zp12apqfcaN+Nc0IhiViiAdVZ
	 /HCKoD/gHLrsy3nSyGht97wQWXzf8Qw/qBEGhUI79BitZFlT+mJQTJ8dg31Lkj3cO9
	 YUkvd95IDTeN/Sete9DLwoDzndBETpPfYRU59rMePN1LVtKN9898DKKz2ANHJSwtYe
	 aWcO+v9NNMZmJrRmfhUGdnvAJs4PFrfSJ1Chdn5RxAYOrJtuKAn
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E874320197;
	Fri, 20 Jun 2025 01:19:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 06/10] t: default to compile-time default hash if not set
Date: Fri, 20 Jun 2025 01:19:38 +0000
Message-ID: <20250620011943.586596-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250620011943.586596-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, the default compile-time hash is SHA-1.  However, in the
future, this might change and it would be helpful to gracefully handle
this case in our testsuite.

To avoid making these assumptions, let's introduce a variable that
contains the built-in default hash and use it in our setup code as the
fallback value if no hash was explicitly set.  For now, this is always
SHA-1, but in a future commit, we'll allow adjusting this and the
variable will be more useful.

To allow us to make our tests more robust, allow test_oid to take the
--hash=builtin option to specify this hash, whatever it is.

Additionally, add a DEFAULT_HASH_ALGORITHM prerequisite to check for the
compile-time hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 5 ++++-
 t/test-lib.sh           | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bee4a2ca34..6ec95ea51f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1695,7 +1695,7 @@ test_set_hash () {
 
 # Detect the hash algorithm in use.
 test_detect_hash () {
-	case "$GIT_TEST_DEFAULT_HASH" in
+	case "${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}" in
 	"sha256")
 	    test_hash_algo=sha256
 	    test_compat_hash_algo=sha1
@@ -1767,6 +1767,9 @@ test_oid () {
 	--hash=compat)
 		algo="$test_compat_hash_algo" &&
 		shift;;
+	--hash=builtin)
+		algo="$GIT_TEST_BUILTIN_HASH" &&
+		shift;;
 	--hash=*)
 		algo="${1#--hash=}" &&
 		shift;;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 51370a201c..ef3759ec80 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -536,7 +536,8 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 export EDITOR
 
-GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
+GIT_TEST_BUILTIN_HASH=sha1
+GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
 GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
 export GIT_DEFAULT_REF_FORMAT
@@ -1908,6 +1909,10 @@ test_lazy_prereq SHA1 '
 	esac
 '
 
+test_lazy_prereq DEFAULT_HASH_ALGORITHM '
+	test "$GIT_TEST_BUILTIN_HASH" = "$GIT_DEFAULT_HASH"
+'
+
 test_lazy_prereq DEFAULT_REPO_FORMAT '
 	test_have_prereq SHA1,REFFILES
 '
