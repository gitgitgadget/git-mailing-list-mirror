Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA7120986
	for <e@80x24.org>; Thu, 29 Sep 2016 09:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbcI2JPO (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 05:15:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:49811 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932185AbcI2JPN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 05:15:13 -0400
Received: (qmail 12731 invoked by uid 109); 29 Sep 2016 09:15:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 09:15:12 +0000
Received: (qmail 32332 invoked by uid 111); 29 Sep 2016 09:15:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 05:15:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 05:15:10 -0400
Date:   Thu, 29 Sep 2016 05:15:10 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
Cc:     Junio C Hamano <gitster@pobox.com>, torvalds@linux-foundation.org,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160929091509.2n4mdrevwxechqol@sigill.intra.peff.net>
References: <20160928233047.14313-5-gitster@pobox.com>
 <20160929024400.22605-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160929024400.22605-1-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 04:44:00AM +0200, SZEDER Gábor wrote:

> >     So 12 seems reasonable, and the only downside for it (or for "13", for
> >     that matter) is a few extra bytes. I dunno, maybe people will really
> >     hate that, but I have a feeling these are mostly cut-and-pasted anyway.
> 
> I for one raise my hand in protest...
> 
> "few extra bytes" is not the only downside, and it's not at all about
> how many characters are copy-and-pasted.  In my opinion it's much more
> important that this change wastes 5 columns worth of valuable screen
> real estate e.g. for 'git blame' or 'git log --oneline' in projects
> that don't need it and certainly won't ever need it.

True. The core of the issue is that we really only care about this
minimum length when _storing_ an abbreviation, but we don't know when
the user is just looking at it in the moment, and when they are going to
stick it in a commit message, email, or bug tracker.

In an ideal world, anybody who was about to store it would run "git
describe" or something to come up with some canonical reference format.
And we could just bump the default minimum there. Personally, I almost
exclusively cite commits as the output of:

  git log -1 --pretty='tformat:%h (%s, %ad)' --date=short

and I'd be fine to stick "--abbrev=12" in there for future-proofing. But
I don't know what the kernel or other projects do.

I'd also be curious to know if the patch I sent in [1] to more
aggressively prefer commits would make this less of an issue, and people
wouldn't care as much about using longer hashes in the first place. So
one option is to merge that (and possibly even make it the default) and
see if people still care in 6 months.

-Peff

[1] http://public-inbox.org/git/20160927123801.3bpdg3hap3kzzfmv@sigill.intra.peff.net/
