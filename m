Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2AC33CAF
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 23:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DF42465B
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 23:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eu8izpiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAUXlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:41:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32887 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 18:41:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so2329751pfk.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 15:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pmFWD9P4OdqLI+hCcogVqnUOOn9Ob1iP+SpPzGTd128=;
        b=eu8izpiEH+BrZ65BZe9MeKlsbX7P4dXVTzldHUXG94voYSjxE6Ptr0h4qQi5AMmAf5
         8FyuiDSZUO3diGCBsLLYHntxJpeYTutAti3Owb+iFTJzzdJWQDPeZct1X2Nou8u/H1iE
         vsAg2XNyPUxsAU4p665Jvpi4Ggd+IVIQt6BEfETyGFe0B0uvkTkXGm+ZXujjiRuOJpHc
         RTCrqcs9alZ57FEnLWptSMHvblVo1cbf+cyCoz9QY5TaULLdXI0XW+KRlSGOmOA/HG01
         ICBOblVTl8SuGjfrcbU9IBiYOsaX72G6poAKBKtP9H7iQaR+33tAandONd0Z0c1HfFYN
         ysxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pmFWD9P4OdqLI+hCcogVqnUOOn9Ob1iP+SpPzGTd128=;
        b=b+QfYswflvZxsfRimBWl84JguWV0bV/MquLdqXX91sLmYtsRqM8aC2rlGbaoabBqrP
         gq803haZLSc26ahilTEsc5u9hTmG/MqZzX+GR5arTS3gqn0zOU0J2t6+gQRUB6nVJG6q
         0h5SA47l3ApbWseOqo1C4C+hooeKCyXKrZO1J0AuTTy8e0acv3fSrAiMPhs2l5yXa4g4
         /kSI6P7ap3j1DXJgyg/jQIErHzeTqrqrhtBUYYy2MBx+gwIxGmATjdT5s9/z0j4hv5HF
         r2STEp2AVzuRWpgq9Zxq4arCjcCe4DF2pvJlvwWtqDF/klRhiAcbMHKXf4YrJ8y7XQYw
         THEQ==
X-Gm-Message-State: APjAAAV76ZH3wkXLv1gAvnFBWXB8qEs4WVfWWCo6YVOeWLKTYOkLRXDN
        XGItPCNhVQ2J4Z+5JNa4ln8eFA==
X-Google-Smtp-Source: APXvYqx51f8fRetkBonjm2BMDI6chD43gmeUIZNXXpim+27nkleGLsuV19dsmbHIp6dRbY5w9nP5Gg==
X-Received: by 2002:a63:1447:: with SMTP id 7mr7985909pgu.22.1579650061240;
        Tue, 21 Jan 2020 15:41:01 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id o134sm46247890pfg.137.2020.01.21.15.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:41:00 -0800 (PST)
Date:   Tue, 21 Jan 2020 15:40:55 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
Message-ID: <20200121234055.GN181522@google.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Dec 20, 2019 at 10:05:11PM +0000, Garima Singh via GitGitGadget wrote:
> This series is intended to start the conversation and many of the commit
> messages include specific call outs for suggestions and thoughts. 

Since it's mostly in RFC stage, I'm holding off on line by line comments
for now. I read the series (thanks for your patience) and I'll try to
leave some review thoughts in the diffspec here.

> Garima Singh (9):
>   [1/9] commit-graph: add --changed-paths option to write
I wonder if this can be combined with 2; without 2 actually the
documentation is wrong for this one, right? Although I suppose you also
mentioned 2 perhaps being too long :)

>   [2/9] commit-graph: write changed paths bloom filters
As I understand it, this one always regenerates the bloom filter pieces,
and doesn't write it down in the commit-graph file. How much longer does
that take now than before? I don't have a great feel for how often 'git
commit-graph' is run, or whether I need to be invoking it manually.

>   [3/9] commit-graph: use MAX_NUM_CHUNKS
>   [4/9] commit-graph: document bloom filter format
I suppose I might like to see this commit squashed with 5, but it's a
nit. I'm thinking it'd be handy to say "git blame commit-graph" and see
some nice doc about the format expected in the commit-graph file.

>   [5/9] commit-graph: write changed path bloom filters to commit-graph file.
Ah, so here we finally write down the result from 2 to disk in the
commit-graph file. And without 7, this gets recalculated every time we
call 'git commit-graph' still.

As for a technical doc around here, I'd really appreciate one. But I'm
speaking selfishly - I'd also be happy if I could watch a talk about
this design to make sure I understand it right :)

>   [6/9] commit-graph: test commit-graph write --changed-paths
>   [7/9] commit-graph: reuse existing bloom filters during write.
I saw an option to give up if there wasn't an existing bloom filter, but
I didn't see an option here to force recalculating. Is there a scenario
when that would be useful? What's the mitigation path if:
 - I have a commit-graph with v0 of the bloom index piece, but update to
   Git which uses v1?
 - My commit-graph file is corrupted in a way that the bloom filter
   results are incorrect and I am missing a blob change (and therefore
   not finding it during the walk)?
I think I understand that without this commit, 8 is not much speedup
because we will be recalculating the filter for each commit, rather than
using the written-down commit-graph file.

>   [8/9] revision.c: use bloom filters to speed up path based revision walks
>   [9/9] commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag

Speaking of making sure I understand the change right, I will also
summarize my own understanding in the hopes that I can be corrected and
others can learn too ;)

 - The general idea is that we can write down a hint at the tree level
   saying "something I own did change this commit"; when we look for an
   object later, we can skip the commit where it looks like that path
   didn't change.
 - The change is in two pieces: first, to generate the hints per tree
   (which happens during commit-graph); second, to use those hints to
   optimize a rev walk (which happens in revision.c patch 8)
 - When we calculate the hints during commit-graph, we check the diff of
   each tree compared to its recent ancestor to see if there was a
   change; if so we calculate a hash for each path and use that as a key
   for a map from hash to path. After we look through everything changed
   in the diff, we can add it to a cumulative bloom filter list (one
   filter per commit) so we have a handy in-memory idea of which paths
   changed in each commit.
 - When it's time to do the rev walk, we ask for the bloom filter for
   each commit and check if that commit's map contains the path to the
   object we're worried about; if so, then it's OK to unpack the tree
   and check if the path we are interested in actually did get changed
   during that commit.

Thanks.
 - Emily

> 
>  Documentation/git-commit-graph.txt            |   5 +
>  .../technical/commit-graph-format.txt         |  17 ++
>  Makefile                                      |   1 +
>  bloom.c                                       | 257 +++++++++++++++++
>  bloom.h                                       |  51 ++++
>  builtin/commit-graph.c                        |   9 +-
>  ci/run-build-and-tests.sh                     |   1 +
>  commit-graph.c                                | 116 +++++++-
>  commit-graph.h                                |   9 +-
>  revision.c                                    |  67 ++++-
>  revision.h                                    |   5 +
>  t/README                                      |   3 +
>  t/helper/test-read-graph.c                    |   4 +
>  t/t4216-log-bloom.sh                          |  77 ++++++
>  t/t5318-commit-graph.sh                       |   2 +
>  t/t5324-split-commit-graph.sh                 |   1 +
>  t/t5325-commit-graph-bloom.sh                 | 258 ++++++++++++++++++
>  17 files changed, 875 insertions(+), 8 deletions(-)
>  create mode 100644 bloom.c
>  create mode 100644 bloom.h
>  create mode 100755 t/t4216-log-bloom.sh
>  create mode 100755 t/t5325-commit-graph-bloom.sh
> 
> 
> base-commit: b02fd2accad4d48078671adf38fe5b5976d77304
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-497%2Fgarimasi514%2FcoreGit-bloomFilters-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-497/garimasi514/coreGit-bloomFilters-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/497
> -- 
> gitgitgadget
