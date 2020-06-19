Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DACC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B4220DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOLV+axR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbgFSOCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbgFSOCf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 10:02:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14427C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:02:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so9762275wru.12
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ar6EuACWjUK7Mkh/PsMCfRupG3K12f4cvyStKdI5sZ4=;
        b=NOLV+axR/5Y5OxFHOXrNkO7WMAJkjVDuiIRgx8AO5SzNiu/27A2ruUVewhGhFoV/LI
         FVX/wqPSbGB4qpOAFrpiJTpvwwJ/f02swFGH8qvOtNc6EiJfx29j9pR7qq74fYo4GldV
         DgyDUEXd0L0EOU57IlQ3jvWne6gMV1oLjD/fDHxFxgUBucdKBbEMHZVF0ZrwBcYfgX56
         tNdIs+RKlFPcr45GI+m0M+FGeDocP3h9chtj+BcJkuvV1q7dgArf6bs8Jj2alujWtTRJ
         nkjpZThmNVyVCb1O4loct02qevidbl+3YGxpgj33/PGaor1in1HHoA+UAYlpYP6T6uKM
         9nJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ar6EuACWjUK7Mkh/PsMCfRupG3K12f4cvyStKdI5sZ4=;
        b=p5BVNYFbX2OthL4w/k53zGMC+4YLmKGzXDa+uNt1xInKnLjap9mm4KtfmJ7b2zF+HO
         s6zb1zk0s5OkJvp8mBXkp+8qTpDripDoFbiausP+dfbZUEW8Ouoh99X421qey3WaAwpW
         wGUL0LIXnsHn4SLK/m/UrFVyFICHRa0Fo+CxEq2+VAwp6LtURcYBmvvjhJlr32kl35+F
         0XIQxFIjEnaZpk99YS9WnrviW6dsNDvk7wjqp7rwaEPhV9+/Nq15KuD7J0p2z2cKp/JG
         hIkbNQ1Ymp0YKp4CphJ7jDKCR8xoKpHdY0CcnqwSdUg0EXRwXgs/4ljG1rvN2jBW6mOP
         /XFg==
X-Gm-Message-State: AOAM532ZZOIbwfqji51Ww4E04TGSbxtOU4kFFCrE/lBrTx9IEYhSPJxe
        OgzsCJz2bt/gP6cZZnL3VjA=
X-Google-Smtp-Source: ABdhPJwqYdlsI9tpaVIynuTubh52DjcxVZnwYvRY8mK7RppBHFA8VAtAcbL8RfPKYxNq2e39LN42eQ==
X-Received: by 2002:adf:9788:: with SMTP id s8mr2431673wrb.19.1592575353521;
        Fri, 19 Jun 2020 07:02:33 -0700 (PDT)
Received: from szeder.dev (62-165-236-97.pool.digikabel.hu. [62.165.236.97])
        by smtp.gmail.com with ESMTPSA id h203sm6825489wme.37.2020.06.19.07.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:02:32 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:02:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 10/15] commit-graph: reuse existing Bloom filters
 during write
Message-ID: <20200619140230.GB22200@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <cc8022bdf82d0ada326ad546fdd7bb7801fc3675.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc8022bdf82d0ada326ad546fdd7bb7801fc3675.1586192395.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:59:50PM +0000, Garima Singh via GitGitGadget wrote:
> From: Garima Singh <garima.singh@microsoft.com>
> 
> Add logic to
> a) parse Bloom filter information from the commit graph file and,
> b) re-use existing Bloom filters.
> 
> See Documentation/technical/commit-graph-format for the format in which
> the Bloom filter information is written to the commit graph file.
> 
> To read Bloom filter for a given commit with lexicographic position
> 'i' we need to:
> 1. Read BIDX[i] which essentially gives us the starting index in BDAT for
>    filter of commit i+1. It is essentially the index past the end
>    of the filter of commit i. It is called end_index in the code.
> 
> 2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT
>    for filter of commit i. It is called the start_index in the code.
>    For the first commit, where i = 0, Bloom filter data starts at the
>    beginning, just past the header in the BDAT chunk. Hence, start_index
>    will be 0.
> 
> 3. The length of the filter will be end_index - start_index, because
>    BIDX[i] gives the cumulative 8-byte words including the ith
>    commit's filter.
> 
> We toggle whether Bloom filters should be recomputed based on the
> compute_if_not_present flag.

A very important question is not discussed here: when should we
recompute Bloom filters?

> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  bloom.c               | 49 ++++++++++++++++++++++++++++++++++++++++++-
>  bloom.h               |  4 +++-
>  commit-graph.c        |  6 +++---
>  t/helper/test-bloom.c |  2 +-
>  4 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/bloom.c b/bloom.c
> index a16eee92331..0f714dd76ae 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -4,6 +4,8 @@
>  #include "diffcore.h"
>  #include "revision.h"
>  #include "hashmap.h"
> +#include "commit-graph.h"
> +#include "commit.h"
>  
>  define_commit_slab(bloom_filter_slab, struct bloom_filter);
>  
> @@ -26,6 +28,36 @@ static inline unsigned char get_bitmask(uint32_t pos)
>  	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
>  }
>  
> +static int load_bloom_filter_from_graph(struct commit_graph *g,
> +				   struct bloom_filter *filter,
> +				   struct commit *c)
> +{
> +	uint32_t lex_pos, start_index, end_index;
> +
> +	while (c->graph_pos < g->num_commits_in_base)
> +		g = g->base_graph;
> +
> +	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
> +	if (!g->chunk_bloom_indexes)
> +		return 0;
> +
> +	lex_pos = c->graph_pos - g->num_commits_in_base;
> +
> +	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
> +
> +	if (lex_pos > 0)
> +		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
> +	else
> +		start_index = 0;
> +
> +	filter->len = end_index - start_index;
> +	filter->data = (unsigned char *)(g->chunk_bloom_data +
> +					sizeof(unsigned char) * start_index +
> +					BLOOMDATA_CHUNK_HEADER_SIZE);
> +
> +	return 1;
> +}
> +
>  /*
>   * Calculate the murmur3 32-bit hash value for the given data
>   * using the given seed.
> @@ -127,7 +159,8 @@ void init_bloom_filters(void)
>  }
>  
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c)
> +				      struct commit *c,
> +					  int compute_if_not_present)
>  {
>  	struct bloom_filter *filter;
>  	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;

This line in the hunk context sets the default parameters with which
this process will compute any new changed path Bloom filters.

Note that this is not the settings instance that eventually gets
written to the header of the Bloom filters chunk:
write_commit_graph_file() has its own 'struct bloom_filter_settings'
instance, and that's the one that goes into the chunk header.

> @@ -140,6 +173,20 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  
>  	filter = bloom_filter_slab_at(&bloom_filters, c);
>  
> +	if (!filter->data) {
> +		load_commit_graph_info(r, c);
> +		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
> +			r->objects->commit_graph->chunk_bloom_indexes) {
> +			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
> +				return filter;
> +			else
> +				return NULL;
> +		}
> +	}

And in the above conditions we try to load the existing Bloom filter
for the given commit and return it as-is for reuse if it already
exists, or go on to compute a new Bloom filter with the parameters set
at the beginning of the function.

Unfortunately, the parameters used to compute the now reused Bloom
filters are not checked anywhere.  In fact this writing process
entirely ignores all parameters in the header of the existing Bloom
filters chunk, and simply replaces them with the default parameters
hard-coded in write_commit_graph_file().  Consequently, we can end up
with Bloom filters computed with different parameters in the same
commit-graph file, which, in turn, can result in commits omitted from
the output of pathspec-limited revision walks.

The makeshift (there is no way to override those hard-coded defaults)
tests below demonstrate this issue.

This issue raises a good couple of questions:

  - What should we do when updating a commit-graph that was written
    with different Bloom filter parameters than our hardcoded
    defaults?

    Reusing the exising Bloom filters is clearly wrong.  Throwing away
    all existing Bloom filters and recomputing them with our defaults
    parameters doesn't seem to be good option, because that's a
    considerable amount of work, and the user might have a reason to
    chose those parameters.

  - What should we do when updating a commit-graph that was written
    with different Bloom filter parameters than specified by the user
    on the command line or in the config?

    Wipe out the old Bloom filters and recompute with new parameters,
    spending considerable time in bigger repositories?  Or stop with a
    warning about the different parameters (maybe it's just a typo),
    and require '--force'?
    
    Dunno, and we don't have such options and configuration yet
    anyway.

  - What about split commit-graphs?

    When split commit-graphs were introduced there was not a single
    chunk that had its own header.  Now the Bloom filters chunk does
    have a header, which leads to other questions:

    - Should that Bloom filters header be included in every split
      commit-graph?

      Not sure, but I suppose that having a header in each split
      commit-graph file would make loading and parsing that chunk a
      bit simpler, because all of them should be parsed the same way.
      Anyway, I think the specs should be explicit about it.  But...:

    - Should we allow different parameters in the Bloom filter chunks
      in each split commit-graph?

      The point of split commit-graphs is to avoid the overhead of
      re-writing the whole commit-graph file every time new commits
      are added, and it's crucial that both writing and merging split
      commit-graph files are cheap.  However, split commit-graph files
      using different Bloom filter parameters can't be merged without
      recomputing those Bloom filters, making merging quite expensive.

      So I don't think that it's a good idea to allow different Bloom
      filter parameters in split commit-graphs.  But then perhaps it
      would be better not to have a Bloom filter chunk header in all
      split commit-graph files after all.

    In any case, the last test below shows that the Bloom filter
    parameters are only read from the header of the most recent split
    commit-graph file.


  ---  >8  ---

#!/bin/sh

test_description='test'

. ./test-lib.sh

test_expect_success 'yuckiest setup ever!' '
	(
		cd "$GIT_BUILD_DIR" &&

		# The number of hashes per path cannot be configured
		# at runtime, so build a dedicated git binary that
		# writes Bloom filters using only 6 hashes per path.
		sed -i -e "/DEFAULT_BLOOM_FILTER_SETTINGS/ s/7/6/" bloom.h &&
		make -j4 git &&
		cp git git6 &&

		# Revert, rebuild.
		sed -i -e "/DEFAULT_BLOOM_FILTER_SETTINGS/ s/6/7/" bloom.h &&
		make -j4 git
	) &&
	git6="$GIT_BUILD_DIR"/git6
'

test_expect_success 'setup' '
	# We need a filename whose 7th hash maps to a different bit
	# position than any of its first 6 hashes in a 2-byte Bloom
	# filter.
	file=File &&

	test_tick &&
	git commit --allow-empty -m initial &&
	echo 1 >$file &&
	git add $file &&
	git commit -m one $file &&
	echo 2 >$file &&
	git commit -m two $file &&

	git log --oneline -- $file >expect
'

test_expect_success 'can read Bloom filters with different parameters' '
	test_when_finished "rm -rfv .git/objects/info/commit-graph*" &&

	# Write a commit-graph with Bloom filters using only 6 hashes
	# per path.
	"$git6" commit-graph write --reachable --changed-paths &&

	# Try pathspec-limited revision walk with the git binary writing
	# Bloom filters using 7 hashes: it still works, because no matter
	# how many hashes it would use when writing the commit-graph, the
	# reader part respects the nr of hashes stored in the
	# commit-graph file.  So far so good.
	git log --oneline $file >actual &&
	test_cmp expect actual
'

test_expect_failure 'commit-graph write does not reuse Bloom filters with different parameters' '
	test_when_finished "rm -rfv .git/objects/info/commit-graph*" &&

	# Write a commit-graph with Bloom filters using only 6 hashes
	# per path for a subset of commits.
	git rev-parse HEAD^ |
	"$git6" commit-graph write --stdin-commits --changed-paths &&

	# Add the rest of the commits to the commit-graph containing Bloom
	# filters using 6 hashes with a git version that writes Bloom
	# filters using 7 hashes.
	# Does it reuse the existing Bloom filters with 6 hashes?
	git commit-graph write --reachable --changed-paths &&

	# Yes, it does, because these report different filter data,
	# even though both commits modified the same file.
	test-tool bloom get_filter_for_commit $(git rev-parse HEAD^) &&
	test-tool bloom get_filter_for_commit $(git rev-parse HEAD) &&

	# Furthermore, it updated the Bloom filter chunk header as well,
	# which now stores that all Bloom filters use 7 hashes.
	# Consequently, the first commit whose Bloom filter was written
	# with only 6 hashes falls victim of a false negative, and is
	# omitted from the output.
	git log --oneline $file >actual &&
	test_cmp expect actual
'

test_expect_failure 'split commit-graphs and Bloom filters with different parameters' '
	test_when_finished "rm -rfv .git/objects/info/commit-graph*" &&

	git rev-parse HEAD^ |
	"$git6" commit-graph write --stdin-commits --changed-paths --split &&

	git commit-graph write --reachable --changed-paths --split=no-merge &&

	# To make sure that I test what I want, i.e. two commit-graphs
	# with one commit in each.  (Though "test-tool read-graph" is
	# utterly oblivious to split commit graphs...)
	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain &&
	verbose test "$(test-tool read-graph |sed -n -e "s/^num_commits: //p")" = 1 &&

	test-tool bloom get_filter_for_commit $(git rev-parse HEAD^) &&
	test-tool bloom get_filter_for_commit $(git rev-parse HEAD) &&

	git log --oneline $file >actual &&
	test_cmp expect actual
'

test_done

  ---  8<  ---

> +	if (filter->data || !compute_if_not_present)
> +		return filter;
> +
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
>  	diffopt.max_changes = max_changes;
> diff --git a/bloom.h b/bloom.h
> index 85ab8e9423d..760d7122374 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -32,6 +32,7 @@ struct bloom_filter_settings {
>  
>  #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
>  #define BITS_PER_WORD 8
> +#define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)
>  
>  /*
>   * A bloom_filter struct represents a data segment to
> @@ -79,6 +80,7 @@ void add_key_to_filter(const struct bloom_key *key,
>  void init_bloom_filters(void);
>  
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c);
> +				      struct commit *c,
> +				      int compute_if_not_present);
>  
>  #endif
> \ No newline at end of file
> diff --git a/commit-graph.c b/commit-graph.c
> index a8b6b5cca5d..77668629e27 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1086,7 +1086,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
>  			ctx->commits.nr);
>  
>  	while (list < last) {
> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
>  		cur_pos += filter->len;
>  		display_progress(progress, ++i);
>  		hashwrite_be32(f, cur_pos);
> @@ -1115,7 +1115,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
>  	hashwrite_be32(f, settings->bits_per_entry);
>  
>  	while (list < last) {
> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
>  		display_progress(progress, ++i);
>  		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
>  		list++;
> @@ -1296,7 +1296,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		struct commit *c = sorted_commits[i];
> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
>  		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
>  		display_progress(progress, i + 1);
>  	}
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index f18d1b722e1..ce412664ba9 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -39,7 +39,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
>  	struct bloom_filter *filter;
>  	setup_git_directory();
>  	c = lookup_commit(the_repository, commit_oid);
> -	filter = get_bloom_filter(the_repository, c);
> +	filter = get_bloom_filter(the_repository, c, 1);
>  	print_bloom_filter(filter);
>  }
>  
> -- 
> gitgitgadget

