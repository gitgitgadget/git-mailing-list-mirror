From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Fri, 4 Jul 2008 02:44:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807040237580.2849@eeepc-johanness>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>  <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>  <20080702032155.GA13581@sigill.intra.peff.net>  <200807021144.46423.jnareb@gmail.com>  <20080703195915.GA18532@sigill.intra.peff.net>
 <c376da900807031638l219229bcy983ed994b37512c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZQF-0004NU-2f
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYGDAoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 20:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYGDAoN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:44:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:53201 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754043AbYGDAoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 20:44:12 -0400
Received: (qmail invoked by alias); 04 Jul 2008 00:44:10 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp048) with SMTP; 04 Jul 2008 02:44:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19S+tEwgRlSEsCZLoVUOItceBuLwDQ0vE0E7m29Us
	UXDCDUYoxyI8O0
X-X-Sender: user@eeepc-johanness
In-Reply-To: <c376da900807031638l219229bcy983ed994b37512c9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87349>

Hi,

On Thu, 3 Jul 2008, Adam Brewster wrote:

> > Yes, certainly it is more flexible to have them split. I find Adam's 
> > argument the most compelling, though. Think about moving commits as a 
> > multi-step protocol:
> >
> >  1. Local -> Remote: Here are some new commits, basis..current
> >  2. Remote -> Local: OK, I am now at current.
> >  3. Local: update basis to current
> >
> > git-push has the luxury of asking for "basis" each time, so we know it 
> > is correct. But with bundles, we can't do that. And failing to update 
> > "basis" means we will send some extra commits next time. But updating 
> > "basis" when we shouldn't means that the next bundle will be broken.
> >
> > So I think even if people _do_ want to update "basis" when they create 
> > the bundle (because it is more convenient, and they are willing to 
> > accept the possibility of losing sync), it is trivial to create that 
> > workflow on top of the separate components. But I can see why somebody 
> > might prefer the separate components, and it is hard to create them if 
> > the feature is lumped into "git-bundle" (meaning in such a way that 
> > you cannot perform the steps separately; obviously git-bundle --basis 
> > would be equivalent).
> >
> > But I am not a bundle user, so that is just my outsider perspective.
> 
> How does everybody feel about the following:
> 
> - Leave git-basis as a small perl script.

I'd rather not.

> - Add a -b/--basis option in git-bundle that calls git-basis.  Any 
>   objects mentioned in the output would be excluded from the bundle.  
>   Multiple --basis options will call git-basis once with several 
>   arguments to generate the intersection of specified bases.

So the only function of -b would be to fork() && exec() a _shell_ script?  
I don't like that at all.

> - (maybe) Add an option "--update-bases" to automatically call git-basis 
>   --update after the bundle is created successfully.

Rather, have it as a feature to auto-detect if there is a ".basis" file of 
the same basename (or, rather ".state", a I find "basis" less than 
descriptive), and rewrite it if it was there.

It could be forced by a to-be-introduced "--state" option to git-bundle.

> There's still plenty of potential for improvements, like a --gc mode
> to clean up basis files,

umm, why?  "rm" is not simple enough?

> a --rewind option to undo an incorrect --update,

Rather hard, would you not think?  The information is either not there, or 
you store loads of cruft in the .state file.

> or improvements in the way it calculates intersections,

Umm.  How so?

> but I think that with these changes the system is as simple as possible 
> while maximizing flexibility, utility, and usability.

I am not convinced.  This sort of feature belongs into git-bundle.  It 
certainly does not deserve being blessed by yet-another git-* command, 
when we are constantly being bashed for having _way_ too many _already_.

Ciao,
Dscho
