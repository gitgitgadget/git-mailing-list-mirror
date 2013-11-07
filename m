From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitignore.txt: clarify recursive nature of excluded
 directories
Date: Thu, 7 Nov 2013 11:55:46 -0800
Message-ID: <20131107195546.GA13456@sigill.intra.peff.net>
References: <527BC00D.8000501@gmail.com>
 <527BC068.3040303@gmail.com>
 <xmqqa9hg59av.fsf@gitster.dls.corp.google.com>
 <xmqq61s457gd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 20:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeVgH-0003mW-Dd
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 20:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab3KGTzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 14:55:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:35126 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752191Ab3KGTzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 14:55:48 -0500
Received: (qmail 9919 invoked by uid 102); 7 Nov 2013 19:55:48 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Nov 2013 13:55:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Nov 2013 11:55:46 -0800
Content-Disposition: inline
In-Reply-To: <xmqq61s457gd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237426>

On Thu, Nov 07, 2013 at 11:37:38AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Karsten Blees <karsten.blees@gmail.com> writes:
> >
> >> Additionally, precedence of negated patterns is exactly as outlined in
> >> the DESCRIPTION section, we don't need to repeat this.
> >
> > Very good, thanks.
> >
> > Even though I have a suspicion that somebody else may be able to
> > come up with a better phrase that does not sound unnecessarily
> > strongly than "recursively and irrevocably", that somebody else is
> > not me, so I'll queue this as-is for now.
> 
> Just in case somebody thinks about rephrasing, to me, these two
> words sound heavier than the information they actually convey, and
> that is why I said "unnecessarily strong".

I agree that it seems unnecessarily strong.  The word "irrevocable" to
me implies that it cannot ever be changed. But of course it is only
irrevocable for the particular run; you can always edit the .gitignore
file. :)

> The key thing in the behaviour when a directory is excluded is that
> it tells us to stop going into that directory, and there is no way
> to override it with another .gitignore file somewhere inside,
> because we are told not to even bother looking for it.  "Recursively
> and irrevocably" may be an accurate description of the end result,
> but that sounds more like a rule without a "because"; to a reader
> (me), it lacks the "aha, of course" that comes from understanding
> why.

I think it is more than just "we do not descend and so do not read the
.gitignore file". I thought the previous discussion on this topic showed
that you cannot do:

  $ cat .gitignore
  foo
  !foo/bar

to see foo/bar.

> >>   - An optional prefix "`!`" which negates the pattern; any
> >>     matching file excluded by a previous pattern will become
> >> -   included again.  If a negated pattern matches, this will
> >> -   override lower precedence patterns sources.
> >> +   included again. It is not possible to re-include a file if a parent
> >> +   directory of that file is excluded (i.e. excluding a directory
> >> +   will recursively and irrevocably exclude the entire content).
> >>     Put a backslash ("`\`") in front of the first "`!`" for patterns
> >>     that begin with a literal "`!`", for example, "`\!important!.txt`".

How about:

  It is not possible to re-include a file if a parent directory of that
  file is excluded. Once git considers a directory excluded, it does not
  descend into the directory to consider its contents further.

> >> +Example to exclude everything except a specific directory `foo/bar`
> >> +(note the `/*` - without the slash, the wildcard would also exclude
> >> +everything within `foo/bar`):
> >> +
> >> +--------------------------------------------------------------
> >> +    $ cat .gitignore
> >> +    # exclude everything except directory foo/bar
> >> +    /*
> >> +    !/foo
> >> +    /foo/*
> >> +    !/foo/bar
> >> +--------------------------------------------------------------

That looks good to me. The simplest example would be handling a
top-level directory (i.e., ignore all except `/foo`). That is a subset
of what's happening above, and I think showing the general case is good.
I'd worry slightly that a non-astute reader might not figure out how to
simplify down to the top-level case, and we should have two examples. I
may just be overly pessimistic, though.

-Peff
