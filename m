Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA951C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F9E2076F
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 17:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Dyx5r/l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCUR1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:27:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40375 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgCUR1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 13:27:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id l184so5067590pfl.7
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m91hiMdzZa3SPUYitXmqZppQuscclKUpudVCs3WRYzo=;
        b=Dyx5r/l7Xzap5OkDJsNg9caKqQxMfHpMwPcFj1zv1IN60FmGyL9m210Yo3xclkj814
         B7Z0J+bEMiZZfu2y2345pnEM696b5w+2vn9P+Nndoz2QkrXXbWjh1TAmx1P+YKFUseBm
         uNmrOoB5Tsjxu0Ek0Jv3sAIVUIiV+FHlvXhJkp+BPj4jVj77XVMhwur0FdcajIDrFpQL
         b0BvBh6kIQ4Ev/zvpMoLkjjBp4tjhBqGAO8+QY3X747NMFSfLXjzIsGiB6lX+r7WMEYg
         nYwzZvxIT/KUxPucu+E1QucT56qmEG2AYQkj+KWKXAA4w7tPBbT/bL2SRtilGcn8TEbi
         wUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m91hiMdzZa3SPUYitXmqZppQuscclKUpudVCs3WRYzo=;
        b=R1VBBPI+ft7H1AB7Es5p4w0WvbRIqSFmCec5vBFwNkv/c5uH9RUl7MyAd0IagykZdO
         DT3WIFgXD9F6gyYwWyZbJaWhdc6lqQdcHapB7ZKPlycpSsQj6vVdLJi5/jCwZhB+KfAv
         1Q3g0SlGZEtubK3KE0jOpvfvOm3pKvQoALL1A/AvSlwwqJ28GHAqTKHj7qZOxfCT1oGp
         k2vzxmIXn4i1h3rgfMjs6aoIKdjPGFAvNTVg3iDA9fB9iVnpK/kg39Ln7wlk/tghQumN
         huaKW1FglxwzA2RAgbZBiBiGvrmQ6SFiBeN4walDjyv63601xwny6ngPhfDjL8fVEm36
         j0Cw==
X-Gm-Message-State: ANhLgQ2pKmTHAcv6ZYs00Yni9FffQD1XWzYXVtM5Igb1t+TVcJsnHyKy
        cRy18xDtW4GbdhZ37taiPt7OAA==
X-Google-Smtp-Source: ADFU+vvxNUlMjLywbLx/HPLXfZrtJAJmKSmTbhcpyTPspGefcR9WfwUHZVSgBD2mXDeHbqXiu8BJYg==
X-Received: by 2002:a62:1946:: with SMTP id 67mr16519044pfz.0.1584811638732;
        Sat, 21 Mar 2020 10:27:18 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y9sm8137534pgo.80.2020.03.21.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 10:27:18 -0700 (PDT)
Date:   Sat, 21 Mar 2020 11:27:16 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200321172716.GA39461@syl.local>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321070333.GB1441446@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 03:03:33AM -0400, Jeff King wrote:
> On Sat, Mar 21, 2020 at 12:11:41AM -0600, Taylor Blau wrote:
>
> > Sure. I'm running best-of-five on the time it takes to re-generate and
> > merge a commit-graph based on in-pack commits.
> >
> > The script is (in linux.git):
> >
> >   $ best-of-five \
> >       -p 'rm -rf .git/objects/info/commit-graph{,s/}; git commit-graph write --split=no-merge 2>/dev/null' \
> >       git commit-graph write --split=merge-all
>
> If I build Git without your patch and run the "--split=merge-all"
> command under a debugger, and then break on parse_object() I find that
> all of the commits are already parsed. This happens in
> close_reachable().
>
> So we weren't actually reading all of the commits even under the old
> code. We were just going into deref_tag(), seeing that the object is
> already parsed, and then quickly returning when we see that we already
> have an OBJ_COMMIT. I suspect most of your timing differences are mostly
> noise.

Aha. Thanks for reasoning through this. That makes sense, and I think
that you're probably right.

> Perhaps a more interesting case is when you're _not_ adding all of the
> existing packed commits as input. There we'd feed only a few objects to
> close_reachable(), and it would stop traversing as soon as it hits a
> parent that's already in a graph file. So most of the existing objects
> would remain unparsed.
>
> I'm not sure how to do that, though. Saying "--input=none" still puts
> all of those existing graphed objects into the list of oids to include.
> I think you'd need a case where you were legitimately only adding a few
> commits, but the merge rules say we need to create one big commit-graph
> file.

You have to be careful, since we're taking the reachability closure over
any commits that you do give. So, one thing you could do to ensure that
you have an actually small graph is to take something from the output of
'git rev-list --max-parents=0 HEAD'.

To try and reproduce your results, I used '1da177e4c3', which is the
kernel's first commit in Git. If my interpretation of your setup is
faithful, it goes something like:

  $ graphdir=.git/objects/info/commit-graphs
  $ git rev-parse 1da177e4c3 |
    git commit-graph write --split=no-merge --stdin-commits
  $ cp -r "$graphdir{,.bak}"

  $ best-of-five -p "rm -rf $graphdir && cp -r $graphdir{.bak,}" \
    'git commit-graph write --split=merge-all'

Where the last step is taking all commits listed in any pack, which is
cheap to iterate.

> I guess --input=stdin-commits is a good way to simulate that. Try this
> (assuming there's already a split-graph file with all of the commits in
> it):
>
>   git rev-parse HEAD >input
>   time git commit-graph write --input=stdin-commits --split=merge-all <input
>
> Without your patch on linux.git I get:
>
>   real	0m11.713s
>   user	0m11.349s
>   sys	0m0.341s
>
> but with it I get:
>
>   real	0m2.305s
>   user	0m2.177s
>   sys	0m0.100s

In the above setup, I get something like:

  git version 2.26.0.rc2.221.ge327a58236
  Attempt 1: 16.933
  Attempt 2: 18.101
  Attempt 3: 17.603
  Attempt 4: 20.404
  Attempt 5: 18.871

  real	0m16.933s
  user	0m16.440s
  sys	0m0.472s

versus:

  git version 2.26.0.rc2.222.g295e7905ee
  Attempt 1: 5.34
  Attempt 2: 4.623
  Attempt 3: 5.263
  Attempt 4: 5.268
  Attempt 5: 5.606

  real	0m4.623s
  user	0m4.428s
  sys	0m0.176s

which is a best-case savings of ~72.7%, and a savings of ~71.5%. That
seems much better.

If you think that this is a realistic setup, I'll amend the original
patch text to include these updated numbers, along with the reproduction
steps.

> A more realistic case would probably be feeding a new small pack to
> --input=stdin-packs.
>
> > But, here's where things get... Bizarre. I was trying to come up with a
> > way to do fewer things and spend proportionally more time in
> > 'merge_commit_graphs', so I did something like:
> >
> >   - Generate a pack containing a single, empty commit.
> >   - Generate a split commit-graph containing commits in the single large
> >     pack containing all of history.
> >   - Generate a commit-graph of the small pack, and merge it with the
> >     large pack.
> >
> > That script is:
> >
> >   $ git --version
> >   $ git commit -m "empty" --allow-empty
> >   $ pack="pack-$(git rev-parse HEAD | git pack-objects .git/objects/pack/pack).idx"
> >   $ best-of-five \
> >       -p "rm -rf .git/objects/info/commit-graphs && cp -r .git/objects/info/commit-graphs{.bak,}" \
> >       sh -c "echo $pack | git commit-graph write --split=merge-all"
>
> I think you'd need --stdin-packs in the actual timed command?
>
> At any rate, I think there is a demonstrable speedup there. But
> moreover, I'm pretty sure this existing code is not doing what it
> expects:
>
>   /* only add commits if they still exist in the repo */
>   result = lookup_commit_reference_gently(ctx->r, &oid, 1);
>
> That won't look at the object database at all if the commit is already
> marked as parsed. And that parsing might have come from the commit graph
> itself, as our earlier attempts showed. So switching to a real
> has_object_file() call is an important _correctness_ fix, even leaving
> aside the speed improvements.

That's a great point. I hadn't thought of this myself, but I agree with
your reasoning here, too, and think that this is an important
correctness fix even if it yielded no performance benefit (thankfully,
we get both :)).

> -Peff

Thanks,
Taylor
