From: Junio C Hamano <junkio@cox.net>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Fri, 22 Dec 2006 02:26:06 -0800
Message-ID: <7vvek41b29.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
	<Pine.LNX.4.64.0612211013500.3394@woody.osdl.org>
	<38b2ab8a0612220135p6925be4cmf003811f616395ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jay Cliburn" <jacliburn@bellsouth.net>, git@vger.kernel.org,
	"Jeff Garzik" <jeff@garzik.org>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 11:26:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxhbT-00061X-UM
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 11:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946021AbWLVK0I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 05:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946023AbWLVK0I
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 05:26:08 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61049 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946021AbWLVK0H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 05:26:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222102607.GDHH15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 05:26:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1mRQ1W0031kojtg0000000; Fri, 22 Dec 2006 05:25:24 -0500
To: "Francis Moreau" <francis.moro@gmail.com>
In-Reply-To: <38b2ab8a0612220135p6925be4cmf003811f616395ba@mail.gmail.com>
	(Francis Moreau's message of "Fri, 22 Dec 2006 10:35:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35158>

"Francis Moreau" <francis.moro@gmail.com> writes:

> I think this part is really confusing. For a new comer, saying that:
>
> 	git diff a b == git diff a..b
>
> is really not intuitive. Maybe just because adding a new symbol ".."
> in git diff command line means (for me) that we're doing a special
> diff. I would never thought by my own that ".." means a simple "to".

We did not originally have "A B"; you were supposed to always
say "A..B".  But all other SCM had "A B" notation, so we added
support for both because doing so was trivial and there is no
risk of confusion (because diff is about two points while log is
about a set).  These two notations are interchangeable for
"diff".  If it confuses you, you can stick to the "git diff A B"
notation.  Of if you are like Linus, stick to "A..B" notation.
Either way, you can pretend that the other notation does not
even exist and be happy ;-).

Yes, users often wondered why "git diff" accepts "A B", "git
log" wants "A..B" and "git log A B" is a disaster.  But the root
cause of the confusion was not about notation but about the
conceptual difference (two points vs a set).

I do not think changing the meaning of "diff A..B" to what "diff
A...B" means is a good thing.  The notation "..." even _looks_
like a magic, and in diff context, what it does _is_ magic (it
is magic in log context, too).  You are giving two points, but
what actually is used as the two points for diff are different
from what you gave; in that sense, it is a very good notation.
Changing it would confuse and inconvenience people who already
understood and got used to the difference between "diff" and
"log": diff takes two points, so given usual A..B notation it
uses A and B, while log is about a set and means 'the ones
reachable from B, excluding the ones reachable from A'; "A...B"
is magic and does a magical thing in both "diff" and "log",
taking the merge bases between A and B into account.
