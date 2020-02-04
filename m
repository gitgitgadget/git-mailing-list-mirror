Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A74C3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 04:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DBD20732
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 04:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="V+M4Acce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDEGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:06:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38156 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDEGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 23:06:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6so6707660plj.5
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 20:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZSgTimCbZs8SpqR4m9+JNHGNDpTxSxvi2hP8dt+QXBw=;
        b=V+M4AcceWNrn3CmA/jikZ4cbNww8F5wsIcQRiQMNJgtOm1iOej6jmQOe9nyGs3ianh
         nSY3gvL4ufefweqm5zCKIvGNvmDkjJKWTLmu4yUaYkK8v4pJLohLYUh1PWVxpc7aE5i4
         s0hNyGwpYfk1o+/dAU9SEQNwsdSGeIQ4VamEgg/KxJaJ5VVl0umIBcokBC8HikvzoKvg
         bhMKcAgNIMKtOiwSb4WfnXOQ8uh2v0Q4/01nWzwkjXi63y6kLvPrZSmuLNBk3ELa2qoc
         FrLPXL6pHaR5Bnm9XAOtq8wFWmd8ouM0IMeXnk8YH92ehqBWcVbopgrvBfspEMTKSqgo
         lICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZSgTimCbZs8SpqR4m9+JNHGNDpTxSxvi2hP8dt+QXBw=;
        b=j+hAPLlhHVrn2r1dyp7gj5214irCNjkcABBbNqSuvqwPD3R3Mp5L/oeQpkyVDqFAM5
         VUZLni+yOq74SLt1T1Yz0Mlu1fzEHetWgXYhpl1R2uZDm8gOawiflwUrxo+6dEWBxFtJ
         EALagS6xtrIrc49o4ptqyN8kQCHqunWhAP/3Uyho4m0RzQTLXdvFN5I7VuaxJEo6WKAD
         NmQHyzSZ3DZcHfq0Hl+/vl3dS5QJP9vI8/wvlXbZAKKknxAcaUgIQgz+ZGnhntTZUZ3h
         7f/6jFmZBfI2kNKc69GotmirtqkLHlyDsuRV3tisx+/EI032XJtAY9BXIC5Md/XyAq1h
         8Zcg==
X-Gm-Message-State: APjAAAWqEzpejqZbcX6RwMiNW0wXtz1dXCvUY7qGtVJB+xfgDn3u/rtb
        aZRVmNX5WVdzjCuAyDnOP0k1Fw==
X-Google-Smtp-Source: APXvYqzpaQBUzPn4/OweXLwm5sGGA20dArFRLoslEHtIMmqdONT+YD3dU4p2nFsYojyXPyEznnEpyg==
X-Received: by 2002:a17:902:9b8a:: with SMTP id y10mr25873759plp.114.1580789189607;
        Mon, 03 Feb 2020 20:06:29 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id r3sm22436176pfg.145.2020.02.03.20.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 20:06:29 -0800 (PST)
Date:   Mon, 3 Feb 2020 20:06:28 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200204040628.GE5790@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <CAN0heSo29+sf1352EfGv=qFsir-e=Ompja445bh5z3vpOfkaJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSo29+sf1352EfGv=qFsir-e=Ompja445bh5z3vpOfkaJA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 08:27:27PM +0100, Martin Ågren wrote:
> On Fri, 31 Jan 2020 at 01:29, Taylor Blau <me@ttaylorr.com> wrote:
> > With '--split', the commit-graph machinery writes new commits in another
> > incremental commit-graph which is part of the existing chain, and
> > optionally decides to condense the chain into a single commit-graph.
> > This is done to ensure that the aysmptotic behavior of looking up a
>
> asymptotic

Thanks, fixed.

> > commit in an incremental chain is dominated by the number of
> > incrementals in that chain. It can be controlled by the '--max-commits'
> > and '--size-multiple' options.
> >
> > On occasion, callers may want to ensure that 'git commit-graph write
> > --split' always writes an incremental, and never spends effort
> > condensing the incremental chain [1]. Previously, this was possible by
> > passing '--size-multiple=0', but this no longer the case following
> > 63020f175f (commit-graph: prefer default size_mult when given zero,
> > 2020-01-02).
> >
> > Reintroduce a less-magical variant of the above with a new pair of
> > arguments to '--split': '--split=no-merge' and '--split=merge-all'. When
> > '--split=no-merge' is given, the commit-graph machinery will never
> > condense an existing chain and will always write a new incremental.
> > Conversely, if '--split=merge-all' is given, any invocation including it
> > will always condense a chain if one exists.  If '--split' is given with
> > no arguments, it behaves as before and defers to '--size-multiple', and
> > so on.
>
> I understand your motivation for doing this -- it all seems quite sound
> to me. Not being too familiar with this commit-graph splitting and
> merging, I had a hard time groking this terminology though. From what I
> understand, before this patch, `--split` means "write the commit-graph
> using the 'split' file-format / in a split fashion". Ok, that makes
> sense.
>
> >From seeing `--split=no-merge`, I have no idea how to even parse that.
> Of course I don't want to merge, I want to split! Well not split, but
> write split files.
>
> I think it would help me (and others like me) if we could somehow
> separate "I want to use 'split' files" from "and here's how I want you
> to decide on the merging". That is, which "strategy" to use. Obviously,
> talking about a "merge strategy" would be stupid and "split strategy"
> also seems a bit odd. "Coalescing strategy"? "Joining strategy"?
>
> Or can you convince me otherwise? From which angle should I look at
> this?

Heh. This is all very reminiscent of an off-list discussion that I had
with Peff and Stolee before sending this upstream. Originally, I had
implemented this as:

  $ git commit-graph write --split --[no-]merge

but we decided that this '--merge' and '--no-merge' requiring '--split'
seemed to indicate that this was better off as an argument to '--split'.
Of course, there's no getting around that it is... odd to say
'--split=no-merge' for exactly the reason you suggest.

Here's another way of looking at it: the presence of '--split' means
"work with split graph files" and the '[no-]merge' argument means:
"always/never condense multiple layers".

For me, this not only makes the new option language jive, but makes it
clearer to me than the combination of '--split', '--split --no-merge'
and '--split --merge', where the third one is truly bizarre. At least
condensing the second '--' and making 'merge' an argument to 'split'
makes it clear that the two work together somehow.

If you have a different suggestion, I'd certainly love to hear about it
and discuss. But, at least as far as our internal discussions have gone,
this is by far the best option that we have been able to come up with.

> > -With the `--split` option, write the commit-graph as a chain of multiple
> > -commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
> > -not already in the commit-graph are added in a new "tip" file. This file
> > -is merged with the existing file if the following merge conditions are
> > -met:
> > +With the `--split[=<strategy>]` option, write the commit-graph as a
> > +chain of multiple commit-graph files stored in
> > +`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
> > +strategy and other splitting options. The new commits not already in the
> > +commit-graph are added in a new "tip" file. This file is merged with the
> > +existing file if the following merge conditions are met:
> > +* If `--split=merge-always` is specified, then a merge is always
> > +conducted, and the remaining options are ignored. Conversely, if
> > +`--split=no-merge` is specified, a merge is never performed, and the
> > +remaining options are ignored. A bare `--split` defers to the remaining
> > +options. (Note that merging a chain of commit graphs replaces the
> > +existing chain with a length-1 chain where the first and only
> > +incremental holds the entire graph).
>
> To better understand the background for this patch, I read the manpage
> as it stands today. From the section on `--split`, I got this
> impression: Let's say that `--max-commits` is huge, so all that matters
> is the `--size-multiple`. Let's say it's two. If the current tip
> contains three commits and we're about to write one with two, then 2*2 >
> 3 so we will merge, i.e., write a tip file with five commits. Unless of
> course *that* is more than half the size of the file before. And so on.
> We might just merge once, or maybe "many" files in an avalanche effect.
> Every now and then, such avalanches will go all the way back to the
> first file.
>
> Now this says something different, namely that once we decide to merge,
> we do it all the way back, no matter what.
>
> The commit message of 1771be90c8 ("commit-graph: merge commit-graph
> chains", 2019-06-18) seems to support my original understanding, at
> least for `--size-multiple`, but not `--max-commits`, curiously enough.
>
> Can you clarify?

1771be90c8 is right, and this documentation is wrong. Upon re-reading
it, I found the contents of this documentation between those two
parenthesis to be confusing rather than helpful. For that reason, I
simply removed it.

> > -               OPT_BOOL(0, "split", &opts.split,
> > -                       N_("allow writing an incremental commit-graph file")),
> > +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> > +                       N_("allow writing an incremental commit-graph file"),
>
> This still sounds very boolean. Cramming in the "strategy" might be hard
> -- is this an argument in favor of having two separate options? ;-)

Heh. Exactly how we started these patches when I originally wrote
them...

> > +enum commit_graph_split_flags {
> > +       COMMIT_GRAPH_SPLIT_UNSPECIFIED      = 0,
> > +       COMMIT_GRAPH_SPLIT_MERGE_REQUIRED   = 1,
> > +       COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 2
> > +};
>
> I wonder if this should be "MERGE_AUTO" rather than "UNSPECIFIED". This
> is related to Stolee's comment, I think.

I think you're right. I changed it in my local v2.
>
> Martin

Thanks,
Taylor
