Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC461FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 07:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbcFPHeP (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 03:34:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:55470 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751931AbcFPHeO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 03:34:14 -0400
Received: (qmail 4882 invoked by uid 102); 16 Jun 2016 07:34:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 03:34:13 -0400
Received: (qmail 13647 invoked by uid 107); 16 Jun 2016 07:34:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 03:34:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 03:34:10 -0400
Date:	Thu, 16 Jun 2016 03:34:10 -0400
From:	Jeff King <peff@peff.net>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	ZhenTian <loooseleaves@gmail.com>, git@vger.kernel.org
Subject: Re: I lost my commit signature
Message-ID: <20160616073410.GA651@sigill.intra.peff.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
 <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net>
 <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net>
 <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
 <CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
 <20160615043450.GA3975@sigill.intra.peff.net>
 <be771366-00a7-6c20-2623-5fa54b8e19b7@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be771366-00a7-6c20-2623-5fa54b8e19b7@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 15, 2016 at 09:07:16AM +0200, Michael J Gruber wrote:

> > Ah, so the problem is probably that you had a signature _initially_, but
> > that it did not survive the rebase. Which makes sense, as rebase would
> > need to re-sign.  It does not by default, but you can tell it to do so
> > with "-S". Or you can set `commit.gpgsign`, which should sign in both
> > cases.
> 
> While it's clear that a rebase invalidates the signature, we could try
> to be more helpful here, especially given the fact that (with our model)
> you can't sign a commit afterwards any more.
> 
> commit.gpgsign signs everything, but there should be a mode for
> re-signing signed commits, or at least a warning that rebase dropped a
> signature so that you can --amend -S the last commit.

I had a similar thought, though I'm not sure how useful a "re-sign
signed commits" mode would be in practice. Mostly because I'm not sure
why signing would be more important for one commit versus another.

That is, I can see why somebody would set "commit.gpgSign"; their
preference (or that of their project) is to sign commits, and they've
set up gpg, etc, to make it relatively painless.

But why does somebody run "commit -S" for a single commit, but not all
the time? Is it because that commit is special? Or is that particular
moment special? One implies that it's important for the signature to be
retained during a rebase, and one does not.

So I dunno. I would not be opposed to such a feature, but I'm having
trouble figuring out why it would be useful (though for the most part, I
do not see why anything but per-project commit.gpgSign config is
particularly useful. Maybe I just lack imagination).

-Peff
