From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/6] pack-objects hook for upload-pack
Date: Thu, 26 May 2016 01:44:18 -0400
Message-ID: <20160526054418.GB21580@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 07:44:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5o5q-0005TG-4D
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 07:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbcEZFoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 01:44:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:44470 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbcEZFoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 01:44:21 -0400
Received: (qmail 8227 invoked by uid 102); 26 May 2016 05:44:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 01:44:21 -0400
Received: (qmail 17204 invoked by uid 107); 26 May 2016 05:44:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 01:44:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 01:44:19 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295635>

On Tue, May 24, 2016 at 05:59:15PM -0700, Junio C Hamano wrote:

> On Wed, May 18, 2016 at 3:37 PM, Jeff King <peff@peff.net> wrote:
> > I've often wanted to intercept the call from upload-pack to
> > pack-objects. The final patch in this series goes into more detail, but
> > basically it's good for:
> >
> >   1. Capturing the output from pack-objects for debugging/inspection.
> >
> >   2. Capturing the input to pack-objects to replay for debugging or
> >      performance analysis.
> >
> >   3. Caching pack-objects output.
> >
> > It's pretty trivial to add a hook to run instead of pack-objects (and
> > the hook would just run pack-objects itself). But we don't want to run
> > hooks in upload-pack, because we don't necessarily trust the repository
> > we're running in.
> 
> Although I'd need to study the final step a bit more carefully than I did,
> overall I think these are good changes. The way the callbacks learn
> about the origin of the configuration may have to be rethought in the
> long run, though. We already have been relying on a filename thing
> kept separately as a global variable, and the approach taken by this
> series extends it, so we are not making anything fundamentally worse,
> but at some point we may need to bite the bullet and pass kv-info as
> an extra callback parameter or something.

Yeah, I had the same thought while working on this, but just didn't want
to have to tweak every config callback. As you say, I don't think this
makes anything fundamentally worse, though. I'm inclined to go with this
strategy, especially with the extra die("BUG") safety added here. But I
can look into changing the callbacks if you feel strongly.

-Peff

PS Did you have any thoughts on the t/helper problem mentioned in:

     http://article.gmane.org/gmane.comp.version-control.git/295029

   I suspect it will bite you if you try merging/testing this.
