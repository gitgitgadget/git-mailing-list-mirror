From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push over http is very dangerous
Date: Sat, 21 Apr 2007 11:28:25 -0700
Message-ID: <7v4pn9vaye.fsf@assigned-by-dhcp.cox.net>
References: <462394AC.303@beronet.com>
	<7vfy6uwncc.fsf@assigned-by-dhcp.cox.net> <462A44B6.30404@beronet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian <crich-ml@beronet.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 20:28:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfKKF-0001Rk-O1
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 20:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXDUS21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 14:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbXDUS21
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 14:28:27 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49956 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXDUS20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 14:28:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421182826.XFZI1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 21 Apr 2007 14:28:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id puUS1W0051kojtg0000000; Sat, 21 Apr 2007 14:28:26 -0400
In-Reply-To: <462A44B6.30404@beronet.com> (crich-ml@beronet.com's message of
	"Sat, 21 Apr 2007 19:07:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45187>

Christian <crich-ml@beronet.com> writes:

> The central machine is a  AMD Sempron, it runs Debian Sarge (3.1)
> We've installed git from source, because sarge has it not in its
> archives.
>
> Maybe we did something wrong at building time ? or you're right and
> the debian sarge zlib does not fit good to the current git versions ?

What I have been suspecting since I got that not-corrupted but
reported to be corrupt tree is that the version running on your
"unable to fsck" machine -- the one you use as the central
machine -- has a dud (or miscompiled) version of git, which
somehow reports corruption incorrectly on perfectly good
objects when it validates it before using them.

And to that machine, push over http succeeds fine only because
push over http is "dangerous" in that it does not "validate" the
pushed data on the receiving end like other codepaths do.

It would be interesting to find out what the breakage is on that
central machine.  I think enough people run Sarge that it is
unlikely it's zlib at fault, but the way git uses the zlib API,
which was cleaned up in the current tree with the two fixes from
Linus I mentioned earlier.
