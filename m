Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFE02022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbdBWTmJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:42:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:60980 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdBWTmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:42:08 -0500
Received: (qmail 11651 invoked by uid 109); 23 Feb 2017 19:35:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:35:27 +0000
Received: (qmail 2015 invoked by uid 111); 23 Feb 2017 19:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 14:35:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 14:35:24 -0500
Date:   Thu, 23 Feb 2017 14:35:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170223193524.e7jsik4nwchjaeoe@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
 <20170222234246.wjp3567vesdusiaf@sigill.intra.peff.net>
 <xmqq1suo90za.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1suo90za.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 11:11:05AM -0800, Junio C Hamano wrote:

> >> As far as Kerberos, this is a desirable feature to have enabled, with
> >> little downside.  I just don't know about the security of the NTLM part,
> >> and I don't think we should take this patch unless we're sure we know
> >> the consequences of it.
> >
> > Hmm. That would be a problem with my proposed patch 2 then, too, if only
> > because it turns the feature on by default in more places.
> >
> > If it _is_ dangerous to turn on all the time, I'd think we should
> > consider warning people in the http.emptyauth documentation.
> 
> I presume that we have finished discussing the security
> ramification, and if I am not mistaken the conclusion was that it
> could leak information if we turned on emptyAuth unconditionally
> when talking to a wrong server, and that the documentation needs an
> update to recommend those who use emptyAuth because they want to
> talk to Negotiate servers to use the http.<site>.emptyAuth form,
> limited to such servers, not a more generic http.emptyAuth, to avoid
> information leakage?

I don't know enough to evaluate the claims of emptyAuth being dangerous
or not (nor do I use it myself or admin a server whose users need it).
So I will let interested parties hash out whether it is a good idea or
not, and I'm happy to drop my 2/2 for now.

If we are to make it more widely available, I would prefer something
more like my 2/2 than always turning on http.emptyAuth, if only because
it reduces the cost to people not using the feature. I'm happy to work
more on the patch if we decide to go that route.

> If that is the case, let's take your 1/2 in the near-by thread
> without 2/2 (auto-enable emptyAuth) for now, as Dscho seems to have
> a case that may be helped by it.

Yes, I think 1/2 stands on its own. Whether it helps Dscho's case or
not, it eliminates an HTTP round-trip for Basic-only servers, which I
think is worth it.

-Peff
