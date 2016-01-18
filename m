From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] shortlog: match both "Author:" and "author" on stdin
Date: Mon, 18 Jan 2016 14:27:39 -0500
Message-ID: <20160118192739.GA1009@sigill.intra.peff.net>
References: <20160115170627.GA20983@sigill.intra.peff.net>
 <20160115170823.GA21102@sigill.intra.peff.net>
 <CAPig+cQXDn+iR29vKzSRAUBYgXzTiR5MykKAtvCcF0SE7J4kUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 20:27:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFSs-0000n7-7P
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 20:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbcART1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 14:27:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:55572 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932168AbcART1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 14:27:41 -0500
Received: (qmail 29611 invoked by uid 102); 18 Jan 2016 19:27:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:27:41 -0500
Received: (qmail 12982 invoked by uid 107); 18 Jan 2016 19:28:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:28:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 14:27:39 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQXDn+iR29vKzSRAUBYgXzTiR5MykKAtvCcF0SE7J4kUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284305>

On Fri, Jan 15, 2016 at 06:19:30PM -0500, Eric Sunshine wrote:

> > +/*
> > + * If header is "author", match candidate against the regex /[Aa]uthor:? /,
> > + * and return a pointer to the remainder of the string in out_value.
> > + */
> > +static int match_ident_header(const char *candidate, const char *header,
> > +                             const char **out_value)
> > +{
> > +       const char *v;
> > +
> > +       if (tolower(*candidate++) != tolower(*header++))
> > +               return 0;
> 
> Presumably, this will never be invoked as match_ident_header("", "",
> ...) so we don't have to worry about it accessing beyond end-of-string
> when it gets past this conditional. Does it deserve an
> assert(*candidate) at the top of the function, though, or is that
> overkill?

Good point. It shouldn't happen (we will always feed a string literal),
but it never hurts to document assumptions with an assertion.

However, there is some reason to think this isn't the ideal function;
see the message I just posted elsewhere in the thread.

-Peff
