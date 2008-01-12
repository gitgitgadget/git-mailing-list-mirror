From: Nicolas Pitre <nico@cam.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 21:32:24 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801112125470.3054@xanadu.home>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
 <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net>
 <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org>
 <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
 <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
 <478691EB.1080704@vilain.net>
 <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
 <47869C24.3000400@vilain.net>
 <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org>
 <4786BFCD.1000303@vilain.net>
 <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org>
 <47870CDF.4010606@vilain.net>
 <alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org>
 <47881D44.9060105@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 03:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDWBF-000518-MK
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 03:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYALCce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 21:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbYALCcd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 21:32:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18241 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYALCcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 21:32:33 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUI001ITF20X141@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 11 Jan 2008 21:32:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <47881D44.9060105@vilain.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70255>

On Sat, 12 Jan 2008, Sam Vilain wrote:

> Linus Torvalds wrote:
> > 
> > On Fri, 11 Jan 2008, Sam Vilain wrote:
> >> The difference seems only barely measurable;
> > 
> > Ok. 
> > 
> > It may be that it might help other cases, but that seems unlikely.
> > 
> > The more likely answer is that it's either of:
> > 
> >  - yes, zlib uncompression is noticeable in profiles, but that the 
> >    cold-cache access is simply the bigger problem, and getting rid of zlib 
> >    just moves the expense to whatever other thing that needs to access it 
> >    (memcpy, xdelta apply, whatever)
> > 
> > or
> > 
> >  - I don't know exactly which patch you used (did you just do the 
> >    "core.deltacompression=0" thing?), and maybe zlib is fairly expensive 
> >    even for just the setup crud, even when it doesn't really need to be.
> > 
> > but who knows..
> 
> Well, my figures agree with Pierre I think - 6-10% time savings for
> 'git annotate'.
> 
> I think Pierre has hit the nail on the head - that skipping
> compression for small objects is a clear win.  He saw the obvious
> criterion, really.  I've knocked it up as a config option that doesn't
> change the default behaviour below.

Sorry to rain on your parade, but to me 6-10% time saving is not a clear 
win at all, given the equal increase in repository size.  This is simply 
not worth it.

And a 50% time saving on an operation, such a git log, which takes less 
than 2 seconds in absolute time, is not worth the repo size increase 
either.  Going from 2 seconds down to one second doesn't make enough of 
a user experience difference.

If git blame was to go from 10 seconds down to 4 then I'd say this is a 
clear win.  But this is not the case.


Nicolas
