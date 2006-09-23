From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories
 at once
Date: Sat, 23 Sep 2006 19:54:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609231947340.25853@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060923164308.16334.49252.stgit@machine.or.cz> <45156780.6070801@gmail.com>
 <20060923170439.GQ8259@pasky.or.cz> <Pine.LNX.4.63.0609231921110.25853@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060923173943.GA20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 19:54:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRBhg-0006zy-4E
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 19:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWIWRyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 13:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWIWRyN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 13:54:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:58539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751366AbWIWRyM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 13:54:12 -0400
Received: (qmail invoked by alias); 23 Sep 2006 17:54:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 23 Sep 2006 19:54:10 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923173943.GA20017@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27608>

Hi,

On Sat, 23 Sep 2006, Petr Baudis wrote:

> Dear diary, on Sat, Sep 23, 2006 at 07:23:01PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > On Sat, 23 Sep 2006, Petr Baudis wrote:
> > 
> > > Dear diary, on Sat, Sep 23, 2006 at 06:57:36PM CEST, I got a letter
> > > where A Large Angry SCM <gitzilla@gmail.com> said that...
> > > > Petr Baudis wrote:
> > > > >You still need to pass git-fetch-pack some URL in addition to the
> > > > >repositories - it is used only for git_connect(), the purpose is that
> > > > >repositories must be local directories so if you want to talk remote, you
> > > > >need to do something like
> > > > >
> > > > >	git-fetch-pack git://kernel.org/pub/scm/git/git.git 
> > > > >	--repo=/pub/scm/git/git.git master next 
> > > > >	--repo=/pub/scm/cogito/cogito.git master
> > > > >
> > > > 
> > > > Can't this be done with a simple wrapper around git-fetch* ?
> > > 
> > > The point is that that is too slow (the difference is noticeable
> > > especiall in the case there is no new stuff ready), you need to create a
> > > connection and do whole lot of work for each of the repositories.
> > 
> > I still firmly believe that it would be way more efficient to fetch all 
> > those branches into _one_ proxy repository. Especially since you can reuse 
> > the objects with an alternate, which has an additional benefit over your 
> > approach.
> 
>   Huh? You can reuse the objects with my approach as well. Actually, it
> is automagically done so.
> 
>   With proxy repository, you would still need a server-side setup to
> maintain that repository, and specialized client-side porcelain to fetch
> from it. My approach initially requires some core changes (which aren't
> very pretty as it is but are not very fundamental or logically intrusive
> either) but in the longer run it pays off since you don't need a
> convoluted server-side setup for that.

No, you do not need _any_ server-side setup. And you do not need any 
specialized client-side porcelain other than a script, which just does 
the job.

The point is, your changes are not only intrusive, they are unnecessary.

You can even declare the first repository as the proxy. Sketch of script:

	- find which branches are wanted at all,

	- do the fetch (of all wanted branches) in the first repository,
	  storing the refs under refs/multi/,

	- for each repository

		- ensure that the first repo is given as alternative

		- store the branches this repo wants (you only need to 
		  update the refs, since you have all the objects)

This is not particularly complicated, is it?

Ciao,
Dscho
