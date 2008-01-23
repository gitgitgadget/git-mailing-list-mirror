From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 16:34:51 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801231630480.5731@racer.site>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org> <7vprvtngxk.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801231224300.5731@racer.site>
 <alpine.LFD.1.00.0801230817390.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHiZl-0006lD-7U
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbYAWQe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 11:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYAWQe7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:34:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:34499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752130AbYAWQe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 11:34:58 -0500
Received: (qmail invoked by alias); 23 Jan 2008 16:34:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 23 Jan 2008 17:34:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/V5n5rT0DVilOS0QtYj7O05v7gN4CKjvPeSc86ik
	ewheF23pMNTDgY
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801230817390.1741@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71552>

Hi,

On Wed, 23 Jan 2008, Linus Torvalds wrote:

> On Wed, 23 Jan 2008, Johannes Schindelin wrote:
> > 
> > I fully expect it to be noticable with that UTF-8 "normalisation".  
> > But then, the infrastructure is there, and whoever has an itch to 
> > scratch...
> 
> Actually, it's going to be totally invisible even with UTF-8 
> normalization, because we're going to do it sanely.
> 
> And by "sanely" I mean just having the code test the high bit, and using 
> US-ASCII as-is (possibly with that " & ~0x20 " thing to ignore case in 
> it).
> 
> End result: practically all projects will never notice anything at all for 
> 99.9% of all files. One extra well-predicted branch, and a few more hash 
> collissions for cases where you have both "Makefile" and "makefile" etc.

Well, that's the point, to avoid having both "Makefile" and "makefile" in 
your repository when you are on case-challenged filesystems, right?

> Doing names with *lots* of UTF-8 characters will be rather slower. It's 
> still not horrible to do if you do it the smart way, though. In fact, 
> it's pretty simple, just a few table lookups (one to find the NFD form, 
> one to do the upcasing).
> 
> And yes, for hashing, it makes sense to turn things into NFD because 
> it's generally simpler, but the point is that you really don't actually 
> modify the name itself at all, you just hash things (or compare things) 
> character by expanded character.
> 
> IOW, only a total *moron* does Unicode name comparisons with
> 
> 	strcmp(convert_to_nfd(a), convert_to_nfd(b));
> 
> which is essentially what Apple does.

Heh, indeed that is what I would have done as an initial step (out of 
laziness).

> It's quite possible to do
> 
> 	utf8_nfd_strcmp(a,b)
> 
> and (a) do it tons and tons faster and (b) never have to modify the 
> strings themselves. Same goes (even more) for hashing.

Okay.  Point taken.

But I really hope that you are not proposing to use the case-ignoring 
hash when we are _not_ on a case-challenged filesystem...

Ciao,
Dscho
