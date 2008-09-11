From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 18:00:40 +0200
Message-ID: <20080911160040.GE2056@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <alpine.LFD.1.10.0809111047380.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdocI-0004sd-Er
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 18:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbYIKQAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 12:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYIKQAl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 12:00:41 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:45235 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYIKQAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 12:00:41 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0D8B05466; Thu, 11 Sep 2008 18:00:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111047380.23787@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95616>

Nicolas Pitre wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> Anything I missed?

>Technically speaking, implementation d is obviously the most efficient.  
>but, as mentioned above, the actual need for this feature has not been 
>convincing so far.  Until then, it is not wise to add random stuff to 
>the very structure of a commit object, while c can be done even 
>externally from git which is a good way to demonstrate and convince 
>people about the usefulness of such feature.

The actual need for the feature seems to be dependent on one's workflow
habits.  This is also the problem I sense throughout the thread: some
people know exactly what I'm talking about, and would come up with the
almost identical design specs for the feature independent of myself, and
others need to be explained every tiny detail of the spec because they
are not familiar with the concept and can't imagine why/how it would be
used.

Let me try and describe once more the typical environment this origin field
is vital in:

Imagine a repository with:
- 33774 commits total
- 13 years of history
- 1 development branch
- 9 stable branches (forked off of the development branch at regular
  intervals during the past 13 years).
- The stable branches are never merged with each other or with the
  development branch.
- 2787 individual back/forward ports between the development and stable
  branches.

In order to have meaningful output for git-blame, it needs to follow the
chain across cherry-picks reliably.
Once you alter a piece of code, in order to figure out what more to alter,
you need to verify if this piece of code was or wasn't forward/backported.
Reliable and fast reporting of this, and actual comparison of the
different forward/backports between the 9 branches is essential.  It
basically means that you need to view the diffs of the patches across 9
branches on a regular basis.

Without the origin links, this workflow will cost a lot more time to
pursue (I know it, because I'm living it at the moment, and no, I'm not
the only developer, it's a development team).

This development model is not unique to my situation, it occurs at more
places.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
