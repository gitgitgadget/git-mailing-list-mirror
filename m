Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F6C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiCWTyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiCWTya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 15:54:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F668B6FD
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:52:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i65so1958192qkd.7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aMG5vz9WfT2o4CvEK5bmQa6ATgSNN7p5kT/AMLzGwts=;
        b=jqlXkBrqCECkRWiKWz6fSqylQ1qCMY4fpwZcM0n/l3EYTT3sb+wY4CE4oXrAYFn9Hy
         6MZWh6RwxkvscPxGVKGYLGHr0A79bw1M26h5nhjFSSgo2SHwE36cMk+qTCnLUJML2rFO
         GSnvKHWAtobeXvSZPFFoYxxacgHIMIVDukoqkYOfVhvacYRvFIeS0rPZQa/tgtLqhqJ/
         Xv8lkYm3lwb7nKlI3ZVN0MdYOhxMq1Hg3u8ZfP2spmMhL2JojdXG2cNqmXneQ4KYxT2r
         B+eIc9V+kecMmzJMAD1O+PziuIMEGnMXtWmySJQHAlclDiWYi7CUVf/Cz2kTWCnIiGlP
         tj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aMG5vz9WfT2o4CvEK5bmQa6ATgSNN7p5kT/AMLzGwts=;
        b=O4ZcWlKuOlfCBZjfZHhjsCPEXKl+xMS/L6Savtw9mJ9vtBAyI/zYCXMTA/eGufJqzG
         bG4qKCrOpMeN+ybCtXC1oYZ2o98fXBUaaapco0DUM4t1dBDdn/QlkTwVyANAu1x/GBs2
         RP1l+wqwf8KXa8yqnmNvpLddFfGh+KEb9NqQDxOfRMem3PW7/wY2wxuedCSx2/UWHRnl
         a1dgLHXec5AHBNFBofKN8glu2o5fBKqLk74yXlEJDfGSn0Xg+Udp3mGpsYAhrmTyu3Y6
         zKkgWoD4S3CTNzV+wZuKQ7QtS/qkpdZv/xb5Z6OOJJX3QWzSTcIUKVjSuwUfGlcg9heu
         CC3g==
X-Gm-Message-State: AOAM532iXG9EgpmvBDdWQScd+sdoG3dIz0nksQiTWV3KD2rnXqSGY6xF
        IfGemFd2M96pLI7vTF4B4n1vyHQRSZbDRWJm
X-Google-Smtp-Source: ABdhPJxT0Zipy0s9H3n1VzEBZga6SEACvTxx8so4HchyNWdd1rmX58MUahay+N0brB1K9guOenGMAQ==
X-Received: by 2002:a05:620a:1903:b0:67d:243b:a8ae with SMTP id bj3-20020a05620a190300b0067d243ba8aemr1143331qkb.142.1648065177408;
        Wed, 23 Mar 2022 12:52:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b0067d15afb9ebsm503888qke.90.2022.03.23.12.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:52:57 -0700 (PDT)
Date:   Wed, 23 Mar 2022 15:52:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <Yjt6mLIfw0V3aVTO@nand.local>
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 03:22:13PM -0400, Derrick Stolee wrote:
> On 3/23/2022 2:03 PM, Josh Steadmon wrote:
> > prepare_repo_settings() initializes a `struct repository` with various
> > default config options and settings read from a repository-local config
> > file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
> > in git repos), prepare_repo_settings was changed to issue a BUG() if it
> > is called by a process whose CWD is not a Git repository. This approach
> > was suggested in [1].
> >
> > This breaks fuzz-commit-graph, which attempts to parse arbitrary
> > fuzzing-engine-provided bytes as a commit graph file.
> > commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> > since we run the fuzz tests without a valid repository, we are hitting
> > the BUG() from 44c7e62 for every test case.
> >
> > Fix this by refactoring prepare_repo_settings() such that it sets
> > default options unconditionally; if its process is in a Git repository,
> > it will also load settings from the local config. This eliminates the
> > need for a BUG() when not in a repository.
>
> I think you have the right idea and this can work.

Hmmm. To me this feels like bending over backwards in
`prepare_repo_settings()` to accommodate one particular caller. I'm not
necessarily opposed to it, but it does feel strange to make
`prepare_repo_settings()` a noop here, since I would expect that any
callers who do want to call `prepare_repo_settings()` are likely
convinced that they are inside of a repository, and it probably should
be a BUG() if they aren't.

I was initially thinking that Josh's alternative of introducing and
calling a lower-level version of `prepare_commit_graph()` that doesn't
require the use of any repository settings would make sense.

But when I started looking at implementing it, I became confused at how
this is supposed to work at all without using a repository. We depend on
the values parsed from:

  - commitGraph.generationVersion
  - commitGraph.readChangedPaths

to determine which part(s) of the commit graph we do and don't read.

Looking around, I think I probably inadvertently broke this in
ab14d0676c (commit-graph: pass a 'struct repository *' in more places,
2020-09-09). But prior to ab14d0676c, neither of those settings existed,
so parsing the commit graph was a pure function of the commit graph's
contents alone, and didn't rely on the existence of a repository.

We could pretend as if `commitGraph.generationVersion` is always "2" and
`commitGraph.readChangedPaths` is always "true", and I think that would
still give us good-enough coverage.

I assume that libFuzzer doesn't give us a convenient way to stub out a
repository. Maybe we should have a variant of `parse_commit_graph` that
instead takes a `struct repo_settings` filled out with the defaults?

We could use that to teach libFuzzer about additional states that the
commit graph parser can be in, too (though probably outside the scope of
this patch).

I tried to sketch all of this out, which seems to work. Let me know what
you think:

--- 8< ---

diff --git a/commit-graph.c b/commit-graph.c
index adffd020dd..3d5aa536c2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -96,13 +96,6 @@ define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
 static struct commit_graph_data_slab commit_graph_data_slab =
 	COMMIT_SLAB_INIT(1, commit_graph_data_slab);

-static int get_configured_generation_version(struct repository *r)
-{
-	int version = 2;
-	repo_config_get_int(r, "commitgraph.generationversion", &version);
-	return version;
-}
-
 uint32_t commit_graph_position(const struct commit *c)
 {
 	struct commit_graph_data *data =
@@ -335,6 +328,13 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,

 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size)
+{
+	prepare_repo_settings(r);
+	return parse_commit_graph_settings(&r->settings, graph_map, graph_size);
+}
+
+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
+						 void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
 	struct commit_graph *graph;
@@ -371,8 +371,6 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		return NULL;
 	}

-	prepare_repo_settings(r);
-
 	graph = alloc_commit_graph();

 	graph->hash_len = the_hash_algo->rawsz;
@@ -402,7 +400,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);

-	if (get_configured_generation_version(r) >= 2) {
+	if (s->commit_graph_generation_version >= 2) {
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			&graph->chunk_generation_data);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
@@ -412,7 +410,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 			graph->read_generation_data = 1;
 	}

-	if (r->settings.commit_graph_read_changed_paths) {
+	if (s->commit_graph_read_changed_paths) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
@@ -2299,7 +2297,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->opts = opts;
 	ctx->total_bloom_filter_data_size = 0;
-	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
+	ctx->write_generation_data = (r->settings.commit_graph_generation_version == 2);
 	ctx->num_generation_data_overflows = 0;

 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
diff --git a/commit-graph.h b/commit-graph.h
index 2e3ac35237..1fdca7a927 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -95,6 +95,8 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size);
+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
+					void *graph_map, size_t graph_size);

 /*
  * Return 1 if and only if the repository has a commit-graph
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index e7cf6d5b0f..07ef4643d8 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -11,7 +11,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	struct commit_graph *g;

 	initialize_the_repository();
-	g = parse_commit_graph(the_repository, (void *)data, size);
+	g = parse_commit_graph_settings(the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);

diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..a7e5d10b27 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -10,6 +10,13 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 		*dest = def;
 }

+static void repo_cfg_int(struct repository *r, const char *key, int *dest,
+			 int def)
+{
+	if (repo_config_get_int(r, key, dest))
+		*dest = def;
+}
+
 void prepare_repo_settings(struct repository *r)
 {
 	int experimental;
@@ -43,6 +50,7 @@ void prepare_repo_settings(struct repository *r)

 	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
+	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
 	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
diff --git a/repository.h b/repository.h
index e29f361703..6c40ea3f1b 100644
--- a/repository.h
+++ b/repository.h
@@ -29,6 +29,7 @@ struct repo_settings {
 	int initialized;

 	int core_commit_graph;
+	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;

--- >8 ---

Thanks,
Taylor
