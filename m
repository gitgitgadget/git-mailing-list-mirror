From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Fri, 19 Jan 2007 19:30:25 -0800
Message-ID: <7vfya69xym.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45AF5F83.6090207@fs.ei.tum.de>
	<Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 04:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H86w3-0006dF-0J
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 04:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882AbXATDa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 22:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932891AbXATDa0
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 22:30:26 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48373 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882AbXATDa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 22:30:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120033025.NVRF3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 22:30:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DFWi1W00x1kojtg0000000; Fri, 19 Jan 2007 22:30:43 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 02:18:08 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37255>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> P.S.: Perhaps you should just stop worrying and learn to love --reverse 
> ;-)

Another thing to think about is how --reverse should interact
with --max-count and --skip (and perhaps --max-age but I am not
sure about that one).

I think there are two very valid ways.  You determine what you
would spit out as if there is no --reverse, and then reverse the
result, or you do not limit with them to get everthing, reverse
the result and do the counting limit on that reversed list.

The former is probably more efficient (I do not think you would
need to artificially make it limited like your patch does if you
go this route), while the latter may or may not be more useful
for what the end users would want to do.

For example, "git log -4" would show the topmost four commits.
If you do the former, "git log --reverse -4" would give you the
same four but in the chronological order (we usually show in the
reverse order and --reverse would make it the forward order ;-),
and you do not need to do the limiting for this.  You need to
capture them and reverse them yourself anyway, so not having to
limit may not be a big deal, though.

If you do the latter, you would be able to get the first four
commits in the chronological order.  I do not think that is
usually of much practical value (although people new to git
always seem to ask "how do I get to the root commit" at least
once), but there may be some valid uses for that kind of
behaviour.
