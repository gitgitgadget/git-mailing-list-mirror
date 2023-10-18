Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF347366
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZIDwIEyR"
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F262118
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:03 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b610279c8aso3354047241.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653982; x=1698258782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtxLmuLHbQFmui1lvZH3xBsp1KXecwUjRoMts1nMQ0g=;
        b=ZIDwIEyRMJbwtv3ezHFVlScErAtAtciF5fIhKzZgEOskPk3tbVwipf8YzX2Arsgfln
         xFtgEjom6OAe6/2Zlgavcl17HZzl33vAmsJ6TM+/SjkLgRyRxfrVzyznaKEvt1w5a7i5
         3XE86Kc3R8xYEgZMS/W7+Hz4QVxhxTymYQXzanurw0WhTq9pn57miBC9OSaYMk04Fex4
         2vDlGwTpgkR1l6AGcY8htSRu3HTGeHrq29Mk6Dm47G/EQh4JXOT72lUsAK5Kh+TTAKDT
         8WkwmoNQexDbV+Fgy0JSIyNtOyrC+QP7uDG30zK4LbQgd3EzP8VxrrFEmPb/sxwYamhe
         +TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653982; x=1698258782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtxLmuLHbQFmui1lvZH3xBsp1KXecwUjRoMts1nMQ0g=;
        b=Juop6d8yNPr/3hgRYz9GMMyBzJb0sPvR9jl+m1bIOQyUc/WEnEZNhQ+gTP+FssBFDb
         DgmEx41OmI26BALpH2R2ehwIhARJPvqt4oSXGUN5XZpkWYgP4rJ4bf6VYYAWm7y2LQDk
         lJhqZfImRSGTJCEgRmHcAdeCa6LFm1Zoc6S43+ABC7NYMj81gRtUUgwDXACmxaPmypvM
         3TMkkP23Q7x+rY4mvYuxNMFgHfijaWSGsYClV/8mU6PvYYGXWijy8azR3ekUkpxdya+L
         p6NnZWERVHER70zQU5Mvqp30zzQRfN9K8WfFZRok2eJAt8wFnLDWuFXRlIVmis0ZPXk1
         UyWw==
X-Gm-Message-State: AOJu0YystzwdLIYY+l7QjH5p3djqHKCyKdbnjLhZ4OlnQegcSeoVDdHI
	UnKf8tMRrO32R6RpETXlgN54VIthECYxGNr/q9Wrxg==
X-Google-Smtp-Source: AGHT+IFEvKlHBlFXI0D8nxknXQeEX+fU5u2XxUl/bTDTiOgEn+Wx9Ca/AVeynIesMjsKreW9XgMYgQ==
X-Received: by 2002:a67:e108:0:b0:458:62c6:d7fc with SMTP id d8-20020a67e108000000b0045862c6d7fcmr2341844vsl.3.1697653981903;
        Wed, 18 Oct 2023 11:33:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cn6-20020a05622a248600b0041812703b7esm146787qtb.52.2023.10.18.11.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:00 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 10/17] commit-graph: new filter ver. that fixes murmur3
Message-ID: <f6ab427ead86bc82284b2c721f3c177947ece3c9.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jonathan Tan <jonathantanmy@google.com>

The murmur3 implementation in bloom.c has a bug when converting series
of 4 bytes into network-order integers when char is signed (which is
controllable by a compiler option, and the default signedness of char is
platform-specific). When a string contains characters with the high bit
set, this bug causes results that, although internally consistent within
Git, does not accord with other implementations of murmur3 (thus,
the changed path filters wouldn't be readable by other off-the-shelf
implementatios of murmur3) and even with Git binaries that were compiled
with different signedness of char. This bug affects both how Git writes
changed path filters to disk and how Git interprets changed path filters
on disk.

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
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/commitgraph.txt |   5 +-
 bloom.c                              |  69 +++++++++++++++-
 bloom.h                              |   8 +-
 commit-graph.c                       |  32 ++++++--
 t/helper/test-bloom.c                |   9 ++-
 t/t0095-bloom.sh                     |   8 ++
 t/t4216-log-bloom.sh                 | 114 +++++++++++++++++++++++++++
 7 files changed, 232 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 2dc9170622..acc74a2f27 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -15,7 +15,7 @@ commitGraph.readChangedPaths::
 
 commitGraph.changedPathsVersion::
 	Specifies the version of the changed-path Bloom filters that Git will read and
-	write. May be -1, 0 or 1.
+	write. May be -1, 0, 1, or 2.
 +
 Defaults to -1.
 +
@@ -28,4 +28,7 @@ filters when instructed to write.
 If 1, Git will only read version 1 Bloom filters, and will write version 1
 Bloom filters.
 +
+If 2, Git will only read version 2 Bloom filters, and will write version 2
+Bloom filters.
++
 See linkgit:git-commit-graph[1] for more information.
diff --git a/bloom.c b/bloom.c
index 3e78cfe79d..ebef5cfd2f 100644
--- a/bloom.c
+++ b/bloom.c
@@ -66,7 +66,64 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
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
@@ -131,8 +188,14 @@ void fill_bloom_key(const char *data,
 	int i;
 	const uint32_t seed0 = 0x293ae76f;
 	const uint32_t seed1 = 0x7e646e2c;
-	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
-	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
+	uint32_t hash0, hash1;
+	if (settings->hash_version == 2) {
+		hash0 = murmur3_seeded_v2(seed0, data, len);
+		hash1 = murmur3_seeded_v2(seed1, data, len);
+	} else {
+		hash0 = murmur3_seeded_v1(seed0, data, len);
+		hash1 = murmur3_seeded_v1(seed1, data, len);
+	}
 
 	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
 	for (i = 0; i < settings->num_hashes; i++)
diff --git a/bloom.h b/bloom.h
index 1e4f612d2c..138d57a86b 100644
--- a/bloom.h
+++ b/bloom.h
@@ -8,9 +8,11 @@ struct commit_graph;
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
 
@@ -80,7 +82,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
  * Not considered to be cryptographically secure.
  * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  */
-uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len);
+uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len);
 
 void fill_bloom_key(const char *data,
 		    size_t len,
diff --git a/commit-graph.c b/commit-graph.c
index bcc9a15cfa..6b21b17b20 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -314,17 +314,26 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
+struct graph_read_bloom_data_context {
+	struct commit_graph *g;
+	int *commit_graph_changed_paths_version;
+};
+
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
-	struct commit_graph *g = data;
+	struct graph_read_bloom_data_context *c = data;
+	struct commit_graph *g = c->g;
 	uint32_t hash_version;
-	g->chunk_bloom_data = chunk_start;
 	hash_version = get_be32(chunk_start);
 
-	if (hash_version != 1)
+	if (*c->commit_graph_changed_paths_version == -1) {
+		*c->commit_graph_changed_paths_version = hash_version;
+	} else if (hash_version != *c->commit_graph_changed_paths_version) {
 		return 0;
+	}
 
+	g->chunk_bloom_data = chunk_start;
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
 	g->bloom_filter_settings->hash_version = hash_version;
 	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
@@ -412,10 +421,14 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_changed_paths_version) {
+		struct graph_read_bloom_data_context context = {
+			.g = graph,
+			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
+		};
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
-			   graph_read_bloom_data, graph);
+			   graph_read_bloom_data, &context);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
@@ -2436,6 +2449,13 @@ int write_commit_graph(struct object_directory *odb,
 	}
 	if (!commit_graph_compatible(r))
 		return 0;
+	if (r->settings.commit_graph_changed_paths_version < -1
+	    || r->settings.commit_graph_changed_paths_version > 2) {
+		warning(_("attempting to write a commit-graph, but "
+			  "'commitgraph.changedPathsVersion' (%d) is not supported"),
+			r->settings.commit_graph_changed_paths_version);
+		return 0;
+	}
 
 	CALLOC_ARRAY(ctx, 1);
 	ctx->r = r;
@@ -2448,6 +2468,8 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
+		? 2 : 1;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2477,7 +2499,7 @@ int write_commit_graph(struct object_directory *odb,
 		g = ctx->r->objects->commit_graph;
 
 		/* We have changed-paths already. Keep them in the next graph */
-		if (g && g->chunk_bloom_data) {
+		if (g && g->bloom_filter_settings) {
 			ctx->changed_paths = 1;
 			ctx->bloom_settings = g->bloom_filter_settings;
 		}
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index aabe31d724..3cbc0a5b50 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -50,6 +50,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 
 static const char *bloom_usage = "\n"
 "  test-tool bloom get_murmur3 <string>\n"
+"  test-tool bloom get_murmur3_seven_highbit\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
 "  test-tool bloom get_filter_for_commit <commit-hex>\n";
 
@@ -64,7 +65,13 @@ int cmd__bloom(int argc, const char **argv)
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
index 400dce2193..68066b7928 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -535,4 +535,118 @@ test_expect_success 'version 1 changed-path used when version 1 requested' '
 	)
 '
 
+test_expect_success 'version 1 changed-path not used when version 2 requested' '
+	(
+		cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion 2 &&
+		test_bloom_filters_not_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'version 1 changed-path used when autodetect requested' '
+	(
+		cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'when writing another commit graph, preserve existing version 1 of changed-path' '
+	test_commit -C highbit1 c1double "$CENT$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths &&
+	(
+		cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		echo "options: bloom(1,10,7) read_generation_data" >expect &&
+		test-tool read-graph >full &&
+		grep options full >actual &&
+		test_cmp expect actual
+	)
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
+	(
+		cd highbit2 &&
+		echo "c01f" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'setup make another commit' '
+	# "git log" does not use Bloom filters for root commits - see how, in
+	# revision.c, rev_compare_tree() (the only code path that eventually calls
+	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
+	# has one parent. Therefore, make another commit so that we perform the tests on
+	# a non-root commit.
+	test_commit -C highbit2 anotherc2 "another$CENT"
+'
+
+test_expect_success 'version 2 changed-path used when version 2 requested' '
+	(
+		cd highbit2 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'version 2 changed-path not used when version 1 requested' '
+	(
+		cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion 1 &&
+		test_bloom_filters_not_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'version 2 changed-path used when autodetect requested' '
+	(
+		cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'when writing another commit graph, preserve existing version 2 of changed-path' '
+	test_commit -C highbit2 c2double "$CENT$CENT" &&
+	git -C highbit2 commit-graph write --reachable --changed-paths &&
+	(
+		cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		echo "options: bloom(2,10,7) read_generation_data" >expect &&
+		test-tool read-graph >full &&
+		grep options full >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'when writing commit graph, do not reuse changed-path of another version' '
+	git init doublewrite &&
+	test_commit -C doublewrite c "$CENT" &&
+	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
+	git -C doublewrite commit-graph write --reachable --changed-paths &&
+	for v in -2 3
+	do
+		git -C doublewrite config --add commitgraph.changedPathsVersion $v &&
+		git -C doublewrite commit-graph write --reachable --changed-paths 2>err &&
+		cat >expect <<-EOF &&
+		warning: attempting to write a commit-graph, but ${SQ}commitgraph.changedPathsVersion${SQ} ($v) is not supported
+		EOF
+		test_cmp expect err || return 1
+	done &&
+	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
+	git -C doublewrite commit-graph write --reachable --changed-paths &&
+	(
+		cd doublewrite &&
+		echo "c01f" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.42.0.415.g8942f205c8

