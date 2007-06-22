From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Fri, 22 Jun 2007 00:07:35 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706212337030.20596@xanadu.home>
References: <20070621045903.GA14047@spearce.org>
 <7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
 <20070621061045.GG8477@spearce.org>
 <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
 <7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
 <7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
 <alpine.LFD.0.99.0706211137020.20596@xanadu.home>
 <7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com>
 <20070622032502.GA17393@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 06:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1aQt-0000Dl-Td
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 06:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXFVEHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 00:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbXFVEHh
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 00:07:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65525 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbXFVEHg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 00:07:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JK000GLRRGN9UL0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Jun 2007 00:07:36 -0400 (EDT)
In-reply-to: <20070622032502.GA17393@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50673>

On Thu, 21 Jun 2007, Shawn O. Pearce wrote:

> > Nicolas Pitre <nico@cam.org> writes:
> > > When you need git behavior X and you know that it appeared in version Y 
> > > then you only need to test for git_version >= Y.  Determining that 
> > > particular Y is much easier after the facts using the commit log than 
> > > trying to anticipate what item should be added to a feature list for 
> > > future usage.  In fact the same argument as for not explicitly recording 
> > > renames in commit objects should apply here.
> 
> Here's the problem though: `git-blame -w` will be supported
> in Git 1.5.3 and later, we all know this.  But Git doesn't.
> Ask git-describe what version `master` and `next` are; its
> v1.5.2.2-249 and v1.5.2.2-1050.
> 
> So tell me, how can git-gui know that Git 1.5.2.2.249 is OK, and
> 1.5.3 is OK, but 1.5.2.3 isn't?  Actually its 1.5.2.1.160 that is
> OK (b82871b introduced the -w option).  Sure Junio won't release
> a 1.5.2.1.160 as an actual tagged release (160 patch releases to
> 1.5.2.1 is nuts).  But what about in the future if a cool feature
> 3 commits past 1.5.3 appears?  Wouldn't that look like 1.5.3.3,
> and isn't that a possibly valid version number?
> 
> Besides, I can't say 1.5.2.3 is >= 1.5.2.2.249, because in git.git
> it isn't.  Only 1.5.3 will be >= 1.5.2.2.249.

First of all, I mentioned at the time that using a . for separator 
between the tagged version and the number of commits since then in the 
git-describe output was a bad idea.  You just made the perfect 
demonstration of that.  If it was just me I'd change that . for a + or a 
: like the original patch did.

Now to your issue.  I think that if you must rely upon a particular 
version then it's best if it is a released version.  Intermediate 
versions as provided by git-describe aren't reliable enough to provide 
a proper number to test against, especially in the presence of 
concurrent branches.  The 1.6.0+38 (let me use a saner output) from the 
master branch is totally different from 1.6.0+38 from the 'next' branch.  
So only released versions should be used to compare against.

Now you say that you don't want to wait for the release to happen before 
using this cool new feature.  Well, I'd reply that life is tough.  
Either you 
trick Junio into making a release sooner because the feature is just too 
valuable to wait.  Or you try the feature (git-blame -w) and hope for 
the best.  Certainly in that case you can predict the behavior of 
older git-blame versions if you pass it -w which they don't understand?

> Nico mentioned that git-gui ships with git.git, and therefore should
> just rely on exactly whatever that git.git supports at the time of
> the merge.  I think that is only partially valid.  git-gui is also
> an independent project with a repository and history that exists
> outside of git.git.  Users can (and should be able to) mix and
> match the version of git-gui with the version of plumbing, to the
> maximum extent possible.  

Fair enough.

> I'd like to at least gracefully fail by
> disabling an option, or suggesting the user upgrade their plumbing,
> if an option isn't supported.

Well you should be able to just try the option and detect it when it 
isn't supported.

> Unlike how we gracefully fail with a useful error message say
> when an early 1.4 release that doesn't support offset deltas is
> given a packfile with an OFS_DELTA in it (corrupt pack, recently
> rediscussed on list).  Or when a 1.5.1 client tries to checkout
> a tree that uses the new subproject mode in 1.5.2 (missing blob,
> recently discussed on #git).

Those are different as you have an older version that couldn't 
anticipate the future.  In your case you can "anticipate the past".


Nicolas
