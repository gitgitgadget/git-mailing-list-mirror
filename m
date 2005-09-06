From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-ancestor read-tree notes
Date: Mon, 05 Sep 2005 22:42:42 -0700
Message-ID: <7virxeycod.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 07:43:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECWEe-0002xL-Sz
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 07:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVIFFmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 01:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVIFFmo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 01:42:44 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60835 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932394AbVIFFmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 01:42:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906054244.ZALY17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 01:42:44 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509050049030.23242@iabervon.org> (Daniel
	Barkalow's message of "Mon, 5 Sep 2005 01:41:36 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8121>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I've got a version of read-tree which accepts multiple ancestors and does 
> a merge using information from all of them.

After disabling the debugging printf(), I used this read-tree to
try resolving the parents of four commits Fredrik Kuivinen gave
us in <20050827014009.GB18880@c165.ib.student.liu.se> using
their two merge bases, and compared the resulting tree with the
tree recorded in the commit.  The results are really promising.

For the following two commits, multi-base merge resolved their
parents trivially and produced the same result as the tree in
the commit.  The current "best-base merge" in the master branch
performed far worse and left many conflicts.

 - 467ca22d3371f132ee225a5591a1ed0cd518cb3d 
 - da28c12089dfcfb8695b6b555cdb8e03dda2b690

Another one, 0e396ee43e445cb7c215a98da4e76d0ce354d9d7,
multi-base merge left only one conflicting path to be hand
resolved.  The best-base merge again performed far worse.

The other one, 3190186362466658f01b2e354e639378ce07e1a9, is
resolved trivially with both algorithms.

> In case #16, I'm not sure what I should produce. I think the best thing 
> might be to not leave anything in stage 1.

Because?  I know it would affect the readers of index files if
you did so, but it would seem the most natural in git
architecture to have merge-cache look at the resulting cache
with such multiple stage 1 entries (and other stages) and let
the script make a decision.

> The desired end effect is that the user is given a file with a
> section like:
>
>   {
>     *t = NULL;
>     *m = 0;
> <<<<<<<<
>     return Z_DATA_ERROR;
> ========
>     return Z_OK;
>>>>>>>>>
>   }

Sounds fine.

Anyway, I really am happy to see this multi-base merge perform
well on real-world data, and you are certainly the git hero of
the week ;-).
