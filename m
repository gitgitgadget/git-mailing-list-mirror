Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905634D383
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417788; cv=none; b=bc0QQa1Jg3Oy93HEE+jmk4Ak4y6x2zzywFViLhZjQi4eUEN3qC3Pk2Mk4X4YhjDeJQuPSUrVchXj90nRs5lfq3Ryv+eScJIxPdadWVbLQJDJ+P4YMir8GCgOvoZH6RfSlYmFdle7wIMO9UVL9HhxnGmBfIEcUs1DnK03xE5Ed88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417788; c=relaxed/simple;
	bh=482ZHGxYMsu+Ip8/3yWXDJTrCp9rCbjt57+JhCNr0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKgWUC5sUqZvfKleJEQKSZ/HwFS8vd/P3eIJbYbZQa6LupfSYVm9Eosqoa/XtvDwKT+9mHhPFy+ozfiCvhp/33s5zc1WU3MaIuDZNQGQLqogYrid1wOfM48nbMXHhqTHFq0d0NICHpFIbqm8DSb9+PWqR0EYfDZt4QLDvrQarY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=n154S6tT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="n154S6tT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=482ZHGxYMsu+Ip8/3yWXDJTrCp9rCbjt57+JhCNr0NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=n154S6tTnYa0wSRPt1f7y9WlD6UKz2abfr9ahzPDIiKM3fAdth4WvMrwjequJxb11
	 QNpHMXlC7AHLGYc8x4D9LDyyg4yIuhqlfqj+y0cbG57CwHRhfyNLCy1i6xduAogSHP
	 29lMdaYGVbWRLkmYOn6AiS1ulg2Gev3GBqbyikd38yMkbs5Xms8h0qhI+Gr6u7TK8r
	 4C35RW7VXa1Vikd/IWuc0HWnCPkijuehsVa4DJG67u59y+3vgsrXY7vTAZp7JiSKKE
	 ayuM2VngIK/ZFBJl2EpQQDCawrAIUz/ntAKNlvhadO60R3jgCnsodoWIOLVrJh+K+C
	 1RenMKE4th6t/ss03XBYFcgt4gmIEpxHecCQZ8jxotCE44Pn5wpO5m3AsCOVmxUuAG
	 uobBLGSyGSqRWGKmgQg6Ae3Y/332eZPGEMjw6etNysxE8T0y/MtWXnrD8LRQtJUDgb
	 mG9S6m8/K7lpTGqlxdnoJ1M6r01VLW68AJtIFJ+pCQXN3TwQ6Is
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 01DB220193;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 02/15] conversion: don't crash when no destination algo
Date: Mon, 17 Nov 2025 22:16:08 +0000
Message-ID: <20251117221621.2863243-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
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
