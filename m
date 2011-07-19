From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Tue, 19 Jul 2011 16:00:22 -0400
Message-ID: <20110719200022.GB3957@sigill.intra.peff.net>
References: <20110714200144.GE26918@sigill.intra.peff.net>
 <CAP8UFD3p8rv9BoPkTYSr_qRztKhWmmHgjHi0pZ6gN9YzkSX0Jw@mail.gmail.com>
 <20110718034106.GB2468@sigill.intra.peff.net>
 <201107190614.38431.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Ted Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 22:00:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjGT1-0007Ev-39
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 22:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092Ab1GSUA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 16:00:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40423
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1GSUAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 16:00:25 -0400
Received: (qmail 1185 invoked by uid 107); 19 Jul 2011 20:00:52 -0000
Received: from m-0-33.docsis.hbci.com (HELO sigill.intra.peff.net) (64.213.220.33)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jul 2011 16:00:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jul 2011 16:00:22 -0400
Content-Disposition: inline
In-Reply-To: <201107190614.38431.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177499>

On Tue, Jul 19, 2011 at 06:14:38AM +0200, Christian Couder wrote:

> >      But once you start replacing commits, you need to put in a
> >      reasonable value for the timestamp. So you may well be replacing a
> >      perfectly valid commit with one that has bogus, skewed information
> >      in the commit timestamp.
> 
> Perhaps but with "git replace" you can choose to create new replace refs and 
> deprecate the old replace refs to fix this where you got it wrong.
> 
> It would be easier to do that if "git replace" supported sub directories like 
> "refs/replace/clock-skew/ted-july-2011/", so you could manage the replace refs 
> more easily.

I think all of the arguments I cut from your email are reasonable, but
the crux of the issue comes down to this point.

If you are interested in actually correcting the skew, then yes, replace
refs are a good solution. But doing so is going to involve somebody
looking at the commits and deciding which ones are wrong, and what they
should be. And maybe that's a good thing to do for people who really
care about cleaning history.

But for something like "speed up revision traversal by assuming commit
timestamps are roughly increasing", we want something very automated,
and what is needs to say is much weaker (not "this is what this commit
_should_ say", but rather "this commit might be right, but it is not a
good point for cutting off a traversal"). So that's a much easier
problem, and it's easy to do in an automated way.

So I think while you could use replace refs to handle this issue, it is
not always going to be the right solution, and there is room for
something simpler (and weaker).

-Peff
