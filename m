From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Mechanical conversion to use prefixcmp()
Date: Wed, 21 Feb 2007 13:41:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702211340490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702191839.05784.andyparkins@gmail.com>
 <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net> <200702200942.18654.andyparkins@gmail.com>
 <7v3b51xihy.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702201243000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7iuct3ic.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 13:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJqn6-0001Uw-Ew
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 13:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbXBUMlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 07:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXBUMlc
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 07:41:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:52481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751243AbXBUMl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 07:41:27 -0500
Received: (qmail invoked by alias); 21 Feb 2007 12:41:25 -0000
X-Provags-ID: V01U2FsdGVkX1/cAV4iGOLciVPoBDPJdta01PNAlid47SKGcRa98+
	8pYA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7iuct3ic.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40296>

Hi,

On Tue, 20 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Ha, I did it by
> >
> > $ perl -pi.bup -e \
> >  's/strncmp\( *("[^"]*"), *([^"]*), *[0-9]* *\)/prefixcmp\($2, $1\)/g' \
> >  $(git ls-files)
> >
> > and
> >
> > $ perl -pi.bup -e \
> >  's/strncmp\( *([^"]*), *("[^"]*"), *[0-9]* *\)/prefixcmp\($1, $2\)/g' \
> >  $(git-ls-files)
> >
> > Of course, I missed the two ,ofs ones, but a git grep -n strncmp brought 
> > these up.
> 
> I think you totally missed my point.  I wanted to make sure that
> things like these do not go unnoticed:
> 
>         if (!strncmp(arg, "--foo==", 6))
> 	if (strncmp(line, "foo\nbar", 8))
> 
> Both are probably incorrectly written code in the original, but
> probably would _happen_ to be working (for a certain definition
> of "working" -- the former probably wanted to make sure the
> parameter is of form "--foo=something", and the latter wanted to
> check the line has the 7 bytes terminated with NUL).  But your
> conversion would make them actually start behaving incorrectly.
> 
> And the worst part of this is that the change that caused to
> expose these bugs would be literally _buried_ in 1800 lines of
> "mechanical conversion" patch which is mind-numbing to audit.
> 
> That's why you are better off writing mechanical conversion
> script in stricter than seemingly necessary to catch only the
> safe conversion target, while accepting false negatives.

All true. I thought fixing them without checking was fine, but you are 
right: better safe than sorry.

Ciao,
Dscho
