From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 15:07:59 -0400
Message-ID: <20160601190759.GB12496@sigill.intra.peff.net>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
 <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
 <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
 <20160601163747.GA10721@sigill.intra.peff.net>
 <20160601183100.GN1355@john.keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:08:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8BV0-0000Kr-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 21:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcFATIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 15:08:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:47438 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbcFATID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 15:08:03 -0400
Received: (qmail 23602 invoked by uid 102); 1 Jun 2016 19:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 15:08:02 -0400
Received: (qmail 3980 invoked by uid 107); 1 Jun 2016 19:08:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 15:08:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 15:07:59 -0400
Content-Disposition: inline
In-Reply-To: <20160601183100.GN1355@john.keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296150>

On Wed, Jun 01, 2016 at 07:31:00PM +0100, John Keeping wrote:

> > >  reset_submodule_urls () {
> > > -	local root
> > > -	root=$(pwd) &&
> > >  	(
> > > +		root=$(pwd) &&
> > >  		cd super-clone/submodule &&
> > >  		git config remote.origin.url "$root/submodule"
> > >  	) &&
> > >  	(
> > > +		root=$(pwd) &&
> > >  		cd super-clone/submodule/sub-submodule &&
> > >  		git config remote.origin.url "$root/submodule"
> [...]
> I wonder if it's relevant that the "local root" line isn't &&-chained?
> Is it possible that on some shells we ignore an error but everything
> still works?

I don't think so. We're inside a function, so we wouldn't affect any
outer &&-chaining in the function (and there isn't any in the caller
anyway). I think it's a reasonable custom not to bother &&-chaining
"local" lines, as they come at the top of a function and can't fail.

-Peff
