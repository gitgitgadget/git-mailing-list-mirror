From: Jeff King <peff@peff.net>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 11:21:45 -0500
Message-ID: <20110114162144.GA867@sigill.intra.peff.net>
References: <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 17:21:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdmPR-0008Rh-D3
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 17:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666Ab1ANQVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 11:21:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52864 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab1ANQVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 11:21:47 -0500
Received: (qmail 5791 invoked by uid 111); 14 Jan 2011 16:21:47 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 14 Jan 2011 16:21:47 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jan 2011 11:21:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165109>

On Fri, Jan 14, 2011 at 05:13:59PM +0100, Erik Faye-Lund wrote:

> > The three-letter minimum is just a sanity check. If your name really
> > is even just three letters, I suspect you're just lying. I don't know
> > of anybody named "A B".
> >
> Thanks for clarifying that it's not there for a technical reason. The
> thing is, git-am seems to be the only place where such a sanity-check
> is performed. Shouldn't git-commit rather perform such checks also (if
> such a check should be done at all), perhaps with an override similar
> to --allow-empty? And on top of all it doesn't barf, it just silently
> replace the name with the e-mail...

I tend to agree with Linus on the stupidity issue, but I do worry about
the subtlety of the results. It causes silent data corruption during a
rebase (or when somebody is applying an emailed patch). On the other
hand, I do understand why Linus made a sanity check in the first place;
his use case is to deal with whatever crap people happen to mail him,
whether they have used git or not.

So we should probably do one or both of:

  1. Make an --allow-any-name option to mailinfo, and use it when we
     invoke mailinfo internally for rebasing. That still doesn't solve
     the emailed patch problem, but at least keeps purely internal
     operations sane.

  2. Bump the check up to git-commit time, which is the best place to
     catch and tell somebody that their name is too short, because they
     can actually fix it.

Even if we dropped the check now, option (2) is still useful, because
you have no idea which version of git the other end will use to apply
your patch.

-Peff
