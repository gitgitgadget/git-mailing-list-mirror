Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB3C55179
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 11:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319F9206C1
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 11:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+E0qfGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgKFL2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 06:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFL2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 06:28:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24850C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 03:28:09 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f38so720094pgm.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 03:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lbY28jCrTmjIhu1zU0/KRevbPmmr/lHh5CyhRSnh+3E=;
        b=i+E0qfGGEFBaXuy/J0MEwQuwvPFzz3RVSAl4bZPPijAAAzyx7yFmKaC3khdzKxK1s8
         M6zYPdXs7T+OaDqj1BvBPolYUlhyS7T3w1eF/BCdtyB46Jr3GM3bB7rBbkyMeKIuHhg/
         YBFKMMtpwHf8iKPMeGjdCS5UgeZ1jM0hWdyZxQsFy9322oeilFkv1aYHbasZgTuvlk63
         mKH+x/vWYn5ixWgIPc0Hh6hewvbs6kbRKPzs1B3nHYYFqmnwPO6GYPG5JvlZaoADnzJl
         Z1k4wD6zxEfkITzbb9UUbTOqdrIzzjKFdtnDVnRxErZV/jRb28CwUr9dhqjFwxidbjtx
         2XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=lbY28jCrTmjIhu1zU0/KRevbPmmr/lHh5CyhRSnh+3E=;
        b=MNalJG8rd2L/6BcQFGc7ToDpqH2g0cIS8muvqz0GOqzcdXISt51c44XeO10PnT2SqI
         M9PRL3JOUq7t0v62V8T7K4oy+FAqDWzac/3B9OzdMuLSl7HuL5i0H1viN8fAOpvb4duv
         PoVFEhhxbIkdzLk4o9Z664Rl2RDw1aexeTwvcS/KNeoLdW6EuMPt2lHfYygAJLZcuEzP
         E4Z7VOKFhTDLK9r1T3gcPquTUQzkK6k4jCZHZvhYXuDz1rPHBONqWgPL29Od4g0EjC8q
         bLcZhohn908N18QWUTt606KxzaTlCgx3Wg/opydOMINMtMzYqeKcS8u9lQZhC9azb2it
         KuFA==
X-Gm-Message-State: AOAM5307HPho1UyVMA+U09F5TxZGvMoX6QrnEl+/EhSjcF5EuoLxXCBt
        3/Bpjh30k6mdHPJ2eiJwvg7bACbRKBHyyg==
X-Google-Smtp-Source: ABdhPJyCWqc29DZx3gmJQ0HcM4e/csPfUFtjzd/oY7Y74RWKrRnjMz7onj4ykJ7J8QDKIyRXNmpTiA==
X-Received: by 2002:a62:8f8b:0:b029:164:9e98:c0e with SMTP id n133-20020a628f8b0000b02901649e980c0emr1490574pfd.80.1604662088255;
        Fri, 06 Nov 2020 03:28:08 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:4dbf:b1cf:d5a4:8c66:57:d9f9])
        by smtp.gmail.com with ESMTPSA id t24sm2569760pjw.1.2020.11.06.03.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:28:07 -0800 (PST)
Date:   Fri, 6 Nov 2020 16:55:13 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 07/10] commit-graph: implement generation data chunk
Message-ID: <20201106112513.GA1553@Abhishek-Arch>
Reply-To: 854kmbx4pi.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <b903efe2ea11bc0b7e1ef8f239ed34f72caa4f03.1602079786.git.gitgitgadget@gmail.com>
 <854kmbx4pi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <854kmbx4pi.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 01:45:29PM +0100, Jakub Narębski wrote:
> 
> ...
>
> >
> > While storing corrected commit date offset instead of the corrected
> > commit date saves us 4 bytes per commit, it's possible for the offsets
> > to overflow the 4-bytes allocated. As such overflows are exceedingly
> > rare, we use the following overflow management scheme:
> 
> Perhaps it would be good idea to write the idea in full from start, as
> the commit message is intended to be read stadalone and not in the
> context of the patch series.  On the other hand it might be too much
> detail in already [necessarily] lengthty commit message.
> 
> Perhaps something like the following proposal would read better.
> 
>   To minimize the space required to store corrected commit date, Git
>   stores corrected commit date offsets into the commit-graph file,
>   instead of corrected commit dates themselves. This saves us 4 bytes
>   per commit, decreasing the GDAT chunk size by half, but it's possible
>   for the offset to overflow the 4-bytes allocated for storage. As such
>   overflows are and should be exceedingly rare, we use the following
>   overflow management scheme:
>

Thanks, that's better.

> 
> ...
>
> > We test the overflow-related code with the following repo history:
> >
> >            F - N - U
> >           /         \
> > U - N - U            N
> >          \          /
> >            N - F - N
> 
> Do we need such complex history? I guess we need to test the handling of
> merge commits too.
> 

I wanted to test three cases - a root epoch zero commit, a commit that's
far enough in past to overflow the offset and a commit that's far enough
in the future to overflow the offset.

> >
> > Where the commits denoted by U have committer date of zero seconds
> > since Unix epoch, the commits denoted by N have committer date of
> > 1112354055 (default committer date for the test suite) seconds since
> > Unix epoch and the commits denoted by F have committer date of
> > (2 ^ 31 - 2) seconds since Unix epoch.
> >
> > The largest offset observed is 2 ^ 31, just large enough to overflow.
> >
> > [1]: https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c                | 98 +++++++++++++++++++++++++++++++++--
> >  commit-graph.h                |  3 ++
> >  commit.h                      |  1 +
> >  t/README                      |  3 ++
> >  t/helper/test-read-graph.c    |  4 ++
> >  t/t4216-log-bloom.sh          |  4 +-
> >  t/t5318-commit-graph.sh       | 70 ++++++++++++++++++++-----
> >  t/t5324-split-commit-graph.sh | 12 ++---
> >  t/t6600-test-reach.sh         | 68 +++++++++++++-----------
> >  9 files changed, 206 insertions(+), 57 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 03948adfce..71d0b243db 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -38,11 +38,13 @@ void git_test_write_commit_graph_or_die(void)
> >  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> >  #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
> >  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
> > +#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
> > +#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f56 /* "GDOV" */
> >  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
> >  #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
> >  #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
> >  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> > -#define MAX_NUM_CHUNKS 7
> > +#define MAX_NUM_CHUNKS 9
> 
> All right.
> 
> >  
> >  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
> >  
> > @@ -61,6 +63,8 @@ void git_test_write_commit_graph_or_die(void)
> >  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
> >  			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
> >  
> > +#define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
> > +
> 
> All right, though the naming convention is different from the one used
> for EDGE chunk: GRAPH_EXTRA_EDGES_NEEDED and GRAPH_EDGE_LAST_MASK.
> 
> >  /* Remember to update object flag allocation in object.h */
> >  #define REACHABLE       (1u<<15)
> >  
> > @@ -385,6 +389,20 @@ struct commit_graph *parse_commit_graph(struct repository *r,
> >  				graph->chunk_commit_data = data + chunk_offset;
> >  			break;
> >  
> > +		case GRAPH_CHUNKID_GENERATION_DATA:
> > +			if (graph->chunk_generation_data)
> > +				chunk_repeated = 1;
> > +			else
> > +				graph->chunk_generation_data = data + chunk_offset;
> > +			break;
> > +
> > +		case GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW:
> > +			if (graph->chunk_generation_data_overflow)
> > +				chunk_repeated = 1;
> > +			else
> > +				graph->chunk_generation_data_overflow = data + chunk_offset;
> > +			break;
> > +
> 
> Necessary but unavoidable boilerplate for adding new chunks to the
> commit-graph file format.  All right.
> 
> >  		case GRAPH_CHUNKID_EXTRAEDGES:
> >  			if (graph->chunk_extra_edges)
> >  				chunk_repeated = 1;
> > @@ -745,8 +763,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
> >  {
> >  	const unsigned char *commit_data;
> >  	struct commit_graph_data *graph_data;
> > -	uint32_t lex_index;
> > -	uint64_t date_high, date_low;
> > +	uint32_t lex_index, offset_pos;
> > +	uint64_t date_high, date_low, offset;
> 
> All right, we are adding two new variables: `offset` to read data stored
> in GDAT chunk, and `offset_pos` to help read data from GDOV chunk if
> necessary i.e. to handle overflow in corrected commit data offset
> storage.
> 
> >  
> >  	while (pos < g->num_commits_in_base)
> >  		g = g->base_graph;
> > @@ -764,7 +782,16 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
> >  	date_low = get_be32(commit_data + g->hash_len + 12);
> >  	item->date = (timestamp_t)((date_high << 32) | date_low);
> >  
> > -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> > +	if (g->chunk_generation_data) {
> > +		offset = (timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
> 
> Style: why space after the `(timestamp_t)` cast operator?
> 
> Though CodingGuidelines do not say anything on this topic... perhaps the
> space after cast operator makes it more readable?
> 
> > +
> > +		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
> 
> All right, so the CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW is equivalent of
> GRAPH_EXTRA_EDGES_NEEDED.
> 
> > +			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
> 
> Hmmm... instead of using bitwise and on an equivalent to the
> GRAPH_EDGE_LAST_MASK, we utilize the fact that we know that the MSB bit
> is set, so we can clear it with bitwise xor.  Clever trick.
>
> 
> > +			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
> > +		} else
> > +			graph_data->generation = item->date + offset;
> 
> All right, this handles the case when we have generation number v2, with
> or without overflow.
> 
> > +	} else
> > +		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> 
> All right, this handles the case where we have only generation number
> v1, like for commit-graph file written by old Git.
> 
> >  
> >  	if (g->topo_levels)
> >  		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
> > @@ -942,6 +969,7 @@ struct write_commit_graph_context {
> >  	struct packed_oid_list oids;
> >  	struct packed_commit_list commits;
> >  	int num_extra_edges;
> > +	int num_generation_data_overflows;
> >  	unsigned long approx_nr_objects;
> >  	struct progress *progress;
> >  	int progress_done;
> > @@ -960,7 +988,8 @@ struct write_commit_graph_context {
> >  		 report_progress:1,
> >  		 split:1,
> >  		 changed_paths:1,
> > -		 order_by_pack:1;
> > +		 order_by_pack:1,
> > +		 write_generation_data:1;
> >  
> >  	struct topo_level_slab *topo_levels;
> >  	const struct commit_graph_opts *opts;
> 
> All right, this adds necessary fields to `struct write_commit_graph_context`.
> 
> > @@ -1120,6 +1149,44 @@ static int write_graph_chunk_data(struct hashfile *f,
> >  	return 0;
> >  }
> >  
> > +static int write_graph_chunk_generation_data(struct hashfile *f,
> > +					      struct write_commit_graph_context *ctx)
> > +{
> > +	int i, num_generation_data_overflows = 0;
> 
> Minor nitpick: in my opinion there should be empty line here, between
> the variables declaration and the code... however not all
> write_graph_chunk_*() functions have it.
> 
> > +	for (i = 0; i < ctx->commits.nr; i++) {
> > +		struct commit *c = ctx->commits.list[i];
> > +		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
> > +		display_progress(ctx->progress, ++ctx->progress_cnt);
> 
> All right.
> 
> > +
> > +		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
> > +			offset = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_overflows;
> > +			num_generation_data_overflows++;
> > +		}
> 
> Hmmm... shouldn't we store these commits that need overflow handling
> (with corrected commit date offset greater than GENERATION_NUMBER_V2_OFFSET_MAX)
> in a list or a queue, to remember them for writing GDOV chunk?
> 

We could, although write_graph_chunk_extra_edges() (just like this function)
prefers to iterate over all commits again. Both octopus merges and
overflowing corrected commit dates are exceedingly rare, might be
worthwhile to trade some memory to avoid looping again.

> We could store oids, or we could store commits themselves, for example:
> 
> 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
> 			offset = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_overflows;
> 			num_generation_data_overflows++;
> 
> 			ALLOC_GROW(ctx->gdov_commits.list, ctx->gdov_commits.nr + 1, ctx->gdov_commits.alloc);
> 			ctx->commits.list[ctx->gdov_commits.nr] = c;
>             ctx->gdov_commits.nr++;
> 		}
> 
> Though in the above proposal we could get rid of `num_generation_data_overflows`, 
> as it should be the same as `ctx->gdov_commits.nr`.
> 
> I have called the extra commit list member of write_commit_graph_context
> `gdov_commits`, but perhaps a better name would be `commits_gen_v2_overflow`, 
> or similar more descriptive name.
> 
> > +
> > +		hashwrite_be32(f, offset);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> All right.
> 
> > +
> > +static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
> > +						       struct write_commit_graph_context *ctx)
> > +{
> > +	int i;
> > +	for (i = 0; i < ctx->commits.nr; i++) {
> 
> Here we loop over *all* commits again, instead of looping over those
> very rare commits that need overflow handling for their corrected commit
> date data.
> 
> Though this possible performance issue^* could be fixed in the future commit.
> 
> *) It needs to be actually benchmarked which version is faster.
> 
> ...
> 
> >  
> >  graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
> > @@ -454,8 +454,9 @@ test_expect_success 'warn on improper hash version' '
> >  
> >  test_expect_success 'git commit-graph verify' '
> >  	cd "$TRASH_DIRECTORY/full" &&
> > -	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
> > -	git commit-graph verify >output
> > +	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --stdin-commits &&
> > +	git commit-graph verify >output &&
> 
> All right, this simply adds GIT_TEST_COMMIT_GRAPH_NO_GDAT=1.  I assume
> this is needed because this test is also setup for the following commits
> _without_ even saying that in the test name (bad practice, in my
> opinion), and the comment above this test says the following:
> 
>   # the verify tests below expect the commit-graph to contain
>   # exactly the commits reachable from the commits/8 branch.
>   # If the file changes the set of commits in the list, then the
>   # offsets into the binary file will result in different edits
>   # and the tests will likely break.
> 
> So the following tests are fragile (though perhaps unavoidably fragile),
> and without this change they would not work, I assume.
> 
> > +	graph_read_expect 9 extra_edges
> 
> I guess that this is here to check that GIT_TEST_COMMIT_GRAPH_NO_GDAT=1
> work as intended, and that the following "verify" tests wouldn't break.
> I understand its necessity, even if I don't quite like having a test
> that checks multiple things.  This is a minor issue, though.
> 
> All right.
> 
> 
> We might want to have a separate test that checks that we get
> commit-graph with and without GDAT chunk depending on whether we use
> GIT_TEST_COMMIT_GRAPH_NO_GDAT=1.  On the other hand, this environment
> variable is there purely for tests, so the question is should we test
> the test infrastructure?
> 


> >  '
> >  
> >  NUM_COMMITS=9
> > @@ -741,4 +742,47 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
> >  	)
> >  '
> >  
> > +test_commit_with_date() {
> > +  file="$1.t" &&
> > +  echo "$1" >"$file" &&
> > +  git add "$file" &&
> > +  GIT_COMMITTER_DATE="$2" GIT_AUTHOR_DATE="$2" git commit -m "$1"
> > +  git tag "$1"
> > +}
> 
> Here we add a helper function.  All right.
> 
> I wonder though if it wouldn't be a better idea to add `--date <date>`
> option to the test_commit() function in test-lib-functions.sh (which
> option would set GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, and also
> set notick=yes).
> 

Yes, that's a better idea - I didn't know how to change test_commit()
well enough to tinker with what's working.

> For example:
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f1ae935fee..a1f9a2b09b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -202,6 +202,12 @@ test_commit () {
>  		--signoff)
>  			signoff="$1"
>  			;;
> +        --date)
> +            notick=yes
> +            GIT_COMMITTER_DATE="$2"
> +            GIT_AUTHOR_DATE="$2"
> +            shift
> +            ;;
>  		-C)
>  			indir="$2"
>  			shift
> 
> 
> > +
> 
> It would be nice to have there comment describing the shape of the
> revision history we generate here, that currenly is present only in the
> commmit message.
> 
> # We test the overflow-related code with the following repo history:
> #
> #               4:F - 5:N - 6:U
> #              /               \
> # 1:U - 2:N - 3:U               M:N
> #              \               /
> #               7:N - 8:F - 9:N
> #
> # Here the commits denoted by U have committer date of zero seconds
> # since Unix epoch, the commits denoted by N have committer date
> # starting from 1112354055 seconds since Unix epoch (default committer
> # date for the test suite), and the commits denoted by F have committer
> # date of (2 ^ 31 - 2) seconds since Unix epoch.
> #
> # The largest offset observed is 2 ^ 31, just large enough to overflow.
> #

Yes, it would. Added.
> 
> > +test_expect_success 'overflow corrected commit date offset' '
> > +	objdir=".git/objects" &&
> > +	UNIX_EPOCH_ZERO="1970-01-01 00:00 +0000" &&
> > +	FUTURE_DATE="@2147483646 +0000" &&
> 
> It is a bit funny to see UNIX_EPOCH_ZERO spelled one way, and
> FUTURE_DATE other way.
> 
> Wouldn't be more readable to use UNIX_EPOCH_ZERO="@0 +0000"?

It would, for some reason - I couldn't figure out the valid format for
this. Changed.

> 
> > +	test_oid_cache <<-EOF &&
> > +	oid_version sha1:1
> > +	oid_version sha256:2
> > +	EOF
> > +	cd "$TRASH_DIRECTORY" &&
> > +	mkdir repo &&
> > +	cd repo &&
> > +	git init &&
> > +	test_commit_with_date 1 "$UNIX_EPOCH_ZERO" &&
> > +	test_commit 2 &&
> > +	test_commit_with_date 3 "$UNIX_EPOCH_ZERO" &&
> > +	git commit-graph write --reachable &&
> > +	graph_read_expect 3 generation_data &&
> > +	test_commit_with_date 4 "$FUTURE_DATE" &&
> > +	test_commit 5 &&
> > +	test_commit_with_date 6 "$UNIX_EPOCH_ZERO" &&
> > +	git branch left &&
> > +	git reset --hard 3 &&
> > +	test_commit 7 &&
> > +	test_commit_with_date 8 "$FUTURE_DATE" &&
> > +	test_commit 9 &&
> > +	git branch right &&
> > +	git reset --hard 3 &&
> > +	git merge left right &&
> 
> We have test_merge() function in test-lib-functions.sh, perhaps we
> should use it here.
> 
> > +	git commit-graph write --reachable &&
> > +	graph_read_expect 10 "generation_data generation_data_overflow" &&
> 
> All right, we write the commit-graph and check that it has both GDAT and
> GDOV chunks present.
> 
> > +	git commit-graph verify
> 
> All right, we checks that created commit graph with GDAT and GDOV passes
> 'git commit-graph verify` checks.
> 
> > +'
> > +
> > +graph_git_behavior 'overflow corrected commit date offset' repo left right
> 
> All right, here we compare the Git behavior with the commit-graph to the
> behavior without it... however I think that those two tests really
> should have distinct (different) test names. Currently they both use
> 'overflow corrected commit date offset'.
> 

Following the earlier tests, the first test could be "set up and verify
repo with generation data overflow chunk" and the git behavior test can
be "generation data overflow chunk repo"

> > +
> >  test_done
> > diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> > index c334ee9155..651df89ab2 100755
> > --- a/t/t5324-split-commit-graph.sh
> > +++ b/t/t5324-split-commit-graph.sh
> > @@ -13,11 +13,11 @@ test_expect_success 'setup repo' '
> >  	infodir=".git/objects/info" &&
> >  	graphdir="$infodir/commit-graphs" &&
> >  	test_oid_cache <<-EOM
> > -	shallow sha1:1760
> > -	shallow sha256:2064
> > +	shallow sha1:2132
> > +	shallow sha256:2436
> >  
> > -	base sha1:1376
> > -	base sha256:1496
> > +	base sha1:1408
> > +	base sha256:1528
> >  
> >  	oid_version sha1:1
> >  	oid_version sha256:2
> > @@ -31,9 +31,9 @@ graph_read_expect() {
> >  		NUM_BASE=$2
> >  	fi
> >  	cat >expect <<- EOF
> > -	header: 43475048 1 $(test_oid oid_version) 3 $NUM_BASE
> > +	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
> >  	num_commits: $1
> > -	chunks: oid_fanout oid_lookup commit_metadata
> > +	chunks: oid_fanout oid_lookup commit_metadata generation_data
> >  	EOF
> >  	test-tool read-graph >output &&
> >  	test_cmp expect output
> 
> All right, we now expect the commit graph to include the GDAT chunk...
> though shouldn't be there old expected value for no GDAT, for future
> tests?  But perhaps this is not necessary.
> 
> Note that I have not checked the details, but it looks OK to me.
> 
> > diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> > index f807276337..e2d33a8a4c 100755
> > --- a/t/t6600-test-reach.sh
> > +++ b/t/t6600-test-reach.sh
> > @@ -55,10 +55,13 @@ test_expect_success 'setup' '
> >  	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
> >  	mv .git/objects/info/commit-graph commit-graph-half &&
> >  	chmod u+w commit-graph-half &&
> > +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable &&
> > +	mv .git/objects/info/commit-graph commit-graph-no-gdat &&
> > +	chmod u+w commit-graph-no-gdat &&
> 
> All right, this prepares for testing one more mode.  The run_all_modes()
> function would test the following cases:
>  - no commit-graph
>  - commit-graph for all commits, with GDAT
>  - commit-graph with half of commits, with GDAT
>  - commit-graph for all commits, without GDAT
> 
> >  	git config core.commitGraph true
> >  '
> >  
> > -run_three_modes () {
> > +run_all_modes () {
> >  	test_when_finished rm -rf .git/objects/info/commit-graph &&
> >  	"$@" <input >actual &&
> >  	test_cmp expect actual &&
> > @@ -67,11 +70,14 @@ run_three_modes () {
> >  	test_cmp expect actual &&
> >  	cp commit-graph-half .git/objects/info/commit-graph &&
> >  	"$@" <input >actual &&
> > +	test_cmp expect actual &&
> > +	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
> > +	"$@" <input >actual &&
> >  	test_cmp expect actual
> >  }
> >  
> > -test_three_modes () {
> > -	run_three_modes test-tool reach "$@"
> > +test_all_modes () {
> > +	run_all_modes test-tool reach "$@"
> >  }
> 
> All right.
> 
> Though to reduce "noise" in this patch, the rename of run_three_modes()
> to run_all_modes() and test_three_modes() to test_all_modes() could have
> been done in a separate preparatory patch.  It would be pure refactoring
> patch, without introducing any new functionality.
> 

Sure, that makes sense to me - this is patch is over 200 lines long
already.

> ...

Thanks
- Abhishek
