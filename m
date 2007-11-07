From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git push refspec problem
Date: Wed, 7 Nov 2007 15:40:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711071533590.29952@iabervon.org>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com>
 <Pine.LNX.4.64.0711071510480.4362@racer.site> <4731D852.2080500@hackvalue.de>
 <607586B5-7BA0-4018-9FB1-691C5E78D550@nc.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: James <jtp@nc.rr.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iprhy-0004Ta-Jg
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbXKGUkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165AbXKGUkn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:40:43 -0500
Received: from iabervon.org ([66.92.72.58]:50891 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396AbXKGUkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 15:40:42 -0500
Received: (qmail 15714 invoked by uid 1000); 7 Nov 2007 20:40:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Nov 2007 20:40:41 -0000
In-Reply-To: <607586B5-7BA0-4018-9FB1-691C5E78D550@nc.rr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63852>

On Wed, 7 Nov 2007, James wrote:

> On Nov 7, 2007, at 10:22 AM, Johannes Gilger wrote:
> 
> >Johannes Schindelin wrote:
> > >Hi,
> > >
> > >On Wed, 7 Nov 2007, James wrote:
> > >
> > > >      fetch = +refs/heads/*:refs/remotes/origin/*
> > >
> > >This is a refspec.
> > >
> > > >      push = ssh://james@my.server.com/home/james/scm/git/project.git/
> > >
> > >This is a URL.  It does not specify any refs.  But "push =" expects a URL.
> >
> >I think Johannes meant to say "But 'push =' expects a refspec." (the
> >manpage even says so).
> >
> >About your problem: If you want to pull from a git:// repository and
> >push to another with ssh:// (or in general when having two different
> >repositories for pushing and fetching) in my novice understanding
> >you would need two remotes. In your case, can't you just use your
> >ssh-url for fetching as well?
> >
> >Regards,
> >Jojo
> 
> 
> I guess I could use my ssh url for pulling, as well.  I simply figured it
> would be easier to add an ssh URL for push (like I was doing manually) and be
> done with it.  But it doesn't seem there's a super simple solution (i.e., my
> syntax was wrong in the config file) to using git for pull and ssh for push.

We *should* be able to make the rules: fetch tries URLs until one works, 
and then ignores later ones; push uses, in turn, all URLs that support 
pushing.

Then you could just list both URLs, with the "git:" one first, and it 
would do what you want (plus, if the git server on your remote machine 
were down, it would fall back to ssh automatically for you).

Actually, I think this would be a relatively easy project now, if you want 
to attempt it, since fetch and push and both in C now and the config file 
parser in remote.h reports all URLs in the config file's order. You'd just 
need to make it silently skip URLs in push that don't support pushing, and 
only give an error if none remain. (And add fallback support to fetch, for 
completeness; it's currently only using the first, IIRC).

	-Daniel
*This .sig left intentionally blank*
