From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Thu, 22 Feb 2007 12:59:23 -0800
Message-ID: <7vr6shdi38.fsf@assigned-by-dhcp.cox.net>
References: <17885.60477.53356.123095@lisa.zopyra.com>
	<7vodnmdk8y.fsf@assigned-by-dhcp.cox.net>
	<17885.64501.15547.465411@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKL2G-0005Z4-ER
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbXBVU7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXBVU7Z
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:59:25 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37648 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbXBVU7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:59:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222205923.IVAF3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 15:59:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SkzP1W00E1kojtg0000000; Thu, 22 Feb 2007 15:59:23 -0500
In-Reply-To: <17885.64501.15547.465411@lisa.zopyra.com> (Bill Lear's message
	of "Thu, 22 Feb 2007 14:24:21 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40390>

Bill Lear <rael@zopyra.com> writes:

> % git log -p HEAD~"All the way back" update
>
> or something similar.

But in that use case "root" commit is not necessarily what you
wanted to say, isn't it?  It is more like "I want *earlier*
history, not latest ones as the command usually gives, of this
file".

$ git log --reverse -p HEAD -- update

would give you the changes that touch the path in the reverse
order than usual (I think this was merged post 1.5.0).

But my point is, you may happen to know it was in your root
commit, but that is a special case.  You may happen to know
other things to limit the output.  The timeperiod you made that
change (e.g. --until=2006-05-31), for example.

By the way, on the face of it:

$ git log --reverse -4 -p HEAD -- update

(or whatever number of commits you are interested in viewing)
might be closer to what you want to express, but the --reverse
option does not work like that, unfortunately for this
particular use case, because the way the semantics of
interaction between --reverse and --max-count is defined.

Given the above command line, the current implementation limits
the traversal to four items and then reverses the output,
instead of traversing normally as if --max-count limitation is
not there, reversing the result and then limiting the output to
four items, which would have made the sample command line above
a bit more useful.

But I would recommend against changing it.  Being able to view
the latest four commits in reverse is much more useful in
practice than being able to view the four commits at the
beginning of time in reverse.  Having both options is certainly
a possibility but I doubt it is worth it.
