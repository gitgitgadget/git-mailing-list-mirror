Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216C302CB6
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404968; cv=none; b=b+v60kNGVORtR/1J04V1qE05fydiUo29k5DPxsz6HMQznoIpZ7rwHu7mhlgas1IdOzLTq5IFTDchmDlTxMYfBdNTtp7FY5ccQCi2SIDqP3/kyExCiI/ZaqWWe8gtKz2eXB+HBbFLw9iUbK6MLAtfyM+HOxGOYHg1e9o4u5nmJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404968; c=relaxed/simple;
	bh=X1SxWtw3SJ+CsRqopOxYAdDWFw6nJ7n2d0JYisoybck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcdFpwUoxCbmuV8r+KJpgz8Lh+MOyjunbpIVh2PwxKeuwJKPpIrI3oTSrgGDqL+jFPgBaXSsTjCGw3UytMbj25pRgxIDASlM4x3SL7DWL3uHnOH/Wv8/yDvQy5ZcoH5OQpOWlxUHfmQKJK33TpYiKnJ04uwQS20WORkLBqG0KNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nkhj9iMb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nkhj9iMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=X1SxWtw3SJ+CsRqopOxYAdDWFw6nJ7n2d0JYisoybck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=nkhj9iMbMIrqBK5uJX90dOBu8/ryoHCYCrWkJpauVz+0TLoPatGB97NXQVBHmc67q
	 5V4xjiVx6X/fN22U9zAYIahC7msoU9g5r7hShaj/JRU63P7hKT7I35kL/qingEkwxz
	 uyHlA2gHvLJDFS+K5WagPKOT1fdcAK6I1fFmfnlpBHWcoJ10uhyHuj9wg82YKHyF2h
	 CIGSSxF6oiGidS37LYf54xTXP1CO5zkcO2m6iD3kkgEVaEKaOsuA+bzugPyk25IOsF
	 asqdNSLUpPs7VAui6oK+dz4jl6nXMXptIWeKQFX+d1tepmfmrsiHU7SGGZ7JdacuFU
	 MtPE22c5q70RaVFfEDRM0sKihcvSDkEmEcZZYhcOd626b0lNaiNiiqFgiMLJUk2tMO
	 DScoQeQuEN9UtcCVlaKCvnJKs7L0ADQbJNbPKV/bSWTqL128r2JWgelhxa49ymJAiS
	 d7a8WxyIWfVxlMaaNFRXBVZUPsX4k5Od2jwTiydFi1M6eW5Ho+I
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8DEB92019F;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 11/11] Enable SHA-256 by default in breaking changes mode
Date: Tue,  1 Jul 2025 21:22:37 +0000
Message-ID: <20250701212237.766774-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Our document on breaking changes indicates that we intend to default to
SHA-256 in Git 3.0.  Since most people choose the default option, this
is an important security upgrade to our defaults.

To allow people to test this case, when WITH_BREAKING_CHANGES is set in
the configuration, build Git with SHA-256 as the default hash.  Update
the testsuite to use the build options information to automatically
choose the right value.

Note that if the command substitution for GIT_TEST_BUILTIN_HASH fails,
so does the testsuite—and quite spectacularly at that.  Thus, the case
where the Git binary is somehow subtly broken will not go undetected.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h        | 8 +++++++-
 t/test-lib.sh | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hash.h b/hash.h
index 953e840d15..3fcbe9bcba 100644
--- a/hash.h
+++ b/hash.h
@@ -174,8 +174,14 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 #define GIT_HASH_SHA256 2
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+
 /* Default hash algorithm if unspecified. */
-#define GIT_HASH_DEFAULT GIT_HASH_SHA1
+#ifdef WITH_BREAKING_CHANGES
+# define GIT_HASH_DEFAULT GIT_HASH_SHA256
+#else
+# define GIT_HASH_DEFAULT GIT_HASH_SHA1
+#endif
+
 /* Legacy hash algorithm. Implied for older data formats which don't specify. */
 #define GIT_HASH_SHA1_LEGACY GIT_HASH_SHA1
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef3759ec80..6dc2022ee1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -536,7 +536,7 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 export EDITOR
 
-GIT_TEST_BUILTIN_HASH=sha1
+GIT_TEST_BUILTIN_HASH=$("$GIT_BUILD_DIR/git" version --build-options | sed -ne 's/^default-hash: //p')
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
 GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
