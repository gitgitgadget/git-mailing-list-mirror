Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD134CFDE
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417789; cv=none; b=HvgUeGynD150ugxVMS15CYTT3kzSA8ID5SlkSqtpGBkSkSE7LNiijDEC+CEOe3p57K8kSwLYaqZaDLt1Vg/QBb2bFLKHN+7jV8jIYrWWbeJ910aLfBWpzUUu1sGbT6k7/4KhsGtxiqDrQJKdaJMbMYIyau/vofQlgJAG9Wzbt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417789; c=relaxed/simple;
	bh=prII+m1PikhC2dUI2MwGcZzNZM44siOOB0UZXLvqf5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq6Ow23T5V89D7vLl/Nc+OS3/4BDBkYBFohExlm8sK9nmD5OWEk0GKtxOpnoybuiJxdnm1S0iDBh0UazrO+kFH5Uu8QHBe4GuU9KfBXnM1hU2ghuOv6caL862CHOM6+40yIsJjQT5k6Cd4G6SvSteSSFnf1F+D/M63dhJSGF/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sdGm433w; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sdGm433w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=prII+m1PikhC2dUI2MwGcZzNZM44siOOB0UZXLvqf5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=sdGm433wo+sJ1n1TeejN9+/sFW29lgwu95mawUEK0JOHqey44/gKrAmyZc9cOqkiI
	 J0k2KEShz901Iw5gR2EEyrwauKqJkc2zv+9nkBI22VGUc9MJobx5+yraDfldA65ALB
	 8mEE/UiD+LTuytqmM5XB9GzNCMVL06LucX0RNeTOC88tNhr4DC7fp0SQAZFCwlsvr8
	 4oSlhEgkjSOJgI2Kjfid5VRKLRQ1O/InjRv45VcH1AeF33r8808Wc+q2+xuyOdiBLw
	 EgKhm0KeaFNixovJ5MjeejvO5LRntxlNjPOhkoiIQ5stGaQwio8AgzbenrWYuFx8p9
	 RmU/h8mUfPvDLO35FDu/LBS+pmqNI9wYelnx745yLM9G4rmg2PAX2Iurf6nj6RDnr5
	 eyzfNks0y/rQhMq7eHSBQ7fFY0f9vNoS3S8/P8bpa2N1WIZNW31Sfph0PmxL7QUw5g
	 VhidOKVmZMZ+swfp07BBFKLLXjKSQRMe2byic30A+4TtZLZBzUH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 129F725521;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 03/15] hash: use uint32_t for object_id algorithm
Date: Mon, 17 Nov 2025 22:16:09 +0000
Message-ID: <20251117221621.2863243-4-sandals@crustytoothpaste.net>
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

We currently use an int for this value, but we'll define this structure
from Rust in a future commit and we want to ensure that our data types
are exactly identical.  To make that possible, use a uint32_t for the
hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.c       |  6 +++---
 hash.h       | 10 +++++-----
 oidtree.c    |  2 +-
 repository.c |  6 +++---
 repository.h |  4 ++--
 serve.c      |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hash.c b/hash.c
index 4a04ecb50e..81b4f87027 100644
--- a/hash.c
+++ b/hash.c
@@ -241,7 +241,7 @@ const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
 	return oid_to_hex_r(buf, algop->empty_tree);
 }
 
-int hash_algo_by_name(const char *name)
+uint32_t hash_algo_by_name(const char *name)
 {
 	if (!name)
 		return GIT_HASH_UNKNOWN;
@@ -251,7 +251,7 @@ int hash_algo_by_name(const char *name)
 	return GIT_HASH_UNKNOWN;
 }
 
-int hash_algo_by_id(uint32_t format_id)
+uint32_t hash_algo_by_id(uint32_t format_id)
 {
 	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (format_id == hash_algos[i].format_id)
@@ -259,7 +259,7 @@ int hash_algo_by_id(uint32_t format_id)
 	return GIT_HASH_UNKNOWN;
 }
 
-int hash_algo_by_length(size_t len)
+uint32_t hash_algo_by_length(size_t len)
 {
 	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (len == hash_algos[i].rawsz)
diff --git a/hash.h b/hash.h
index fae966b23c..99c9c2a0a8 100644
--- a/hash.h
+++ b/hash.h
@@ -211,7 +211,7 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;	/* XXX requires 4-byte alignment */
+	uint32_t algo;	/* XXX requires 4-byte alignment */
 };
 
 #define GET_OID_QUIETLY                  01
@@ -344,13 +344,13 @@ static inline void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx
  * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
  * the name doesn't match a known algorithm.
  */
-int hash_algo_by_name(const char *name);
+uint32_t hash_algo_by_name(const char *name);
 /* Identical, except based on the format ID. */
-int hash_algo_by_id(uint32_t format_id);
+uint32_t hash_algo_by_id(uint32_t format_id);
 /* Identical, except based on the length. */
-int hash_algo_by_length(size_t len);
+uint32_t hash_algo_by_length(size_t len);
 /* Identical, except for a pointer to struct git_hash_algo. */
-static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
+static inline uint32_t hash_algo_by_ptr(const struct git_hash_algo *p)
 {
 	size_t i;
 	for (i = 0; i < GIT_HASH_NALGOS; i++) {
diff --git a/oidtree.c b/oidtree.c
index 151568f74f..324de94934 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -10,7 +10,7 @@ struct oidtree_iter_data {
 	oidtree_iter fn;
 	void *arg;
 	size_t *last_nibble_at;
-	int algo;
+	uint32_t algo;
 	uint8_t last_byte;
 };
 
diff --git a/repository.c b/repository.c
index 186d2c1028..ebe719de3c 100644
--- a/repository.c
+++ b/repository.c
@@ -39,7 +39,7 @@ struct repository *the_repository = &the_repo;
 static void set_default_hash_algo(struct repository *repo)
 {
 	const char *hash_name;
-	int algo;
+	uint32_t algo;
 
 	hash_name = getenv("GIT_TEST_DEFAULT_HASH_ALGO");
 	if (!hash_name)
@@ -186,12 +186,12 @@ void repo_set_gitdir(struct repository *repo,
 			repo->gitdir, "index");
 }
 
-void repo_set_hash_algo(struct repository *repo, int hash_algo)
+void repo_set_hash_algo(struct repository *repo, uint32_t hash_algo)
 {
 	repo->hash_algo = &hash_algos[hash_algo];
 }
 
-void repo_set_compat_hash_algo(struct repository *repo MAYBE_UNUSED, int algo)
+void repo_set_compat_hash_algo(struct repository *repo MAYBE_UNUSED, uint32_t algo)
 {
 #ifdef WITH_RUST
 	if (hash_algo_by_ptr(repo->hash_algo) == algo)
diff --git a/repository.h b/repository.h
index 5808a5d610..c0a3543b24 100644
--- a/repository.h
+++ b/repository.h
@@ -193,8 +193,8 @@ struct set_gitdir_args {
 void repo_set_gitdir(struct repository *repo, const char *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
-void repo_set_hash_algo(struct repository *repo, int algo);
-void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
+void repo_set_hash_algo(struct repository *repo, uint32_t algo);
+void repo_set_compat_hash_algo(struct repository *repo, uint32_t compat_algo);
 void repo_set_ref_storage_format(struct repository *repo,
 				 enum ref_storage_format format);
 void initialize_repository(struct repository *repo);
diff --git a/serve.c b/serve.c
index 53ecab3b42..49a6e39b1d 100644
--- a/serve.c
+++ b/serve.c
@@ -14,7 +14,7 @@
 
 static int advertise_sid = -1;
 static int advertise_object_info = -1;
-static int client_hash_algo = GIT_HASH_SHA1_LEGACY;
+static uint32_t client_hash_algo = GIT_HASH_SHA1_LEGACY;
 
 static int always_advertise(struct repository *r UNUSED,
 			    struct strbuf *value UNUSED)
