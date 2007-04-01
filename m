From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-add has gone lstat() mad
Date: Sat, 31 Mar 2007 17:39:28 -0700
Message-ID: <7vy7ld3p33.fsf@assigned-by-dhcp.cox.net>
References: <200703302055.13619.andyparkins@gmail.com>
	<200703302120.23713.andyparkins@gmail.com>
	<7vslbmxkcv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 02:39:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXo6m-0003yS-Fi
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 02:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbXDAAja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 20:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbXDAAja
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 20:39:30 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:45286 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbXDAAja (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 20:39:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070401003930.NAOO373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 20:39:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hcfU1W00M1kojtg0000000; Sat, 31 Mar 2007 20:39:29 -0400
In-Reply-To: <Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 30 Mar 2007 20:39:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43578>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Here's a patch. It passes all tests. It's not that complex. But people 
> should double-check. ESPECIALLY the list of special characters (currently 
> '?' '*' '\\' and '[').

I think the above is a good set.

This is an optimization different from what I was thinking
about.  I was hoping that we do not even need to call into
read_directory() if all the pathspec[] elements succeeds to
lstat() and they are not directories; in such a case we can just
stuff them to dir structure by hand, and use the remainder for
directory walk.

But I like this patch better.  We need to look at .gitignore to
warn about adding ignored files, so we cannot just stuff what
are found to dir without checking if they are ignored.
