Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2807F20970
	for <e@80x24.org>; Tue, 11 Apr 2017 12:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbdDKMhe (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 08:37:34 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:41229 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdDKMha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 08:37:30 -0400
Received: from [10.1.0.219] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id C677B302790;
        Tue, 11 Apr 2017 14:37:28 +0200 (CEST)
To:     peff@peff.net (Jeff King)
Cc:     jacob.keller@gmail.com (Jacob Keller),
        avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
        matt@mattmccutchen.net (Matt McCutchen),
        git@vger.kernel.org (git), gitster@pobox.com (Junio C Hamano)
In-Reply-To: <20170410183120.oa5yqwvlrdzitqci@sigill.intra.peff.net>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Tue, 11 Apr 2017 14:37:27 +0200
Message-ID: <1n4bn17.oag6uj12fkc2fM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:

> On Sun, Apr 09, 2017 at 10:38:42AM +0200, Stefan Haller wrote:
> 
> > I think it's wrong to think about these leases as something that you
> > take before you start a rewindy operation. That's the wrong time to take
> > the lease; by that time, the remote tracking branch may already contain
> > new things that you haven't seen yet, so using that as a lease at that
> > time will overwrite those things later. You have to take the lease at a
> > time where you know that your local branch and the remote tracking
> > branch are up to date with each other, which is after pull and push. And
> > if you do that, there's no multiple-operation ambiguity to deal with at
> > all.
> 
> OK. I was assuming that you'd have just integrated before starting such
> a rebase, but I guess that doesn't have to be the case.
> 
> I agree that probably makes the multiple-operation stuff go away, which
> is nice. It does raise the question of when the integration point
> happens, and how we handle alternate paths through which commits may
> land in a local branch (e.g., if both you and upstream do a ff-merge of
> a particular branch).

Are you talking about the case where the user doesn't say git pull, but
instead says "git fetch && git merge --ff @{u}"? Just so that I
understand the concern.

> I think that would probably just end up with extra
> failures though (so erring on the side of caution). 

Yes, and I think this is a very important decision in general.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
