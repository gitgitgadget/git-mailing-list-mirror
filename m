Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03D34EF15
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328328; cv=none; b=QB6fVUuNPC3bP1IHhhtsQFcwHZARKdnrYrMtkh6MNYq++0iLCkpl2Ng2HIA14InAjo33RBHgJrkjsJmbtU3ebYu8Z9FcyzTj6ji+H0Y3jPOtxMftBw3oqL2/O84Xeq0iokiVun2TVnJTv8AvHU1F4M/2c2Z72/ekeTB4ZJsTGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328328; c=relaxed/simple;
	bh=KwubEve0rk3EZvHRivTGgzgZEUxxiwNHkzJXq0Daxe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvWfkViVf4LLaohkxzvf84wleYvw8gF46ukwETC0J2UWozRrHJ/aKdRkxW7cdyrH3kpiQtQqMgxQGyVQUPZyXNIvZKZO4K/3CFHQTJXtqzJT6Nh7Iba0yrdSn0tRdMBH07yRgB5RSE2/e8pJxxx7RF4659+fZdo4bvAOLwfOg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Ln/+BdIr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ln/+BdIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1777328319;
	bh=KwubEve0rk3EZvHRivTGgzgZEUxxiwNHkzJXq0Daxe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Ln/+BdIrUgoaj9gnNT/gDve4OrpoRfrZlnEvbiBycS7JMeD9C2h3QCDSmGqFmEtAo
	 Z6ggNdbNiDmQQb4Hiaf3bNe8c469WwCFNr9d558I+pqhXzmfkoumlyey4gBby1qQwN
	 LZtUFTK7m6QfKVuPgbsXAPXO+xckXmdG9ThRHx0Z5UOn/fTpB06c33Atvk6qo93WwD
	 GtFZiQHCYSgKWx+QImRmmRt6BIpASOLNd0HAUMxlAwVa/x+yDziTK9zqOcIs3TXNup
	 R+Yzqkdswr9wA8BzUmGGlfI70eAKuuehUZN8LhoTYwGzufwNLs0nJxJZnqWB3JYJBm
	 qpJvylDL/mctLybf5qSf5d2Amm1MEdutF42FK1oRkgksCXQvsLn/Yy6WA5Xxiy8Kte
	 g2aKA9MdpJrWPwvOusvrY11XNoxzH2G3RCnGwDleIC4HRky+E5V162jXRyFITd4+Nl
	 82VzNx9d++kqyUOzGxvatcgf/Hqol5ysN5UZlW+4sXaM2lfI9YI
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:83ef:6e6f:372d:4e85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3555F20118;
	Mon, 27 Apr 2026 22:18:39 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kushal Das <kushal@sunet.se>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/2] commit: sign commit after mutating buffer
Date: Mon, 27 Apr 2026 22:18:34 +0000
Message-ID: <20260427221834.1824543-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260427221834.1824543-1-sandals@crustytoothpaste.net>
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
 <20260427221834.1824543-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ensure_utf8 function can mutate the buffer to change its encoding,
so we must call it before signing the buffer so that we do not
invalidate the signature, which is made over raw bytes.  Fix a bug which
caused the compatibility code to not convert the compatibility buffer if
the main buffer was invalid UTF-8.  We expect both buffers to be valid
UTF-8 or both invalid, since the only data that would differ between
them would be hex object IDs, which are always valid UTF-8.

Add a test for this case using 0xfe and 0xff, which are never valid in
UTF-8.

Reported-by: Kushal Das <kushal@sunet.se>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c                 | 15 +++++++++++----
 t/t7510-signed-commit.sh | 10 ++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 790dd2faed..e5d725fe93 100644
--- a/commit.c
+++ b/commit.c
@@ -1726,6 +1726,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	struct repository *r = the_repository;
 	int result = 0;
 	int encoding_is_utf8;
+	bool warned = false;
 	struct strbuf buffer = STRBUF_INIT, compat_buffer = STRBUF_INIT;
 	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
 	struct object_id *parent_buf = NULL, *compat_oid = NULL;
@@ -1747,6 +1748,13 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
 	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+
+	/* And check the encoding. */
+	if (encoding_is_utf8 && !ensure_utf8(&buffer)) {
+		fprintf(stderr, _(commit_utf8_warn));
+		warned = true;
+	}
+
 	if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
 				       SIGN_BUFFER_USE_DEFAULT_KEY)) {
 		result = -1;
@@ -1780,6 +1788,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
 
+		if (encoding_is_utf8 && !ensure_utf8(&compat_buffer) && !warned)
+			fprintf(stderr, _(commit_utf8_warn));
+
 		if (sign_commit && sign_buffer(&compat_buffer, &compat_sig,
 					       sign_commit,
 					       SIGN_BUFFER_USE_DEFAULT_KEY)) {
@@ -1818,10 +1829,6 @@ int commit_tree_extended(const char *msg, size_t msg_len,
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
index 1201c85ba6..aa9108da54 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -462,4 +462,14 @@ test_expect_success 'custom `gpg.program`' '
 	git commit -S --allow-empty -m signed-commit
 '
 
+test_expect_success GPG 'commit verifies with non-UTF-8 commit message' '
+	printf "I hate\\376\\377UTF-8\\n" >message &&
+	echo unusual-message >file &&
+	git add file &&
+	test_tick && git commit -S -F message 2>err &&
+	git verify-commit HEAD &&
+	grep "commit message did not conform to UTF-8" err >lines &&
+	test_line_count = 1 lines
+'
+
 test_done
