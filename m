Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A7C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60C020722
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="A1opxN/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgCVPoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:44:44 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37504 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCVPon (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 11:44:43 -0400
Received: by mail-pj1-f67.google.com with SMTP id o12so1112928pjs.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pUQNZ83oRcijD1mAWYmnZtmoB7oVeyT/k0sL2bUVkwQ=;
        b=A1opxN/QPnSC/BP//7bB6kV/X4UG8OgddOz29pwkuoE5ZzVnNpVfTzXhSvRIPtyHBr
         OddzYuGCcEXTzoCIBNIhDU/vebGvyFxLLXzlezfNFeFCuV6jEYzquwZyJc3BEogXjJdV
         IOhVYqPMCtaO1VMBr7eSbfDDzNV0WrzZxlyxzYSbW5mL4gQP1rq7ugTgewdpYukiTZxx
         EdtwOD+fGG1fSupcOK8UcUry3nVacDryuAlze5MF5M26ovrUen6TJhZVEg5WXw34T8cP
         A4GV5Mr3CwYyKF9pDa5dLlM9UrYhoz5bDLC2oP0Q2XM8mwbsUrSrbROopbFD12gfKrcn
         EKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pUQNZ83oRcijD1mAWYmnZtmoB7oVeyT/k0sL2bUVkwQ=;
        b=Q3E1QRgWO1y4UuPlV7WWwDdDraEc4iMz3p2zULI8zWWvQZ9JmZaJEg3HcGknhbupaq
         Qb54d7JYVvY7dei2KDkCH0SeP89IQNrbRN4LoTWrkvLGGOqfGm5Ed/D38FTwj92WL95X
         kdTLWz8Z+E/AB/KnSDxCl8tT0tR/y7MRwxKG3is0n6gbtGY7iTSnDaKhJmUq+n9/7O/S
         a1POv/hw6k7hIVLjN2FGBTooJZ4h2xWx+w/4T4E0ai7/kRW8HiLJdY3ZwgtTPMX8g0nx
         hnQDAAsxx1Z+OpYfL7kTamVEjC5SgmFLhRUg6VnbrNvXX04Nk3NTh/td0IWth0VmR9js
         9YfQ==
X-Gm-Message-State: ANhLgQ0z42qK8ywkgLAHG8YD57R64iNLwnmyLOO+bEX02opwk6wEfr8/
        EC/uL3qCH1feVu1qyL3NIdE/Rw==
X-Google-Smtp-Source: ADFU+vuTYRA4rHvSwsDfcasKvwCKVKAN1jMXohZo7QzYYNYY9ChW7sGLSodUZwRKeCbcFs2UBhc16A==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr18100354plb.148.1584891881484;
        Sun, 22 Mar 2020 08:44:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f22sm6389639pgl.20.2020.03.22.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 08:44:41 -0700 (PDT)
Date:   Sun, 22 Mar 2020 09:44:39 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322154439.GA53402@syl.local>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322054916.GB578498@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 01:49:16AM -0400, Jeff King wrote:
> On Sat, Mar 21, 2020 at 08:23:13PM -0400, Derrick Stolee wrote:
>
> > On 3/21/2020 8:20 PM, Taylor Blau wrote:
> > > On Sat, Mar 21, 2020 at 08:03:01PM -0400, Derrick Stolee wrote:
> > >> On 3/21/2020 2:50 PM, Junio C Hamano wrote:
> > >>> Do we need to worry about INFO_QUICK and SKIP_FETCH_OBJECT in this
> > >>> codepath, by the way?
> > >>
> > >> I was coming back to this thread to bring up these exact flags for
> > >> consideration. The good news is that in a partial clone with any
> > >> amount of filtering we will still have all reachable commits, which
> > >> are necessary for the commit-graph to make sense. The only ones that
> > >> would fail has_object_file() are ones removed by GC, but they may
> > >> still exist on the remote. So without SKIP_FETCH_OBJECT, we would
> > >> generate a network call even if the server has GC'd to remove the
> > >> commits. This gets particularly bad when the server returns all
> > >> reachable objects from that commit!
> > >
> > > That makes sense. Do you think something like this should be applied?
> > > +       int flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
> > [...]
> >
> > Yes, I think this is the appropriate update. Thanks!
>
> I'm not so sure.
>
> In a non-partial clone, when would expect QUICK to matter? If we find
> the object is missing, then either:
>
>   - we are racing with repack, and we would benefit from double-checking
>     that the object really is gone
>
>   - we used to have it (since it was mentioned in the graph file) but it
>     went away
>
> Using QUICK means we won't waste time double-checking in the second
> case. But it means we won't catch the first case, and we may generate a
> new graph file that omits the object. They're both optimizations, and I
> don't think we're impacting correctness[1], but it's not clear to me
> whether one is a win over the other. We don't generally expect objects
> we have to go away often.
>
> Skipping fetching seems a little more straight-forward to me. If we had
> it in a graph file, presumably we had the actual object before, too. And
> either we're in the first case above (we really do have it and just need
> to double-check) in which case not saying QUICK would be enough. Or we
> intentionally got rid of it. In which case downloading it just to
> generate a cache is quite silly.

I was going to write that I'm not entirely sure of this, but I tried to
talk myself through it below, and I think that the right flag is *only*
OBJECT_INFO_SKIP_FETCH_OBJECT.

First, I agree with your reasoning that we shouldn't have
OBJECT_INFO_QUICK, that much makes sense to me.

To consider OBJECT_INFO_SKIP_FETCH_OBJECT, let's say that we used to
have some commit, and it got GC'd away. This shouldn't happen unless a
commit is unreachable, so if we ever find ourselves in a situation where
the parent of some other commit is missing, we know that that represents
a true corruption, not the result of a normal 'git gc'.

Now, if we do find ourselves in this case, we know that a 'git
commit-graph write --input=none --split' *would* work because we would
find that the unreachable commit (if it were in the graph) was missing,
and 'OBJECT_INFO_SKIP_FETCH_OBJECT' would tell us not to go looking for
it. Likewise, if the commit weren't already in the graph, this would
work fine, too.

But, most of the time we won't even get a chance to write a new
commit-graph based on existing ones, since 'gc.writeCommitGraph' will
take care of this for us in-process with 'git gc'. This uses
'--reachable' without '--split', so we won't ever invoke
'merge_commit_graph{s,}'.

> So it seems like SKIP_FETCH_OBJECT but _not_ QUICK might be reasonable
> here.

I agree with your original reasoning that OBJECT_INFO_QUICK is the wrong
choice, but I think my reasoning above that
OBJECT_INFO_SKIP_FETCH_OBJECT *is* an appropriate flag is sound.

> -Peff
>
> [1] I'm actually not quite sure about correctness here. It should be
>     fine to generate a graph file without any given commit; readers will
>     just have to load that commit the old-fashioned way. But at this
>     phase of "commit-graph write", I think we'll already have done the
>     close_reachable() check. What does it mean to throw away a commit at
>     this stage? If we're the parent of another commit, then it will have
>     trouble referring to us by a uint32_t. Will the actual writing phase
>     barf, or will we generate an invalid graph file?

Thanks,
Taylor
