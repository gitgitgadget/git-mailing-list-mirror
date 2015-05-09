From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is available
Date: Fri, 8 May 2015 21:09:52 -0400
Message-ID: <20150509010952.GA29555@peff.net>
References: <20150416084733.GA17811@peff.net>
 <20150416090138.GG17938@peff.net>
 <CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
 <20150421230929.GA27773@peff.net>
 <CAPig+cQi7SfJJc4d3DJ2mJ0-5vT7LJDttPPec=UEsmjiqtLcZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 09 03:10:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqtHU-0001Y2-4K
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 03:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbbEIBJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 21:09:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:55954 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751536AbbEIBJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 21:09:55 -0400
Received: (qmail 5927 invoked by uid 102); 9 May 2015 01:09:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 20:09:55 -0500
Received: (qmail 25030 invoked by uid 107); 9 May 2015 01:10:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 21:10:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2015 21:09:52 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQi7SfJJc4d3DJ2mJ0-5vT7LJDttPPec=UEsmjiqtLcZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268690>

On Fri, May 08, 2015 at 07:56:28PM -0400, Eric Sunshine wrote:

> I spent some time downloading old Xcode releases and poking through
> the packages. Xcode 3.2.x seems to be the last in the Xcode 3 series,
> and none of the Xcode 3.2.x versions I examined carried getdelim().
> The first package in which I found getdelim() was Xcode 4.1.
> (Unfortunately, Apple doesn't seem to make Xcode 4.0 available for
> download anymore or it's only available to paying developers, so I
> couldn't check it.) According to Wikipedia[1], Xcode 4.1 was released
> the same day as Lion (OS X 10.7 [2]), but was also available to paying
> developers for Snow Leopard (OS X 10.6).
> 
> Consequently, I think it's safe to say that getdelim() is available
> for Lion (10.7) and later. If we don't mind being a bit less
> conservative, then we might assume that it also is available for Snow
> Leopard (10.6), which it definitely supported, but perhaps that's too
> risky, since not everyone would have been a paid subscriber.

Thanks for digging. I'd argue for the conservative choice, simply
because this is a pure optimization. The old code should work just fine,
and people have been living with it for years.

I doubt it will affect many people either way, though. Lion is 4 years
old, and most OS X people seem to upgrade fairly regularly. It is not
like long-term server systems where we are supporting Solaris 7. :)

Want to roll a patch?

> Alternately, we could make the test more dynamic and accurate by
> grepping stdio.h for 'getdelim' or just by trying a test compile,
> though that's probably too expensive.

The natural place would be in configure.ac, and that is orthogonal to
the default Darwin setting, I think.

-Peff
