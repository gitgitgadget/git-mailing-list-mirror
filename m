Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F3F1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbcKNTH3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:07:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:42961 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754630AbcKNTH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:07:28 -0500
Received: (qmail 15458 invoked by uid 109); 14 Nov 2016 19:07:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 19:07:28 +0000
Received: (qmail 3795 invoked by uid 111); 14 Nov 2016 19:07:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 14:07:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 14:07:26 -0500
Date:   Mon, 14 Nov 2016 14:07:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: [PATCH] fetch/push: document that private data can be leaked
Message-ID: <20161114190725.fxjymvztc2eiomv6@sigill.intra.peff.net>
References: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
 <1479001205.3471.1.camel@mattmccutchen.net>
 <xmqq1syezs3g.fsf@gitster.mtv.corp.google.com>
 <1479148088.2406.27.camel@mattmccutchen.net>
 <xmqqbmxhyjij.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmxhyjij.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 11:00:04AM -0800, Junio C Hamano wrote:

> Matt McCutchen <matt@mattmccutchen.net> writes:
> 
> >> Yup, and then "do not push to untrustworthy place without checking
> >> what you are pushing", too?
> >
> > If there is no private data in the repository, then there is no need
> > for the user to check what they are pushing. As I've indicated before,
> > IMO manually checking each push would not be a workable security
> > measure in the long term anyway.
> 
> Then what is?  Don't answer; this is a rhetorical question.
> 
> The answer is "do not push to untrustworthy place", if you are
> unable to check what you are pushing.

I think "check what you are pushing" only covers one case (attacker lies
to you during a fetch, and you accidentally push that back, thinking
they already have it).

But consider the other case mentioned: the attacker lies to you while
pushing and _says_ they have X, then deduces information from the delta
you generate. The only advice there is "do not push to an untrusted
place from a repository containing private objects".

So I think the in-between answer is "it is OK to push to an
untrustworthy place, but do not do it from a repo that may contain
secret contents".

-Peff
