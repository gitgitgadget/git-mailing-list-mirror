From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 13:32:45 -0500
Message-ID: <E1EIVsD-0001Hu-9m@jdl.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 20:33:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIVsR-0000a0-3t
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 20:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVIVScz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 14:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVIVScz
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 14:32:55 -0400
Received: from jdl.com ([66.118.10.122]:2476 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750969AbVIVScz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 14:32:55 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EIVsD-0001Hu-9m
	for git@vger.kernel.org; Thu, 22 Sep 2005 13:32:46 -0500
To: git@vger.kernel.org
In-Reply-To: Pine.LNX.4.58.0509220826460.2553@g5.osdl.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9136>

Linus schreib:
>
>	git fetch rsync:..../linus-2.6-git <src>:<dst>
>
> will fetch the <src> branch (ie you'd usually use "master") from my tree 
> and write it to the <dst> branch on your tree.

... "origin".  OK.

Und, Petr schreib auch:
> Then it creates an 'origin' head, and will copy all the history from
> the remote repository's 'master' head there. So this head exists to
> reflect the state of the remote repository. The important point is
> that it is called 'origin' in our new repository, even through it
> corresponds to a 'master' head in the old repository. This is normal -
> you can name your local heads whatever you want.

Wait.

For me, this paragraph suddenly turned on one missing light:
The default construction of repository branches/heads _mismatches_
names on local and remote ends: "origin" local came from "master"
remote.  Did I miss reading that somewhere else? (Likely.)

And I sat through the Great Remote Name Discussion of '05
("How is working on arbitrary remote heads supposed to work in Cogito")
but I just didn't get it back then.

(This is an intentional asymmetry, right?  Distributed systems, right?)

In any case, I just tried this:

    git fetch rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.gi\t master:origin

And got this mess:

    sent 18136 bytes  received 2731519 bytes  60431.98 bytes/sec
    total size is 97584183  speedup is 35.49
    rsync: link_stat "/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/alt\ernates" (in pub) failed: No such file or directory (2)
    rsync error: some files could not be transferred (code 23) at main.c(1173)
    * non-commit: 3fd07d3bf0077dcc0f5a33d2eb1938ea050da8da
      branch 'master' of rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/l\inux-2.6
    * refs/heads/origin: does not fast forward to branch 'master' of rsync://www.ke\rnel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6;
      leaving it in 'refs/heads/origin.remote'

And this is due to kernel.org being Not Quite Right, right?

Which points out one of the other points of frustration
that I feel should be addressed eventually:  A whole section
about "What To Do When It Goes Wonky" needs to be written.

OK, so it didn't merge?  Now what?  What got left where?
How do I recover?  What bits are in my tree, and what bits
are in the Index, and what bits are in the Object store now?

OK, so it didn't download it left you "refs/heads/rigin.remote".
What should I do with it now?  And later, should I re-execute
the same "git fetch" command and hope it recovers and patches
the pieces together?  Should I do a round of house cleaning
before attempting to re-run some (the same?) command?

Things of that nature.

And more as I get further too. :-)

Thanks!
jdl
