Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A5E95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbjJHQEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjJHQEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 12:04:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B0AB
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 09:04:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4181bd07f25so26872301cf.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696781046; x=1697385846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GCw0gdLn4UQOfU6Abl2XOqWQT731xBHDOxKn9KKcdQ=;
        b=vzY5K3Se1LvKy/YmXU2k8eCpZLRrGbCdhztO9X709LvAoKTqgcQmdu0XTYzvdasuHd
         I2Uxqc9M5Iigc3zNwCimubTaHzA0A20sT4nDoFRtDBggpFcaWyOlzqJFPvUZX3tRoLIf
         LrqkepFkdDroMKBl1Kvqj2+nFP+dkAWrFsZ75jWNV3YAvC8bYLBLscg12KT/GxU/lkzb
         9ZkQcB9vKLL5TJSSdEalduHEGcdCrSjdC9RvMuC55eZdwiaio5G5dkmxpuvVM31JvJVD
         LSeqCxcmi+C5RcRVEjgm+v3L66NzuO/V0g8XHVPGagRqGviFWRN3gvEs0KpGVsjekiGE
         Mcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696781046; x=1697385846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GCw0gdLn4UQOfU6Abl2XOqWQT731xBHDOxKn9KKcdQ=;
        b=rdPBAkUgJqqTm46c3hnoOH1aAlHPN7Cawsf9+u1pG1tpgbus1uHgLAdO+fV3nMpR/j
         4KVEPSuC7z24eU+moKY748wzEOfRWcNu+9fcUwxNII7Am8yPGY7M421uUxDu9FmBb3Kh
         Jls3TWKdJsgveFYr/TArTtZZL9aV/NrLxK9TfkcVahdKG5H76UYbnN2K2Ird4xBDMFn9
         TZRKwLezLwjdU5moiJT/u/1IqxBEd+4L2Ro/6vzvVbfVmGTfuK//bRpyn6hVzz5Wq8rR
         yPyRmbAXlxY+wRi83zPLM81XJlNWpOzYYrZKvCyBu7pi+bYbYcLgTdYVWGgK16HutOfZ
         EJ+Q==
X-Gm-Message-State: AOJu0Yz8o+VPU4LJS4ljTjlk+0eYEwVuQ4EQ7GvkMXG2AVuRZMXjeRBC
        X2Xv+PRtVpKvae5IhEaW3S2O/g==
X-Google-Smtp-Source: AGHT+IEL9WsFTu+KDISZ1BwJUN2yoZx+O5KdqTqN3MKBHwc190KryShQkVag3P/j95lZSgnq64sMqg==
X-Received: by 2002:a05:622a:1355:b0:418:1272:7c6e with SMTP id w21-20020a05622a135500b0041812727c6emr16402012qtk.7.1696781046545;
        Sun, 08 Oct 2023 09:04:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q5-20020ac84505000000b0041b0a7d1872sm1966436qtn.70.2023.10.08.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 09:04:06 -0700 (PDT)
Date:   Sun, 8 Oct 2023 12:04:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZSLS9G1lHruig48a@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
 <ZSCR7e6KKqFv8mZk@nand.local>
 <CABPp-BE+mJ4e==fWNqUNi5RVkoui_xeZN+axnM6vBykDqAzHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BE+mJ4e==fWNqUNi5RVkoui_xeZN+axnM6vBykDqAzHiA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2023 at 12:02:27AM -0700, Elijah Newren wrote:
> On Fri, Oct 6, 2023 at 4:02 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 03:35:25PM -0700, Junio C Hamano wrote:
> > > Taylor Blau <me@ttaylorr.com> writes:
> > >
> > > > When using merge-tree often within a repository[^1], it is possible to
> > > > generate a relatively large number of loose objects, which can result in
> > > > degraded performance, and inode exhaustion in extreme cases.
> > >
> > > Well, be it "git merge-tree" or "git merge", new loose objects tend
> > > to accumulate until "gc" kicks in, so it is not a new problem for
> > > mere mortals, is it?
> >
> > Yeah, I would definitely suspect that this is more of an issue for
> > forges than individual Git users.
>
> It may still be nice to also do this optimization for plain "git
> merge" as well.  I had it in my list of ideas somewhere to do a
> "fast-import-like" thing to avoid writing loose objects, as I
> suspected that'd actually be a performance impediment.

I think that would be worth doing, definitely. I do worry a little bit
about locking in low-quality deltas (or lack thereof), but more on that
below...

> Oh, at the contributor summit, Johannes said he only needed pass/fail,
> not the actual commits, which is why I suggested this route.  If you
> need to keep the actual commits, then this won't help.

Yep, agreed. Like I said earlier, I think there are some niche scenarios
where we just care about "would this merge cleanly?", but in most other
cases we want to keep around the actual tree.

> I was interested in the same question as Junio, but from a different
> angle.  fast-import documentation points out that the packs it creates
> are suboptimal with poorer delta choices.  Are the packs created by
> bulk-checkin prone to the same issues?  When I was thinking in terms
> of having "git merge" use fast-import for pack creation instead of
> writing loose objects (an idea I never investigated very far), I was
> wondering if I'd need to mark those packs as "less optimal" and do
> something to make sure they were more likely to be repacked.
>
> I believe geometric repacking didn't exist back when I was thinking
> about this, and perhaps geometric repacking automatically handles
> things nicely for us.  Does it, or are we risking retaining
> sub-optimal deltas from the bulk-checkin code?
>
> (I've never really cracked open the pack code, so I have absolutely no
> idea; I'm just curious.)

Yes, the bulk-checkin mechanism suffers from an even worse problem which
is the pack it creates will contain no deltas whatsoever. The contents
of the pack are just getting written as-is, so there's no fancy
delta-ficiation going on.

I think Michael Haggerty (?) suggested to me off-list that it might be
interesting to have a flag that we could mark packs with bad/no deltas
as such so that we don't implicitly trust their contents as having high
quality deltas.

> > I think that like anything, this is a trade-off. Having lots of packs
> > can be a performance hindrance just like having lots of loose objects.
> > But since we can represent more objects with fewer inodes when packed,
> > storing those objects together in a pack is preferable when (a) you're
> > doing lots of test-merges, and (b) you want to keep those objects
> > around, e.g., because they are reachable.
>
> A couple of the comments earlier in the series suggested this was
> about streaming blobs to a pack in the bulk checkin code.  Are tree
> and commit objects also put in the pack, or will those continue to be
> written loosely?

This covers both blobs and trees, since IIUC that's all we'd need to
implement support for merge-tree to be able to write any objects it
creates into a pack. AFAIK merge-tree never generates any commit
objects. But teaching 'merge' to perform the same bulk-checkin trick
would just require us implementing index_bulk_commit_checkin_in_core()
or similar, which is straightforward to do on top of the existing code.

Thanks,
Taylor
