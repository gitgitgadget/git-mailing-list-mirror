From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git branch bug
Date: Sat, 05 May 2007 23:30:14 -0700
Message-ID: <7vabwih3bd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705051823300.13988@bianca.dialin.t-online.de>
	<Pine.LNX.4.64.0705051841200.4015@racer.site>
	<Pine.LNX.4.64.0705051253380.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun May 06 08:30:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkaGG-00038O-8S
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbXEFGaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbXEFGaR
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:30:17 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56280 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694AbXEFGaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:30:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506063015.YNHB24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 02:30:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id viWE1W0051kojtg0000000; Sun, 06 May 2007 02:30:14 -0400
In-Reply-To: <Pine.LNX.4.64.0705051253380.28708@iabervon.org> (Daniel
	Barkalow's message of "Sat, 5 May 2007 13:05:51 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46301>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This leaves open the question of how you make your initial commit in a 
> branch that isn't master. I think the answer should be:
>
>  $ git checkout -b experimental
>  warning: You appear to be on a branch yet to be born.
>  warning: Forcing checkout of HEAD.
>  fatal: just how do you expect me to merge 0 trees?
>
> Which should probably be:
>
>  $ git checkout -b experimental
>  warning: You appear to be on a branch yet to be born.
>  warning: Putting you on a new branch yet to be born.
>
> And leaving .git/HEAD pointing to refs/heads/experimental instead of 
> refs/heads/master, with refs/heads/ still empty.

While I agree that is probably correct, it would not be useful
in real-life that much.  When you do not even have 'master', I
do not think there is much point of being able to create two
useless, yet-to-be-born branches.

Also, once you make a commit on 'master', you would not be able
to create a new disconnected root with your suggestion alone.  I
am not convinced that being able to start a disconnected root is
useful to begin with, but it is a different matter.  We allow
fetching and merging from a different repository to cause
disconnected roots to exist in a repository anyway, so I do not
see any reason to disallow it either.

Assuming that the ability to switch to a new yet-to-be-born
branch is useful, I think the right thing to do is:

 - Regardless of your HEAD state, you may want to have a way to
   create a yet-to-be-born branch and switch to it.  Perhaps
   "git checkout -e new" make HEAD point at refs/heads/new
   without creating one (I picked -e randomly for "empty").

 - When you are on a yet-to-be-born branch, "git checkout -b
   new" and "git checkout -b new HEAD" makes HEAD point at
   refs/heads/new without creating one.  I happen to consider
   this a not so useful corner case, but that is to make things
   consistent.

 - When you are on a yet-to-be-born branch, "git branch new" and
   "git branch new HEAD" is a nonsense operation.  We should
   clearly state that it is nonsense (I am agreeing with the
   last point in your message).
