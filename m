Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3D720C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbdFLV7F (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:59:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:38564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752386AbdFLV7E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:59:04 -0400
Received: (qmail 4905 invoked by uid 109); 12 Jun 2017 21:59:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:59:04 +0000
Received: (qmail 17080 invoked by uid 111); 12 Jun 2017 21:59:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:59:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:59:02 -0400
Date:   Mon, 12 Jun 2017 17:59:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv2 1/5] revision.h: turn rev_info.early_output back into
 an unsigned int
Message-ID: <20170612215902.62cnfxdivv76337p@sigill.intra.peff.net>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
 <20170609181733.6793-2-szeder.dev@gmail.com>
 <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net>
 <xmqq60g1ndtz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq60g1ndtz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 01:36:08PM -0700, Junio C Hamano wrote:

> > I'm not sure if I was just being thick or if that point (and the fact
> > that --early-output has basically been a noop since 2011!) should be
> > made more explicit.
> >
> > Given that nobody noticed, I kind of wonder if we should consider
> > ripping the feature out entirely.
> 
> Yes, we may want to think about deprecating it, especially given
> that it is not advertised anywhere.
> 
> In any case, the patch looks correct ;-)

Yeah, it's definitely orthogonal to Gábor's patches.

I also wondered who might be using the feature. I assumed it was written
with gitk in mind. Digging in the list archive that seems to be the
case, and there was even an RFC patch for gitk to use it:

  http://public-inbox.org/git/18221.2285.259487.655684@cargo.ozlabs.ibm.com/

but AFAICT it was never merged.

It looks like QGit had a patch around that time, too, but left
the line using "--early-output" commented out until Git merged the
patches. And then it never got uncommented. ;)

Tig doesn't seem to use it at all. I don't know about other GUIs. I'd
kind of doubt, given the obscurity of the feature (both gitk and qgit
authors were involved in the discussion way back in 2007).

The nice thing about deprecating it is that I think callers need to be
prepared to handle the case already that it does nothing. So if we just
ripped out the code and treated it as a silent noop, everything would
just work.

-Peff
