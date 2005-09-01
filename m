From: Junio C Hamano <junkio@cox.net>
Subject: Re: Couple of read-tree questions
Date: Wed, 31 Aug 2005 22:16:07 -0700
Message-ID: <7vll2h4bc8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509010009350.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 07:17:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAhRM-00009c-K9
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 07:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVIAFQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 01:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVIAFQL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 01:16:11 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:64976 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932145AbVIAFQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 01:16:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050901051608.PDST8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Sep 2005 01:16:08 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509010009350.23242@iabervon.org> (Daniel
	Barkalow's message of "Thu, 1 Sep 2005 00:17:18 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7990>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Is there any current use for read-tree with multiple trees without -m or 
> equivalent?

I did not know it even allowed multiple trees without -m, but
you are right.  It does not seem to complain.

I have never thought about using multiple trees without -m, and
I do not remember hearing any plan nor purpose of using it to do
something interesting from Linus.  I think its allowing multiple
trees without -m is simply a bug.

> Why does --emu23 use I+H for stage 2, rather than just I? Wouldn't this 
> just reintroduce removed files?

They are not "removed files", at least in the original context.

The original intention was that git was supposed to work without
having _any_ files in the working tree.  The reason why
multi-tree read-tree has so many special cases that says "must
match *if* work file exists", is that not having a corresponding
working file was supposed to be equivalent to having the file
checked out *and* unmodified.

That assumption and design goal was partially broken at around
the beginning of June when we started touching working tree
during a merge.  Until that timeframe, we did not touch (nor
even look at) files in the working tree during the merge, mainly
due to the desire of performing the merge operation entirely in
the cache (which was the name of "index file" back then).

I do not think anybody currently uses --emu23.  I did it because
it has a potential of making the two-tree fast forward (which is
used in "git checkout" to switch between branches) easier to
manage when the working tree is dirty than doing straight
two-tree merge, but that is just a theoretical potential never
tested in the field.  Frankly, I do not mind, and I do not think
anybody else minds, too much if you need to break or remove
emu23 if that would make your code clean-up and redoing
read-tree easier.
