Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3751F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 06:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeFAGvY (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 02:51:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:58946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750793AbeFAGvX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 02:51:23 -0400
Received: (qmail 12321 invoked by uid 109); 1 Jun 2018 06:51:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Jun 2018 06:51:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21786 invoked by uid 111); 1 Jun 2018 06:51:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 02:51:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 02:51:21 -0400
Date:   Fri, 1 Jun 2018 02:51:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is origin/HEAD only being created on clone a bug? #leftoverbits
Message-ID: <20180601065121.GA15578@sigill.intra.peff.net>
References: <87bmcyfh67.fsf@evledraar.gmail.com>
 <xmqqo9gyey13.fsf@gitster-ct.c.googlers.com>
 <xmqqbmcxg8sn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmcxg8sn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 11:46:16AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >  - When we fetch from a remote that has refs/remotes/$name/HEAD, and
> >    if the protocol notices that their HEAD today is pointing to a
> >    branch different from what our side has, should we repoint ours
> >    to match?  
> >
> >    I am leaning against doing this, but mostly out of superstition.
> > ...
> >    interested in".  But once fetch starts messing with where
> >    origin/HEAD points at, that would no longer be the case, which is
> >    why I am against doing something magical like that.
> 
> Well, I shouldn't say "I am against" on the last line; rather, "I
> feel uneasy".

I didn't bother to dig up the past discussions, but I am pretty sure we
intentionally avoided updating origin/HEAD without an explicit action
from the user. Because what the other side considers "the default
branch" and what you consider "the default branch" when dealing with the
remote are not necessarily the same thing. If we auto-adjust the symref
on fetch, we might be undoing the user's previous "git remote set-head"
operation.

I don't have any real problem with creating it if it _doesn't_ exist,
though. (I think ideally it would get created by "remote add", but that
command does not always talk to the remote, so this kind of
delayed-create is probably the best we can do).

-Peff
