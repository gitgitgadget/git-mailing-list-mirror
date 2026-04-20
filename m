Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8383A9628
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723279; cv=none; b=i95WUf4e1AL6dAPxHLuerRPrAt8WsiWwY3m30AUOXrSDP+37+Nj4CKNuiW9WGAw8PgrAbdmnZmMtqOGUEKEsqgiRAH1CeNHP6WnZh7Q3Ikvq/tIjh0lpUcFTe81tfasN/Ovp8IZ5M+um5kyRR10szAUODgZzJwI7hyg/DC8KjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723279; c=relaxed/simple;
	bh=z7x3Mrtt8L1I9zSihTWDP1YPAmlg1q8LvwFG/U1ui5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9Ff5UuJNEqqRXSZgcD3gTYZnMwdcrQW+Nb+v0WhkHaPdrSDWur/9ad/BFfanLKD0COXFa4Av5icMkcHad/dEnVDbFcedf0A6dm97jVzF+SPHMgt6kIFG9mVZspPlN0AxckiTaApKt4Lz7tgHq6Bp63Wz6JMRQCblpWc95lLLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NS+9mNRI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NS+9mNRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776723277;
	bh=z7x3Mrtt8L1I9zSihTWDP1YPAmlg1q8LvwFG/U1ui5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=NS+9mNRIp/lx5lE9VCX63VZsBlIW6oprrk5vmH2pgscLtNqPnaftc1dLL9hVefRIx
	 Zf6mVjvME02BPvd3xhh4dW3oX1AMIUGqs6yBFXMrIvbSX0yvhURKxxmdwjd/msF500
	 bw5ppC7Sjb/yJMklvKf1jaMxgdvEXUvoDwo1udNBn47WrONfbgp/pK2qyot5ui5xK8
	 0N7lXZVv9iqdLPQpB3TNyA2VVsjnVqNBeW/IDD9TUAydDjwD58qMOJejj/VMVH6fHD
	 a8rDnPBKy1DlXhuu7cXqaTEbbJ1p1kowqGvNEV2Yr5uxyVHC9TTcN3ln1pXg2ydrLy
	 kEserUPQgBzUw73EICuG06q6QkudINE/3sunXQN2fPo6dwp587hVKXbxO6JJEr4GIq
	 tGz1ccf1fjPdgAzX+rODX06NAILvpXC45f5K9jqUUoVxPkcnCa8zOKj91ALFBezfO3
	 DriLqcTH23OSCt/yPg2XJIknxJCYD27jUttcHIyEibNvJ4Fao3N
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:57bc:7ea2:ca35:d24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5DACE2011E;
	Mon, 20 Apr 2026 22:14:37 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kushal Das <kushal@sunet.se>
Subject: [PATCH 2/2] commit: sign commit after mutating buffer
Date: Mon, 20 Apr 2026 22:14:25 +0000
Message-ID: <20260420221425.2763661-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260420221425.2763661-1-sandals@crustytoothpaste.net>
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
 <20260420221425.2763661-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ensure_utf8 function can mutate the buffer to change its encoding,
so we must call it before signing the buffer so that we do not
invalidate the signature, which is made over raw bytes.  Add a test for
this case as well using 0xfe and 0xff, which are never valid in UTF-8.

Reported-by: Kushal Das <kushal@sunet.se>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c                 | 12 ++++++++----
 t/t7510-signed-commit.sh |  8 ++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 790dd2faed..bc41859be1 100644
--- a/commit.c
+++ b/commit.c
@@ -1747,6 +1747,11 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
 	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+
+	/* And check the encoding. */
+	if (encoding_is_utf8 && !ensure_utf8(&buffer))
+		fprintf(stderr, _(commit_utf8_warn));
+
 	if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
 				       SIGN_BUFFER_USE_DEFAULT_KEY)) {
 		result = -1;
@@ -1780,6 +1785,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
 
+		if (encoding_is_utf8 && !ensure_utf8(&compat_buffer))
+			fprintf(stderr, _(commit_utf8_warn));
+
 		if (sign_commit && sign_buffer(&compat_buffer, &compat_sig,
 					       sign_commit,
 					       SIGN_BUFFER_USE_DEFAULT_KEY)) {
@@ -1818,10 +1826,6 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		}
 	}
 
-	/* And check the encoding. */
-	if (encoding_is_utf8 && (!ensure_utf8(&buffer) || !ensure_utf8(&compat_buffer)))
-		fprintf(stderr, _(commit_utf8_warn));
-
 	if (r->compat_hash_algo) {
 		hash_object_file(r->compat_hash_algo, compat_buffer.buf, compat_buffer.len,
 			OBJ_COMMIT, &compat_oid_buf);
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 1201c85ba6..071dbb3d39 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -462,4 +462,12 @@ test_expect_success 'custom `gpg.program`' '
 	git commit -S --allow-empty -m signed-commit
 '
 
+test_expect_success GPG 'commit verifies with non-UTF-8 commit message' '
+	printf "I hate\\376\\377UTF-8\\n" >message &&
+	echo unusual-message >file &&
+	git add file &&
+	test_tick && git commit -S -F message &&
+	git verify-commit HEAD
+'
+
 test_done
