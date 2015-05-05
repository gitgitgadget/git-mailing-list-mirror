From: Jeff King <peff@peff.net>
Subject: Re: t5570 - not cloned error
Date: Tue, 5 May 2015 18:55:21 -0400
Message-ID: <20150505225521.GB18817@peff.net>
References: <013701d08769$a5bbab80$f1330280$@nexbridge.com>
 <xmqqr3qud6qm.fsf@gitster.dls.corp.google.com>
 <017401d08782$24d6f5b0$6e84e110$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
	'Joachim Schmitz' <jojo@schmitz-digital.de>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Wed May 06 00:55:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YplkP-0006d8-KX
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 00:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbbEEWzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 18:55:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:54542 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932124AbbEEWzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 18:55:24 -0400
Received: (qmail 2230 invoked by uid 102); 5 May 2015 22:55:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 17:55:24 -0500
Received: (qmail 12181 invoked by uid 107); 5 May 2015 22:55:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 18:55:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 18:55:21 -0400
Content-Disposition: inline
In-Reply-To: <017401d08782$24d6f5b0$6e84e110$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268431>

On Tue, May 05, 2015 at 06:23:41PM -0400, Randall S. Becker wrote:

> 
> On May 5, 2015 6:01 PM Junio C Hamano wrote:
> > "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > > We definitely have an issue with localhost. When forcing the DNS
> resolver to
> > > return 127.0.0.1, we pass 1-16 then 17 fails as I expected to happen
> based
> > > on my DNS futzing. Heads up that this test is not-surprisingly sensitive
> to
> > > DNS problems. My environment is still in a messy state where I can
> reproduce
> > > the original problem so it might be a useful moment for me to find a way
> to
> > > modify the test script to harden it. Any suggestion on that score
> > > (as in where and roughly how it might be made more reliable)?
> > 
> > I do not think this counts as a useful "suggestion", but is this
> > "resolver does not work for local as expected" case even worth
> > protecting our tests against?
> 
> I see your point, but after having spent "way too much time" away from the
> $DAYJOB tracking this down, I was hoping to catch the root cause earlier
> next time. Perhaps adding a test step validating that localhost comes back
> with a reasonable value - whatever that may be in context. I'm just not sure
> what the test really needs at its heart to run properly - obviously the IP
> address of the system as  visible in our DMZ is not working for the test.

I'm having trouble even understanding who is looking up "localhost"
here.  All of the git-daemon tests should be directly using 127.0.0.1 in
the URLs (i.e., what is in $GIT_DAEMON_URL). If that is a problem, I
think you might be able to parameterize the way we set up
$GIT_DAEMON_URL (and how we invoked git-daemon; see lib-git-daemon.sh).

In the interpolation tests, we do use the string "localhost" but we
should never do a lookup on it. We set an environment variable that
tells the git client to _tell_ the server we looked up localhost, but we
should still be accessing it as 127.0.0.1.

So I'm confused about what the actual problem is, or why the test cares
about resolving "localhost" in the first place.

-Peff
