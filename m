From: Jeff King <peff@peff.net>
Subject: Re: git status / git diff -C not detecting file copy
Date: Tue, 2 Dec 2014 16:50:13 -0500
Message-ID: <20141202215013.GB25338@peff.net>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
 <CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
 <CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
 <CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
 <20141202065550.GB1948@peff.net>
 <CAGyf7-EHBqZn5LCTYuA+07GSNOF0vVdszL6oTUKwY1ETRDKEwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Pol Online <info@pol-online.net>,
	Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:50:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvvL4-0003dL-NR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 22:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbaLBVuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 16:50:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:47418 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933022AbaLBVuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 16:50:16 -0500
Received: (qmail 32164 invoked by uid 102); 2 Dec 2014 21:50:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 15:50:16 -0600
Received: (qmail 19113 invoked by uid 107); 2 Dec 2014 21:50:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 16:50:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 16:50:13 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-EHBqZn5LCTYuA+07GSNOF0vVdszL6oTUKwY1ETRDKEwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260598>

On Wed, Dec 03, 2014 at 08:40:47AM +1100, Bryan Turner wrote:

> On Tue, Dec 2, 2014 at 5:55 PM, Jeff King <peff@peff.net> wrote:
> >
> > So from these timings, I'd conclude that:
> >
> >   1. It's probably fine to turn on copies for "git status".
> >
> >   2. It's probably even OK to use "-C -C" for some projects. Even though
> >      22s looks scary there, that's only 11ms for git.git (remember,
> >      spread across 2000 commits). For linux.git, it's much, much worse.
> >      I killed my "-C -C" run after 10 minutes, and it had only gone
> >      through 1/20th of the commits. Extrapolating, you're looking at
> >      500ms or so added to a "git status" run.
> >
> >      So you'd almost certainly want this to be configurable.
> >
> > Does either of you want to try your hand at a patch? Just enabling
> > copies should be a one-liner. Making it configurable is more involved,
> > but should also be pretty straightforward.
> 
> I'm interested in taking a stab at a patch, but I'd like to confirm
> which way to go. Based on Junio's reply I'm not certain the simple
> patch could get accepted (assuming I do all the submission parts
> properly and the implementation itself passes review). Does that mean
> the only real option is the configurable patch?

I think this is the part where you get to use your judgement, and decide
what you think the maintainer will take. :)

Personally, I would probably go for the configurable version, as it is
not that much harder, and is a nicer end-point.

Junio gave an example elsewhere in which the config option value would
look like "-C -C". I'd consider trying to match diff.renames instead,
which takes false/true/copies for its three levels. It may make sense to
teach both places "copies-harder" or something similar, for
completeness.

-Peff
