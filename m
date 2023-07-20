Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE38EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGTVqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGTVqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F792D45
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso12179287b3.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889603; x=1690494403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+cwAx8heNk/Gj9BqF49o9+hfunRLg3SPbZrtcPnWuQ=;
        b=lVlzd9eLSMNckIORSnyVw4c6M1HKDQFeNDKmQ2XGdpW70RgeS/snrMDaCnZYgehdrD
         KheRnDmWYLZ52zLCYVV/fXng2ShxziSMm/56gabfRBoEpWXHottDVrMJoNd/viqrinC8
         8PgLC9ggAWftPzhGEpHnz4NetznPJMXxjkMLKF6B7OH9jYBchOf8BHIiOD57a4witQI4
         ziPeYiZUn0M0nHTB10T9OB1ot3jwI48ndBJuDfPiRpMaDyh/a61RrRGTHkIPkW2gX224
         SDfDYTnmfR7nddoFZeME3gJmov02fQdR2nLKyt5zyXu8bXZxz5JHiAGOzNOaR+Q78sBi
         ZufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889603; x=1690494403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+cwAx8heNk/Gj9BqF49o9+hfunRLg3SPbZrtcPnWuQ=;
        b=jdoRiq7LfEmH68olv6gkjTG5RPZqC1lMKCeExMDT5kLv2yroFbGxU4RZzxzvmN23rC
         lWDb0NyBbd8TcZf8YlEeXHUUMmGhhnpE+nIUVZMlJz4CfU09mPHlihIwUJvTqMt7Q5Cg
         2AfXp3yEGzf/Fm484JfREXT4YbHTSKkQhqKB3M6yDjQnN+A2aGXg23MlR6rN8BKeNQdL
         xrQ9hY7CZzJ4gcaWeAsSsHD9ixHhNfSo+mKROAfGP0j43O6imze51uteOd1RItMgKDkb
         JEgA6+3zjC4PGNTDuMPmTES6k7L+jHy2XgdzTpnAEautr16/qVm/XiuEVhS2f/3sLBeZ
         npPw==
X-Gm-Message-State: ABy/qLaXvC7EXUB573nzyfrDG0qj0OZVDK6eguR4rAGIii/oOjZ4Eu7b
        RFAptBqszU+WOknXR81yBI7BvAPZVK++MY1yxCL+R/3/dru/vIgxzinoZHiSH3gp4EuP4sr4fO1
        5+1t1ddtHCSlZNV5cIDPtnxu/qm29z0H2Ar4p9b3rwGGfGzYJlvczBnoZtynuGZt4Fcuevxdutx
        fa
X-Google-Smtp-Source: APBJJlFvzSQBYC3GeavS/89RSybpZ3llcLp5QOA6rZk+xxHUwZNtK1rkTDNVS1SwbLqcr1XKLHyI8mgEHPdwYtv3MDgZ
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a908:0:b0:582:e4fb:fae8 with
 SMTP id g8-20020a81a908000000b00582e4fbfae8mr2881ywh.2.1689889603569; Thu, 20
 Jul 2023 14:46:43 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:46:33 -0700
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <cover.1689889382.git.jonathantanmy@google.com>
Subject: [PATCH v6 0/7] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio and Taylor, for your reviews. I have included Taylor's
patches in this patch set.

There seemed to be some merge conflicts when I tried to apply the
patches Taylor provided on the base that I built my patches on (that is,
the base of jt/path-filter-fix, namely, maint-2.40), so I have rebased
all my patches onto latest master.

Jonathan Tan (4):
  gitformat-commit-graph: describe version 2 of BDAT
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new filter ver. that fixes murmur3

Taylor Blau (3):
  t/helper/test-read-graph.c: extract `dump_graph_info()`
  bloom.h: make `load_bloom_filter_from_graph()` public
  t/helper/test-read-graph: implement `bloom-filters` mode

 Documentation/config/commitgraph.txt     |  26 +++++-
 Documentation/gitformat-commit-graph.txt |   9 +-
 bloom.c                                  |  75 ++++++++++++++--
 bloom.h                                  |  13 ++-
 commit-graph.c                           |  33 +++++--
 oss-fuzz/fuzz-commit-graph.c             |   2 +-
 repo-settings.c                          |   6 +-
 repository.h                             |   2 +-
 t/helper/test-bloom.c                    |   9 +-
 t/helper/test-read-graph.c               |  67 ++++++++++++---
 t/t0095-bloom.sh                         |   8 ++
 t/t4216-log-bloom.sh                     | 104 +++++++++++++++++++++++
 12 files changed, 315 insertions(+), 39 deletions(-)

Range-diff against v5:
1:  efe7f40fed = 1:  3ce6090a4d gitformat-commit-graph: describe version 2 of BDAT
-:  ---------- > 2:  1955734d1f t/helper/test-read-graph.c: extract `dump_graph_info()`
-:  ---------- > 3:  4cf7c2f634 bloom.h: make `load_bloom_filter_from_graph()` public
-:  ---------- > 4:  47b55758e6 t/helper/test-read-graph: implement `bloom-filters` mode
2:  f684d07971 ! 5:  5276e6a90e t4216: test changed path filters with high bit paths
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
      	)
      '
      
    -+get_bdat_offset () {
    -+	perl -0777 -ne \
    -+		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
    -+		.git/objects/info/commit-graph
    -+}
    -+
     +get_first_changed_path_filter () {
    -+	BDAT_OFFSET=$(get_bdat_offset) &&
    -+	perl -0777 -ne \
    -+		'print unpack("H*", substr($_, '$BDAT_OFFSET' + 12, 2))' \
    -+		.git/objects/info/commit-graph
    ++	test-tool read-graph bloom-filters >filters.dat &&
    ++	head -n 1 filters.dat
     +}
     +
     +# chosen to be the same under all Unicode normalization forms
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +
     +test_expect_success 'setup check value of version 1 changed-path' '
     +	(cd highbit1 &&
    -+		printf "52a9" >expect &&
    ++		echo "52a9" >expect &&
     +		get_first_changed_path_filter >actual &&
     +		test_cmp expect actual)
     +'
3:  2fadd87063 ! 6:  dc3f6d2d4f repo-settings: introduce commitgraph.changedPathsVersion
    @@ Documentation/config/commitgraph.txt: commitGraph.maxNewFilters::
     -	If true, then git will use the changed-path Bloom filters in the
     -	commit-graph file (if it exists, and they are present). Defaults to
     -	true. See linkgit:git-commit-graph[1] for more information.
    -+	Deprecated. Equivalent to changedPathsVersion=-1 if true, and
    -+	changedPathsVersion=0 if false.
    ++	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
    ++	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
    ++	is also set, commitGraph.changedPathsVersion takes precedence.)
     +
     +commitGraph.changedPathsVersion::
     +	Specifies the version of the changed-path Bloom filters that Git will read and
    -+	write. May be -1, 0 or 1. Any changed-path Bloom filters on disk that do not
    -+	match the version set in this config variable will be ignored.
    ++	write. May be -1, 0 or 1.
     ++
     +Defaults to -1.
     ++
     +If -1, Git will use the version of the changed-path Bloom filters in the
     +repository, defaulting to 1 if there are none.
     ++
    -+If 0, git will write version 1 Bloom filters when instructed to write.
    ++If 0, Git will not read any Bloom filters, and will write version 1 Bloom
    ++filters when instructed to write.
    +++
    ++If 1, Git will only read version 1 Bloom filters, and will write version 1
    ++Bloom filters.
     ++
     +See linkgit:git-commit-graph[1] for more information.
     
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
      	}
      
     -	if (s->commit_graph_read_changed_paths) {
    -+	if (s->commit_graph_changed_paths_version != 0) {
    ++	if (s->commit_graph_changed_paths_version) {
      		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
      			   &graph->chunk_bloom_indexes);
      		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
    @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
      	int value;
      	const char *strval;
      	int manyfiles;
    -+	int readChangedPaths;
    ++	int read_changed_paths;
      
      	if (!r->gitdir)
      		BUG("Cannot add settings for uninitialized repository");
    @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
      	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
      	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
     -	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
    -+	repo_cfg_bool(r, "commitgraph.readchangedpaths", &readChangedPaths, 1);
    ++	repo_cfg_bool(r, "commitgraph.readchangedpaths", &read_changed_paths, 1);
     +	repo_cfg_int(r, "commitgraph.changedpathsversion",
     +		     &r->settings.commit_graph_changed_paths_version,
    -+		     readChangedPaths ? -1 : 0);
    ++		     read_changed_paths ? -1 : 0);
      	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
      	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
      
    @@ repository.h: struct repo_settings {
     -	int commit_graph_read_changed_paths;
     +	int commit_graph_changed_paths_version;
      	int gc_write_commit_graph;
    - 	int gc_cruft_packs;
      	int fetch_write_commit_graph;
    + 	int command_requires_full_index;
4:  e31711ae85 ! 7:  6e2d797406 commit-graph: new filter ver. that fixes murmur3
    @@ Commit message
         controllable by a compiler option, and the default signedness of char is
         platform-specific). When a string contains characters with the high bit
         set, this bug causes results that, although internally consistent within
    -    Git, does not accord with other implementations of murmur3 and even with
    -    Git binaries that were compiled with different signedness of char. This
    -    bug affects both how Git writes changed path filters to disk and how Git
    -    interprets changed path filters on disk.
    +    Git, does not accord with other implementations of murmur3 (thus,
    +    the changed path filters wouldn't be readable by other off-the-shelf
    +    implementatios of murmur3) and even with Git binaries that were compiled
    +    with different signedness of char. This bug affects both how Git writes
    +    changed path filters to disk and how Git interprets changed path filters
    +    on disk.
     
         Therefore, introduce a new version (2) of changed path filters that
         corrects this problem. The existing version (1) is still supported and
    @@ Documentation/config/commitgraph.txt: commitGraph.readChangedPaths::
      
      commitGraph.changedPathsVersion::
      	Specifies the version of the changed-path Bloom filters that Git will read and
    --	write. May be -1, 0 or 1. Any changed-path Bloom filters on disk that do not
    -+	write. May be -1, 0, 1, or 2. Any changed-path Bloom filters on disk that do not
    - 	match the version set in this config variable will be ignored.
    +-	write. May be -1, 0 or 1.
    ++	write. May be -1, 0, 1, or 2.
      +
      Defaults to -1.
    + +
    +@@ Documentation/config/commitgraph.txt: filters when instructed to write.
    + If 1, Git will only read version 1 Bloom filters, and will write version 1
    + Bloom filters.
    + +
    ++If 2, Git will only read version 2 Bloom filters, and will write version 2
    ++Bloom filters.
    +++
    + See linkgit:git-commit-graph[1] for more information.
     
      ## bloom.c ##
    -@@ bloom.c: static int load_bloom_filter_from_graph(struct commit_graph *g,
    +@@ bloom.c: int load_bloom_filter_from_graph(struct commit_graph *g,
       * Not considered to be cryptographically secure.
       * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
       */
    @@ bloom.c: void fill_bloom_key(const char *data,
      	const uint32_t seed1 = 0x7e646e2c;
     -	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
     -	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
    -+	const uint32_t hash0 = (settings->hash_version == 2
    -+		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed0, data, len);
    -+	const uint32_t hash1 = (settings->hash_version == 2
    -+		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed1, data, len);
    ++	uint32_t hash0, hash1;
    ++	if (settings->hash_version == 2) {
    ++		hash0 = murmur3_seeded_v2(seed0, data, len);
    ++		hash1 = murmur3_seeded_v2(seed1, data, len);
    ++	} else {
    ++		hash0 = murmur3_seeded_v1(seed0, data, len);
    ++		hash1 = murmur3_seeded_v1(seed1, data, len);
    ++	}
      
      	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
      	for (i = 0; i < settings->num_hashes; i++)
     
      ## bloom.h ##
    -@@ bloom.h: struct repository;
    +@@ bloom.h: struct commit_graph;
      struct bloom_filter_settings {
      	/*
      	 * The version of the hashing technique being used.
    @@ bloom.h: struct repository;
      	 */
      	uint32_t hash_version;
      
    -@@ bloom.h: struct bloom_key {
    +@@ bloom.h: int load_bloom_filter_from_graph(struct commit_graph *g,
       * Not considered to be cryptographically secure.
       * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
       */
    @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_star
      	return 0;
      }
      
    -+struct graph_read_bloom_data_data {
    ++struct graph_read_bloom_data_context {
     +	struct commit_graph *g;
     +	int *commit_graph_changed_paths_version;
     +};
    @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_star
      				  size_t chunk_size, void *data)
      {
     -	struct commit_graph *g = data;
    -+	struct graph_read_bloom_data_data *d = data;
    -+	struct commit_graph *g = d->g;
    ++	struct graph_read_bloom_data_context *c = data;
    ++	struct commit_graph *g = c->g;
      	uint32_t hash_version;
      	g->chunk_bloom_data = chunk_start;
      	hash_version = get_be32(chunk_start);
      
     -	if (hash_version != 1)
    -+	if (*d->commit_graph_changed_paths_version == -1) {
    -+		*d->commit_graph_changed_paths_version = hash_version;
    -+	} else if (hash_version != *d->commit_graph_changed_paths_version) {
    - 		return 0;
    +-		return 0;
    ++	if (*c->commit_graph_changed_paths_version == -1) {
    ++		*c->commit_graph_changed_paths_version = hash_version;
    ++	} else if (hash_version != *c->commit_graph_changed_paths_version) {
    ++ 		return 0;
     +	}
      
      	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
    @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_star
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
      	}
      
    - 	if (s->commit_graph_changed_paths_version != 0) {
    -+		struct graph_read_bloom_data_data data = {
    + 	if (s->commit_graph_changed_paths_version) {
    ++		struct graph_read_bloom_data_context context = {
     +			.g = graph,
     +			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
     +		};
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
      			   &graph->chunk_bloom_indexes);
      		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
     -			   graph_read_bloom_data, graph);
    -+			   graph_read_bloom_data, &data);
    ++			   graph_read_bloom_data, &context);
      	}
      
      	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
    @@ t/t0095-bloom.sh: test_expect_success 'compute unseeded murmur3 hash for test st
      	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
     
      ## t/t4216-log-bloom.sh ##
    -@@ t/t4216-log-bloom.sh: get_bdat_offset () {
    - 		.git/objects/info/commit-graph
    - }
    - 
    -+get_changed_path_filter_version () {
    -+	BDAT_OFFSET=$(get_bdat_offset) &&
    -+	perl -0777 -ne \
    -+		'print unpack("H*", substr($_, '$BDAT_OFFSET', 4))' \
    -+		.git/objects/info/commit-graph
    -+}
    -+
    - get_first_changed_path_filter () {
    - 	BDAT_OFFSET=$(get_bdat_offset) &&
    - 	perl -0777 -ne \
     @@ t/t4216-log-bloom.sh: test_expect_success 'set up repo with high bit path, version 1 changed-path' '
      	git -C highbit1 commit-graph write --reachable --changed-paths
      '
    @@ t/t4216-log-bloom.sh: test_expect_success 'set up repo with high bit path, versi
     -test_expect_success 'setup check value of version 1 changed-path' '
     +test_expect_success 'check value of version 1 changed-path' '
      	(cd highbit1 &&
    - 		printf "52a9" >expect &&
    + 		echo "52a9" >expect &&
      		get_first_changed_path_filter >actual &&
     @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when version 1 requested' '
      		test_bloom_filters_used "-- $CENT")
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +	git -C highbit1 commit-graph write --reachable --changed-paths &&
     +	(cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
    -+		printf "00000001" >expect &&
    -+		get_changed_path_filter_version >actual &&
    ++		echo "options: bloom(1,10,7) read_generation_data" >expect &&
    ++		test-tool read-graph >full &&
    ++		grep options full >actual &&
     +		test_cmp expect actual)
     +'
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +
     +test_expect_success 'check value of version 2 changed-path' '
     +	(cd highbit2 &&
    -+		printf "c01f" >expect &&
    ++		echo "c01f" >expect &&
     +		get_first_changed_path_filter >actual &&
     +		test_cmp expect actual)
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +	git -C highbit2 commit-graph write --reachable --changed-paths &&
     +	(cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
    -+		printf "00000002" >expect &&
    -+		get_changed_path_filter_version >actual &&
    ++		echo "options: bloom(2,10,7) read_generation_data" >expect &&
    ++		test-tool read-graph >full &&
    ++		grep options full >actual &&
     +		test_cmp expect actual)
     +'
     +
-- 
2.41.0.487.g6d72f3e995-goog

