Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E4302CAE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404968; cv=none; b=gyNZ+n8P9WgBB7BFPoziNmbRhV7eUTBm60XcUapTHAtjGcWCNVubFYxVhDo5pN6e3t9ynJ/R1r4QrrZ7megvl5hRKWaBkyZqHfd4lT/ah3G/y7HzciHq4yv8D+cZVa7joLHBkqDXap4n+w9Swpxf97RnzSBIIL2CdhsBtto3dy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404968; c=relaxed/simple;
	bh=JScSqnOEibXSLIM0/Vbqfu/8ITUbj+HzYUwSu11fFUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqX5x9MHE25upFnqgdlIrnhB44X3Eeuku2wu3Ii431mf0WFsuThW+dN5nq7MoL7wHUk9eXj8AVYD8EzLdO96rcHI1uhu4EYPfocUIMbN39vZfT7h6cL3xxwewi+Gz7WYvUKZFFgXvrgjCdiOvnHYw9tuL89MPUNFpOvu6zlye+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aYR2BAHS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aYR2BAHS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=JScSqnOEibXSLIM0/Vbqfu/8ITUbj+HzYUwSu11fFUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=aYR2BAHS2iZP9wXlU4bR+H8cE2zCFoxYAN5y1IeiX8awwWGFKJ7WKI1xICPvbgDzE
	 qRzGY7v+0032Tacnr90ss/iQW5pO7wXXCVdv3kvjztd5mmt4lFlXPMF/urmiA1Jkyj
	 Ojg6bDn9beSAKWpiYo9z+6E3hq4f3hQ1W1ZHtsdRuv9ZLhqK4yHM6NAimy8g/gqoNe
	 A374f6PE/jP+JvrM+eWmC68frqHGCqWk9kKhPrptysyCS0SdneHn4jN488neg5olLn
	 2coCqzde1xLKsSJ44hVBgvNWty2+WQUniyA1UJBJ6st3ulpOxXMa9mVk9rjH5bZFqu
	 WiKS1SB2+99ivU4LMhlZ/df3kWWnqpEMwLwkzz5qbD+uvChXoqyaRpaGck0y/5BWTY
	 n2Watv1iID8R6Clm8XV/MVz12ih3QtnQoOFmKcWhjhviW4apHXFnyTCoQjMvFm2dpd
	 NrE/WNZuS1cuW2iT1JT+X7KvHra4f2UopUeR9xnodNkfbUuOOji
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 75E692019D;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 09/11] t5300: choose the built-in hash outside of a repo
Date: Tue,  1 Jul 2025 21:22:35 +0000
Message-ID: <20250701212237.766774-10-sandals@crustytoothpaste.net>
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
Content-Transfer-Encoding: 8bit

Right now, the built-in default hash is always SHA-1, but that will
change in a future commit.  Instead of assuming that operating outside
of a repository will always use SHA-1, look up the default hash
algorithm for operating outside of a repository using an appropriate
environment variable, which will always be correct.

Additionally, for operations outside of a repository, use the
DEFAULT_HASH_ALGORITHM prerequisite rather than SHA1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5300-pack-object.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index ae72158b94..73445782e7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -525,7 +525,7 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
-test_expect_success SHA1 'show-index works OK outside a repository' '
+test_expect_success DEFAULT_HASH_ALGORITHM 'show-index works OK outside a repository' '
 	nongit git show-index <foo.idx
 '
 
@@ -658,7 +658,7 @@ do
 		test_commit -C repo initial &&
 		git -C repo repack -ad &&
 		git -C repo verify-pack "$(pwd)"/repo/.git/objects/pack/*.idx &&
-		if test $hash = sha1
+		if test $hash = $GIT_TEST_BUILTIN_HASH
 		then
 			nongit git verify-pack "$(pwd)"/repo/.git/objects/pack/*.idx
 		else
@@ -676,7 +676,7 @@ do
 		test_commit -C repo initial &&
 		git -C repo repack -ad &&
 		git -C repo index-pack --verify "$(pwd)"/repo/.git/objects/pack/*.pack &&
-		if test $hash = sha1
+		if test $hash = $GIT_TEST_BUILTIN_HASH
 		then
 			nongit git index-pack --verify "$(pwd)"/repo/.git/objects/pack/*.pack
 		else
