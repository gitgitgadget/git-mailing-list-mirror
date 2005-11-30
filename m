From: linux@horizon.com
Subject: Re: git-name-rev off-by-one bug
Date: 29 Nov 2005 22:15:59 -0500
Message-ID: <20051130031559.26411.qmail@science.horizon.com>
References: <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, linux@horizon.com, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 04:17:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhIS0-0006r8-6V
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 04:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVK3DQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 22:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVK3DQA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 22:16:00 -0500
Received: from science.horizon.com ([192.35.100.1]:30271 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750822AbVK3DQA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 22:16:00 -0500
Received: (qmail 26413 invoked by uid 1000); 29 Nov 2005 22:15:59 -0500
To: junkio@cox.net, torvalds@osdl.org
In-Reply-To: <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12983>

>   This one is done with the updated merge-one-file, which leaves
>   unmerged entries in the index file to prevent unresolved merge
>   from getting committed by mistake.
>   
>   After "git pull ..." fails, earlier the user said:
>   
>   	$ git-diff
>   
>   to see half-merged state.  Now git-diff just says:
>   
>   	$ git-diff
>   	* Unmerged path ls-tree.c
>   
>   In order to get the earlier "show me the failed merge relative
>   to my HEAD", you can say:
>   
>   	$ git-diff HEAD ls-tree.c

Cool!  You all know I like this change, mostly because it makes git's
merging conceptually cleaner and easier to explain.

Looking at git, the difference between it and other SCMs is the emphasis
on merging over editing.  The tools for local development are a bit
primitive in core git, but that's a well-understood problem and the
tools can be implemented as needed.

What makes git special is the assumption that a patch is going to pass
through several people on its way from the text editor to the release,
so merging is actually more important than initial writing.

Rather than saying "Linus doesn't scale" and giving up, it's seen as an
Amdahl's law problem - the goal is to remove as much work from Linus as
possible and thus make him scale.  (The shorter and earther way to say
this is that Linus is a lazy bastard, which is no surprise to anyone
who's seen him try to hide behind a podium. ;-) )

And an essential part of making that work is a good toolkit for dealing
with merging, and particularly in-progress merges.  By having the
concept of an unmerged index, git lets you develop merging algorithms
in a modular way, as opposed to "one big hairy pile of magic DWIMmery"
that people are afraid to touch.

For example, one thing I'm sure will arrive fairly soon is file-type
specific merge algorithms.  For something like a .po file where the
order of sections doesn't matter, merging ad->abd and ad->acd can be
fully automated.

There are a number of good idea in git, but from what I've seen so far,
"git-read-tree -m" is the most important one.


Making git-diff Do The Right Thing is a relatively minor matter.
