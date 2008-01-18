From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: errors in git pull
Date: Fri, 18 Jan 2008 13:07:01 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181301590.5731@racer.site>
References: <d0383f90801180049p1599dd6fmfabcdcad7d9d3275@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ian Brown <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 14:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFqwd-0000jg-OW
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 14:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166AbYARNHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 08:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757023AbYARNHK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 08:07:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:37585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751361AbYARNHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 08:07:08 -0500
Received: (qmail invoked by alias); 18 Jan 2008 13:07:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp039) with SMTP; 18 Jan 2008 14:07:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kUPkwIQqkyEaPgiYzbOKyM5Cgo9JP/NoemRqNzM
	pkvWEUXbrXqjEa
X-X-Sender: gene099@racer.site
In-Reply-To: <d0383f90801180049p1599dd6fmfabcdcad7d9d3275@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71014>

Hi,

On Fri, 18 Jan 2008, Ian Brown wrote:

>  I am working agains a linux kernel net git repository.
> 
> It occurred to me more than once that when trying to
> git-pull a repository I get the following errors; there errors appear
> also after I am running
> "git-reset --hard".
> Any idea what can it be ?
> I must add that I did not made changes in my local copy of the repository.
> 
> the command I am running is:
> 
> git-pull git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.25.git

To simplify, you can

	git remote add origin git://<...>

so you can call "git pull" and it will do the same.

> CONFLICT (content): Merge conflict in Documentation/feature-removal-schedule.txt

These are merge conflicts.  Git thinks you have changed something.

Now, this might be true, but it also might be the case that the tree you 
are pulling was rebased, i.e. rewound to a certain point in commit 
history, and committed to _differently_.

As a consequence, your state _before_ pulling looks as if _you_ changed 
something.  Since these changes are different than the now-current 
changes, but touch the same code, they produce conflicts.

You might be lucky with "git pull --rebase" (needs a pretty recent git), 
but if you are just tracking a certain tree and not committing yourself, I 
suggest something like this:

git fetch origin && git reset --hard origin/master

Of course, you _really_ have to make sure that you have no local changes 
of your own with this reset call, since it will just undo them (without 
saving them first).

If you _do_ have local changes, you might want to do a "git stash" before 
the reset, and a "git stash apply" after it (again, needs a pretty recent 
git).

Hth,
Dscho
