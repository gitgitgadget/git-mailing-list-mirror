From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Sat, 14 Oct 2006 12:06:01 -0700
Message-ID: <7v7iz290py.fsf@assigned-by-dhcp.cox.net>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
	<7vlknlmc9y.fsf@assigned-by-dhcp.cox.net>
	<d620685f0610130656u55079a1fkc2c98a82f3aa4a33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 21:06:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYops-0001uP-Kt
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 21:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWJNTGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 15:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbWJNTGD
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 15:06:03 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7617 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1422825AbWJNTGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 15:06:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061014190602.NVAF12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Oct 2006 15:06:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aK641V00n1kojtg0000000
	Sat, 14 Oct 2006 15:06:05 -0400
To: apodtele <apodtele@gmail.com>
In-Reply-To: <d620685f0610130656u55079a1fkc2c98a82f3aa4a33@mail.gmail.com>
	(apodtele@gmail.com's message of "Fri, 13 Oct 2006 09:56:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28887>

apodtele <apodtele@gmail.com> writes:

> Before my patch is completely forgotten, let me critique the current
> approach. Currently everything is great and beautiful unless one
> particular change adds a couple of hundred lines, say, to a man page.
> With large changes in play, small changes are squashed to a single
> character. Would you argue that this scenario correctly represent
> importance of man pages? Would you say, that it's not misleading that
> 1-, 2-, and 5-liners all look the same as long as a man page is
> prominently shown? Moreover, 1-, 2-, and 5- liners may look different
> depending on the size of that man page. The current approach is not
> invariant; it is, however, normalized as needed. "Normalized" is good,
> "as needed" is bad.

One thing that mildly irritates me has been:

	git log --stat v2.6.17..

which, as you correctly point out, shows the bad effect of
scaling per commit.  "Normalized as needed" is good.  What's bad
is "not normalizing across things we show".

Even with your non-linear scaling, you would need to make sure
every commit gets the same graph width; I do not think they
currently do, due to name part scaling.

People are used to seeing the traditional diffstat output, so
any improvement you make that is different from it (including
e.g. "being able to show differences between 1- and 2- liner
patch when a monster 800- liner happens to be in the same patch
set", which is a worthwhile goal) will look bizarre and/or
misleading to them and they would not like it.

With the change to align things in the middle, it might become
easier to accept, because then it is _so_ obviously different
from traditional diffstat, it is very clear to people that the
output is different but still they can easily figure out that
longer bars are for larger changes.

And this new output needs to be an option.
