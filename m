From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 16:17:21 -0700
Message-ID: <20130327231720.GB5204@jtriplet-mobl1>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
 <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Thu Mar 28 00:18:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzbZ-00026E-Fq
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 00:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851Ab3C0XRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 19:17:31 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41569 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab3C0XRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 19:17:30 -0400
Received: from mfilter3-d.gandi.net (mfilter3-d.gandi.net [217.70.178.133])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id F3CD2A80D3;
	Thu, 28 Mar 2013 00:17:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter3-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter3-d.gandi.net (mfilter3-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id vgzqRS47-tt7; Thu, 28 Mar 2013 00:17:26 +0100 (CET)
X-Originating-IP: 173.246.103.110
Received: from jtriplet-mobl1 (joshtriplett.org [173.246.103.110])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EE69AA80CF;
	Thu, 28 Mar 2013 00:17:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130327230943.GA5204@jtriplet-mobl1>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219357>

On Wed, Mar 27, 2013 at 04:09:43PM -0700, Josh Triplett wrote:
> On Wed, Mar 27, 2013 at 05:48:45PM -0500, Rob Hoelz wrote:
> > On Wed, 27 Mar 2013 15:07:18 -0700
> > Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > > Jonathan Nieder <jrnieder@gmail.com> writes:
> > > 
> > > > Sorry, typo.  The configuration in the example above should have
> > > > been
> > > >
> > > > 	[url "git://anongit.myserver.example.com/"]
> > > > 		insteadOf = myserver.example.com:
> > > > 	[url "myserver.example.com:"]
> > > > 		pushInsteadOf = myserver.example.com:
> > > >
> > > > In other words, suppose I set url.*.insteadof to point to a faster
> > > > address for fetching alongside url.*.pushinsteadof requesting that
> > > > the original address should still be used for pushing.
> > > 
> > > I didn't know we were even shooting for supporting the identity
> > > mapping:
> > > 
> > > 	url.X.pushinsteadof=X
> > > 
> > > but that would certainly be nice.
> > > 
> > > By the way, it seems that the original commit 1c2eafb89bca (Add
> > > url.<base>.pushInsteadOf: URL rewriting for push only, 2009-09-07)
> > > wanted to explicitly avoid use of pushInsteadOf aliasing for a
> > > pushURL and it is also documented in config.txt from day one.
> > > 
> > > I think the intent is "You have a normal URL, and a way to override
> > > it explicitly with pushURL, or a way to rewrite it via the aliasing
> > > the normal URL with pushInsteadOf. Either one or the other, but not
> > > both, as having many levels of indirection would be confusing."
> > > 
> > > Which I can understand and sympathise.
> > > 
> > > In anay case, the change proposed in this thread seems to change
> > > that, so the documentation would need to be updated.  Also the tests
> > > the original commit adds explicitly checks that pushInsteadOf is
> > > ignored, which may have to be updated (unless that test is already
> > > broken).
> > > 
> > 
> > My use case is that I use Github for my personal development.  I have a
> > prefix for my personal repos (hoelzro: -> git://github.com/hoelzro for
> > fetch, git@github.com:hoelzro/ for push) and one for all other Git repos
> > (github: -> git://github.com/)  I have a few projects where I work in a
> > fork, but I want to fetch updates from the original project.  So my url
> > for the origin remote is github:org/project, but my pushurl is
> > hoelzro:project.  This behavior in Git currently doesn't allow me to
> > work that way.  I used to work with two remotes; origin for my repo and
> > base for the official one, but I've found that I prefer this other way.
> > 
> > The test that checked that pushInsteadOf + pushurl shouldn't work as I
> > expect was actually broken; I have removed it, updated the
> > documentation, and sent a new patch to the list.
> 
> There's an argument for either behavior as valid.  My original patch
> specifically documented and tested for the opposite behavior, namely
> that pushurl overrides any pushInsteadOf, because I intended
> pushInsteadOf as a fallback if you don't have an explicit pushurl set.
> For instance, you could use pushInsteadOf to rewrite a family of
> anonymous git URLs to corresponding pushable repositories, but then use
> an explicit pushurl to override that for a specific repository.  This
> change would break the ability to use pushurl for its original intended
> purpose, namely having a local repository where fetch comes from one
> remote repo and push goes to another.
> 
> One use case of mine: I have a .gitconfig in my git-managed home
> directory which sets pushInsteadOf so that I can clone via git:// and
> immediately have working push.  I work with a number of systems that
> don't have inbound access to each other but do have outbound access to
> the network; on some of these "satellite" boxes, I can't push changes
> directly to the server pushInsteadOf points to, so I can explicitly set
> pushurl in .git/config for that repository, which overrides the
> pushInsteadOf.  This change would break that configuration.

Clarifying this use case a bit: note that it's been a while since I had
many such boxes, so I don't actually have any systems currently using
that pushurl configuration.  Still a regression in defined behavior,
though.

Why not just use insteadOf for your personal github prefix hoelzro:, and
both insteadOf and pushInsteadOf for github: in general?  Then, a
repository cloned via github: would work for pull and push (if you have
push access), and you can change pushurl to your personal github alias
if needed.

Though, as Junio said, the modern push-updates-remote-heads behavior of
git means that both of our configurations arguably seem wrong, and we
should both just use separate remotes for separate repos.

- Josh Triplett
