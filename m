From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 11:00:55 -0700
Message-ID: <7vr6mcy4dk.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: moe <moe-git@mbox.bz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 20:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJCJj-00018B-Ub
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 20:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbXHISA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbXHISA7
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 14:00:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41530 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbXHISA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 14:00:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809180055.ZPGE7193.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 14:00:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zu0v1X0071kojtg0000000; Thu, 09 Aug 2007 14:00:55 -0400
In-Reply-To: <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 9 Aug 2007 10:38:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55464>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So this is all O(n**2), which is why we haven't reacted very much - it 
> doesn't show up nearly as much with the kernel. Also, with a smaller set 
> of files, it would tends to fit in the L2 cache of most competent CPU's. 
> So not only is it n**2, you get the cache trashing behaviour too, and 
> that, I think, is what really causes it to fall off the cliff edge!
>
> Gaah. This shouldn't be *that* hard to fix, but I'm not entirely sure I'll 
> have time today.

One thing to keep in mind is that in your earlier test of "git
write-tree" (or "git commit") followed by "git add a/file"
followed by "git write-tree" is extremely fast because the
last operation optimizes otherwise O(n) behaviour of write-tree
from index extreamely cheap, thanks to cache-tree in the index.

> Diffing the index against the tree *should* be instantaneous.

Right now we do not cull the subdirectory that we _know_ are
unchanged in "git diff-index --cached" using cache-tree, but
diffing the index against the tree could be instantaneous.
