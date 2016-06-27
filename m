Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531C42018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbcF0QU4 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:20:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:33304 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751863AbcF0QUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:20:55 -0400
Received: (qmail 28018 invoked by uid 102); 27 Jun 2016 16:20:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:20:55 -0400
Received: (qmail 8913 invoked by uid 107); 27 Jun 2016 16:21:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 12:21:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 12:20:53 -0400
Date:	Mon, 27 Jun 2016 12:20:53 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] config: add conditional include
Message-ID: <20160627162052.GA4532@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com>
 <20160626182715.GA12546@sigill.intra.peff.net>
 <CACsJy8DAMe3YH-f_Qm8FEmanXepnwF2z1L6DDGoJf1eysmW2xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DAMe3YH-f_Qm8FEmanXepnwF2z1L6DDGoJf1eysmW2xQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 06:14:17PM +0200, Duy Nguyen wrote:

> >> +             } else if (!strchr(pattern.buf, '/')) {
> >> +                     /* no slashes match one directory component */
> >> +                     strbuf_insert(&pattern, 0, "**/", 3);
> >> +                     strbuf_addstr(&pattern, "/**");
> >> +             }
> >
> > I guess it's a little funny that "foo" and "foo/bar" are matched quite
> > differently. I wonder if a simpler rule would just be: relative paths
> > are unanchored.
> 
> I modeled it after .gitignore patterns, but that's probably not a good
> fit here. Making all relative paths un-anchored means I can't say
> "paths that end with this suffix". How useful that statement is, I
> can't say though. Or if you mean only prepend "**/" to relative paths,
> not "/**" then that door is still open.

I didn't really mean anything, as I had not thought about it that
carefully. :)

You do allow distinguishing the suffix thing with "/" at the end in the
rule above, though. So between the two rules:

  - slash at the end is a shorthand for "/**"

  - no-slash at the beginning (i.e., a non-absolute path) is a shorthand
    for "**/" at the beginning

you should be able to specify anything.

I do agree that there's value in trying to make the rules consistent
with other parts of git, though. I don't know the corner cases of
gitignore and gitattributes well enough to compare off the top of my
head, though (though I suspect you do. :) ).

-Peff
