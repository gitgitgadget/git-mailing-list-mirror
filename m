From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 8 Feb 2016 09:24:40 -0500
Message-ID: <20160208142439.GA8262@sigill.intra.peff.net>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
 <alpine.DEB.2.20.1602061518220.2964@virtualbox>
 <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox>
 <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
 <20160208141552.GC27054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 15:24:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSmkC-0001OM-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 15:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbcBHOYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 09:24:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:39196 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750929AbcBHOYm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 09:24:42 -0500
Received: (qmail 31229 invoked by uid 102); 8 Feb 2016 14:24:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 09:24:41 -0500
Received: (qmail 5312 invoked by uid 107); 8 Feb 2016 14:24:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 09:24:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 09:24:40 -0500
Content-Disposition: inline
In-Reply-To: <20160208141552.GC27054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285769>

On Mon, Feb 08, 2016 at 09:15:52AM -0500, Jeff King wrote:

> I wonder if we could fix this pretty simply, though, by skipping the
> "does it have a wildcard" check when we see a colon in the path. That is
> a good indication that we are using one of git's special rev syntaxes
> (either "tree:path", or ":path", or ":/search string". That breaks
> anybody who really wanted to look for "path:with:colons.*", but that
> seems a lot less likely to me.

Actually, I guess:

  :/foo

does have a meaning as a pathspec (though again, this is only about
limiting the wildcard case, so I think that's OK). More worrisome would
be:

  :(literal)[brackets]

which is almost certainly a pathspec.

So I guess I would revise my suggestion to: we could probably do a lot
better (but not perfectly, of course) by guessing at basic syntactic
components.

-Peff
