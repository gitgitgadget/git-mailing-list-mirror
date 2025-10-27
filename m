Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604730E0FB
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525877; cv=none; b=hgHOYKzz4FUm6NQGpgqH8r66cyzobPdm0VsaZkQQeG3TqHeIWzp2p6Esz80otpvVhbZ+4Fry4XDqF5B+RBbRQnCMNRo/s9lDL9hoUX/ZWQ3zGh5jyV8bXI90yT2STzMeGo/yF5xG4AGnJeEhSPo+wPpwXsSDWd8DLBiUGgLt79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525877; c=relaxed/simple;
	bh=kg41+dqjOzuXFZWYaLWiR0bhM8dISTlb+UAzLYeybg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWo+j86uwjxblUE0VY04yzyQihU5OyWioc9yzeO84vaKolAh+xrbbNZrEGSq0WKdon9JOfLNuTv8CuU6hN0NCcf9ohMi3wGC2JWLeXWURVD/V3ogybKeo0b8fFFp+UqujrgFx4Qb41c4ByIPIPDZDBHdeY1n2jXhWt2WhQO6RR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ltbUMPNP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ltbUMPNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525868;
	bh=kg41+dqjOzuXFZWYaLWiR0bhM8dISTlb+UAzLYeybg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ltbUMPNPjxWTVN1K9WquOi89gCUeoWzfAuOMhYYLJY5Jl6FsIai8gSXHnWpq9o5uQ
	 eU0uHWfBzkZUQvlq8CBwZ/d6tc7Z1LuibIXZEq6IQnYoeO+J80e7A/x1q+Pe+7Z4Rh
	 ga8q2R+BjNpUYK55snEsLuNAlBhokEfOJ2fGiXp42janP03dwAsYfbqme848Nv8Oik
	 MgAjStkN7SGK0ozZymadMWxXROv4cPcjTknQJmAdvjUd68ZAvuCRXVrSdiI0bU7vE5
	 nI5bEqF7UCYDPf8GfyiujBlsxnCuiezBCaxWxPbZgfn/hq7QTjBuX0lbZb7bzujnSs
	 Him3ZA0hZIKkhbpgHzZSPgsk1VSuuCi6vmW8S/raNyGrG1Rm05JWfqCAL/Xke0JS6c
	 SSHiD75T8+nyUUe1SqF8lMT1FWkxsEl3gRFhBSLUuqsU4h4DPSE+yqO91pGeH/HraV
	 LrfElR0B2p8zTU86b4l/Rnj85akcoJUa+X5w/Ra44yIo3VGcOFn
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F26D223201;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 14/14] object-file-convert: always make sure object ID algo is valid
Date: Mon, 27 Oct 2025 00:44:04 +0000
Message-ID: <20251027004404.2152927-15-sandals@crustytoothpaste.net>
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

In some cases, we zero-initialize our object IDs, which sets the algo
member to zero as well, which is not a valid algorithm number.  This is
a bad practice, but we typically paper over it in many cases by simply
substituting the repository's hash algorithm.

However, our new Rust loose object map code doesn't handle this
gracefully and can't find object IDs when the algorithm is zero because
they don't compare equal to those with the correct algo field.  In
addition, the comparison code doesn't have any knowledge of what the
main algorithm is because that's global state, so we can't adjust the
comparison.

To make our code function properly and to avoid propagating these bad
entries, if we get a source object ID with a zero algo, just make a copy
of it with the fixed algorithm.  This has the benefit of also fixing the
object IDs if we're in a single algorithm mode as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file-convert.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index e44c821084..f8dce94811 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -13,7 +13,7 @@
 #include "gpg-interface.h"
 #include "object-file-convert.h"
 
-int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
+int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 		      const struct git_hash_algo *to, struct object_id *dest)
 {
 	/*
@@ -21,7 +21,15 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 	 * default hash algorithm for that object.
 	 */
 	const struct git_hash_algo *from =
-		src->algo ? &hash_algos[src->algo] : repo->hash_algo;
+		srcoid->algo ? &hash_algos[srcoid->algo] : repo->hash_algo;
+	struct object_id temp;
+	const struct object_id *src = srcoid;
+
+	if (!srcoid->algo) {
+		oidcpy(&temp, srcoid);
+		temp.algo = hash_algo_by_ptr(repo->hash_algo);
+		src = &temp;
+	}
 
 	if (from == to || !to) {
 		if (src != dest)
