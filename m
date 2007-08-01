From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git clone error
Date: Wed, 1 Aug 2007 22:12:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708012211040.14781@racer.site>
References: <C2D647C0.2B60%denbuen@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <denbuen@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGLVJ-0004SO-02
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 23:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbXHAVNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbXHAVNI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 17:13:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:35654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751265AbXHAVNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 17:13:06 -0400
Received: (qmail invoked by alias); 01 Aug 2007 21:13:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 01 Aug 2007 23:13:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18veS1zCtIv4QMoZgms1EcqUWGUgMQuHPTBQ6V64C
	n6VZRbo103zdsI
X-X-Sender: gene099@racer.site
In-Reply-To: <C2D647C0.2B60%denbuen@sandia.gov>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54477>

Hi,

On Wed, 1 Aug 2007, Denis Bueno wrote:

> On 08/01/2007 11:17, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> wrote:
> > But this is what I would do if I had the problem: I would try to create
> > a state which is as close to the corrupt revision as possible,
> > use a graft to replace the initial commit with that revision, and
> > rewrite the branch. I'd probably start by doing something like this:
> > 
> > $ git symbolic-ref HEAD refs/heads/recreate-first && rm .git/index
> > $ git ls-tree -r --name-only <initial-commit> |
> > grep -v "^condor/condor-uninstall.sh$" |
> > xargs git checkout <initial-commit>
> > $ git checkout <second-commit> condor/condor-uninstall.sh
> > [possibly some minor hacking on the latter file to make it work]
> > $ git commit -c <initial-commit>
> 
> Wow.  `commit' and `checkout' are the only two commands that I have ever
> heard of in that sequence.
> 
> How difficult would it be to create a new git repo which is exactly the same
> minus the initial condor-uninstall.sh commit?  That is, just to pretend the
> initial import of condor-uninstall.sh never existed, and use the second
> commit of the old repo the first commit of the new, and preserve the rest of
> the history of the entire repo?

That would be even easier.  Just graft "nothingness" as parent of the 
second commit:

	$ git rev-parse <second-commit> >> .git/info/grafts

But of course, you should use filter-branch nevertheless, since you would 
have to do the same hack in _every_ repository.

Ciao,
Dscho
