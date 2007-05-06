From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'upstream' branches.
Date: Sun, 06 May 2007 01:00:25 -0700
Message-ID: <7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	<20070505174416.GA2898@steel.home>
	<1178387429.17680.35.camel@shinybook.infradead.org>
	<20070505225249.GE2898@steel.home>
	<7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
	<1178436926.17680.74.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sun May 06 10:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkbfS-0003uu-JY
	for gcvg-git@gmane.org; Sun, 06 May 2007 10:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbXEFIA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 04:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbXEFIA1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 04:00:27 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38916 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbXEFIA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 04:00:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506080025.TQST6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 04:00:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vk0R1W00T1kojtg0000000; Sun, 06 May 2007 04:00:26 -0400
In-Reply-To: <1178436926.17680.74.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Sun, 06 May 2007 08:35:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46314>

David Woodhouse <dwmw2@infradead.org> writes:

> So that 'git-diff linus..' or 'git-log linus..' will show me what's
> outstanding against the master('s) tree. And scripts feeding the commits
> list can ignore those commits, etc. 
>
>> On the other hand, I think it is perfectly reasonable thing to
>> want to track where the tip of Linus's tree is "from mtd tree's
>> point of view".  Then diff between "mtd's idea of Linus's tip"
>> and "mtd's tip" would represent what mtd people did, regardless
>> of what Linus did in his tree, before mtd people had a chance to
>> sync again with Linus. 
>
> Right. That's what I'm trying to track. And that 'idea of Linus' tip'
> needs to get updated whenever we pull from Linus' tree into our
> mtd-2.6.git tree on the server -- by whatever route, even if it's
> indirectly through another repo.

Ahh, I did not mean by "mtd's idea" _your_ repository, but I
meant whichever one that was overwriting your 'linus' tracking
branch you are using to track fetch from Linus's tree.

The cleanest way to view "what do we really have since the
latest of Linus, regardless of how and from whom we learned
where the tip of Linus is", would be not to let other trees to
disturb the tracking branch you use for Linus's tree with each
other.

	[remote "a"] fetch = refs/heads/linus:refs/remotes/a/linus
	[remote "b"] fetch = refs/heads/linus:refs/remotes/b/linus
	[remote "c"] fetch = refs/heads/linus:refs/remotes/c/linus
	...

Then

	git log master --not remotes/a/linus remotes/b/linus remotes/c/linus


> Is that possible? I'm fairly sure it used to be.

I doubt we had that bug.  If you allowed overwriting with +, it
would not have prevented a rewind (i.e. pull from Linus and then
pull from somebody who pulled from Linus earlier than you did).
If you didn't, then it would have failed the fetch.
