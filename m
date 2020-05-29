Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279E7C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B8020C09
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMQvGV3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgE2N7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2N7G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:59:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272DC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:59:06 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id x22so1983132otq.4
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VEOS4/+O7YKp//6Kh28oXCSod3iTORgl4GN8l5fLE7g=;
        b=QMQvGV3VNsa6q6/lmLbuy8IqOA4uB5Z48YCeTcEq/XC4HQthg78SQa2jKR83lWCAGT
         r2A1vP69DNLEPJWBT3j479nuDysIhU/l0ax4o7p4vQX8zkL9k81qk2GKh/2C8pEVc8+Y
         W3RIJTVzBdWVEC/qUWtWtmEkKYXFPQfVCD1PRPm/kbyC/szw8Jf+CtLRcV84YxgyzW1P
         JjtcWNT+VIZLJVYywErRaiG/yGN2gvIK1uRBM/vi84OnisSxt03ZnlSlGKn1eVJ7esRh
         6KbmHCNT3h392sGc5nv6/iziBMkxAdxu+2pMwLVs/XTqCdinCfZLZlu6seNFBblqacn6
         6mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VEOS4/+O7YKp//6Kh28oXCSod3iTORgl4GN8l5fLE7g=;
        b=IBcDIaJXb93C+PCnpn5XcLpcorQYeK82bqIMdyTdfVrfhJjIEeLrDd7AS/2d7hN0ZK
         qT2WNxqjB5FGZEj7KU5Q4+eJA5TJT/wX/fNgW/kvJ0wqssPJzCwiJKD/PlNYt0g2x3WO
         fPjzuND9+ig7gENYVhevVOL8DCKJ5VfREHKPex0W7ZPbj0KOHfXoojegR4crLVGaOovU
         d9MJ5TgHgr7EeJbzl1Lh7bzJi/IhjnEAsOgTBWYxspN/5dcBy05Pt4d+uvxx4k7zC23s
         c4XqY6PNxnYlCZ94lBQoiCRi2hHQNiwbGWfUam7dauuzJFLuO/tqGupkuWYdcEM56yDx
         5Zkg==
X-Gm-Message-State: AOAM532Onv67hQxIBwW1sFmLlve8RoHl2gMd9YAz0ba67L4LTQSLXRv8
        sq0QdTzaWEiunTiuMlvvQoCYt0USiz2j7A==
X-Google-Smtp-Source: ABdhPJyebEAE25mtaAKvJJiopABEwlzD7vHclTkKaCsp5KUjBrSlj11Wh0ApUXgcfyKfN9nRvBdUaQ==
X-Received: by 2002:a9d:7f0c:: with SMTP id j12mr2355718otq.228.1590760745391;
        Fri, 29 May 2020 06:59:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g10sm2693287ooq.45.2020.05.29.06.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 06:59:04 -0700 (PDT)
Subject: Re: [PoC PATCH 00/34] An alternative modified path Bloom filters
 implementation
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <82928690-13e5-2881-30d0-d52a93e087d3@gmail.com>
Date:   Fri, 29 May 2020 09:59:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2020 4:50 AM, SZEDER Gábor wrote:
> Sigh...  but better late than never, right?

True. The best time to present these ideas would be while the series
was under review, which was a reasonable amount of time. But there's
no helping that, so what can we learn from your extensive work here?

> I experimented quite a bit with modified path Bloom filters a year and
> more ago, and got quite far...  but my disappointment in the
> inadequacy of all double hashing schemes, the arrival of split
> commit-graphs, and, well, life in general has put the whole thing on
> the back burner, and I haven't touched it for a couple of releases.
> 
> Now I finally managed to take a closer look at the current changed
> paths Bloom filters implementation, and saw that it has some of the
> same issues that I had stumbled upon and that it missed some
> optimization opportunities.  Unfortunately, fixing those issues and
> performing those optimizations do require a thorough format change.

My initial reaction is "it's too late for a format change now" but
that's not quite true. Even if we ship v2.27.0 with the existing
format, the data is in optional chunks. It would not be too difficult
to replace the storage with a different set of optional chunks and
stop reading the old ones. The question remains: exactly _how much
better_ is your implementation, and is it enough to justify the
upheaval?

The other thing that impacts this consideration is how complicated
the format becomes. Bloom filters are already complicated, so how
can we keep things simple when possible?

> So here is my proof of concept version, in all its incompleteness,
> with the following benefits:

These are all very interesting items. Here is my initial categorization:

These are bold claims that I hope you have end-to-end performance
numbers to back them up. Depending on how much the benefit is, then
we can consider a replacing.

>   - Better hashing scheme (though it should be better still).
>   - Orders of magnitude lower average false positive rate.
>   - Consequently, faster pathspec-limited revision walks.

These bullets seem like they may apply to the existing implementation,
since they seem unrelated to the format itself. Is it possible to
contribute these ideas to the existing implementation first?

>   - Faster processing of the tree-diff output and lower memory usage
>     while computing Bloom filters (from scratch...).
>   - Supports multiple pathspecs right from the start.
>   - Supports some wildcards in pathspecs.
>   - More cleanups, more bugfixes.

These items are confusing to me. I either don't know what they mean,
or doubt the value of having them present.

>   - Better understanding of the problem it tries to optimize.
>   - Better understanding of the issues with many small Bloom filters.
>   - Deduplicates Bloom filters.
>   - It has the right name :)  The diff machinery and all its frontends
>     report "modified" paths with the letter 'M', not "changed".
>   - Handles as many commits as the commit-graph format can>   - Optional support for storing Bloom filters for all parents of
>     merge commits.

(This last item in particular is one where I have already communicated
why there is little value in storing filters for diffs against a
second parent. Perhaps you have some concrete numbers on what happens
in terms of storage-vs-performance when adding these diffs.)

> Alas, the drawbacks are significant:
> 
>   - No tests whatsoever.
>   - Computes all modified path Bloom filters from scratch when
>     writing, no matter what.
>   - Doesn't work with split commit-graphs.
>   - Basically if anything works besides 'git commit-graph write
>     --reachable' it's a miracle.
>   - Not a single test.
>   - Many BUG()s, which should rather be graceful errors...  though I
>     have to admit that at this point they are indeed bugs.
>   - Many TODOs, both in commit messages and code, some incomplete
>     commit messages, crappy subject lines, even missing signoffs.
>   - Some ridiculously long variable, function, macro and config
>     variable names.
>   - It's based on v2.25.0 (no technical reason, but that's the version
>     I used to run the baseline benchmarks the last time, which takes
>     days...)
>   - I'm pretty sure that there are more...
>   - Oh, did I mention that there are no tests?

And now you get to the _real_ hard part of this feature. It is easy to
create a prototype that implements the idea, but it's another step to
make it a full contribution. You clearly know this, which I expect is
the reason this was not submitted earlier.

> 
> The first 14 patches are preparatory fixes and cleanups:
> 
>   01/34 tree-walk.c: don't match submodule entries for 'submod/anything'
> 
> This fix or something similar is necessary to have consistent output
> with and without modified path Bloom filters for paths crossing
> submodule boundary.
> 
>   02/34 commit-graph: fix parsing the Chunk Lookup table
> 
> The minimal (though not the best) fix for a bug which, I think, is as
> old as the commit-graph.  I don't know how to test this.
> 
>   03/34 commit-graph-format.txt: all multi-byte numbers are in network byte order
>   04/34 commit-slab: add a function to deep free entries on the slab
>   05/34 diff.h: drop diff_tree_oid() & friends' return value
>   06/34 commit-graph: clean up #includes
> 
> A couple of minor cleanups.
> 
>   07/34 commit-graph: simplify parse_commit_graph() #1
>   08/34 commit-graph: simplify parse_commit_graph() #2
> 
> These two would be the right, though not minimal fix for the parsing
> bug above.
> 
>   09/34 commit-graph: simplify write_commit_graph_file() #1
>   10/34 commit-graph: simplify write_commit_graph_file() #2
>   11/34 commit-graph: allocate the 'struct chunk_info' array dinamically
> 
> I think these three cleanup patches are a better alternative of
> 3be7efcafc (commit-graph: define and use MAX_NUM_CHUNKS, 2020-03-30),
> because...
> 
>   12/34 commit-graph: unify the signatures of all write_graph_chunk_*() functions
>   13/34 commit-graph: simplify write_commit_graph_file() #3
>   14/34 commit-graph: check chunk sizes after writing

These 14 patches are probably worth submitting on their own. I hope they
still apply cleanly to a recent master.

> ... they laid the ground work for this patch.
> 
>   15/34 commit-graph-format.txt: document the modified path Bloom filter chunks
> 
> This is the most important one, specifying and _justifying_ the new
> chunk formats.
> 
> Do grab a cup or pint of your favourite beverage and get comfy before
> reading this one.  You have been warned.
> 
>   16/34 Add a generic and minimal Bloom filter implementation
>   17/34 Import a streaming-capable Murmur3 hash function implementation
>   18/34 commit-graph: write "empty" Modified Path Bloom Filter Index chunk
>   19/34 commit-graph: add commit slab for modified path Bloom filters
>   20/34 commit-graph: fill the Modified Path Bloom Filter Index chunk
> 
> This shows a more efficient approach to process the tree-diff output
> into Bloom filters.
> 
>   21/34 commit-graph: load and use the Modified Path Bloom Filter Index chunk
>   22/34 commit-graph: write the Modified Path Bloom Filters chunk
>   23/34 commit-graph: load and use the Modified Path Bloom Filters chunk

Ok, these implement the new filter format.

>   24/34 commit-graph: check all leading directories in modified path Bloom filters
> 
> This was a good lightbulb moment.  It is essential to try to maintain
> reasonable performance in repositories where the vast majority of
> changes are concentrated to a single directory.

This is really interesting! This could apply to the existing format, so
when you compare formats this patch should either be in both or in neither.
 
>   25/34 commit-graph: check embedded modified path Bloom filters with a mask
>   26/34 commit-graph: deduplicate modified path Bloom filters
>   27/34 commit-graph: load modified path Bloom filters for merge commits
>   28/34 commit-graph: write Modified Path Bloom Filter Merge Index chunk
>   29/34 commit-graph: extract init and free write_commit_graph_context
>   30/34 commit-graph: move write_commit_graph_reachable below write_commit_graph
>   31/34 t7007-show: make the first test compatible with the next patch
>   32/34 PoC commit-graph: use revision walk machinery for '--reachable'
> 
> Once upon a time I thought this was the greatest idea ever, but as
> time goes by I get more and more concerned that this is a really dumb
> idea, though don't yet know why.

Ok, here are some extra patches that implement your extra features. The
multi-parent filters are a fair thing to compare against the existing
implementation, but we need to compare file size changes, extra computation
time changes, and how much the end-to-end rev-list performance changes.
Are the costs justified?

>   33/34 commit-graph: write modified path Bloom filters in "history order"

I think we've covered this in these two patches:

3d112755056 commit-graph: examine commits by generation number
d21ee7d1110 commit-graph: examine changed-path objects in pack order

>   34/34 commit-graph: use modified path Bloom filters with wildcards, if possible
> 
> Finally a cherry on top.

This is also something that could be interesting for the current
implementation. Perhaps group it with patches 1-14 and 24, if the idea
applies to the existing implementation.

I think it would be great to apply whatever code cleanups and fixes
that you've presented here to the existing implementation _first_,
then we have the optimal way to compare how your proposed format
improves over the existing implementation.
 
I can't commit more time to this series today, but hopefully the discussion
is just getting started. I'll try to poke around some of the patches
next week.

Thanks,
-Stolee
