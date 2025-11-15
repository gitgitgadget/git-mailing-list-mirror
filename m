Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D3D1D54FA
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763168304; cv=none; b=bL3jxHmUvu36DnM8lS0+qC9HnL1ek57QIfijoO3zH5JduKLwSadN//aFhjduy4ufEq5ku+r3HZYS+I66eyghggCRXFmoz6SGLo/KOZf8k2xxk2cJI3C0Ymk8sYVdZwWDJjP6Mg6G+uFXLAWeuTCvr8f+YeNxSLPXcwtNrbbxWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763168304; c=relaxed/simple;
	bh=RELoP4SSldt73Co4xcLyL1+HPgnN1krseaWScYVwhkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggx383XyUWy3ENhWfIYC9btRkbVeyIKbZP0J4KxK3mvttLD9RGvaBkmCsggCYA7dGAf8euxohjP6Bd8s/ijs2/eQCMvFlylNaYcTnw7Y5fHEjAx730kuKqP/eouaFeCvo5x0b9Kf58aq42NK7e1pv2W2k9GqC9C2AYMTJ7MaSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RXmV5umX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RXmV5umX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763168300;
	bh=RELoP4SSldt73Co4xcLyL1+HPgnN1krseaWScYVwhkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=RXmV5umXeiuzgs3heDAcYMXTlt5v2RJhpv3hNFJJkSE/ZoQ5tyngAA7ZWtSQeOlNv
	 oIPgzQkwWoF5O3w5n84PIn8hKo7fLuGQkeQh/cyJt1UEdhcvb8Qd4smbF8QuBuCVpt
	 Z7WJJ/CZj3gftUcPqHHklt/r4gpTd8F51FqNjuI7SJ1cohTPXLJTSTGF3XpF8LSPOq
	 dvwmgjy1MCyoUTF9+b8kKTaou0BOpv6aqZpnWn82Jq4ttxmAgfL3XeVBnFFLTqfo7H
	 7zaT9V5FhEh3WknRqG7uqQGIU5XUAgO+TkRMQntCYJlOcCvcuBPD6iUAmBG6oRBoA5
	 TSFX2ZnyhPYBm5p3CvlDsd+e6HDIQkbnHnt07qP2+0cZaMizmRqiT2baJGqdCbox7W
	 +VX3Tf+VJbX+9UNNJa8x6jcyBDOHvEGATNFl7HG7NiIuJeGwQl9W7SucOWQzstQ7SY
	 dXk4ImPo0Zi7kk73dH7tEc8+iruDflrP/yTCV5CfpzREyOtRa89
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d3f4:1fda:d3d6:71fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A10D520065;
	Sat, 15 Nov 2025 00:58:20 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Martin Wilck <mwilck@suse.com>,
	Adrian Schroeter <adrian@suse.com>
Subject: [PATCH v2 1/2] object-file: disallow adding submodules of different hash algo
Date: Sat, 15 Nov 2025 00:58:17 +0000
Message-ID: <20251115005818.2271557-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
References: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The design of the hash algorithm transition plan is that objects stored
must be entirely in one algorithm since we lack any way to indicate a
mix of algorithms.  This also includes submodules, but we have
traditionally not enforced this, which leads to various problems when
trying to clone or check out the the submodule from the remote.

Since this cannot work in the general case, restrict adding a submodule
of a different algorithm to the index.  Add tests for git add and git
submodule add that these are rejected.

Note that we cannot check this in git fsck because the malformed
submodule is stored in the tree as an object ID which is either
truncated (when a SHA-256 submodule is added to a SHA-1 repository) or
padded with zeros (when a SHA-1 submodule is added to a SHA-256
repository).  We cannot detect even the latter case because someone
could have an actual submodule that actually ends in 24 zeros, which
would be a false positive.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file.c              |  6 +++++-
 t/t3700-add.sh             | 25 +++++++++++++++++++++++++
 t/t7400-submodule-basic.sh | 25 +++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 4675c8ed6b..8c43c52ed0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1661,7 +1661,11 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid);
+		if (repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid))
+			return -1;
+		if (&hash_algos[oid->algo] != istate->repo->hash_algo)
+			return error(_("cannot add a submodule of a different hash algorithm"));
+		break;
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index df580a5806..9a2c8dbcc2 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -541,6 +541,31 @@ test_expect_success 'all statuses changed in folder if . is given' '
 	)
 '
 
+test_expect_success 'cannot add a submodule of a different algorithm' '
+	git init --object-format=sha256 sha256 &&
+	(
+		cd sha256 &&
+		test_commit abc &&
+		git init --object-format=sha1 submodule &&
+		test_commit -C submodule def &&
+		test_must_fail git add submodule 2>err &&
+		test_grep "cannot add a submodule of a different hash algorithm" err &&
+		git ls-files --stage >entries &&
+		test_grep ! ^160000 entries
+	) &&
+	git init --object-format=sha1 sha1 &&
+	(
+		cd sha1 &&
+		test_commit abc &&
+		git init --object-format=sha256 submodule &&
+		test_commit -C submodule def &&
+		test_must_fail git add submodule 2>err &&
+		test_grep "cannot add a submodule of a different hash algorithm" err &&
+		git ls-files --stage >entries &&
+		test_grep ! ^160000 entries
+	)
+'
+
 test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
 	path="$(pwd)/BLUB" &&
 	touch "$path" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fd3e7e355e..e6b551daad 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -407,6 +407,31 @@ test_expect_success 'submodule add in subdirectory with relative path should fai
 	test_grep toplevel output.err
 '
 
+test_expect_success 'submodule add of a different algorithm fails' '
+	git init --object-format=sha256 sha256 &&
+	(
+		cd sha256 &&
+		test_commit abc &&
+		git init --object-format=sha1 submodule &&
+		test_commit -C submodule def &&
+		test_must_fail git submodule add "$submodurl" submodule 2>err &&
+		test_grep "cannot add a submodule of a different hash algorithm" err &&
+		git ls-files --stage >entries &&
+		test_grep ! ^160000 entries
+	) &&
+	git init --object-format=sha1 sha1 &&
+	(
+		cd sha1 &&
+		test_commit abc &&
+		git init --object-format=sha256 submodule &&
+		test_commit -C submodule def &&
+		test_must_fail git submodule add "$submodurl" submodule 2>err &&
+		test_grep "cannot add a submodule of a different hash algorithm" err &&
+		git ls-files --stage >entries &&
+		test_grep ! ^160000 entries
+	)
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	git config --file=.gitmodules submodule.example.url git://example.com/init.git
 '
