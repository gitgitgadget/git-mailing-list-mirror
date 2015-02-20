From: Jeff King <peff@peff.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Thu, 19 Feb 2015 20:48:01 -0500
Message-ID: <20150220014801.GB16124@peff.net>
References: <20150218170007.784be6aa@pc09.procura.nl>
 <54E4CFDC.40401@drmicha.warpmail.net>
 <20150218182547.GA6346@peff.net>
 <xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
 <20150218185734.GB7257@peff.net>
 <54E5BBDD.7040100@drmicha.warpmail.net>
 <20150219121438.59050ce8@pc09.procura.nl>
 <54E5C6E2.9040101@drmicha.warpmail.net>
 <20150219125433.GA1591@peff.net>
 <54E5E347.4070401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:34:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOeMi-0001ID-Fx
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 04:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbbBTDeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 22:34:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:51368 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753696AbbBTDep (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 22:34:45 -0500
Received: (qmail 28437 invoked by uid 102); 20 Feb 2015 03:34:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Feb 2015 21:34:45 -0600
Received: (qmail 5450 invoked by uid 107); 20 Feb 2015 01:48:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Feb 2015 20:48:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2015 20:48:01 -0500
Content-Disposition: inline
In-Reply-To: <54E5E347.4070401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264132>

On Thu, Feb 19, 2015 at 02:21:11PM +0100, Michael J Gruber wrote:

> > It passes NO_ICONV through to the test suite, sets up a prerequisite,
> > disables some test scripts which are purely about i18n (e.g.,
> > t3900-i18n-commit), and marks some of the scripts with one-off tests
> > using the ICONV prereq.
> 
> Hmm. I know we pass other stuff down, but is this really a good idea? It
> relies on the fact that the git that we test was built with the options
> from there. This assumptions breaks (with) GIT_TEST_INSTALLED, if not more.
> 
> Basically, it may break as soon as we run the tests by other means than
> "make", which is quite customary if you run single tests.
> 
> (And we do pass config.mak down, me thinks, but NO_ICONV may come from
> the command line.)

It's not quite so bad as you make out. We write the value to the
GIT-BUILD-OPTIONS file during "make", no matter where it comes from, and
load that in test-lib.sh. So:

  make NO_ICONV=Nope
  cd t
  ./t3901-i18n-patch.sh

works just fine (for this and for any of the other options we mark
there).

It won't work for GIT_TEST_INSTALLED, but that is not a new problem.
Fundamentally you cannot expect to test a version built without option X
without telling git _somehow_ that it was built that way.

I suspect GIT_TEST_INSTALLED is not all that widely used, or somebody
would have complained before. But if we really want to support it, I
think the right thing is to bake GIT-BUILD-OPTIONS into the binary, so
that "git --build-options" dumps it. It might also have value for
debugging and forensics in general.

> Jeff, you got it wrong. You should do the hard part and leave the easy
> part to us!

Oops. :)

-Peff
