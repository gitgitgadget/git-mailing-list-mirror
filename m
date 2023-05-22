Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72ACC77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 21:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjEVVsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjEVVsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 17:48:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F794100
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:48:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561f6e63decso85688817b3.1
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684792097; x=1687384097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhDqwxJlhiKDFPYd2f1aE/pD3+9R0Bx9XMCdLEI6dzM=;
        b=L33H+/VzHhn0ZC0L85AY7JY62Oall1jNmk0JvHG0Wqk2ema6xgbglketpR/CEcxX+B
         nk7wW7woKps3RNXgACUW7Fv9heca1Ew14yjlsY7fCNA202ltoPHHnimdVt0TyTeVU3zq
         MgYKMGKoBG7eFZlmk/WJ2Gu7YiBxaAfHYUzwZ/MlAbvdhuyr9AnXtghZKpOFRBkpEeLl
         KyDyMiEkzsZGBjo2ctYjqBignjhchKntoYMTRWvbZw+OXoAijr01NoqVtI86rrVUZKlV
         LV3Ygy6lG7u5XXy5NK2nBhrTRjzVREEyA0/jwTmB+4jajEPHAPw6iDULjCIjtQzxRiWD
         d21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684792097; x=1687384097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhDqwxJlhiKDFPYd2f1aE/pD3+9R0Bx9XMCdLEI6dzM=;
        b=BcaPchG3rpaywqf2K4Sii3xKwNHnCBN8ZqU2hhNpeACrSBr98lPlWd5w9/86WhsBKu
         MYvh4JzAOZ/mrXolUpDFB7KjWCRpBVLSW7Z2RuFebcJh1k5mKIyg4Qt+R8kkr7wGBqjh
         XeOs2YoIAgwqprWa+gX9aebmXL+/OMe4qX1p6M3aMJoBpiTK0gf4K90XCtdAM+PbuRBv
         xCDbOzrP8wqK6wNvG/dFeZu64vakuiT9haFEFGwhYBUKBYb75cK7s7x3MemnCiii+H2F
         meZBiavLJuyRLxdjFXQq5mEzVL0OI4ikiICOn3qmy1UuPC8bl578OQScPNkB58U4jAxz
         WjVg==
X-Gm-Message-State: AC+VfDwWhpZGNHut9oI54vayqWB7ceIxlzK8hXCUIlxP+BP/o5bexjyF
        hXGJG59pL5JgDhFOUHHCRPfXjubMPQn2kNeA08CDW8No37zFwBkFDxMWvhYb6LFnBe7wa8TZijR
        0LS2Hs0wngNCDWbrJm7+IU+V+tGFoV3g8bUrebzcJ6eXHBtDxu49TppupiBq3EuE0k42UVHJ+L5
        Cf
X-Google-Smtp-Source: ACHHUZ7C7CqWDcYrpWz529vXWO49YZKmhWvMGc6rxOMpSGmmPQY+wyket+H/Pg9Xf7lPRz/2+bLkrQou7lzoU/tFl52+
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:e715:4b4d:d1be:8ec0])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ae19:0:b0:54f:a35e:e79a with
 SMTP id m25-20020a81ae19000000b0054fa35ee79amr7239326ywh.8.1684792096659;
 Mon, 22 May 2023 14:48:16 -0700 (PDT)
Date:   Mon, 22 May 2023 14:48:07 -0700
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <1cb0ee10253ab38b194c6554ecc68a5267e21145.1684790529.git.jonathantanmy@google.com>
Subject: [PATCH 2/2] commit-graph: fix murmur3, bump filter ver. to 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The murmur3 implementation in bloom.c has a bug when converting series
of 4 bytes into network-order integers when char is signed (which is
controllable by a compiler option, and the default signedness of char is
platform-specific). When a string contains characters with the high bit
set, this bug causes results that, although internally consistent within
Git, does not accord with other implementations of murmur3 and even with
Git binaries that were compiled with different signedness of char. This
bug affects both how Git writes changed path filters to disk and how Git
interprets changed path filters on disk.

Therefore, fix this bug. And because changed path filters on disk might
no longer be compatible, teach Git to write "2" as the version when
writing changed path filters (instead of "1" currently), and only accept
"2" as the version when reading them (instead of "1" currently).

Because this bug only manifests with characters that have the high bit
set, it may be possible that some (or all) commits in a given repo would
have the same changed path filter both before and after this fix is
applied. However, in order to determine whether this is the case, the
changed paths would first have to be computed, at which point it is not
much more expensive to just compute a new changed path filter. So this
patch does not include any mechanism to "salvage" changed path filters
from repositories.

There is a change in write_commit_graph(). graph_read_bloom_data()
makes it possible for chunk_bloom_data to be non-NULL but
bloom_filter_settings to be NULL, which causes a segfault later on. I
produced such a segfault while developing this patch, but couldn't find
a way to reproduce it neither after this complete patch (or before),
but in any case it seemed like a good thing to include that might help
future patch authors.

The value in the test was obtained from another murmur3 implementation
using the following Go source code:

  package main

  import "fmt"
  import "github.com/spaolacci/murmur3"

  func main() {
          fmt.Printf("%x\n", murmur3.Sum32([]byte("Hello world!")))
          fmt.Printf("%x\n", murmur3.Sum32([]byte{0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff}))
  }

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 bloom.c               | 14 +++++++-------
 bloom.h               |  9 ++++++---
 commit-graph.c        |  4 ++--
 t/helper/test-bloom.c |  7 +++++++
 t/t0095-bloom.sh      |  8 ++++++++
 t/t4216-log-bloom.sh  |  8 ++++----
 6 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/bloom.c b/bloom.c
index aef6b5fea2..fec243b2f1 100644
--- a/bloom.c
+++ b/bloom.c
@@ -82,10 +82,10 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 
 	uint32_t k;
 	for (i = 0; i < len4; i++) {
-		uint32_t byte1 = (uint32_t)data[4*i];
-		uint32_t byte2 = ((uint32_t)data[4*i + 1]) << 8;
-		uint32_t byte3 = ((uint32_t)data[4*i + 2]) << 16;
-		uint32_t byte4 = ((uint32_t)data[4*i + 3]) << 24;
+		uint32_t byte1 = (uint32_t)(unsigned char)data[4*i];
+		uint32_t byte2 = ((uint32_t)(unsigned char)data[4*i + 1]) << 8;
+		uint32_t byte3 = ((uint32_t)(unsigned char)data[4*i + 2]) << 16;
+		uint32_t byte4 = ((uint32_t)(unsigned char)data[4*i + 3]) << 24;
 		k = byte1 | byte2 | byte3 | byte4;
 		k *= c1;
 		k = rotate_left(k, r1);
@@ -99,13 +99,13 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 
 	switch (len & (sizeof(uint32_t) - 1)) {
 	case 3:
-		k1 ^= ((uint32_t)tail[2]) << 16;
+		k1 ^= ((uint32_t)(unsigned char)tail[2]) << 16;
 		/*-fallthrough*/
 	case 2:
-		k1 ^= ((uint32_t)tail[1]) << 8;
+		k1 ^= ((uint32_t)(unsigned char)tail[1]) << 8;
 		/*-fallthrough*/
 	case 1:
-		k1 ^= ((uint32_t)tail[0]) << 0;
+		k1 ^= ((uint32_t)(unsigned char)tail[0]) << 0;
 		k1 *= c1;
 		k1 = rotate_left(k1, r1);
 		k1 *= c2;
diff --git a/bloom.h b/bloom.h
index adde6dfe21..8526fa948c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -7,9 +7,11 @@ struct repository;
 struct bloom_filter_settings {
 	/*
 	 * The version of the hashing technique being used.
-	 * We currently only support version = 1 which is
+	 * We currently only support version = 2 which is
 	 * the seeded murmur3 hashing technique implemented
-	 * in bloom.c.
+	 * in bloom.c. Bloom filters of version 1 were created
+	 * with prior versions of Git, which had a bug in the
+	 * implementation of the hash function.
 	 */
 	uint32_t hash_version;
 
@@ -38,8 +40,9 @@ struct bloom_filter_settings {
 	uint32_t max_changed_paths;
 };
 
+#define BLOOM_HASH_VERSION 2
 #define DEFAULT_BLOOM_MAX_CHANGES 512
-#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10, DEFAULT_BLOOM_MAX_CHANGES }
+#define DEFAULT_BLOOM_FILTER_SETTINGS { BLOOM_HASH_VERSION, 7, 10, DEFAULT_BLOOM_MAX_CHANGES }
 #define BITS_PER_WORD 8
 #define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)
 
diff --git a/commit-graph.c b/commit-graph.c
index 843bdb458d..2eb9b781f4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -314,7 +314,7 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	g->chunk_bloom_data = chunk_start;
 	hash_version = get_be32(chunk_start);
 
-	if (hash_version != 1)
+	if (hash_version != BLOOM_HASH_VERSION)
 		return 0;
 
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
@@ -2402,7 +2402,7 @@ int write_commit_graph(struct object_directory *odb,
 		g = ctx->r->objects->commit_graph;
 
 		/* We have changed-paths already. Keep them in the next graph */
-		if (g && g->chunk_bloom_data) {
+		if (g && g->bloom_filter_settings) {
 			ctx->changed_paths = 1;
 			ctx->bloom_settings = g->bloom_filter_settings;
 		}
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index aabe31d724..5624e4d2db 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -50,6 +50,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 
 static const char *bloom_usage = "\n"
 "  test-tool bloom get_murmur3 <string>\n"
+"  test-tool bloom get_murmur3_seven_highbit\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
 "  test-tool bloom get_filter_for_commit <commit-hex>\n";
 
@@ -68,6 +69,12 @@ int cmd__bloom(int argc, const char **argv)
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
+	if (!strcmp(argv[1], "get_murmur3_seven_highbit")) {
+		uint32_t hashed;
+		hashed = murmur3_seeded(0, "\x99\xaa\xbb\xcc\xdd\xee\xff", 7);
+		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
+	}
+
 	if (!strcmp(argv[1], "generate_filter")) {
 		struct bloom_filter filter;
 		int i = 2;
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index b567383eb8..c8d84ab606 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -29,6 +29,14 @@ test_expect_success 'compute unseeded murmur3 hash for test string 2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'compute unseeded murmur3 hash for test string 3' '
+	cat >expect <<-\EOF &&
+	Murmur3 Hash with seed=0:0xa183ccfd
+	EOF
+	test-tool bloom get_murmur3_seven_highbit >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'compute bloom key for empty string' '
 	cat >expect <<-\EOF &&
 	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index f14cc1c1f1..7a193aa143 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -48,7 +48,7 @@ graph_read_expect () {
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
-	options: bloom(1,10,7) read_generation_data
+	options: bloom(2,10,7) read_generation_data
 	EOF
 	test-tool read-graph >actual &&
 	test_cmp expect actual
@@ -108,7 +108,7 @@ test_expect_success 'incompatible bloom filter versions are not used' '
 
 	# But the correct version number works
 	cat old-commit-graph >new-commit-graph &&
-	printf "\01" |
+	printf "\02" |
 		dd of=new-commit-graph bs=1 count=1 \
 			seek=$((BDAT_OFFSET + 3)) conv=notrunc &&
 	mv new-commit-graph .git/objects/info/commit-graph &&
@@ -209,10 +209,10 @@ test_expect_success 'persist filter settings' '
 		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
 		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
+	grep "{\"hash_version\":2,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
+	grep "{\"hash_version\":2,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
 '
 
 test_max_changed_paths () {
-- 
2.40.1.698.g37aff9b760-goog

