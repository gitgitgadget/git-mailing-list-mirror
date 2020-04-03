Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593B5C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D3E206B8
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="q7sqFMK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgDCT5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:57:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36726 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCT5k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:57:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id c23so4048114pgj.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jglO8U6EWgMFikQjdrJJLGpHx1rUW4DkjB5XI1TIsMI=;
        b=q7sqFMK+2sOwoaBxWpHU6PagLaa89vseBzryozkQWsP/NxH/oQHluT89eojCBz7tbU
         zp4fgnYvEqjTH+QzWoiZSws0w8I/u74h2VfxVj0sVk4HXrTZd9Vgup2p8EKo45OqKqkk
         kXyY5vlsHm7hdDBbevEQOY51dGFYFSsHfYs4YoOJSJcgRVEYHiaK7rBZT9Wpa3tO9nsk
         5KcNMzf/Zu+EBNIed7ZZqrX6OxP3qQSmWACTtkzKXcLODz2K8rOF6cDLBdxTy+Ff79GR
         uJIbmP6oKSCwNFWXsi0PzsBB595TzP+w4Mp6R6yg9b7hEIUJrOruYGE9pqp5eB3CYnMS
         x+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jglO8U6EWgMFikQjdrJJLGpHx1rUW4DkjB5XI1TIsMI=;
        b=q5224gupyf57bB2Ek9degk5zl8J4iyDC+jEvFy1f6QDJYzHu3cxU7uDap0weDOKO90
         3x//YZCV9EJWIhJ8gOtX0GfM9LPM+gxwHac1cTnKiPhVnYpOy9Dxsvlx+wbESmayd/CE
         cOxbtCoA6jSJqRohDcGYkOWNKyg+4t667RtGykmht5a+Krn3za6TCnZZH/4sJM3xiQkv
         cE32SF397eg1tOBLPu6hGvUD9bGG7qxgE7bimvfVBgdOy2D/cVegFipyVGZUS4G6LtuB
         +kbh5Tu+Z2d+4DQAcmAvx3igqI0A266NGk6QI1CQd+T6Ru9GHI8oHcG2RJFOt4w2TBQ3
         jSOA==
X-Gm-Message-State: AGi0PubMJuMCNzxpLJ34Z3rBqVYuatCDrP9Z+7SGOEE2GQ4fiHftrnjy
        CRYkzFUrTam4Iq2LupWqdn+Vmw==
X-Google-Smtp-Source: APiQypL2/Ox0/q0PJiN0WHmCQx1zJftLLCWM0vRxoHXjExR6nZImvn+61hm1PNC0NL8HC/zdxqZp5A==
X-Received: by 2002:a63:715b:: with SMTP id b27mr9366695pgn.351.1585943857430;
        Fri, 03 Apr 2020 12:57:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o3sm5672590pgk.21.2020.04.03.12.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:57:36 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:57:36 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200403195736.GB58262@syl.local>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
 <xmqqd08oz70o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd08oz70o.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 12:47:03PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Fri, Apr 03, 2020 at 02:30:57PM -0400, Jeff King wrote:
> >> On Mon, Aug 05, 2019 at 10:02:40AM +0200, SZEDER Gábor wrote:
> >>
> >> > Check that all input records are indeed valid commit object ids and
> >> > return with error otherwise, the same way '--stdin-packs' handles
> >> > invalid input; see e103f7276f (commit-graph: return with errors during
> >> > write, 2019-06-12).
> >>
> >> Can you explain more why the old behavior is a problem? For reasons (see
> >> below), we want to do something like:
> >>
> >>   git for-each-ref --format='%(objectname)' |
> >>   git commit-graph write --stdin-commits
> >> ...
> >>  - you're generating an incremental graph update. You know somehow that
> >>    a few refs were updated, and you want to feed those tips to generate
> >>    the incremental, but not the rest of the refs (not because it would
> >>    be wrong to do so, but in the name of keeping it O(size of change)
> >>    and not O(number of refs in the repo).
> >> ...
> >> Normally I'm in favor of more error checking instead of less, but in
> >> this case it feels like it's putting scripted use at a disadvantage
> >> versus the internal code (e.g., the auto-write for git-fetch uses the
> >> "--reachable" semantics for its internal invocation).
>
> I think the "incremental from the tip of refs" is a valid and useful
> use case.  I am not sure if the rationale given in the original to
> compare the (stricter) check done here and what e103f7276f did
> (which does not seem to get any input, valid or invalid, from the
> end users) was a meaningful comparison, and regardless of Gábor's
> answer to Peff's question, I think we should have an easy way to let
> the machinery itself filter non-commit, so "--[no-]check-oids" that
> optionally turns the stricter checking off would be an easy way out.

Thanks. I think that this is probably my preference, too. I'll send this
as a patch to the list shortly...

> I do not have a strong opinion on which way the default should be
> (at least not yet), but given that this was already in two major
> releases ago, I'd assume that stricter-by-default-with-escape-hatch
> would be the way to go (at least for now).

Yeah. I think the nice thing about those patches is that we don't have
to decide that right away.

> > For what it's worth, (and in case it wasn't obvious) this came about
> > because we feed '--stdin-commits' at GitHub, and observed exactly this
> > error case. I wasn't sure what approach would be more palatable, so I
> > prepared both in my fork at https://github.com/ttaylorr/git:
> >
> >   - Branch 'tb/commit-graph-dont-check-oids' drops this checking
> >     entirely.
> >
> >   - Branch 'tb/commit-graph-check-oids-option' adds a
> >     '--[no-]check-oids', in case that this is generally desirable
> >     behavior, by offering an opt-out of this OID checking.
>
> Thanks.

Likewise :).

Thanks,
Taylor
