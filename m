From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 04:07:55 -0400
Message-ID: <20071019080755.GO14735@spearce.org>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <20071019075725.GA29436@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IimuW-0005YW-M1
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933808AbXJSIIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761154AbXJSIII
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:08:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51707 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbXJSIIB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:08:01 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iimtf-0006gQ-Bv; Fri, 19 Oct 2007 04:07:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC92D20FBAE; Fri, 19 Oct 2007 04:07:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071019075725.GA29436@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61669>

Jeff King <peff@peff.net> wrote:
> On Fri, Oct 19, 2007 at 03:39:39AM -0400, Shawn O. Pearce wrote:
> 
> > What about this on top of Jeff's patch?
> > 
> > $ git fetch jc
> > ...
> > ==> git://repo.or.cz/alt-git.git
> >  * tag junio-gpg-pub ......................... (new)
> >  * tag v1.5.0 .......................... (tag moved)
> 
> Ugh. I strongly suspect that it would look ugly on anything bigger than
> about 80 columns, anyway. You are probably better off just not worrying
> about the terminal width, and always using an 80-ish column total. And
> then you don't have to worry about the ugly ioctl call.

Then you get linewrap on smaller terminals, and bigger ones don't
line up the right side.  *shrug*
 
> > +			show_update("* branch", note, "->", "FETCH_HEAD", NULL);
> 
> Hrm, btw, I can't seem to get this one to show (I was curious how ugly
> the FETCH_HEAD would look).

Yea, I can't easily see how to get this to generate.
 
> >  		if (verbose)
> > -			fprintf(stderr, " - %s == %s\n",
> > -				note, pretty_ref);
> > +			show_update("-", note, "==", pretty_ref, "unchanged");
> >  		return 0;
> 
> Also, I was unable to generate a test case that showed this one. Did
> you?

git fetch -v jc

> > +static void determine_window_size(void)
> > +{
> > +	struct winsize ws;
> > +	if (!ioctl(2, TIOCGWINSZ, &ws))
> > +		ws_cols = ws.ws_col;
> > +}
> > +
> 
> Ugh. How portable is this?

No clue.  It compiles fine here on Mac OS X and on Linux, but those
are both reasonably modern UNIX systems.  Older systems like Solaris
8 or an ancient OpenBSD might have an issue.  I suspect though that
this is a reasonably standard thing but its not in POSIX so uh,
probably a bad thing to do.

-- 
Shawn.
