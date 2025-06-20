Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80402634EC
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382400; cv=none; b=Yz2DfYE7sKjPiPBoaV0PIXNmwTcKUMp/5Dj4w2fLS25uV66nc04rbbq8N48Ha+fTVJYCdarEkzRZ3seBHFO/QVGZQSuZt2WJPITQbgZTUpoarQJI/G/B05vivqAloDKmD6LVMZwK61Ih//8K/Khl0lzQxkck/JOIF2fG1AK4Xh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382400; c=relaxed/simple;
	bh=x/aiL9T95Zm0pxsU+hfExcm7/MB2JQ8t37bLFc5huU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/Y+qjVq9A1EM/k+uXoGcpz1irO4dtfLxL0lzv/CTaJHp1dm71C3OGjYd486RgvcuIZVFooQ9eMIiX4v6oZ4C+I9gZnCZNdu3yROirar0hW3I6inCYbZvK4kRYxl2S/OIoSaH3MbnqjQdhLtUv6mq5wJa1aHYoAwYAkcmcJL0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wwKmNnX/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wwKmNnX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382395;
	bh=x/aiL9T95Zm0pxsU+hfExcm7/MB2JQ8t37bLFc5huU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=wwKmNnX/yYqxqjvxVOXJc/z/BPQitFXjX0yHDtl5ar87Lv1XgHqXXpo90mlfq/XO2
	 fJSlKTJVD5k0SJ3hG+Q8R36FN7MXm0jkyZ9ulBkvQ98CdTgKf1kmRJvsR1PbgBM1PO
	 2YzqXc3UV20p/0LoriZdcKbIS0xCsLuMhPX4exak0pyzAnWLOmtzy4EQ7etA9PAmR4
	 JpGKV16DRReGRZotmzjgOvtmvLynKBL+R7aSRCtqoWTwbSQkyyA7A/1UqDZzJg/uzR
	 U4Wef7hIZyFR/3rlP+ZeWRABSehJEx78Uj+8nrFpObPMFAdhchNKYcJJ1QmBsiaE/o
	 GEb1HvEw+yqcegCrQ+W96klRN8bC5TaUK7hsvLCcvEFN94FTAToBqNaTCHuYxLyvwD
	 UyRqCd3Gk68UnYk1GCFoIz2FuADZuX6SSfYqtjywjGjfjxOiF6K6exLdMwvxK6ZMte
	 K2liCDTUJE3VUWNGyCaXeGLTBpjrT4Xo9MIB4yOElBSdWQ0fU+T
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 081CF20199;
	Fri, 20 Jun 2025 01:19:55 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 08/10] t4042: choose the built-in hash outside of a repo
Date: Fri, 20 Jun 2025 01:19:40 +0000
Message-ID: <20250620011943.586596-9-sandals@crustytoothpaste.net>
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
