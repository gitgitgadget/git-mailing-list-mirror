Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C761FF6D
	for <e@80x24.org>; Wed, 30 Nov 2016 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758667AbcK3TNh (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 14:13:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:49164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754516AbcK3TNg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 14:13:36 -0500
Received: (qmail 2625 invoked by uid 109); 30 Nov 2016 19:06:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 19:06:55 +0000
Received: (qmail 22912 invoked by uid 111); 30 Nov 2016 19:07:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 14:07:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 14:06:53 -0500
Date:   Wed, 30 Nov 2016 14:06:53 -0500
From:   Jeff King <peff@peff.net>
To:     Eli Barzilay <eli@barzilay.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: gitconfig includes
Message-ID: <20161130190653.kk5pboas54yen2it@sigill.intra.peff.net>
References: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
 <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com>
 <CALO-gutJbM=LA3q8vdmbQJLoeCFAJWfPHFo8f1vz-5KJHVxJ6g@mail.gmail.com>
 <20161129214604.c5xcw3d2a5ydpx42@sigill.intra.peff.net>
 <xmqqeg1udkg4.fsf@gitster.mtv.corp.google.com>
 <CALO-gusHzTaLg=7X=KqYB==Yz_6yH6qkh8GDK54Lacu5ofD2pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALO-gusHzTaLg=7X=KqYB==Yz_6yH6qkh8GDK54Lacu5ofD2pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 01:54:35PM -0500, Eli Barzilay wrote:

> I don't have any strong opinion, but FWIW, the use case I have for this
> is as follows: I sync my ~/.gitconfig between my own machine and a work
> machine.  On the work machine though, I like people to have work emails,
> and I wrote some scripts that verify that.  For my case, I added an
> include of a ~/.gitconfig.more which is not synced, and has values that
> override the ones in ~/.gitconfig.  Since I'm the one who also wrote
> that script, I just added an "--includes" to the check so it won't barf
> on my setup, but had it not been my script I'd be stuck.

I'm not sure what your script does exactly, but in general I think the
right thing for most scripts is _not_ to use a specific-file option like
--global.

If the script is looking up a config value on behalf of a user, it
probably makes sense for it to use the normal config lookup procedure
(system, global, repo, command-line), which also enables includes by
default. That would make it consistent with internal git config lookups
(e.g., user.name probably only ever appears in global config, but you
_can_ override it at the repo level if you want to).

I know that's mostly orthogonal to what we're discussing, but I'd feel
more convinced that enabling "--includes" with "--global" is useful if I
thought that "--global" was useful in the first place outside of a few
narrow debugging cases.

-Peff
