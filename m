Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1A30206F
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404967; cv=none; b=c9CRguMCKeaOqkVcAnD+nFzXLTZGcYr61ePnZ+c0z4vuxc4QFMFfZ+2p4kwJAy8QXSK7xDPgBfZ1dlOkKXbhHMNeofuOLLiFwKetAdBc4wRYHUJsTCr4Wtgchi/5u53rCpvQzb57HkQ9kpfXCpDywHYZycezcBiBhHppxzhs1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404967; c=relaxed/simple;
	bh=x/aiL9T95Zm0pxsU+hfExcm7/MB2JQ8t37bLFc5huU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk0oHF2Azrjk3qGlB0thvlkDZBSHIpR0IDpZszoL0NlYUQI8/QBcdqsNZCcOdVD1bDovvpyTYWIDNvVib/+tqlcCNHN8Ds2yXCH3nPsrXXmZScQn5kFg/56dUtmUtuz4GVZ0lmvHFphOyUKThSmHGDiGKwmqno3vlFi+PTNz/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=N85hbxxR; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N85hbxxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=x/aiL9T95Zm0pxsU+hfExcm7/MB2JQ8t37bLFc5huU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=N85hbxxRMGKUi7Tnp36SEofabgb7a/In6lrpiCn1VC8y4VOqlxiPPSqvQMPEQO1Tu
	 PE4vGmXlzI0D6Rw0NYcHb40MJMBEWuVJs5c0BfXRH/9NCW1MJYEB+p02yekhBeHTSF
	 ubwOOQNDGykqRDirM/ZbJTyHwb6Vsdrgrs00fg93/KqSer/f4JMX4cmZ1l5iqyKHVZ
	 41gon16sC7yXihRzzzBHcCooZh4tcuyYGm0POcm1uYRj6NbFjRyROfHPZ3NE8T6RTd
	 A2voVv+GtqMOPZ9QBGn5LiaviVgjFpriOCcbh1aRzUlBi5Njnk/2afSU4NdwSOFRqX
	 Rl262Af3SkUSSEjX8Jw3jUHPzsRETm4YvzjzNy9gKv8WDBxnGxVT9fjSRwqyLy7faB
	 nCyrHP30svhnwjhcVzSJeoPqGNcfaXMk0zRu4u86OnL5dDXpMogDppHVlGi8IdnEs3
	 Q1xI5kk7c3PpritExejwI9s3L7hFJP/H3n3AkOzY6Xr7rOvBs1U
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6F4182019C;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 08/11] t4042: choose the built-in hash outside of a repo
Date: Tue,  1 Jul 2025 21:22:34 +0000
Message-ID: <20250701212237.766774-9-sandals@crustytoothpaste.net>
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
of a repository will always use SHA-1, provide constants for both
algorithms and then simply ask test_oid for the built-in hash instead,
which will always be correct.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4042-diff-textconv-caching.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index ff0e73531b..31018ceba2 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -120,6 +120,14 @@ test_expect_success 'log notes cache and still use cache for -p' '
 '
 
 test_expect_success 'caching is silently ignored outside repo' '
+	test_oid_cache <<-\EOM &&
+	oid1 sha1:5626abf
+	oid1 sha256:a4ed1f3
+	oid2 sha1:f719efd
+	oid2 sha256:aa9e7dc
+	EOM
+	oid1=$(test_oid --hash=builtin oid1) &&
+	oid2=$(test_oid --hash=builtin oid2) &&
 	mkdir -p non-repo &&
 	echo one >non-repo/one &&
 	echo two >non-repo/two &&
@@ -129,9 +137,9 @@ test_expect_success 'caching is silently ignored outside repo' '
 		   -c diff.test.textconv="tr a-z A-Z <" \
 		   -c diff.test.cachetextconv=true \
 		   diff --no-index one two >actual &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/one b/two
-	index 5626abf..f719efd 100644
+	index $oid1..$oid2 100644
 	--- a/one
 	+++ b/two
 	@@ -1 +1 @@
