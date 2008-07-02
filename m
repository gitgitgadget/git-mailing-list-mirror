From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 19:32:03 +0200
Message-ID: <20080702173203.GA16235@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:33:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE6Cc-0007C0-SW
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 19:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYGBRcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 13:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYGBRcG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 13:32:06 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59464 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYGBRcF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 13:32:05 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 618BB5465; Wed,  2 Jul 2008 19:32:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3lk0kfdo1.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87166>

Jakub Narebski wrote:
>First, if I remember correctly (from KernelTrap and now defunct Kernel
>Traffic and one issue of Git Traffic) the 'graft' mechanizm was
>created so it would be possible to "graft" (join) historical
>conversion repository with the "current work" git repository (started
>from zero when git was deemed good enough for Linux kernel
>development).

Quite.  Which is exactly the spirit I'm extending here.
I need it to stitch together history, but it needs to be more perfect
than mere connecting parents.

Also, the graft mechanism specifically is intended as a temporary
solution until one uses filter-branch to "finalise" the result into a
proper repository which becomes cloneable.

>The fact that git-filter-branch (and earlier cg-admin-rewrite-hist)
>respects grafts, and rewrites history so that grafts are no-op and are
>not needed further is a bit of side-effect.

I beg to differ.  It's not a side effect, it's the proper way to get
rid of the grafts file.  Grafts are temporary and ugly.  In proper
repositories they are a sign of transition to a proper state.
The proper state is attained by using git filter-branch.

>  So I think that it would
>be better to provide generic git-filter-branch filter which can
>understand this "generalized grafts" file format, or rather
>'description of changes' file.  Put it in contrib/, and here you
>go...

The problem is that the process of fixing history is an iterative one,
which can take many months, and everytime you make a change, the
correctness needs to be viewed using gitk.

For argument sake, consider the repository at hand which I'm trying to
"fix", it has 33000 commits, distributed over eight branches with
roughly 3500 merges over a timeperiod of 13 years.
The eight branches were eight separate CVS repositories which have
intersecting histories, and 3500 merges between CVS repositories (i.e.
branches).

If I need to backpatch a certain patch into history, it is likely that
in order to let the change ripple through, it will take 20000 commits to
be rewritten every time I make a slight change to history.
It's not really workable to ripple through 20000 commits everytime I
make a historical change, yet I need to view the change in gitk.

Using git filter-branch, or git sequencer basically has the same
problem, I need to ripple through most of history to get to a state
which is viewable using gitk again.  That is too long a turnaround
cycle.

Using the proposed grafts format, I can make changes incrementally, and
immediately viewable (though not cloneable) on the local repository using gitk.
Then after making all the necessary changes, one git filter-branch run
will "burn" the changes into the repository proper in one go
(renumbering all tags, branches and merges along the way).
-- 
Sincerely,
           Stephen R. van den Berg.

You are confused; but this is your normal state.
