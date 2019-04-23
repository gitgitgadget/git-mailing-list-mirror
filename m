Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81EC71F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 02:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfDWCNP (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 22:13:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:37588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729541AbfDWCNP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 22:13:15 -0400
Received: (qmail 14041 invoked by uid 109); 23 Apr 2019 02:13:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 02:13:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4904 invoked by uid 111); 23 Apr 2019 02:13:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 22:13:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 22:13:12 -0400
Date:   Mon, 22 Apr 2019 22:13:12 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Santiago Torres Arias <santiago@nyu.edu>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.us
Subject: Re: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Message-ID: <20190423021312.GC16369@sigill.intra.peff.net>
References: <20190412201432.11328-1-santiago@nyu.edu>
 <20190422152726.GB1633@sigill.intra.peff.net>
 <20190422154655.sxyrkee7rnywoh2w@LykOS.localdomain>
 <20190422160211.GB9680@sigill.intra.peff.net>
 <20190422230701.GD6316@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422230701.GD6316@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 11:07:01PM +0000, brian m. carlson wrote:

> On Mon, Apr 22, 2019 at 12:02:11PM -0400, Jeff King wrote:
> > On Mon, Apr 22, 2019 at 11:46:56AM -0400, Santiago Torres Arias wrote:
> > 
> > > > In some ways I'm less concerned about verify-tag, though, because the
> > > > point is that it should be scriptable. And scraping gpg's stderr is not
> > > > ideal there. We should be parsing --status-fd ourselves and making the
> > > > result available via format specifier, similar to the way "log
> > > > --format=%G?" works.
> > > 
> > > I think that would be great, as we could make it simpler for verifiers
> > > to parse gpg output.
> > 
> > Alternatively, we could make it an option to dump the --status-fd output
> > to stderr (or to a custom fd). That still leaves the caller with the
> > responsibility to parse gpg's output, but at least they're parsing the
> > machine-readable bits and not the regular human-readable stderr.
> 
> Don't we already have that for verify-tag and verify-commit? I recall
> adding "--raw" for that very reason:

Heh. Today I learned about "--raw". :)

Thanks for pointing it out. I do still think it would be nice for some
cases to have --format specifiers to get the basic info, but I am glad
that we already have a reasonable method that scripts can use.

It might make sense to make it available from the git-tag porcelain,
too, but since the point is scripting, I'm not sure it's all that
important.

It looks like using "--format" suppresses it, too, which we'd probably
want to fix (presumably it's the same as the fix for the non-raw
output).

> The idea was that users might want to restrict signatures to using
> subkeys or certain algorithms or what-have-you, and this was the easiest
> way to let people have all of that power.

Yeah, that makes perfect sense.

-Peff
