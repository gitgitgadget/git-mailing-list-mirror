From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 14/14] shortlog: match commit trailers with --ident
Date: Mon, 4 Jan 2016 05:31:06 -0500
Message-ID: <20160104103106.GC32086@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
 <20151229073832.GN8842@sigill.intra.peff.net>
 <20151229075013.GA9191@sigill.intra.peff.net>
 <CAPig+cTqfd4QezR09QwUb_7viML_4LB5ChNF_eXVCsbGHLaDMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 11:31:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG2Q7-0008DU-Sm
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 11:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbcADKbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 05:31:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:48215 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753386AbcADKbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 05:31:09 -0500
Received: (qmail 6954 invoked by uid 102); 4 Jan 2016 10:31:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 05:31:09 -0500
Received: (qmail 1167 invoked by uid 107); 4 Jan 2016 10:31:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 05:31:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2016 05:31:06 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTqfd4QezR09QwUb_7viML_4LB5ChNF_eXVCsbGHLaDMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283296>

On Mon, Jan 04, 2016 at 04:44:15AM -0500, Eric Sunshine wrote:

> On Tue, Dec 29, 2015 at 2:50 AM, Jeff King <peff@peff.net> wrote:
> > This doesn't leave us many syntactic "outs" for adding new ident types
> > in the future (nor can you match a trailer called "Author"). I guess we
> > could call this "--ident=trailer:reviewed-by" to be more precise, but
> > it's more annoying to type. Perhaps we could consider that the
> > "official" syntax, and DWIM "--ident=foo" to "--ident=trailer:foo", with
> > the caveat that it may change in the future. I dunno.
> 
> Would anyone ever want to be able to specify multiple trailers for
> counting? That is:
> 
>     --ident=trailer:helped-by,reviewed-by
> 
> or
> 
>     --ident=trailer:helped-by --ident=trailer:reviewed-by

Generally I'd prefer the latter, as it builds on the existing option
parsing rather than inventing a new syntax. But it would also allow
mixing trailer and non-trailer items, like:

  git shortlog --ident=trailer:helped-by --ident=author

I guess that is well-formed, though I would expect it to be rare. I
dunno.

I'd rather punt on handling multiple types in this initial attempt, and
let somebody implement that later if they want. I suppose if we did a
release with one and then the other, it would technically change the
meaning of:

  git shortlog --ident=foo --ident=bar

from "just bar, overriding foo" to "both foo and bar". I think I could
live with that, though.

-Peff
