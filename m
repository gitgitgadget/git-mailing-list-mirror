Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F4C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44E820663
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="K5KM13TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgFAXZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFAXZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 19:25:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28658C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 16:25:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a4so4159210pfo.4
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NspD+w6E2WkwE2FuqZGUb3S9F04r/7ycnfjPhQlpQM8=;
        b=K5KM13TJPTM/HxgjOBE/S/DwPqqPXGe9zYZ8BBKJERBaL/FoHr1gJM2jKZBFaVWZZb
         nylfegc+0aLhqni6zfR3yg3ShRa104LUM8rSjZRK66RUjIAtVCgV1diazen2AFn5xccE
         LK5+S3TbyHswCBMwJ8vkVyGjDO4EE2tOn6CAPX90O54J5E4BVk2N7Gz1nrmSr6MflBYE
         Al4AvdGOAcz3L0nAJcJz5CHsg/Jsq0qJi0abz7J7lfW/6omjDXq1SFlSywtuGjx5ZsRn
         9vF0Z0UpXrNKN3jivWrb+kDYW0bhzW1BfUmE9IiOEhmBRYW1fawBZuHDN3YMi1gbugmr
         g2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NspD+w6E2WkwE2FuqZGUb3S9F04r/7ycnfjPhQlpQM8=;
        b=Qm52EDkS3whlnjPRYUMp6hlOMf7Tun9TGCXAhzBSVoFRGGF6FlNAUDiVzCQvdaimgJ
         1TxISrER2j2DuWz1aEEY7bMVvz5rc/EKSdydwFbb0XcjSFnSSP2cn+drk6Ky3/CdhkZp
         HDR+4Oc6Tap41cu9W3O6jV7R82a3qZ4Kif9V4lqcIuDzeGM9NwuJ0QfCslx3elHBcr2k
         YayBAVUTH4gi2EmBh0f45MeIDgad4Fx6607tlNnwSidjBhlZGdqFf3i1FyMXi6bZhyRN
         fANDzlK8LhygRzhcZKXf3PxKtwD2EIT0mP/kaRW2Bz21OwNyYZ7HsZFlhE3PjruE8gpC
         PnRg==
X-Gm-Message-State: AOAM531CCOMZW+0YGvgm6SkX6HFedAqhOaI+nf9IsnTzhz9fIPy+gont
        MWP9Qqs3h8N4OIDZZhhZ1FcoFw==
X-Google-Smtp-Source: ABdhPJxEV1YarYU8JYr7GgHqZFEtzQilsg8X+YAGENB1Ge4gCAsiDMz0Y4JRCm/oaE5AKG1W12qdLw==
X-Received: by 2002:a63:ed46:: with SMTP id m6mr3308161pgk.314.1591053907390;
        Mon, 01 Jun 2020 16:25:07 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f136sm415066pfa.59.2020.06.01.16.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 16:25:06 -0700 (PDT)
Date:   Mon, 1 Jun 2020 17:25:04 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PoC PATCH 00/34] An alternative modified path Bloom filters
 implementation
Message-ID: <20200601232504.GA42750@syl.local>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 29, 2020 at 10:50:04AM +0200, SZEDER Gábor wrote:
> Sigh...  but better late than never, right?

Yes, indeed. I think that there is a balance here: I'm thrilled that you
are choosing to spend your time working on and improving the
changed-path Bloom filter implementation.

Of course, it couldn't have hurt to have these ideas earlier when the
list was more focused on reviewing Garima's original patches. But,
nothing is set in stone, and it seems like there are some re-usable
ideas and clean-ups below.

I'll respond to the patch descriptions below with a "cut-line" where I
think we could extract and apply what's already there before putting the
rest aside to be worked on more.

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
>
> So here is my proof of concept version, in all its incompleteness,
> with the following benefits:
>
>   - Better understanding of the problem it tries to optimize.
>   - Better understanding of the issues with many small Bloom filters.
>   - Better hashing scheme (though it should be better still).
>   - Orders of magnitude lower average false positive rate.
>   - Consequently, faster pathspec-limited revision walks.
>   - Faster processing of the tree-diff output and lower memory usage
>     while computing Bloom filters (from scratch...).
>   - Optional support for storing Bloom filters for all parents of
>     merge commits.
>   - Deduplicates Bloom filters.
>   - Supports multiple pathspecs right from the start.
>   - Supports some wildcards in pathspecs.
>   - Handles as many commits as the commit-graph format can.
>   - It has the right name :)  The diff machinery and all its frontends
>     report "modified" paths with the letter 'M', not "changed".
>   - More cleanups, more bugfixes.
>   - Consistent output with and without modified path Bloom filters for
>     over 80k random paths in 16 repositories, even with submodules in
>     them.  Well, at least on my machine, if nowhere else...
>
> Alas, the drawbacks are significant:
>
>   - No tests whatsoever.

Yes, obviously this needs to be addressed, but I certainly don't fault
you for posting what you have (thanks for adding the 'PoC' prefix to
indicate it as such).

>   - Computes all modified path Bloom filters from scratch when
>     writing, no matter what.
>   - Doesn't work with split commit-graphs.

I originally thought that this would be a non-starter, but it may not
be. GitHub doesn't write Bloom filters at all (yet), but one
consideration of ours is to only generate Bloom filters when we roll-up
all of the split graphs.

Our invocation during this bigger repository maintenance is something
like:

  $ git commit-graph write --reachable --split=replace

But if it turns out to be expensive to run 'git commit-graph write
--split=no-merge --stdin-commits --write --changed-paths' on every push,
we might just run the above with '--changed-paths'.

I can imagine other schemes where it would be desirable to have your
Bloom filter implementation over split graphs, in which case this should
be addressed. But, I don't have a problem with a version that only works
for non-split graphs first, so long as there isn't a compatibility
boundary between that and a version that does work for split graphs.

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

...I think so ;-).

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

I think you're right to draw the "laying the ground work" line here.
Could these first fourteen patches be applied cleanly to master? They
all look mostly like improvements to me, especially the second patch.

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
>   24/34 commit-graph: check all leading directories in modified path Bloom filters
>
> This was a good lightbulb moment.  It is essential to try to maintain
> reasonable performance in repositories where the vast majority of
> changes are concentrated to a single directory.
>
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
>
>   33/34 commit-graph: write modified path Bloom filters in "history order"
>   34/34 commit-graph: use modified path Bloom filters with wildcards, if possible
>
> Finally a cherry on top.

The next twenty patches look like they need some more work. At a
high-level, I think we need to do the following things, in roughly the
following order:

  - Prove that this is a strict performance improvement on the existing
    Bloom filter implementation.

  - Sketch out a way that it would work for cases where '--split' is
    provided, and/or '--reachable' isn't provided.

  - Clean up the existing patches, adding tests which exercise the new
    functionality, and prove that there aren't regressions against the
    existing Bloom filter implementation.

  - Review and repeat.

I guess I'm left wondering whether or not this is something that you
want to continue, given that I outlined a pretty lengthy path for
getting this in a suitable shape to keep going.

Are you planning on keeping working on this?

Thanks,
Taylor
