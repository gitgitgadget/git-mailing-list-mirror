Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7230EF74
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761526436; cv=none; b=qTrFrC19xmpK2wOdQw/4i3XKA9ED/qMDcCqqfpEpfA/ozz3U1jjBFsGXwjCmAzP5Y3yag6FnfNVkj2eOSRwFZxWcep57VSwq1IACa+QiJOu7rqAGE+PWbcrOJ9D+JFlZ9RGTOSSqpVo48LQfwba6Iy4/ydGOSVjF0xG4WfJ27Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761526436; c=relaxed/simple;
	bh=482ZHGxYMsu+Ip8/3yWXDJTrCp9rCbjt57+JhCNr0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4hc+D0x8B4OVfbSlgclyHdkqGLKtmUkNI2vNiFF4GgLVATfkFk/vAlX5pjrlCbdkoq2gdn7dminGvpKQW+8ynmPsL8UnHyhZG/X3zJRbsCrAGWnNN+aWEZVDL9ReKkMWhrc2wmdlO6fv/neGbmiGSvJDE2dpFbJRPak5ZVPdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sewnGFCk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sewnGFCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=482ZHGxYMsu+Ip8/3yWXDJTrCp9rCbjt57+JhCNr0NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=sewnGFCkjKdqI8mVv+SKqcW4dfuMv34MXbCycyEKZukrFUQrH0eIsWa0WZiSZF4oP
	 EltZEf7vxb9Hxj1ILGSaGi+cq6lUk5Es8SRFd5d9YCD0eGyiHrMOb4YMkxWDhbsgsD
	 xJkNjtqnoO4K2Ig7+XY3vFMo9Wp4USHhSbVyuQ0XFu+vUf8ZAr9NzLhHH7rjCtsSll
	 K/Gp2xPzS3lW/2Q4Ih7gA0pGE9S/B2djvgTTYgXPuJzrFpRjZEBo4Xonm7y1foh1mC
	 HYeT3+hWeSEfMFtoegB98/hj5/OhHuyrJkSGLsbPVmuh1bU7B9ZJ/ExjhCJ0b9HJr7
	 fLzVDUHuEcNtiZB8cGsU3xGFR2TARc5NczAtXKuGFjxzxwkjVU3e172wMwJjhuJeGM
	 /mclXaSoOZXxk7a0Ofs/q3ZR2bRnh8aWa3+OBW2Hb/freknmnjVFnfMM9ViHgvfDf0
	 IZRW99YYPh1ZzYZNmGRrpH7/xYYMcXfqdGaSI2HsELjPWdNonUp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8B71D20152;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 02/14] conversion: don't crash when no destination algo
Date: Mon, 27 Oct 2025 00:43:52 +0000
Message-ID: <20251027004404.2152927-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
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
