From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Introduce remote.pushdefault
Date: Sun, 17 Mar 2013 01:48:03 -0400
Message-ID: <20130317054803.GB16070@sigill.intra.peff.net>
References: <7v1ucr43mk.fsf@alter.siamese.dyndns.org>
 <1360314123-1259-1-git-send-email-artagnon@gmail.com>
 <7v4nhm1s85.fsf@alter.siamese.dyndns.org>
 <CALkWK0m2N=D47WJLk1F4j1GsGGWHyfxVF_WGXBbG3vyrfQ-oLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6Sb-000832-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab3CQFsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 01:48:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54029 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab3CQFsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 01:48:06 -0400
Received: (qmail 6919 invoked by uid 107); 17 Mar 2013 05:49:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 01:49:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 01:48:03 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0m2N=D47WJLk1F4j1GsGGWHyfxVF_WGXBbG3vyrfQ-oLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218334>

On Sun, Mar 17, 2013 at 06:00:08AM +0530, Ramkumar Ramachandra wrote:

> >> +remote.pushdefault::
> >> +     The remote to push to by default.  Overrides the
> >> +     branch-specific configuration `branch.<name>.remote`.
> >
> > It feels unexpected to see "I may have said while on this branch I
> > push there and on that branch I push somewhere else, but no, with
> > this single configuration I'm invalidating all these previous
> > statements, and all pushes go to this new place".
> >
> > Shouldn't the default be the default that is to be overridden by
> > other configuration that is more specific?  That is, "I would
> > normally push to this remote and unless I say otherwise that is all
> > I have to say, but for this particular branch, I push to somehwere
> > else".
> 
> I'm a little confused as to where this configuration variable will be
> useful.  On a fresh clone from Github, I get branch.master.remote
> configured to "origin".  How will adding remote.pushdefault have any
> impact, unless I explicitly remove this branch-specific remote
> configuration?  Besides, without branch.<name>.remote configured, I
> can't even pull and expect changes to be merged.  So, really: what is
> the use of remote.pushdefault?
> 
> I'm dropping this patch, and just going with branch.<name>.pushremote,
> unless you convince me otherwise.

That is why I described the scheme I did in [1]. It uses the following
two general rules:

  1. Per-branch config trumps repo-wide config.

  2. Push-specific config (e.g., "remote.pushdefault") trumps
     non-specific config (e.g., "remote.default") for pushing.

So the push lookup list is (in order of precedence):

  1. branch.*.pushremote
  2. remote.pushdefault
  3. branch.*.remote
  4. remote.default
  5. origin

and it solves Junio's issue because the way to say "override my
remote.pushdefault for this branch" is not to set "branch.*.remote", but
to set "branch.*.pushremote".

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/215751
