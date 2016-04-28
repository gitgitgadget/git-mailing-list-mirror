From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 11:28:11 -0400
Message-ID: <20160428152811.GC31063@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
 <20160428133744.GC25319@sigill.intra.peff.net>
 <CAGZ79karNW3+xiZQuoh5v-nRabs+h-5pyHDfjHS4vTVBkAyv_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:28:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnrX-0005me-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbcD1P2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:28:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:58454 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752195AbcD1P2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:28:14 -0400
Received: (qmail 31035 invoked by uid 102); 28 Apr 2016 15:28:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:28:14 -0400
Received: (qmail 10847 invoked by uid 107); 28 Apr 2016 15:28:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:28:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 11:28:11 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79karNW3+xiZQuoh5v-nRabs+h-5pyHDfjHS4vTVBkAyv_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292901>

On Thu, Apr 28, 2016 at 08:25:29AM -0700, Stefan Beller wrote:

> > +test_expect_success 'cmdline credential config passes submodule update' '
> > +       # advance the submodule HEAD so that a fetch is required
> > +       git commit --allow-empty -m foo &&
> > +       git push "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git" HEAD &&
> > +       sha1=$(git rev-parse HEAD) &&
> > +       git -C super-clone update-index --cacheinfo 160000,$sha1,sub &&
> 
> The use of update-index seems elegant to me, though different than
> any submodule test I wrote so far. :)

Yeah, I actually wrestled with finding the shortest recipe to convince
git-submodule to actually call git-fetch. Suggestions welcome if there's
something more canonical.

But I think we have to advance the submodule pointer in some way to
convince it to want to fetch (I also tried deleting the refs in the
cloned module, but that seemed hacky).

I guess the way it would happen in real life is that the "origin" remote
("super" here, not "super-clone") would make the change and commit the
submodule, and then "super-clone" would pull it.

That seemed even more convoluted to me.

-Peff
