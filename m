From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: publishing a forked^W cloned directory with ancestry
Date: Thu, 30 Aug 2007 15:49:47 -0400
Message-ID: <20070830194947.GB10808@fieldses.org>
References: <20070830192533.GA18751@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	mdadm development team 
	<pkg-mdadm-devel@lists.alioth.debian.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 21:50:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQq1s-0002Gg-HQ
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 21:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbXH3Ttu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 15:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbXH3Ttu
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 15:49:50 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45106 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932719AbXH3Ttt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 15:49:49 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IQq1T-00044F-2f; Thu, 30 Aug 2007 15:49:47 -0400
Content-Disposition: inline
In-Reply-To: <20070830192533.GA18751@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57061>

On Thu, Aug 30, 2007 at 09:25:33PM +0200, martin f krafft wrote:
> So I clone upstream and find that git-branch -r includes
> upstream/master (s/origin/upstream/ for clarity). I then branch
> 'debian' off upstream/master and make some required changes. With
> utter enjoyment of git, I wrap it up and package a new mdadm.deb.
> Yay.
> 
> And then I wonder: how do I now publish this result of my work? I'd
> like to push my repository to git.debian.org so that others can
> clone it and help or submit patches against the debianised upstream.

So in the setup you describe if they clone your repo then they'll get a
single branch called 'debian' with your work in it.  That sounds fine to
me, actually.

> But the remote branch upstream/master only really exists in
> $GIT_DIR, which is local and can't be pushed. Or well, even if
> I tried, the people cloning from the push location wouldn't see it

They can always just fetch from upstream as well if they'd like.  They
could do something like:

	git clone git://coolproject.org/cool.git
	cd cool
	git remote add debian git://git.debian.org/cool.git
	git fetch debian

Then they have a repository where git-branch -r reports something like

	origin/master
	debian/debian

Or they could do it the other way around, with "origin" pointing to you
and an "upstream" remote pointing to coolproject.org.  The naming's
obviously up to them.

> 1. I could tell my $GIT_DIR/config that upstream/* comes from mdadm
> upstream and debian/* comes from git.debian.org and then merge
> happily across branches locally and be done with it. However, John
> Doe, who on a rainy Saturday afternoon has two hours to spend and
> wants to fix some mdadm bugs would have to jump through hoops to
> replicate the setup: all the ties between upstream and the
> git.debian.org repo are local to my machine and can't be pushed
> anywhere (except to verbose documentation).

Maybe the one extra "git remote add ...; git remote fetch" isn't such a
big deal?

> I guess the cleanest solution I can come up with is to branch off
> upstream/master into branch "upstream" whenever *I* decide it's time
> to snapshot. Then, people using my repo would basically be confined
> to the state of the tree as it was the last time I rebased
> "upstream", but could work freely on the Debian-specific stuff.
> I think this is actually quite okay, but I am still interested in
> any comments you may have.

Sure, you can do that.  I don't think it's really necessary.

My local kernel repository, for example, currently knows about five
other repos:

	$ git remote
	labiaga		# server pnfs work
	linux-nfs	# my public repo
	origin		# Linus's repo
	richterd	# a coworker's nfs work
	trond		# Trond's nfs stuff

Sure, each of those could add a "linus" branch that tracked upstream, so
I could still get some idea what Linus's tree was even if I didn't
happen to already have it.  But then I'd end up with 4 different
slightly-out-of-date pointers to the head of linus's repo in each of
those trees, which would end up being just be a bunch of cruft that I'd
have to ignore whenever I looked at them.

--b.
