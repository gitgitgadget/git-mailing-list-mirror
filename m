From: Ryan Anderson <ryan@michonline.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 23:37:37 -0400
Message-ID: <20050428033737.GA30308@mythryan2.michonline.com>
References: <200504272049.NAA14598@emf.net> <Pine.LNX.4.58.0504271722260.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Lord <lord@emf.net>, hpa@zytor.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 05:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQzlp-00080J-1H
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 05:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVD1DiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 23:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVD1DiG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 23:38:06 -0400
Received: from mail.autoweb.net ([198.172.237.26]:7554 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261852AbVD1Dht (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 23:37:49 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DQzqM-00062a-4w; Wed, 27 Apr 2005 23:37:38 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DQzrY-0001PI-00; Wed, 27 Apr 2005 23:38:52 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DQzqL-0002B2-In; Wed, 27 Apr 2005 23:37:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504271722260.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2005 at 05:57:07PM -0700, Linus Torvalds wrote:
> On Wed, 27 Apr 2005, Tom Lord wrote:
> 
> I'm not actually all that interested in SCM's. I'd have been much happier
> if I never had to start doing git in the first place. But circumstances
> not only forced me to do my own, it also so happens that I don't believe
> that there are many people around that have ever really _seen_ what my
> kind of development requirements are.

Oddly, I was trying to answer "Why distributed?" in a discussion the
"Joel On Software" forum.

The particular thread I posted on, well, was kind of stupid, but in case
anyone is curious: http://discuss.joelonsoftware.com/default.asp?joel.3.115346.51

What I said might help give an overview of how Linux development works,
from my point of view.  I only occassionally poke at interesting things
on the periphery on whims, but I poke at the SCMy aspects of it, so
maybe it's relevant. 

 Here's an overview of how the distributed world of Linux works:

 1. Linus has his personal tree.  He pushes it out on a regular basis to
 rsync.kernel.org (well, kinda - that's where it ends up at).

 2. "Trusted lieutenants" have their own trees.  Some keep these on
 *.kernel.org, some don't.

 3. Lots of other people have personal trees.  These can be pretty much
 anywhere.

 These trees are in a variety of formats today, some are in "git", some
 are still in BitKeeper, some are from a tarball, some are tarball +
 patches, some are git + patches.

 There are a variety of merging methods:

 a.  Provide a publicly accessible repository.  (Formerly BK, now "git")
 that Linus, or a maintainer (i.e, "trusted lieutenant") can grab it
 from.  In the email where this location is given, the patch is usually
 included, at least in a summary format.

 b.  Provide a series of emails, with a description per email followed,
 inline, with a patch.

 These merging methods can be done directly with Linus, or with anyone
 else who is interested.  (Generally, merging with Linus is for arch and
 subsystem maintainers, or random small things that are either obviously
 correct, useful, or just don't fit elsewhere.)

 So, that's the merge process, for the most part.

 Now, most patches these days are going through Andrew Morton - even if
 he's not actually submitting them personally, he's probably putting
 them into his tree for testing purposes.  (Networking changes go direct
 to Linus, but Andrew keeps an up to date version of them in his -mm
 series of kernels.)

 If code isn't accepted, well, one of a couple things happens:
 1. The patch is silently ignored.  (This is less of a problem these
 days.)

 2. The patch is commented on and someone says, "No".  (Generally, this
 happens a few times for "new" code, as people try to get the concept to
 fit into the kernel in the cleanest way.  There are a lot of style nits
 at this point, but also discussions of "Is this the right way to do
 this?" and "Do we need a more general method to do this instead of this
 hack?")

 Verifying that testing has occurred is less important than you might
 think.  This is basically because small patches either come with a
 description of the bug they fix and an expert in that area will ACK the
 patch, they touch an area that few people use and so the submitter is
 probably the best qualified person to provide a patch and they'll only
 hurt themselves if they haven't tested it, or, via the history of your
 submissions to the kernel, you are known to not submit bad code, so
 there's an expectation of quality.

 Furthermore, an incredible amount of testing occurs in the major public
 trees (Linus/-mm) between a release, so most absolutely major bugs are
 spotted fairly quickly, and if the problem is systemic in a change,
 that change can be reverted until the code improves.

 On the topic of checking into private branches - it's not so much a
 matter of "the parent never sees the changes" as "the parent doesn't
 see them right now".

 FWIW, at my place of employment, we switched from CVS to BitKeeper last
 summer, and it is significantly more pleasant to work with, in all
 aspects.

 Currently our entire development staff is working from home.  This
 still works well, as we can all check in locally, and submit changes to
 the master repository when changes are ready.  Between having a partner
 company in Japan working on our code, and our development staff working
 from home offices, we would have a horrific time getting any
 centralized SCM product to perform well.  With purely local
 repositories, local branching, and submissions via email or ssh, the
 process still works well and is *fast*.  CVS over slow network links is
 certainly not *fast*, and I'd be very surprised if Perforce is
 significantly better in that regard.

 I'll just say this, in closing - working with a decentralized SCM tool
 changes the way you work.  There is a Linux Kernel developer that I am
 aware of that keeps 27 or so seperate branches on his machine, so he
 can keep all the logically unrelated changes seperate from each other.
 He builds kernels off an additional branch that merges all the others
 together, and submits changes to Linus via 2 or 3 "rollup" trees he
 maintains.

 You just don't work like that in a centralized SCM, because branching
 isn't painless, in the same way.

-- 

Ryan Anderson
  sometimes Pug Majere
