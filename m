From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/18] convert trivial cases to ALLOC_ARRAY
Date: Mon, 15 Feb 2016 23:23:46 -0500
Message-ID: <20160216042346.GB27060@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
 <20160215215154.GE10287@sigill.intra.peff.net>
 <CAPig+cRTz4Fb10JDWLjmTEXzQ+FbvmKU51A9B3vmwBepDX+BYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 05:23:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVXB3-0001ba-6H
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 05:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbcBPEXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 23:23:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:42772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752053AbcBPEXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 23:23:48 -0500
Received: (qmail 21323 invoked by uid 102); 16 Feb 2016 04:23:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 23:23:48 -0500
Received: (qmail 16325 invoked by uid 107); 16 Feb 2016 04:23:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 23:23:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 23:23:46 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRTz4Fb10JDWLjmTEXzQ+FbvmKU51A9B3vmwBepDX+BYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286318>

On Mon, Feb 15, 2016 at 11:22:12PM -0500, Eric Sunshine wrote:

> On Mon, Feb 15, 2016 at 4:51 PM, Jeff King <peff@peff.net> wrote:
> > Each of these cases can be converted to use ALLOC_ARRAY or
> > REALLOC_ARRAY, which has two advantages:
> >
> >   1. It automatically checks the array-size multiplication
> >      for overflow.
> >
> >   2. It always uses sizeof(*array) for the element-size,
> >      so that it can never go out of sync with the declared
> >      type of the array.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 77a51d3..0eabe68 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -854,7 +854,7 @@ static char **get_path_split(void)
> >         if (!n)
> >                 return NULL;
> >
> > -       path = xmalloc((n+1)*sizeof(char *));
> > +       ALLOC_ARRAY(path, n+1);
> 
> Elsewhere in this patch, you've reformatted "x+c" as "x + c"; perhaps
> do so here, as well.

Will do. I noticed while going over this before sending it out that it
may also be technically possible for "n+1" to overflow here (and I think
in a few other places in this patch). I don't know how paranoid we want
to be.

-Peff
