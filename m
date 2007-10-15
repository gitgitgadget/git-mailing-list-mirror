From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RCS keyword expansion
Date: Mon, 15 Oct 2007 15:28:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710151520040.25221@racer.site>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
 <Pine.LNX.4.64.0710112144380.4174@racer.site>
 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710121057540.25221@racer.site> <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
 <Pine.LNX.4.64.0710121231410.25221@racer.site> <Pine.LNX.4.64.0710151457131.1901@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Oct 15 16:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQwR-0003IS-GA
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbXJOO27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbXJOO26
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:28:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:49540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753469AbXJOO25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:28:57 -0400
Received: (qmail invoked by alias); 15 Oct 2007 14:28:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 15 Oct 2007 16:28:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KKURyJzFKXaFvlQspaAdaND9uhcBVlsHLOM6iMp
	PQwHEPilQqGNfW
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710151457131.1901@ds9.cixit.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61002>

Hi,

On Mon, 15 Oct 2007, Peter Karlsson wrote:

> I wrote:
>
> > Finding out which commit last changed that file is slow.  That's why 
> > it breaks down.
> 
> That might be, but it only needs to be done when a file is updated.

Almost.

It also needs to be updated when switching branches.  For every file.  
Since the commit blamed for the current version could be different for 
every file.

> > You are just to used to CVS/SVN to see that there is a much better way 
> > in git.
> 
> I can see that favouring the argument that having a $Id$ that gives me 
> the global state id when the file was last updated is a bad idea. Fair 
> enough. Give me a local state tham (which you did, hash id for the file 
> contents).
> 
> My problem now is the file date. That could possibly be fixed by having 
> it updated before I check in the file.
> 
> 
> So, to summarize, if I've understood the responses here correctly, what
> I really want is:
> 
>  on commit:
>   - replace "$Date$" (or whatever) with the current time.

I think that would be more "on edit".

>   - store the contents.
> 
>  on checkout:
>   - update the file.
>   - replace "$Id$" (ditto) with a magic identifier for the file state.
>   - update git's state so that it doesn't see the "$Id$" expansion
>     as a change in the file contents.
> 
> Now the question is: Where can I find documentation on how to do this
> (i.e what should I search for--"hooks"?)?

For the $Id$ thing: Documentation/gitattributes.txt.  For the $Date$ 
thing: Documentation/hooks.txt, and Documentation/git-rev-list.txt.  
You'll need to roll your own thing there, since Git oldtimers feel that 
what you want to do is the wrong thing (see Randal's comment on generating 
it as part of the build process).

What you want to do might be frowned upon by many on the list, but it is 
certainly doable.  See ExampleScripts on the wiki for inspiration.

> And, if this goes into the ".git" directory, can I still have it 
> replicated when I clone a repository? I noticed that my ".git/ignore" 
> file wasn't replicated and that I had to replace it with a local 
> ".gitignore" to get it under version control.

No, there is not way to have it replicated into the .git directory.  The 
common way would be to either have it installed as templates, so that 
every user of yours gets them automatically, or to check them in under 
different names, and make every user install them by hand.

The rationale: every cloner is free to choose what hooks she wants to run.  
So checking in such hooks is always understood as suggestion what hooks 
to install.

Ciao,
Dscho
