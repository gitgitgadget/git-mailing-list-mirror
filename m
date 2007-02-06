From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fast-import
Date: Tue, 06 Feb 2007 13:53:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702061329090.19212@xanadu.home>
References: <20070206023111.GB9222@spearce.org>
 <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
 <20070206054808.GA10508@spearce.org>
 <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org>
 <20070206165630.GB4949@spearce.org>
 <Pine.LNX.4.64.0702060913220.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 19:54:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEVSG-0007Tm-R7
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 19:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965344AbXBFSyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 13:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965362AbXBFSyA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 13:54:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17589 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344AbXBFSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 13:53:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD200IZM1TDEJ01@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Feb 2007 13:53:38 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702060913220.8424@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38867>

On Tue, 6 Feb 2007, Linus Torvalds wrote:

> I'm not so worried about the git date parsing routines (which are fairly 
> solid) as about the fact that absolutely *tons* of people get rfc2822 
> wrong.
> 
> They allow pretty much any half-way valid date, exactly because people 
> don't do rfc2822 right anyway (and because they are also meant to work 
> even if you write the date by hand, like "12:34 2005-06-07").
> 
> Sure, you can still mess up the program that actually generates the data 
> for gfi, and have bugs like that *there*, but at least they'd have to 
> think a bit about it.

Well, exactly because GIT already has fairly solid date parsing 
routines, and the fact that we needed solid date parsing routines in the 
first place, exactly because people don't do rfc2822 right anyway, 
should be a hell of a big clue why we should parse date information for 
the gfi frontend.  Because the date is for sure most likely in a screwed 
up format already and it is counter productive to have to deal with that 
in a duplicated piece of code.  And the bare reality is that people will 
just not care to parse it right themselves.

Quoting from the gfi manual:

|A typical frontend for gfi tends to weigh in at approximately 200
|lines of Perl/Python/Ruby code.  Most developers have been able to
|create working importers in just a couple of hours, even though it
|is their first exposure to gfi, and sometimes even to Git.  This is
|an ideal situation, given that most conversion tools are throw-away
|(use once, and never look back).

This is therefore a damn good idea if gfi can make things right out of 
crap because frontends will not get much attention after the first "hey 
it works" level.  And the GIT date format, albeit being perfectly 
unambigous, is not inline with the statement above.

With the GIT date format a conversion _will_ be necessary in the 
frontend, while if gfi shove it to parse_date() instead then no 
conversion is even likely to be needed by the frontend.  I'd much prefer 
if frontend writers didn't have to care (and most probably manage to 
botch it if they have to) about date conversion.  We even botched it a 
few times ourselves despite the fact that we're damn good.

And because our date parsing code is damn good (hey we're just damn good 
aren't we?) I would bet that there will be much less conversion errors 
if gfi used parse_date() on provided data than if the frontend tries to 
parse the date itself.  This is wat we feed email submission through 
everyday anyway, so we must trust it to do a good job for imports as 
well.


Nicolas
