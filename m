Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D82E2840
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494704; cv=none; b=FgEVpuwMkrZQdNmN+7phjzvSwUtyctqPvZesbEvBTgDY5SmEFSTZRPJb4QYP1tpRHtwGuND2erwck7ubTxyIISmNbDKxz70mHdFYX2xGDWMV79kKZgT5UhzNjXJTbul2hZ9o6jMs87WXOOrpmor/7v8cp34KnzZpSsbTj7/SQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494704; c=relaxed/simple;
	bh=482ZHGxYMsu+Ip8/3yWXDJTrCp9rCbjt57+JhCNr0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZdEr+C4+/r6liEjsGLHlBD2UxdwDxzcxcEuKh4nYE4BJV1YabtbhHGAZl+geNOT3/1qvpdN11Pk60bbK9QTDLGfy1qNJ+0R3P3nHVpCRBVBj6fL8oflE2o3MSndNa4tJe5JsFf8xupoCDlaEA3CbcCi25tlxS/2P8X2ia91boM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=WzutfzQC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WzutfzQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=482ZHGxYMsu+Ip8/3yWXDJTrCp9rCbjt57+JhCNr0NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=WzutfzQC7JW4dcGqWAotxe8ebQqg/FJSz6N5lfXaJ0ZUWMxNpAQPDFAnBMwvVkh5Q
	 XyyK8WzbEgfikaN4aDY363P3Noka5vC7dMGwvWpaBy4GfGiel24orSWCA7YBureyTU
	 +nVPlwt1U5/XN2vYpcouzRhGc5s9BVtu0MqzeFIcqqsDs6Vna5MziWJH5lzEuSOz9O
	 CtkX8TjGJ+vrp6ZDQr0HJogchdmxp1XWzL/qJ7+JST5VLi79aA0z/T1qeN65xnIvP/
	 2lqTO/JJeGZyGbaO+vLPhO/sDbB7ik02/c/soJo7SdWQtnTiO9ujsLOn/aO+SMDmgQ
	 mUuJXfS6wx1hSgRiYJJYrYzq7e3089X2CMWNM2ZHmRnfOTRdlTV9pS0lt94ZOxkuZZ
	 JI+8eIUHBOFsM+IqEXT7NY5U6Hip5Lz6YMVdn5MOFeAdR3B3GKRIoeidbrp6AnmRL8
	 GhR4k+XvFhQDX2hLXDqn89efdF7z9sfoohR89TdymHy7mqULIP7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 647E1231F7;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 02/16] conversion: don't crash when no destination algo
Date: Sat,  7 Feb 2026 20:04:32 +0000
Message-ID: <20260207200446.2837699-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we set up a repository that doesn't have a compatibility hash
algorithm, we set the destination algorithm object to NULL.  In such a
case, we want to silently do nothing instead of crashing, so simply
treat the operation as a no-op and copy the object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file-convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 7ab875afe6..e44c821084 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -23,7 +23,7 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 	const struct git_hash_algo *from =
 		src->algo ? &hash_algos[src->algo] : repo->hash_algo;
 
-	if (from == to) {
+	if (from == to || !to) {
 		if (src != dest)
 			oidcpy(dest, src);
 		return 0;
