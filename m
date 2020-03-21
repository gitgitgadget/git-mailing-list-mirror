Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75022C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 06:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCBC20658
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 06:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fFhb2xhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCUGYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 02:24:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45784 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgCUGYX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 02:24:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9so3441544pls.12
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ehko7eNN0+SA2SMrze7W2jt/sqbtiMOnl1i9GmJhb6s=;
        b=fFhb2xhd9Yjrhgw/XgqOiLR8mhGRjZZeHHNoTmaJQXFHJjgmJc+SSLzVrPZJp3PzFx
         2+8WcBva0yBoRWxK+hHBEisbA3zVdIbhaBpUM5/V0Y23orfzW3y9ssH0IUKb74VVpqlY
         xW5KCPHeAPPTKPDNl2QX/cSMs5i9fiXhHXh9LXdmJeTekuqbDxwYZFKJji/69zmtg+kn
         DziP1RA4OdQ8/10jmLAvCEMPH/aNAKN5fNSeBVptjJfnd/hut6EUg5qnBffmRlsqq2nP
         GcXOW3ArEM0FNJhCFPkdnt6QhXW5SVvCdV3GPmbJBw7g5r/1MJs8vR7bsQe8aWcTcknP
         9TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ehko7eNN0+SA2SMrze7W2jt/sqbtiMOnl1i9GmJhb6s=;
        b=Ssw9UAFjrGteczuHdI0ciYIB5UF6w2BEz0cLY7P+1ZXDuaOX6ndMxddx2QfaWaWOwG
         AqrZvy0zeVwhjG90w7Qc7pYpOjKktBhb8cKVYDYYK8FafQkC1vQ5giOsGVzUKIXxhA4Z
         C8nnuCzNOjWJJS56/AtgHr2LR7U7BLR5X0IeTY8BjW1IzdEdg4Z6nJqK8hUSTMsk2s5S
         Id4swBX5m+GES/heQxsuTR+aymxvvrrjEtg6e9KxYCuFf6bPR9SDKBp63OL7GIrLgAdE
         AQz7IhZeemxG946TqHSsK5UpLGut6hu0hfbi+pipSE/KuYLfk/frBzsup7GDv775zeRz
         nPPQ==
X-Gm-Message-State: ANhLgQ0LDfyS2RzrUo61YNSAQ5SRV577CtaxFwUbbsi+hedGVSrRpepN
        8I/Dp3ZaqYnnFIsFQBIWqHSzFw==
X-Google-Smtp-Source: ADFU+vtkyUhL2Y5i8o2CEREKyiAfMkwCSKK4hPcu2+FW1FsTzn0zRLc/cnwBlVkqJ2MHME+88G07vg==
X-Received: by 2002:a17:90a:23cc:: with SMTP id g70mr13694397pje.122.1584771860942;
        Fri, 20 Mar 2020 23:24:20 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a8sm6622972pgg.79.2020.03.20.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 23:24:20 -0700 (PDT)
Date:   Sat, 21 Mar 2020 00:24:19 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200321062419.GA37345@syl.local>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321061141.GA30636@syl.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 12:11:41AM -0600, Taylor Blau wrote:
> On Sat, Mar 21, 2020 at 01:00:25AM -0400, Jeff King wrote:
> > On Fri, Mar 20, 2020 at 09:44:23PM -0600, Taylor Blau wrote:
> >
> > > In my testing environment, this improves the time to "merge" a split
> > > commit-graph containing all reachable commits in the kernel by
> > > re-writing the same commit-graph (effectively measuring the time it
> > > takes to check that all of those commits still exist) from:
> > >
> > >   Attempt 1: 9.614
> > >   Attempt 2: 10.984
> > >   Attempt 3: 10.39
> > >   Attempt 4: 9.14
> > >   Attempt 5: 9.439
> > >
> > >   real	0m9.140s
> > >   user	0m8.207s
> > >   sys	0m0.602s
> > >
> > > to:
> > >
> > >   Attempt 1: 9.12
> > >   Attempt 2: 8.904
> > >   Attempt 3: 9.361
> > >   Attempt 4: 9.288
> > >   Attempt 5: 9.677
> > >
> > >   real	0m8.904s
> > >   user	0m8.208s
> > >   sys	0m0.596s
> > >
> > > yielding a modest ~2.6% improvement in the best timings from each run,
> > > and ~7.4% improvement on average.
> >
> > That still seems really slow to me. If we were truly eliding the load of
> > most of the commit objects, I'd expect an order of magnitude or so
> > improvement. For example, with a fully constructed commit graph in
> > linux.git, I get:
> >
> >   $ time git -c core.commitGraph=1 rev-list HEAD | wc -l
> >   886922
> >
> >   real	0m1.088s
> >   user	0m0.659s
> >   sys	0m1.161s
> >
> >   $ time git -c core.commitGraph=0 rev-list HEAD | wc -l
> >   886922
> >
> >   real	0m7.185s
> >   user	0m6.729s
> >   sys	0m1.882s
> >
> > Obviously not the same operation, but that should give us a rough idea
> > that commit graph lookups are 6-7 times cheaper than loading the actual
> > objects. I don't remember the details of the case that originally led us
> > towards this patch. Can you share more of the setup you used to generate
> > the numbers above (which repo, but more importantly the commands to
> > create the initial state and then time the test).
>
> Sure. I'm running best-of-five on the time it takes to re-generate and
> merge a commit-graph based on in-pack commits.
>
> The script is (in linux.git):
>
>   $ best-of-five \
>       -p 'rm -rf .git/objects/info/commit-graph{,s/}; git commit-graph write --split=no-merge 2>/dev/null' \
>       git commit-graph write --split=merge-all
>
> So we're measuring the time it takes to crawl all the packs, decide on
> the splitting strategy, and then compare all commits in the new merged
> graph to make sure that they don't already exist in the object store.
>
> But, here's where things get... Bizarre. I was trying to come up with a
> way to do fewer things and spend proportionally more time in
> 'merge_commit_graphs', so I did something like:
>
>   - Generate a pack containing a single, empty commit.
>   - Generate a split commit-graph containing commits in the single large
>     pack containing all of history.
>   - Generate a commit-graph of the small pack, and merge it with the
>     large pack.
>
> That script is:
>
>   $ git --version
>   $ git commit -m "empty" --allow-empty
>   $ pack="pack-$(git rev-parse HEAD | git pack-objects .git/objects/pack/pack).idx"
>   $ best-of-five \
>       -p "rm -rf .git/objects/info/commit-graphs && cp -r .git/objects/info/commit-graphs{.bak,}" \
>       sh -c "echo $pack | git commit-graph write --split=merge-all"
>
> but things get... slower with this patch? Here are the results before
> and after:
>
>   Attempt 1: 8.444
>   Attempt 2: 8.453
>   Attempt 3: 8.391
>   Attempt 4: 8.376
>   Attempt 5: 7.859
>
>   real	0m7.859s
>   user	0m7.309s
>   sys	0m0.511s
>
> vs:
>
>   Attempt 1: 8.69
>   Attempt 2: 8.735
>   Attempt 3: 8.619
>   Attempt 4: 8.747
>   Attempt 5: 8.695
>
>   real	0m8.619s
>   user	0m8.030s
>   sys	0m0.538s
>
> Without more profiling, I'm puzzled by why this patch seems to make
> things *worse* under this scenario.

Hmm. I tried roughly the same setup as the latter of the above two, but
this time under perf. On a warm cache, it does look like this parch is
an improvement:

  $ sudo perf diff perf.data perf.data.patch | grep merge_commit
       0.11%   -0.02%  git                [.] merge_commit_graph

(perf.data is from running 'next', perf.data.patch is from running
'next' with this patch applied on top). So... a slight improvement, but
nothing like what I had reported in the original patch.

I am puzzled.

> So, I'd appreciate your thoughts: does this set-up seem reasonable? Is
> it introducing some latency that isn't being accounted for in the
> original setup?
>
> > The patch otherwise still makes sense to me, but I suspect there are
> > other similar optimizations nearby that we'll need to do in tandem.
> >
> > -Peff
>
> Thanks,
> Taylor

Thanks,
Taylor
