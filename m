Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908D86334
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382400; cv=none; b=aKyEfR1Q1wq3fA9q9zECMiLQ3fMLgr2PIycnSbnF/gPVQJn83OUAkRtHyffYsRJXeoOGwOaLmCL7SS217ePreSAd5LDAfX5zUmU/fxSHduROfd1IwMMXmVFKaxpje5eJBTPOyd9eFEr2NOjaFvINEzHcswogtvMPyefIJ2I677M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382400; c=relaxed/simple;
	bh=JScSqnOEibXSLIM0/Vbqfu/8ITUbj+HzYUwSu11fFUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwi2OxLc2y7Df+muAZr5I4JIKBA/xQn30sv3EAAWpWXV7/vUKTNNJApSUIEx+2Gr1nGxmD5byQCdNvK9HZDyV2rTF1LDcE1uZMQccg9uqT43GkyJIOSvOjUtaQdCZFf6c5Qdlf/CMB6ZR5L0Gg/JPOmD3K2EHqLBYS8zX0FsR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gMuccr5H; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gMuccr5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382395;
	bh=JScSqnOEibXSLIM0/Vbqfu/8ITUbj+HzYUwSu11fFUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=gMuccr5HhKvas4LXeR29vhrkPioK7DULrSQStlp2K/TrvKxlqjCVd3rugoYrAn0fw
	 +jB9NDSmGldXXlc36S2BHkGHDljSHEdIYb7yILitkpxHXGNBX3UgWR9lqOtoGDwI9W
	 x+qnVN8q2bkaTlvxh1ceTDYOjhPRZlaZ2Iaoh12hefM9K4vQo7PBqufjKvmTU6J/Y4
	 aAO1NQ3XWr3DL3QYsALYZjKxcu+2Nu455MQAlPv4O4vNvz+6S5y2/hKYr2S+s1kxcS
	 LqeTF02Rs0e+GHDu5gpY0EFCn5QnA9XYItwA0g5kL5A8tco90aeONahEht5TAxhmQ7
	 d/GP5J+hMoXbUKQIVEJnhTK29LodPnSYyQgnRlrbSEF22c+D1QCaqqdfEU+m8T0W8o
	 ekVfct1QSePcaepEvUKYVRoxNW0A3NADr7yVnUiPhZaXTdyUCEBWZpLAnadLdyNeJz
	 OI/UQb7u2ndaOk3uMuO2yZpoOvRQZG+3ybv1xxV1UvEBiCfOsZB
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1189D2019A;
	Fri, 20 Jun 2025 01:19:55 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 09/10] t5300: choose the built-in hash outside of a repo
Date: Fri, 20 Jun 2025 01:19:41 +0000
Message-ID: <20250620011943.586596-10-sandals@crustytoothpaste.net>
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
