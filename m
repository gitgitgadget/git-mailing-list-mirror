From: Jeff King <peff@peff.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Fri, 20 Feb 2015 05:49:21 -0500
Message-ID: <20150220104921.GA2467@peff.net>
References: <20150218182547.GA6346@peff.net>
 <xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
 <20150218185734.GB7257@peff.net>
 <54E5BBDD.7040100@drmicha.warpmail.net>
 <20150219121438.59050ce8@pc09.procura.nl>
 <54E5C6E2.9040101@drmicha.warpmail.net>
 <20150219125433.GA1591@peff.net>
 <54E5E347.4070401@drmicha.warpmail.net>
 <20150220014801.GB16124@peff.net>
 <54E70E2B.8000604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:49:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOl9F-00031s-1H
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbbBTKtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:49:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:51529 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753994AbbBTKtX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:49:23 -0500
Received: (qmail 17633 invoked by uid 102); 20 Feb 2015 10:49:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 04:49:24 -0600
Received: (qmail 9547 invoked by uid 107); 20 Feb 2015 10:49:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 05:49:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2015 05:49:21 -0500
Content-Disposition: inline
In-Reply-To: <54E70E2B.8000604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264160>

On Fri, Feb 20, 2015 at 11:36:27AM +0100, Michael J Gruber wrote:

> > It's not quite so bad as you make out. We write the value to the
> > GIT-BUILD-OPTIONS file during "make", no matter where it comes from, and
> > load that in test-lib.sh. So:
> > 
> >   make NO_ICONV=Nope
> >   cd t
> >   ./t3901-i18n-patch.sh
> > 
> > works just fine (for this and for any of the other options we mark
> > there).
> 
> It survives a cd, sure...

I think the interesting thing is that it survives running `./tXXXX`
rather than running the test through make.

> Now, change your config.mak before the cd and
> forget the make. Not everyone does
> 
> make -C t t3901-i18n-patch.sh
> 
> Though, having just discovered that shell completion works for that
> form, too, I may do it more often (and then complain about having to use
> GIT_TEST_OPTS ;) )

Yeah, I never use "make tXXXX" myself. But nor would I expect the tests
to respect a version of git I had not actually built. E.g., if you build
with NO_PERL, and then remove NO_PERL from your config.mak but do _not_
actually run "make", should that work? Ditto for NO_ICONV, for that
matter. The tests must match the binary, and the best guess we have
about the binary is the last thing we built.

Adding "git --build-options" would give us a better guess (it may not be
what the user _wanted_ to test, but it is what they _are_ testing).

> > I suspect GIT_TEST_INSTALLED is not all that widely used, or somebody
> > would have complained before. But if we really want to support it, I
> > think the right thing is to bake GIT-BUILD-OPTIONS into the binary, so
> > that "git --build-options" dumps it. It might also have value for
> > debugging and forensics in general.
> 
> Yep, that would be helpful in general. I don't think we should worry
> about GIT_TEST_INSTALLED too much. Who came up with that feature anyway...?

Clearly a crazy person. :) I am not saying it is a _bad_ idea. Only that
the responsibility to make sure the installed version matches the
current build parameters lies with the user (and for that matter, the
current set of tests; we add new tests that would fail on old versions,
and you cannot mix and match).

So an alternate explanation than "not widely used" is "all of the users
of it are responsible individuals who do not make bogus bug reports to
the list". :)

-Peff
