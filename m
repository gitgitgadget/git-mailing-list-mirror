Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F45C20960
	for <e@80x24.org>; Wed, 12 Apr 2017 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753650AbdDLJMA (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 05:12:00 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:59514 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbdDLJL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 05:11:57 -0400
Received: from [10.100.4.232] (nat2.ableton.net [217.110.199.118])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 36FA1302D1C;
        Wed, 12 Apr 2017 11:11:51 +0200 (CEST)
To:     peff@peff.net (Jeff King)
Cc:     jacob.keller@gmail.com (Jacob Keller),
        avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
        matt@mattmccutchen.net (Matt McCutchen),
        git@vger.kernel.org (git), gitster@pobox.com (Junio C Hamano)
In-Reply-To: <20170411125054.23ivvoyqj6y4suyo@sigill.intra.peff.net>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Wed, 12 Apr 2017 11:11:51 +0200
Message-ID: <1n4d6uj.1qtz8h11jkb2rM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:

> On Tue, Apr 11, 2017 at 02:37:27PM +0200, Stefan Haller wrote:
> 
> > Are you talking about the case where the user doesn't say git pull, but
> > instead says "git fetch && git merge --ff @{u}"? Just so that I
> > understand the concern.
> 
> Yes, that (which is the main way that I merge changes).

OK; in my proposal I already mentioned that a few other commands besides
push and pull may have to update the lease; examples I mentioned were 

   git rebase @{u}
   git reset @{u}

and you add "git merge --ff @{u}" to that list now. There might be
others that we can add to make the feature work better. (But this could
happen incrementally later, as we learn about more use cases.)

> But also what happens with:
> 
>   git merge origin/other-branch
>   git rebase origin/master
> 
> I think we only care when origin/master has independently merged
> other-branch, too. And even though we have taken its commits into
> account, we would fail (because "both sides did the same thing" is
> really out of scope for the concept of a lease). So that's OK.

I think there's nothing special to consider here; "git rebase
origin/master" updates the lease (to origin/master), period. It doesn't
matter whether origin/other-branch was merged before, or whether or not
it was independently merged to origin/master too, or whether our local
branch has cherry-picked all the commits of other-branch instead of
merging it, or whatever. In all these cases, the local branch is "up to
date" with origin/master after the rebase, so it's ok to update the
lease at that point.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
