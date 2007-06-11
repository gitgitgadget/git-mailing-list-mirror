From: Junio C Hamano <gitster@pobox.com>
Subject: Re: That improved git-gui blame viewer..
Date: Mon, 11 Jun 2007 09:05:04 -0700
Message-ID: <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	<20070611064203.GG6073@spearce.org>
	<alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:05:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxmOE-0007W7-6P
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 18:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbXFKQFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 12:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXFKQFH
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 12:05:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48722 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbXFKQFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 12:05:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070611160505.EHUD6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Jun 2007 12:05:05 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AG541X00J1kojtg0000000; Mon, 11 Jun 2007 12:05:05 -0400
In-Reply-To: <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 11 Jun 2007 08:46:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49861>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I don't generally do "git blame" very much at all, and I've found that any 
> time I do it (even historically - when I've used bk annotate and even 
> CVS), I have invariably _always_ wanted to go back in history to see the 
> blame of the *previous* version (because the commit that gets blamed 
> initially is simply not interesting, and is just whitespace cleanups or 
> whatever!).

Incidentally I added a small patch to underlying git-blame to
let you ignore whitespace changes so that you can blame through
them.  I do not think I merged it to 'master' yet, but it is
trivial and look obviously safe and correct.

> So I think git-gui isn't quite there yet, but I think it's getting pretty 
> close. It would need
>
>  - the afore-mentioned bug fixed (I _think_ it is a bug, but maybe you had 
>    some other reason for having two separate columns of commits per line), 
>    so that you can literally click on the *previous* version of a line and 
>    say "I don't care about this commit, I want to see the previous one".

I think the two columns are for "who _placed_ these lines in the
final image" vs "where these lines originally came into the
history".  The former is with -C, and the latter is without.

An option to re-blame starting from the parent commit of what is
currently blamed (i.e. "peel" one level) would certainly be
interesting but I do not think git-gui has it (yet).  Of course
it has a not-so-interesting corner case of deciding which parent
to follow for a merge, but a merge commit is blamed only for
lines that are either evil or conflict fixups, so in practice
there is not much to be gained from peeling a merge.
