Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B578C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjGMVnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjGMVnC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:43:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE23530EE
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5734d919156so10256907b3.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689284542; x=1691876542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pK+wIImnEPYj5Y8MsUR9ydGw35AR2uY8OW7UTlHgS0o=;
        b=KPzWCT2A3og+NioY741OtULsPNqPna6Mt78DccZsKrTzSysLGOtQm6PeOXpzBvGHcu
         Qk13k9ON+AAX+nbkqJt5NF9E9dsS/wNY/j1f56c4NsUaOJW15tyCZasgn6DLrNj3PEr9
         JnpYPFH7Xz9eOmm5D0go/a4RffZdRaB7kFWCYMQaIigaTRNWCXVIyxiPbfeXPoTKLhcK
         MxdXGHTnIogKYXui8scSml1GYngtAGSYllXUfWc7To3Xwve0Z1cEJQ/cSX43A6xc0uZB
         t65r0/X/5CJ7N02rYPQfNKImAiasX5Ae7DMIRGrRUbXUf6ZnmyT7/j/9WJvn3btcCjKn
         7IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284542; x=1691876542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pK+wIImnEPYj5Y8MsUR9ydGw35AR2uY8OW7UTlHgS0o=;
        b=YzJPZxufnrOKLgw7YwUb7HKPJ2HhatIkhK/gSYNriCW9I/lPQ/J5L6D/OD4CKwi2It
         Ed9086Mb2c+4/ZBz+1SbOtAYvwtLw+gGkhls78h422gQ0gz3ZUlPRznnFe9fmY3n/KWI
         SO7azGRSajlr7u4QNgawZIxnKm1OOteFrYJPPu6I3jUXJSV1FXJ1x8mWl/SZN64q0f4r
         jlYPbotiIHIJkYhYheu4v7WUZr8F08S4zwLzG4iyH4DkW6OgksruvUvonpQF5xjH8rjO
         AMPJqLBtA5s5kJAzVfk6c/HmsZVwQtj/S+0+Z3saklzWugW6X7tzVxIeBFQSetWWADBu
         5mzA==
X-Gm-Message-State: ABy/qLY1zA9DZy/yWk34McaczbHNPfMLjhusHq3KXW/tFvDCwkbNiOG2
        hKL+ZMZD/QdsnDH2xErhxzydZXkkiUhY6E+xyeOzZTCI7qmABJviwd3Cl7Ft33kmaiFOoogEad5
        igno13W0blC7BvRoEOBqcKDZTBHDWw17IgmHhLgneVd3zfcD970P+HLAVgDfWzpnnGw8qv8FBL8
        ZI
X-Google-Smtp-Source: APBJJlHUA8apRjGgIDXp2adc0Kd2YeZhTe1JQjZDSA2aiylrrFFzJb/lXhKFXoOShSGOspxOmzdBU9thAdn8AfrhFh03
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:8bde:aac2:2aa0:da1a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b306:0:b0:577:4540:905d with
 SMTP id r6-20020a81b306000000b005774540905dmr20810ywh.8.1689284542545; Thu,
 13 Jul 2023 14:42:22 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:42:11 -0700
In-Reply-To: <cover.1689283789.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689283789.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <47ba89c565d3383a8a14272fe52ac274be82d0be.1689283789.git.jonathantanmy@google.com>
Subject: [PATCH v5 4/4] commit-graph: new filter ver. that fixes murmur3
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
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

Therefore, introduce a new version (2) of changed path filters that
corrects this problem. The existing version (1) is still supported and
is still the default, but users should migrate away from it as soon
as possible.

Because this bug only manifests with characters that have the high bit
set, it may be possible that some (or all) commits in a given repo would
have the same changed path filter both before and after this fix is
applied. However, in order to determine whether this is the case, the
changed paths would first have to be computed, at which point it is not
much more expensive to just compute a new changed path filter.

So this patch does not include any mechanism to "salvage" changed path
filters from repositories. There is also no "mixed" mode - for each
invocation of Git, reading and writing changed path filters are done
with the same version number; this version number may be explicitly
stated (typically if the user knows which version they need) or
automatically determined from the version of the existing changed path
filters in the repository.

There is a change in write_commit_graph(). graph_read_bloom_data()
makes it possible for chunk_bloom_data to be non-NULL but
bloom_filter_settings to be NULL, which causes a segfault later on. I
produced such a segfault while developing this patch, but couldn't find
a way to reproduce it neither after this complete patch (or before),
but in any case it seemed like a good thing to include that might help
future patch authors.

The value in t0095 was obtained from another murmur3 implementation
using the following Go source code:

  package main

  import "fmt"
  import "github.com/spaolacci/murmur3"

  func main() {
          fmt.Printf("%x\n", murmur3.Sum32([]byte("Hello world!")))
          fmt.Printf("%x\n", murmur3.Sum32([]byte{0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff}))
  }

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/commitgraph.txt |  2 +-
 bloom.c                              | 65 +++++++++++++++++++++++--
 bloom.h                              |  8 ++--
 commit-graph.c                       | 31 ++++++++++--
 t/helper/test-bloom.c                |  9 +++-
 t/t0095-bloom.sh                     |  8 ++++
 t/t4216-log-bloom.sh                 | 72 +++++++++++++++++++++++++++-
 7 files changed, 181 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 07f3799e05..b93ccfba8f 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -14,7 +14,7 @@ commitGraph.readChangedPaths::
 
 commitGraph.changedPathsVersion::
 	Specifies the version of the changed-path Bloom filters that Git will read and
-	write. May be -1, 0 or 1. Any changed-path Bloom filters on disk that do not
+	write. May be -1, 0, 1, or 2. Any changed-path Bloom filters on disk that do not
 	match the version set in this config variable will be ignored.
 +
 Defaults to -1.
diff --git a/bloom.c b/bloom.c
index d0730525da..915d8e5a31 100644
--- a/bloom.c
+++ b/bloom.c
@@ -65,7 +65,64 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
  * Not considered to be cryptographically secure.
  * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  */
-uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
+uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len)
+{
+	const uint32_t c1 = 0xcc9e2d51;
+	const uint32_t c2 = 0x1b873593;
+	const uint32_t r1 = 15;
+	const uint32_t r2 = 13;
+	const uint32_t m = 5;
+	const uint32_t n = 0xe6546b64;
+	int i;
+	uint32_t k1 = 0;
+	const char *tail;
+
+	int len4 = len / sizeof(uint32_t);
+
+	uint32_t k;
+	for (i = 0; i < len4; i++) {
+		uint32_t byte1 = (uint32_t)(unsigned char)data[4*i];
+		uint32_t byte2 = ((uint32_t)(unsigned char)data[4*i + 1]) << 8;
+		uint32_t byte3 = ((uint32_t)(unsigned char)data[4*i + 2]) << 16;
+		uint32_t byte4 = ((uint32_t)(unsigned char)data[4*i + 3]) << 24;
+		k = byte1 | byte2 | byte3 | byte4;
+		k *= c1;
+		k = rotate_left(k, r1);
+		k *= c2;
+
+		seed ^= k;
+		seed = rotate_left(seed, r2) * m + n;
+	}
+
+	tail = (data + len4 * sizeof(uint32_t));
+
+	switch (len & (sizeof(uint32_t) - 1)) {
+	case 3:
+		k1 ^= ((uint32_t)(unsigned char)tail[2]) << 16;
+		/*-fallthrough*/
+	case 2:
+		k1 ^= ((uint32_t)(unsigned char)tail[1]) << 8;
+		/*-fallthrough*/
+	case 1:
+		k1 ^= ((uint32_t)(unsigned char)tail[0]) << 0;
+		k1 *= c1;
+		k1 = rotate_left(k1, r1);
+		k1 *= c2;
+		seed ^= k1;
+		break;
+	}
+
+	seed ^= (uint32_t)len;
+	seed ^= (seed >> 16);
+	seed *= 0x85ebca6b;
+	seed ^= (seed >> 13);
+	seed *= 0xc2b2ae35;
+	seed ^= (seed >> 16);
+
+	return seed;
+}
+
+static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size_t len)
 {
 	const uint32_t c1 = 0xcc9e2d51;
 	const uint32_t c2 = 0x1b873593;
@@ -130,8 +187,10 @@ void fill_bloom_key(const char *data,
 	int i;
 	const uint32_t seed0 = 0x293ae76f;
 	const uint32_t seed1 = 0x7e646e2c;
-	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
-	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
+	const uint32_t hash0 = (settings->hash_version == 2
+		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed0, data, len);
+	const uint32_t hash1 = (settings->hash_version == 2
+		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed1, data, len);
 
 	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
 	for (i = 0; i < settings->num_hashes; i++)
diff --git a/bloom.h b/bloom.h
index adde6dfe21..0c33ae282c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -7,9 +7,11 @@ struct repository;
 struct bloom_filter_settings {
 	/*
 	 * The version of the hashing technique being used.
-	 * We currently only support version = 1 which is
+	 * The newest version is 2, which is
 	 * the seeded murmur3 hashing technique implemented
-	 * in bloom.c.
+	 * in bloom.c. Bloom filters of version 1 were created
+	 * with prior versions of Git, which had a bug in the
+	 * implementation of the hash function.
 	 */
 	uint32_t hash_version;
 
@@ -75,7 +77,7 @@ struct bloom_key {
  * Not considered to be cryptographically secure.
  * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  */
-uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len);
+uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len);
 
 void fill_bloom_key(const char *data,
 		    size_t len,
diff --git a/commit-graph.c b/commit-graph.c
index 9b72319450..c50107eed5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -302,16 +302,25 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
+struct graph_read_bloom_data_data {
+	struct commit_graph *g;
+	int *commit_graph_changed_paths_version;
+};
+
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
-	struct commit_graph *g = data;
+	struct graph_read_bloom_data_data *d = data;
+	struct commit_graph *g = d->g;
 	uint32_t hash_version;
 	g->chunk_bloom_data = chunk_start;
 	hash_version = get_be32(chunk_start);
 
-	if (hash_version != 1)
-		return 0;
+	if (*d->commit_graph_changed_paths_version == -1) {
+		*d->commit_graph_changed_paths_version = hash_version;
+	} else if (hash_version != *d->commit_graph_changed_paths_version) {
+ 		return 0;
+	}
 
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
 	g->bloom_filter_settings->hash_version = hash_version;
@@ -400,10 +409,14 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_changed_paths_version != 0) {
+		struct graph_read_bloom_data_data data = {
+			.g = graph,
+			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
+		};
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
-			   graph_read_bloom_data, graph);
+			   graph_read_bloom_data, &data);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
@@ -2302,6 +2315,14 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
+	if (r->settings.commit_graph_changed_paths_version < -1
+	    || r->settings.commit_graph_changed_paths_version > 2) {
+		warning(_("attempting to write a commit-graph, but 'commitgraph.changedPathsVersion' (%d) is not supported"),
+			r->settings.commit_graph_changed_paths_version);
+		return 0;
+	}
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
+		? 2 : 1;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2331,7 +2352,7 @@ int write_commit_graph(struct object_directory *odb,
 		g = ctx->r->objects->commit_graph;
 
 		/* We have changed-paths already. Keep them in the next graph */
-		if (g && g->chunk_bloom_data) {
+		if (g && g->bloom_filter_settings) {
 			ctx->changed_paths = 1;
 			ctx->bloom_settings = g->bloom_filter_settings;
 		}
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 6c900ca668..34b8dd9164 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -48,6 +48,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 
 static const char *bloom_usage = "\n"
 "  test-tool bloom get_murmur3 <string>\n"
+"  test-tool bloom get_murmur3_seven_highbit\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
 "  test-tool bloom get_filter_for_commit <commit-hex>\n";
 
@@ -62,7 +63,13 @@ int cmd__bloom(int argc, const char **argv)
 		uint32_t hashed;
 		if (argc < 3)
 			usage(bloom_usage);
-		hashed = murmur3_seeded(0, argv[2], strlen(argv[2]));
+		hashed = murmur3_seeded_v2(0, argv[2], strlen(argv[2]));
+		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
+	}
+
+	if (!strcmp(argv[1], "get_murmur3_seven_highbit")) {
+		uint32_t hashed;
+		hashed = murmur3_seeded_v2(0, "\x99\xaa\xbb\xcc\xdd\xee\xff", 7);
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
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
index 0cf208fdf5..6ff26e5af5 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -410,6 +410,13 @@ get_bdat_offset () {
 		.git/objects/info/commit-graph
 }
 
+get_changed_path_filter_version () {
+	BDAT_OFFSET=$(get_bdat_offset) &&
+	perl -0777 -ne \
+		'print unpack("H*", substr($_, '$BDAT_OFFSET', 4))' \
+		.git/objects/info/commit-graph
+}
+
 get_first_changed_path_filter () {
 	BDAT_OFFSET=$(get_bdat_offset) &&
 	perl -0777 -ne \
@@ -426,7 +433,7 @@ test_expect_success 'set up repo with high bit path, version 1 changed-path' '
 	git -C highbit1 commit-graph write --reachable --changed-paths
 '
 
-test_expect_success 'setup check value of version 1 changed-path' '
+test_expect_success 'check value of version 1 changed-path' '
 	(cd highbit1 &&
 		printf "52a9" >expect &&
 		get_first_changed_path_filter >actual &&
@@ -451,4 +458,67 @@ test_expect_success 'version 1 changed-path used when version 1 requested' '
 		test_bloom_filters_used "-- $CENT")
 '
 
+test_expect_success 'version 1 changed-path not used when version 2 requested' '
+	(cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion 2 &&
+		test_bloom_filters_not_used "-- $CENT")
+'
+
+test_expect_success 'version 1 changed-path used when autodetect requested' '
+	(cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		test_bloom_filters_used "-- $CENT")
+'
+
+test_expect_success 'when writing another commit graph, preserve existing version 1 of changed-path' '
+	test_commit -C highbit1 c1double "$CENT$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths &&
+	(cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		printf "00000001" >expect &&
+		get_changed_path_filter_version >actual &&
+		test_cmp expect actual)
+'
+
+test_expect_success 'set up repo with high bit path, version 2 changed-path' '
+	git init highbit2 &&
+	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
+	test_commit -C highbit2 c2 "$CENT" &&
+	git -C highbit2 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'check value of version 2 changed-path' '
+	(cd highbit2 &&
+		printf "c01f" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual)
+'
+
+test_expect_success 'version 2 changed-path used when version 2 requested' '
+	(cd highbit2 &&
+		test_bloom_filters_used "-- $CENT")
+'
+
+test_expect_success 'version 2 changed-path not used when version 1 requested' '
+	(cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion 1 &&
+		test_bloom_filters_not_used "-- $CENT")
+'
+
+test_expect_success 'version 2 changed-path used when autodetect requested' '
+	(cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		test_bloom_filters_used "-- $CENT")
+'
+
+test_expect_success 'when writing another commit graph, preserve existing version 2 of changed-path' '
+	test_commit -C highbit2 c2double "$CENT$CENT" &&
+	git -C highbit2 commit-graph write --reachable --changed-paths &&
+	(cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		printf "00000002" >expect &&
+		get_changed_path_filter_version >actual &&
+		test_cmp expect actual)
+'
+
 test_done
-- 
2.41.0.255.g8b1d071c50-goog

