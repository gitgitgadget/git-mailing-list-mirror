Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B6DC433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 02:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B42065D
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 02:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgF2CE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:04:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47590 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgF2CE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 22:04:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D37A31F5AE;
        Mon, 29 Jun 2020 02:04:27 +0000 (UTC)
Date:   Mon, 29 Jun 2020 02:04:27 +0000
From:   Eric Wong <e@yhbt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: `seen' datapoint [
Message-ID: <20200629020427.GA8153@dcvr>
References: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
 <20200628192227.GA20227@dcvr>
 <xmqqy2o6fyxl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2o6fyxl.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@yhbt.net> writes:
> 
> > So I had receive.denyNonFastforwards=true set, and a
> > special cases for `pu':
> >
> > 	fetch = +refs/heads/pu:refs/remotes/origin/pu
> 
> Hmph.  I thought receive.denyNonFastforwards was for pushing into
> the repository, so it is a bit puzzling that you bring up "only
> updates to fetch into 'pu' is allowed to be forced" like this.
> Such an arrangement would let you know when 'next' got rewound,
> which is another plus ;-)

Yeah, I can't recall when I started using denyNonFastforwards;
but it was probably a paranoid thing to ensure I'd notice if
`master' got rewound.

> > Which necessitated s/pu/seen/.  So I wonder if there's other
> > denyNonFastforwards users out there affected.  Anyways, just
> > a data point...
> 
> I can sort-of see how the special case would work, but what makes
> your setting fetch other branches like 'master', 'todo', and 'next'?
> 
> Do you have a separate "fetch" refspec for each of the ones you are
> interested in?

Nope, I use the catch-all as you describe below

> Or "remote.origin.fetch = refs/heads/*:refs/remotes/origin/*" which
> serves as the default catch-all (which overlaps with the "pu can be
> fast forwarded" you showed---I don't recall how we designed such a
> set-up to work offhand, so I am a bit curious) works as a natural
> "require fast-forward in general, but a more specific rule about
> 'pu' allows non-fast-forward updates"?

I only have `+' entries for `next' and `seen',
the catch-all provides the rest.

	fetch = +refs/heads/seen:refs/remotes/origin/seen
	fetch = +refs/heads/next:refs/remotes/origin/next
	fetch = refs/heads/*:refs/remotes/origin/*
