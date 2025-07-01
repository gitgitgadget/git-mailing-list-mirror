Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21897280025
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404965; cv=none; b=ml4pxcVC715tqsTal5jJYxTPHwi9vm4HyEQYYlW/bYPaNEm1G6NfshVaEpBrT7q5ACrFwaE6x4Rp7kaXVCbNzkdC/VuqbzenEBQrDPWf/rAHOLpS/M0yuHgAW0JBeHZMeh7ZjlVFyOAgqBXnQI4sRGD1mI0K6ZRcA3pXmDKL26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404965; c=relaxed/simple;
	bh=+v9+oZZfE44wk2LefcbWzvPuTreo+w7xfV3y4plg8xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvrVVSOzdAVHCovHYdkLXd0N6cEoMDa0boFvKKzUrXjHFraZssIN2kow1xA6xPQGb0GVobj5CiYCV0GN8oYjemnNih8Ve8+OYA1NzztmEc0BER7oM3/dKm3drlFN4EcidQNx9Lik4dvtaQO4Gd1rTKVQVfs86jGfIgi1io8s03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TkDf1ASQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TkDf1ASQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=+v9+oZZfE44wk2LefcbWzvPuTreo+w7xfV3y4plg8xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=TkDf1ASQNkF5/ec9guoRiqR/2M0x4a1iFjo3DeGQzIrjkJ7RxOYp5akTtmPSQDLvT
	 k1VV+ZguV6/d7QjYOBqx69TEYev49UpaDsoSWjg6t6dxCY4xaVj1X9WsKDq9FWOuTs
	 +rbx59F/Arq8EzKKkId2rWYhKKjlE/nvlU/noVhkYLSUNp9dLDbyFK4f6Pf1NRj4nu
	 +lUghDmviieuEtBU/f/jr2Y/3PMh4tXFVIhyK0KzNQ6INDZSVTOroApHFAAx1VWBOJ
	 t/tQkPlxm4ZK9gIJkZwbxuLXTkiSmmBm/DftZZ7VLn1sBYLWyYIsnovPiOr56L2loQ
	 osgas/7TTmj+G6zdZd6zsSI0V3/kn3an0QC45AVE/loGtGAuyT/eQ/4uuy3+7icn+F
	 I4vDwtHigf/tM1NWgLk7+0mKBK9W9EAwk8Yz2QCZzExuRIGepzODe+N+EvHmGQI389
	 rl8j3l/ynsy0Xxf9GFj9wVvd6BZOsR7SU3ejQRimJC0tLt1a+KL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3BCF62012D;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 01/11] hash: add a constant for the default hash algorithm
Date: Tue,  1 Jul 2025 21:22:27 +0000
Message-ID: <20250701212237.766774-2-sandals@crustytoothpaste.net>
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

Right now, SHA-1 is the default hash algorithm in Git.  However, this
may change in the future.

We have many places in our code that use the SHA-1 constant to indicate
the default hash if none is specified, but it will end up being more
practical to specify this explicitly and clearly using a constant for
whatever the default hash algorithm is.  Then, if we decide to change it
in the future, we can simply replace the constant representing the
default with a new value.

For these reasons, introduce GIT_HASH_DEFAULT to represent the default
hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hash.h b/hash.h
index d6422ddf45..0d3d85e04c 100644
--- a/hash.h
+++ b/hash.h
@@ -174,6 +174,8 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 #define GIT_HASH_SHA256 2
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+/* Default hash algorithm if unspecified. */
+#define GIT_HASH_DEFAULT GIT_HASH_SHA1
 
 /* "sha1", big-endian */
 #define GIT_SHA1_FORMAT_ID 0x73686131
