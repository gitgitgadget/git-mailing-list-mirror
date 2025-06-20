Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77B2E403
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382399; cv=none; b=BfxS8BQrKmxYdN7/QvuDOSRR9/DXFV+M2gy6dSgZDUXH00cDO/6FOfyYwkM1rhlVZWiRuCfiuBlPH2ijKJ6Nvq4dgai8HxTtvtJEkArxONXyddokCFerdyf5If9oAP/Uj6K1b1bbofPlUvIDGeYfQz734eSzV+bYSyJYv/dPoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382399; c=relaxed/simple;
	bh=Cp60JxgtLK4iNtIYgmgfKdr6nv5lId0Z40VW3jmk8jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRdkIZdTrwTjz3mgqync59f2Fqu35xuH7pHwcPJo2Bofu+MuSLAJ4To2d9XGMhSnXGycBdqVKvZZ9YIsBG3sZvENh2op0/oHoF66dhg++gcGV2pLZwL6hmnmfghsU9fR+81JlwzNti1Rh4xy4bKgtCHAoSgI07IhTpBzHzw2izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SD5abZJM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SD5abZJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382394;
	bh=Cp60JxgtLK4iNtIYgmgfKdr6nv5lId0Z40VW3jmk8jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=SD5abZJMyHb2peEJ2qCNw1a2P2aZVaKMfNEWvlzhURczFtMqkGEDcNB1ovKqCBvFU
	 mfqfG/aCVx01eqkPE0IWsnTHyhI+lcN0an3e6Pw/LAck4wMJjf45Vn7S9tlDxvt+zy
	 fY4gYZ0bYuKmKF70yg8EEMgeNkgNI9PicAXW0DhMkkfgz2N5ptdWkYqYaSBSTOgNQn
	 XiJjMpnNe/CPKZLaQ3uKJ/eTbkS7rwEZHeHoJ5e21YSDqOZNlekED0rIVpyC2DiWhN
	 5VXdmKjFJzPI9dTPY5bfS3lMm/NMEovf6tFh5RmJ9/qwjQoISiaX4G8a+knIPYeghV
	 eHz3HBNnfJzyQ5GxfMiykc3YdXlF9jEz5iuOC5RXOecC4eiXlf5DYNFSu19o8yaAlJ
	 7/ZAdKyploz1E2a7HNq0BMkUNZV5s2wz9gw01J/pa4ROzzq7PT+LcjKkFqVDnRwrIx
	 YN/n3Inl1PaDk+r0gDJ/gMcE2ntzHHF+Q4VAZbc5ZM4BBYBIuvY
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C145920192;
	Fri, 20 Jun 2025 01:19:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 02/10] hash: add a constant for the original hash algorithm
Date: Fri, 20 Jun 2025 01:19:34 +0000
Message-ID: <20250620011943.586596-3-sandals@crustytoothpaste.net>
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

We have a a variety of uses of GIT_HASH_SHA1 littered throughout our
code.  Some of these really mean to represent specifically SHA-1, but
some actually represent the original hash algorithm used in Git which is
implied by older formats and protocols which do not contain hash
information.  For instance, the bundle v1 and v2 formats do not contain
hash algorithm information, and thus SHA-1 is implied by the use of
these formats.

Add a constant for documentary purposes which indicates this value.  It
will always be the same as SHA-1, since this is an essential part of
these formats, but its use indicates this particular reason and not any
other reason why SHA-1 might be used.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hash.h b/hash.h
index 0d3d85e04c..0e14cade4e 100644
--- a/hash.h
+++ b/hash.h
@@ -176,6 +176,8 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
 /* Default hash algorithm if unspecified. */
 #define GIT_HASH_DEFAULT GIT_HASH_SHA1
+/* Original hash algorithm. Implied for older data formats which don't specify. */
+#define GIT_HASH_ORIGINAL GIT_HASH_SHA1
 
 /* "sha1", big-endian */
 #define GIT_SHA1_FORMAT_ID 0x73686131
