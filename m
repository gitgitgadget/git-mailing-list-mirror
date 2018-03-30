Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCFA1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeC3S1S (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:27:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752069AbeC3S1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:27:16 -0400
Received: (qmail 23773 invoked by uid 109); 30 Mar 2018 18:27:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 18:27:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30871 invoked by uid 111); 30 Mar 2018 18:28:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 14:28:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 14:27:13 -0400
Date:   Fri, 30 Mar 2018 14:27:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: prefer `--type=bool` over `--bool`,
 etc.
Message-ID: <20180330182713.GA30349@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180329221122.GL2939@sigill.intra.peff.net>
 <20180330052719.GA6628@syl.local>
 <20180330135315.GE29568@sigill.intra.peff.net>
 <xmqqmuyp4kqi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuyp4kqi.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 09:00:05AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... But actually, last-one-wins applies only
> > to a _single_ option, not necessarily unrelated ones. Many other
> > multi-action commands actually have a series of separate boolean flags,
> > and then complain when more than one of the flags is set.
> >
> > So maybe it's not such a good idea for the actions (I do still think
> > it's the right path for the types).
> 
> If this were using command verbs (e.g. "git config get foo.bar") as
> opposed to command options (e.g. "git config --get foo.bar"), it
> wouldn't ahve allowed multiple command verbs from the command line,
> and last-one-wins would not have made much sense because there is no
> way to trigger it as a desirable "feature".
> 
> Just like the topic of the discussion unifies --int/--bool/etc. into
> a single --type={int,bool,...}, perhaps the existing command options
> --get/--list/etc. can be taken as if they were a mistaken historical
> way to spell --action={get,list,...}.  I of course am not recommending
> to add a new "--action" option.  I am suggesting it as a thought-aid
> to see if actions are all that different from value type options.
> 
> I agree that a-bit-per-type that is checked with HAS_MULTI_BITS()
> for error at the end does not make much sense.  I also think what
> you did in this patch for actions is a good clean-up for the above
> reason.

I agree the code internally is nicer after the patch. If we throw away
the argument of "last-one-wins is more consistent with other parts of
git" (because I don't really think that it is for this type of option),
I could possibly buy this as a code cleanup. But it does have a
user-visible impact, which makes the question: are we _OK_ with
switching to last-one-wins?

-Peff
