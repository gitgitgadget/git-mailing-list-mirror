From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Thu, 21 Jun 2007 11:55:46 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706211137020.20596@xanadu.home>
References: <20070621045903.GA14047@spearce.org>
 <7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
 <20070621061045.GG8477@spearce.org>
 <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
 <7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
 <7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1P14-000753-Si
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 17:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbXFUPz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 11:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbXFUPz5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 11:55:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8968 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229AbXFUPzz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 11:55:55 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJZ009NMTKYIMK0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Jun 2007 11:55:47 -0400 (EDT)
In-reply-to: <7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50638>

On Thu, 21 Jun 2007, Junio C Hamano wrote:

> I am now getting sort of convinced that the list-features is a
> slippery slop towards total suckage, unless managed very
> carefully.
> 
> The "auto manage" patch I am responding to would tempt anybody
> to extend the mechanism to do something like the attached patch,
> because a one-line comment near the code, like:
> 
> 	/* FEATURE<oneline-first-paragraph> */
> 
> does not look very useful nor pretty by itself in the source
> code.  It makes it very tempting to actually describe the
> "feature".  People with only half a brain would even advocate
> updating supported_features[] to a tuple of (name, explanation),
> and have "git version --list-features" to spit both out, or
> something like that.  I really do not think we would want to go
> there.
> 
> A few years down the road, do we really care if we did not do
> something long time ago, but the code was updated and added as a
> new feature?  That information belongs to the commit log, not to
> in-source comments.  This will lead to the same mistake often
> made by users of other SCMs, embedding "$Log$" in their sources.

Well, just in case my opinion matters...

I don't like this feature list idea at all.

Not only is it going to grow indefinitely with no possibility for 
garbage collection because programs will depends on particular features 
to be listed there, the simple fact that deciding if a particular 
improvement should be listed is a subjective matter which will make the 
list grow faster than it absolutely should.

Given that this appears to be needed by git-guy, and since git-guy is 
shipped with main git already, it is a bit odd to have to support code 
to work with older git versions.  Why isn't git-guy simply remaining in 
synch with the git version it is shipped with?  This way cruft won't 
accumulate forever.

And if the tool and git core really have to be decoupled, then the best 
way to test for a specific feature is actually to get the git 
version.  No silly issues with a feature list to maintain, and no issue 
with a particular feature that might not have been added to the list.  

When you need git behavior X and you know that it appeared in version Y 
then you only need to test for git_version >= Y.  Determining that 
particular Y is much easier after the facts using the commit log than 
trying to anticipate what item should be added to a feature list for 
future usage.  In fact the same argument as for not explicitly recording 
renames in commit objects should apply here.


Nicolas
