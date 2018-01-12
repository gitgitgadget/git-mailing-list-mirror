Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E591FADF
	for <e@80x24.org>; Fri, 12 Jan 2018 00:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeALAfH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 19:35:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:41702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754095AbeALAfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 19:35:06 -0500
Received: (qmail 31329 invoked by uid 109); 12 Jan 2018 00:35:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 00:35:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27449 invoked by uid 111); 12 Jan 2018 00:35:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 19:35:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 19:35:04 -0500
Date:   Thu, 11 Jan 2018 19:35:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Andreas G. Schacker" <andreas.schacker@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc/read-tree: remove obsolete remark
Message-ID: <20180112003503.GA14128@sigill.intra.peff.net>
References: <20180109153034.22970-1-andreas.schacker@gmail.com>
 <20180111104914.GA5897@sigill.intra.peff.net>
 <xmqqbmi0z0b7.fsf@gitster.mtv.corp.google.com>
 <20180111222155.GA13570@sigill.intra.peff.net>
 <xmqqd12gxa2o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd12gxa2o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 03:14:07PM -0800, Junio C Hamano wrote:

> >> Doesn't "git read-tree --prefix=previous HEAD^" add paths like
> >> "previous/Documentation/Makefile" to the index, i.e. instead of
> >> forcing you to have the required slash at the end, we give one for
> >> free when it is missing?
> >
> > Yes, I think it does what you'd want with that path. But it would not do
> > what you want by adding "previous-file". Which seems like a gotcha that
> > should be mentioned.
> 
> I am a bit puzzled.  
> 
> Do you mean a user who types "git read-tree --prefix=v1- HEAD^" may
> be expecting to see that the blob object "HEAD^:Makefile" added at
> path "v1-Makefile" etc?

Sorry, I was somewhat turned around in my example, thinking that we were
matching existing entries by prefix here and not putting entries into a
new prefix[1].

But yes, your example hits the point that I think is left unsaid: does
"--prefix=sub" mean the same thing as "--prefix=sub/", or is it a true
string prefix? Reading more carefully, though, we say "under the
directory at <prefix>" in the earlier part, which is probably
sufficient.

Note that this _is_ different than "git checkout-index --prefix", which
is a strict string prefix (i.e., you can checkout "--prefix=v1-" and get
"v1-Makefile").

-Peff

[1] I was trying to figure out which feature of Git I was confusing it
    with, but couldn't find one. I think I may have just been thinking
    of checkout-index (which is not about matching existing paths, but
    does have the different behavior). Normally matching of existing
    paths is done with pathspecs, which I think should all use directory
    boundaries for prefix-matching.
