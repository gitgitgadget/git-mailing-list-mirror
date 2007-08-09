From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 14:37:17 -0700
Message-ID: <7vy7gkwfsi.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	moe <moe-git@mbox.bz>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu Aug 09 23:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJFhL-0004b5-Cy
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 23:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbXHIVhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 17:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbXHIVhV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 17:37:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53674 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbXHIVhS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 17:37:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809213718.PWTA7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 17:37:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZxdH1X0011kojtg0000000; Thu, 09 Aug 2007 17:37:17 -0400
In-Reply-To: <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Thu, 9 Aug 2007 16:52:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55477>

Sean <seanlkml@sympatico.ca> writes:

> This makes things _much_ better, however the final commit in the 
> test script still shows a lot of user time:

I really do not have time to look into this for now until late
in the evening, but it is not surprising at all that per-path
partial commit is _always_ slower than the whole tree commit.

It simply needs to do _extra_ work, such as (1) re-initializing
a temporary index from the tree, (2) add the named entries to
that temporary index, and (3) add the same named entries to the
real index.  After that it writes a tree out of the temporary
index but the cost for that is the same as writing out of the
real index that is done for the normal commit.
