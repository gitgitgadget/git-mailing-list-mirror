Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C6AC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22D320776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv/3LNeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgE2I5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgE2I5a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:57:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0C8C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:57:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so2634321wro.1
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1vf1+ESYDT1eSL8QSqPUomj3kGUnbZTHoZoGKru+9jQ=;
        b=bv/3LNeO1eU3BpuFRoDSZ+EOclv6xVVmGkJLPPIMkaDrEJs2AaIHkw//MtaInr+WQk
         NYvNhNdJtw1knK2TLpcgHmK2XD5RrFoBUEvC80FuB7i7YqFZDSYPTmLyiuc98O+3mfUI
         BTlJKf6PL14jCFpujh/DtxJXGMMr+Hgh4e3aUe0PEknoHFnIf9CanVtSNt3b7X8zfGb4
         GCI7SLO20732bdr8uUA6QB4+jUSRp8tChq+WdTwFAvqb1aHXTojnVkb/WnGqUK6V1SCA
         Z+jP9MIa8fYGP1xrz76YcStw05MAWgCdSIwE5ePxFdwrYxqDQtRdJxDqdOrhdfJnYod6
         5ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1vf1+ESYDT1eSL8QSqPUomj3kGUnbZTHoZoGKru+9jQ=;
        b=QWBnRpKwhJSVJv9CZd9bjBJlLYailFcCX9RamQGrnRmt+dndQsT7jsEOEe8aBZbivV
         WGElykowuA0ADvrzDCU1/vTOznG68JUpOOl0wGnFSwSI1nQH+SaYgUHJFBldtudO5Y+s
         KVnNEX9l7whh8OOsir5+9FJTev0HI4b2Olsu9OZ56QRQ//DYzzKOuvhOBr0OuPJjsJxh
         SpgBQHi4F7AOnCa0maBYSuAZvvj3701U/5O6CVQsQWuqJ507r2WWAsWtIxxULh795a7x
         TdsDL4nyjEhQeJ97AMYLC3LNL94qXsUSa4uqWr4R+GBObZRyRLC6QIoZODs71Gmn6mUz
         uymg==
X-Gm-Message-State: AOAM532lhtGd1ic9Lt6cw3RRr06dgk2SVpQuI3gCk2vvYEDJ/if45+lx
        aEzLaia00mOLPWLWsMaQf+4=
X-Google-Smtp-Source: ABdhPJxCHBxUnOq7PKb06veeYZNnq/S0QNeAThzwZxDlZQqB01pms+YzKvQa0EjKKh4Z4UhpOcpaFg==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr7976647wrp.426.1590742648715;
        Fri, 29 May 2020 01:57:28 -0700 (PDT)
Received: from szeder.dev (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id a10sm9594197wmf.46.2020.05.29.01.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:57:27 -0700 (PDT)
Date:   Fri, 29 May 2020 10:57:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 09/15] commit-graph: write Bloom filters to commit
 graph file
Message-ID: <20200529085721.GA25128@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:59:49PM +0000, Garima Singh via GitGitGadget wrote:
> From: Garima Singh <garima.singh@microsoft.com>
> 
> Update the technical documentation for commit-graph-format with
> the formats for the Bloom filter index (BIDX) and Bloom filter
> data (BDAT) chunks. Write the computed Bloom filters information
> to the commit graph file using this format.
> 
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  .../technical/commit-graph-format.txt         |  30 +++++
>  commit-graph.c                                | 113 +++++++++++++++++-
>  commit-graph.h                                |   5 +
>  3 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index a4f17441aed..de56f9f1efd 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -17,6 +17,9 @@ metadata, including:
>  - The parents of the commit, stored using positional references within
>    the graph file.
>  
> +- The Bloom filter of the commit carrying the paths that were changed between
> +  the commit and its first parent, if requested.
> +
>  These positional references are stored as unsigned 32-bit integers
>  corresponding to the array position within the list of commit OIDs. Due
>  to some special constants we use to track parents, we can store at most
> @@ -93,6 +96,33 @@ CHUNK DATA:
>        positions for the parents until reaching a value with the most-significant
>        bit on. The other bits correspond to the position of the last parent.
>  
> +  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
> +    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all

This is inconsistent with the implementation: according to the code in
one of the previous patches these entries are simple byte offsets, not
8-byte word offsets, i.e. the combined size of all modified path
Bloom filters can be at most 2^32 bytes.

The commit-graph file can contain information about at most 2^31-1
commits.  This means that with that many commits each commit can have
a merely 2 byte Bloom filter on average.  When using 7 hashes we'd
need 10 bits per path, so in two bytes we could store only a single
path.

Clearly, using 4 byte index entries significantly lowers the max
number of commits that can be stored with modified path Bloom filters.
IMO every new chunk must support at least 2^31-1 commits.

> +      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
> +      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
> +      BIDX[i] (plus header length), where BIDX[-1] is 0.
> +    * The BIDX chunk is ignored if the BDAT chunk is not present.
> +
> +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
> +    * It starts with header consisting of three unsigned 32-bit integers:
> +      - Version of the hash algorithm being used. We currently only support
> +	value 1 which corresponds to the 32-bit version of the murmur3 hash
> +	implemented exactly as described in
> +	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
> +	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
> +	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
> +	in Probabilistic Verification"

How should double hashing compute the k hashes, i.e. using 64 bit or
32 bit unsigned integer arithmetic?

I'm puzzled that you link to this paper and still use double hashing.

Two of the contributions of that paper are that it points out some
shortcomings of the double hashing scheme and provides a better
alternative in the form of enhanced double hashing, which can cut the
false positive rate in half.

However, that paper considers the hashing scheme only in the context
of one big Bloom filter.  I've found that when it comes to many small
Bloom filters then the k hashes produced by any double hashing variant
are not independent enough, and "standard" double hashing fares the
worst among them.  There are real repositories out there where double
hashing has over an order of magnitude higher average false positive
rate than enhanced double hashing.  Though that's not to say that
enhanced double hashing is good...

For details on these issues see

  https://public-inbox.org/git/20200529085038.26008-16-szeder.dev@gmail.com

> +      - The number of times a path is hashed and hence the number of bit positions
> +	      that cumulatively determine whether a file is present in the commit.
> +      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
> +	      contains 'n' entries, then the filter size is the minimum number of 64-bit
> +	      words that contain n*b bits.

Since the ideal number of bits per element depends only on the number
of hashes per path (k / ln(2) ≈ k * 10 / 7), why is this value stored
in the commit-graph?

> +    * The rest of the chunk is the concatenation of all the computed Bloom
> +      filters for the commits in lexicographic order.
> +    * Note: Commits with no changes or more than 512 changes have Bloom filters
> +      of length zero.

What does this "Note:" prefix mean in the file format specification?

Can an implementation use a one byte Bloom filter with no bits set for
a commit with no changes?  Can an implementation still store a Bloom
filter for commits that modify more than 512 paths?

> +    * The BDAT chunk is present if and only if BIDX is present.
> +
>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>        This list of H-byte hashes describe a set of B commit-graph files that
>        form a commit-graph chain. The graph position for the ith commit in this
> diff --git a/commit-graph.c b/commit-graph.c
> index 732c81fa1b2..a8b6b5cca5d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c

> @@ -1034,6 +1071,59 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
>  	}
>  }
>  
> +static void write_graph_chunk_bloom_indexes(struct hashfile *f,
> +					    struct write_commit_graph_context *ctx)
> +{
> +	struct commit **list = ctx->commits.list;
> +	struct commit **last = ctx->commits.list + ctx->commits.nr;
> +	uint32_t cur_pos = 0;
> +	struct progress *progress = NULL;
> +	int i = 0;
> +
> +	if (ctx->report_progress)
> +		progress = start_delayed_progress(
> +			_("Writing changed paths Bloom filters index"),
> +			ctx->commits.nr);
> +
> +	while (list < last) {
> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
> +		cur_pos += filter->len;

Given a sufficiently large number of commits with large enough Bloom
filters this will silently overflow.

> +		display_progress(progress, ++i);
> +		hashwrite_be32(f, cur_pos);
> +		list++;
> +	}
> +
> +	stop_progress(&progress);
> +}
