Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00EC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5F720836
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjf2D9fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgBQV4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:56:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44618 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgBQV4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 16:56:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so12895943lfa.11
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=H6IYYD6du1pQKykKFvkyuHo6biyNv8EOXu+5rRzTMfA=;
        b=Zjf2D9fQylbfjRv1WNTk7/81DjbpAzQS7Pi6M8XkKaPM1111leG9o0b7C43mMLE7GW
         NR+++NaiQ9LkKVc0nlo6ueYCCgJRDStv76GF8+sl0+Lcs/uqv4ns1dZDO7SWHrjJqoxv
         EzImgJVkHhg5BH6riEfZ10TZUDWtRmmdSehIvtBD1pWWuNxmMOqQfg2c6/XKjU2aw4NC
         sQYWypdQhi5dMCXqOPwttJyVJiSGiCR1zYHzpvLnK/MYQMVNup6/alg8RZnY3cLm12CW
         CGE2rKSlZc54ecb90dZ23jkEdDkcy0GTgLnAEJ6reYHfFv1ceSxoGVqN0FaRLdSPOtj9
         5trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=H6IYYD6du1pQKykKFvkyuHo6biyNv8EOXu+5rRzTMfA=;
        b=arHMN/+stXYEFLsmtfEbKH4McjABm2tEUxtbgCiGPsLCOcsQLrgJIK7lQwda9WJrgi
         CaMiQy7k6O1Bj8D8hrXtIk/SXSeRnX1LvTtTSl50XiIuBJkZXIHq5CD0FwnhERJe8bLD
         FELDdjUaYT+7t3Aum811CcW/OVN2zOcB8IU4VKMu2XgnMeQ0AR6GHrAkW9Jos68JXsft
         L6kiHp2FiwOxTF2J7xnDL2Jq2XLzGwMScasvqps83/XDBAiG/hKM4UzEgR0/GY/Xk/Hl
         eNjVTcMs3B1NfTiMiiT19tet/PDXbA8T1BqLflP6+JqyO1szbPCv5+Vqe26nKd4LRTWw
         naSA==
X-Gm-Message-State: APjAAAVEGDAmdFZZLXQXV6YGucEUvi2MMBPqx5nd09BloQe/VfyoPEWP
        F1tYmhcl35MUNv0Xs/+P+DE=
X-Google-Smtp-Source: APXvYqxB8gqU2ac8ROieakZS+83BhOtWVK2NueDu6I9/rP/JyP3BILkosjzlcjT0M2xFh+umfLUH/w==
X-Received: by 2002:a19:2351:: with SMTP id j78mr8921499lfj.173.1581976578026;
        Mon, 17 Feb 2020 13:56:18 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id f16sm984503lfm.40.2020.02.17.13.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2020 13:56:17 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 04/11] commit-graph: compute Bloom filters for changed paths
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <c17bbcbc66ea77bb480391804d1f2db66ffa0926.1580943390.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 22:56:12 +0100
Message-ID: <86k14klvyb.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
> Subject: [PATCH v2 04/11] commit-graph: compute Bloom filters for changed paths
>
> Compute Bloom filters for the paths that changed between a commit and its
> first parent using the implementation in bloom.c, when the
> COMMIT_GRAPH_WRITE_CHANGED_PATHS flag is set. This computation is done on a
> commit-by-commit basis. We will write these Bloom filters to the commit graph
> file in the next change.

I have no major complaints about the contents of this patch (except lack
of test, and type of total_bloom_filter_data_size), but the commit
message could have been worded better.

I would write something like this instead:

  Add new COMMIT_GRAPH_WRITE_CHANGED_PATHS flag that makes Git compute
  Bloom filters that store the information about changed paths (that
  changed between a commit and its first parent) for each commit in the
  commit-graph.  This computation is done on a commit-by-commit basis.

  We will write these Bloom filters to the commit-graph file, to store
  this data on disk, in the next change in this series.

In my opinion the fact that we compute Bloom filters for each and every
commit in the commit-graph file is more important than quite obvious
fact that we use implementation from bloom.c.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  commit-graph.c | 32 +++++++++++++++++++++++++++++++-
>  commit-graph.h |  3 ++-
>  2 files changed, 33 insertions(+), 2 deletions(-)

It would be good to have at least sanity check of this feature, perhaps
one that would check that the number of per-commit Bloom filters on slab
matches the number of commits in the commit-graph.

It could look something like this:

  test_expect_success 'create Bloom filters for all commit-graph commits' '
  	# create commit-graph with 2 commits
  	git rev-parse HEAD HEAD^ | git commit-graph write --stdin-commits &&
  	# generate Bloom filters for commit-graph commits
  	cat >commands <<\-EOF &&
  	add-graph-commits
  	filters-count
  	EOF
  	NUM_FILTERS=$(git test-tool bloom <commands) %%
  	test "$NUM_FILTERS" -eq 2
  '

>
> diff --git a/commit-graph.c b/commit-graph.c
> index 3c4d411326..724bfcffc4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -16,6 +16,7 @@
>  #include "hashmap.h"
>  #include "replace-object.h"
>  #include "progress.h"
> +#include "bloom.h"
>  
>  #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> @@ -795,9 +796,11 @@ struct write_commit_graph_context {
>  	unsigned append:1,
>  		 report_progress:1,
>  		 split:1,
> -		 check_oids:1;
> +		 check_oids:1,
> +		 changed_paths:1;

All right, this flag will be used for handling future `--changed-paths`
option to the `git commit-graph write`.

>  
>  	const struct split_commit_graph_opts *split_opts;
> +	uint32_t total_bloom_filter_data_size;

This is total size of Bloom filters data, in bytes, that will later be
used for BDAT chunk size.  However the commit-graph format uses 8 bytes
for byte-offset, not 4 bytes.  Why it is uint32_t and not uint64_t then?

>  };
>  
>  static void write_graph_chunk_fanout(struct hashfile *f,
> @@ -1140,6 +1143,28 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  	stop_progress(&ctx->progress);
>  }
>  
> +static void compute_bloom_filters(struct write_commit_graph_context *ctx)
> +{
> +	int i;
> +	struct progress *progress = NULL;
> +
> +	load_bloom_filters();
> +
> +	if (ctx->report_progress)
> +		progress = start_progress(
> +			_("Computing commit diff Bloom filters"),
> +			ctx->commits.nr);
> +

Shouldn't we initialize ctx->total_bloom_filter_data_size to 0 here?  We
cannot use compute_bloom_filters() to _update_ Bloom filters data, I
think -- we don't distinguish here between new and existing data (where
existing data size is already included in total Bloom filters size).  At
least I don't think so.


> +	for (i = 0; i < ctx->commits.nr; i++) {
> +		struct commit *c = ctx->commits.list[i];

Here we process commit in whatever order commits are in the
commits.list, which probably means lexicographical order, in practice
random order.

> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
> +		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
> +		display_progress(progress, i + 1);
> +	}
> +
> +	stop_progress(&progress);
> +}
> +
>  static int add_ref_to_list(const char *refname,
>  			   const struct object_id *oid,
>  			   int flags, void *cb_data)

> @@ -1794,6 +1819,8 @@ int write_commit_graph(const char *obj_dir,
>  	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
>  	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
>  	ctx->split_opts = split_opts;
> +	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
> +	ctx->total_bloom_filter_data_size = 0;
>  
>  	if (ctx->split) {
>  		struct commit_graph *g;
> @@ -1888,6 +1915,9 @@ int write_commit_graph(const char *obj_dir,
>  
>  	compute_generation_numbers(ctx);
>  
> +	if (ctx->changed_paths)
> +		compute_bloom_filters(ctx);
> +

All right.

>  	res = write_commit_graph_file(ctx);
>  
>  	if (ctx->split)
> diff --git a/commit-graph.h b/commit-graph.h
> index 7f5c933fa2..952a4b83be 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -76,7 +76,8 @@ enum commit_graph_write_flags {
>  	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
>  	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
>  	/* Make sure that each OID in the input is a valid commit OID. */
> -	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
> +	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
> +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)

All right.


Side note: perhaps we could add trailing comma after new enum entry,
that is

  +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),

following new CodingGuidelines recommendation

 - We try to support a wide range of C compilers to compile Git with,
   including old ones.  You should not use features from newer C
   standard, even if your compiler groks them.

   There are a few exceptions to this guideline:

   . since early 2012 with e1327023ea, we have been using an enum
     definition whose last element is followed by a comma.  This, like
     an array initializer that ends with a trailing comma, can be used
     to reduce the patch noise when adding a new identifier at the end.

https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L197

>  };
>  
>  struct split_commit_graph_opts {
