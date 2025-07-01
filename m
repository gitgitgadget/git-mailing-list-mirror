Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038126B766
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404965; cv=none; b=pQg3rcHjh7kqzVPj2s4HYNAJTjhJQ41tjUHSbaUW1/9lR+FNcfhQ0dHkg2GSGgq5ULdHOleFrCJjU2J0y10ojfbaHPiEuRoroh/AHWrzv97YW3fq0Hs/JKvoExXb38wIbgqnsWniC7ryFqGEdxTtycs02eYjCdOy2rF0c1+NQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404965; c=relaxed/simple;
	bh=eLdzFreCTuNf0zaw57LhMKz5eCYKHFe7VvYDuhqBAto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA6yniiaZywCcZUB+sS2/TySOs1xlEsF9U1kYHlCZA3tuEKzVP88ThiwiUpBQ4yiksCfS5bDu0ZKmjkFR2zFBO+IoY/EciOyDxycBvB+OyF26RxUdctljwSxTOaxOVagAXxVyrNhGEe2xnrec3SDOgnWdruVYq03tKaKMqc/n6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pzEeXzg3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pzEeXzg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=eLdzFreCTuNf0zaw57LhMKz5eCYKHFe7VvYDuhqBAto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=pzEeXzg3btUIbFVF8cRUZlu/vOA/RNiPPcWunNud32CSs9Ni1lxb9gGMUtNyn8rLc
	 SJX1WzisA3gtF3hajnysRulodvg1b1etkBqIBPAmTklo+zZ7yIppyHF/VHNrvSG7gq
	 4l+gAO1Wgwv4QNwyat4XRaacwG0DMThEqQjpf3kanlHwW7vRpaBDtaVTbBNhEmAPSY
	 bI40JgtQvbnSQxbMd+UyWyeVAzDBGKdRvcna54PFTb4a0ri8g34xuqqlSi4ImAwYN/
	 BHb9VendXJLSEDptiyLtUp9g2wVAQW+L8SlJTeoBF1uVrI8Lf1bu4qXiaD7erWdHBs
	 HfBvQ1MT+Ufu4x0GBBVjtVP4v6l1106svTM6/s8RUCzW2hhDEJ5AFvGrKVXSPF+zP5
	 uzoEEDYg3KKCoIpsypbVB4HzVmE2Z6N3MadmEC3cJaRq0LfUenGzXi3056F1vGnCrN
	 A+YKyGdykN1zl0ySqvGnWlOiDD0fhgq2/XG5qGddYsQF3czpqTp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 429D720196;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 02/11] hash: add a constant for the legacy hash algorithm
Date: Tue,  1 Jul 2025 21:22:28 +0000
Message-ID: <20250701212237.766774-3-sandals@crustytoothpaste.net>
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

We have a a variety of uses of GIT_HASH_SHA1 littered throughout our
code.  Some of these really mean to represent specifically SHA-1, but
some actually represent the original hash algorithm used in Git which is
implied by older, legacy formats and protocols which do not contain hash
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
index 0d3d85e04c..953e840d15 100644
--- a/hash.h
+++ b/hash.h
@@ -176,6 +176,8 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
 /* Default hash algorithm if unspecified. */
 #define GIT_HASH_DEFAULT GIT_HASH_SHA1
+/* Legacy hash algorithm. Implied for older data formats which don't specify. */
+#define GIT_HASH_SHA1_LEGACY GIT_HASH_SHA1
 
 /* "sha1", big-endian */
 #define GIT_SHA1_FORMAT_ID 0x73686131
