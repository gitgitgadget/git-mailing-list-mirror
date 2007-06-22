From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Thu, 21 Jun 2007 23:25:02 -0400
Message-ID: <20070622032502.GA17393@spearce.org>
References: <20070621045903.GA14047@spearce.org> <7v1wg55065.fsf@assigned-by-dhcp.pobox.com> <20070621061045.GG8477@spearce.org> <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com> <7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com> <7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com> <alpine.LFD.0.99.0706211137020.20596@xanadu.home> <7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 05:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Zln-00037o-Q0
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 05:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbXFVDZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 23:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbXFVDZJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 23:25:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45269 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbXFVDZH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 23:25:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1ZlU-0004yd-Pn; Thu, 21 Jun 2007 23:24:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 671C820FBAE; Thu, 21 Jun 2007 23:25:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50668>

Junio C Hamano <gitster@pobox.com> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > I don't like this feature list idea at all.
> 
> ... and thanks for bringing a bit of sanity to this thread.

Indeed.  I've read Junio's counter proposal (the grep'ed FEATURE<?>
macro) and I'm now convinced you are both right, this feature list
thing is just going to grow out of control or nobody is going to
mark new features.  Either way its useless for its intended purpose.
 
> > When you need git behavior X and you know that it appeared in version Y 
> > then you only need to test for git_version >= Y.  Determining that 
> > particular Y is much easier after the facts using the commit log than 
> > trying to anticipate what item should be added to a feature list for 
> > future usage.  In fact the same argument as for not explicitly recording 
> > renames in commit objects should apply here.

Here's the problem though: `git-blame -w` will be supported
in Git 1.5.3 and later, we all know this.  But Git doesn't.
Ask git-describe what version `master` and `next` are; its
v1.5.2.2-249 and v1.5.2.2-1050.

So tell me, how can git-gui know that Git 1.5.2.2.249 is OK, and
1.5.3 is OK, but 1.5.2.3 isn't?  Actually its 1.5.2.1.160 that is
OK (b82871b introduced the -w option).  Sure Junio won't release
a 1.5.2.1.160 as an actual tagged release (160 patch releases to
1.5.2.1 is nuts).  But what about in the future if a cool feature
3 commits past 1.5.3 appears?  Wouldn't that look like 1.5.3.3,
and isn't that a possibly valid version number?

Besides, I can't say 1.5.2.3 is >= 1.5.2.2.249, because in git.git
it isn't.  Only 1.5.3 will be >= 1.5.2.2.249.


Nico mentioned that git-gui ships with git.git, and therefore should
just rely on exactly whatever that git.git supports at the time of
the merge.  I think that is only partially valid.  git-gui is also
an independent project with a repository and history that exists
outside of git.git.  Users can (and should be able to) mix and
match the version of git-gui with the version of plumbing, to the
maximum extent possible.  I'd like to at least gracefully fail by
disabling an option, or suggesting the user upgrade their plumbing,
if an option isn't supported.

Unlike how we gracefully fail with a useful error message say
when an early 1.4 release that doesn't support offset deltas is
given a packfile with an OFS_DELTA in it (corrupt pack, recently
rediscussed on list).  Or when a 1.5.1 client tries to checkout
a tree that uses the new subproject mode in 1.5.2 (missing blob,
recently discussed on #git).

Maybe I should ask the StGIT folks how they deal with this, or if
they just don't worry about it.  I'm suspecting its the latter...


Hmm.

-- 
Shawn.
