From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: document that pruning happens before fetching
Date: Tue, 14 Jun 2016 02:17:53 -0400
Message-ID: <20160614061752.GA11935@sigill.intra.peff.net>
References: <20160613235850.GA8009@sigill.intra.peff.net>
 <CA+P7+xpk6HqeJfUcAkpTbW_hO6dyjanXoqaaKqdTU363n=-Stw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git mailing list <git@vger.kernel.org>,
	Tom Miller <jackerran@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 08:18:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bChfr-0006yU-GC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 08:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbcFNGR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 02:17:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:54415 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750987AbcFNGR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 02:17:56 -0400
Received: (qmail 8197 invoked by uid 102); 14 Jun 2016 06:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 02:17:55 -0400
Received: (qmail 25487 invoked by uid 107); 14 Jun 2016 06:18:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 02:18:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 02:17:53 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xpk6HqeJfUcAkpTbW_hO6dyjanXoqaaKqdTU363n=-Stw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297267>

On Mon, Jun 13, 2016 at 11:14:36PM -0700, Jacob Keller wrote:

> On Mon, Jun 13, 2016 at 4:58 PM, Jeff King <peff@peff.net> wrote:
> > This was changed in 10a6cc8 (fetch --prune: Run prune before
> > fetching, 2014-01-02), but it seems that nobody in that
> > discussion realized we were advertising the "after"
> > explicitly.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I include myself in that "nobody" of course. :)
> >
> >  Documentation/fetch-options.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> > index 036edfb..b05a834 100644
> > --- a/Documentation/fetch-options.txt
> > +++ b/Documentation/fetch-options.txt
> > @@ -52,7 +52,7 @@ ifndef::git-pull[]
> >
> >  -p::
> >  --prune::
> > -       After fetching, remove any remote-tracking references that no
> > +       Before fetching, remove any remote-tracking references that no
> >         longer exist on the remote.  Tags are not subject to pruning
> >         if they are fetched only because of the default tag
> >         auto-following or due to a --tags option.  However, if tags
> 
> What's the difference in behavior due to pruning before instead of
> after? Curious. It seems like pruning after would make more sense?

See 10a6cc8. :)

Basically, you have to prune first to make way for new incoming refs
when there is a D/F conflict.

The downside is that there is a moment where objects may be unreferenced
(e.g., if upstream moved "foo" to "bar", we delete "foo" and _then_
create "bar"). And due to the way refs are stored, we do not keep even a
reflog for the deleted ref in the interim.

-Peff
