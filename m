From: Junio C Hamano <junkio@cox.net>
Subject: Re: Using git to bridge two svn repositories: a success story
Date: Fri, 20 Apr 2007 00:18:37 -0700
Message-ID: <7vk5w7344y.fsf@assigned-by-dhcp.cox.net>
References: <46283DC4.7070604@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 09:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HenOE-0006hs-JL
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 09:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbXDTHSj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 03:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbXDTHSj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 03:18:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41932 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423026AbXDTHSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 03:18:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420071839.ZPAF1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 03:18:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pKJd1W00H1kojtg0000000; Fri, 20 Apr 2007 03:18:38 -0400
In-Reply-To: <46283DC4.7070604@midwinter.com> (Steven Grimm's message of "Thu,
	19 Apr 2007 21:12:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45070>

Steven Grimm <koreth@midwinter.com> writes:

> ..., so here's a success
> story I can share for a change. I just used git to merge two separate
> svn repositories: the official repo for an open-source program and an
> internal repo with our locally-modified version of the same
> program.

Nice story.  Thanks for sharing.

> Now, about those renames. The major change in structure was to rename
> the source directory from "server" in the official repository to "src"
> which our build system expects. So before I did any merges, I
> committed a revision where I did "git mv src server" (along with a
> couple other similar renames) so there'd be an explicit rename-only
> revision for git's rename detection to use to apply changes to the
> right files.

In the work you did in the story, your rename from server to src
was indeed an atomic action YOU wanted to have, which was done
to match the two tree structure.  It was your project, not git,
that did not want the name upstream uses.  So it makes perfect
sense to have that rename-only commit.  But if you do it only
because you think it would help later merges, don't.

I do not know who started this myth, but "rename only commit"
does not help rename detection in merges AT ALL, as rename
deteciton is not done step-by-step, but between ancestor and the
tip of each branch.

A "rename-only commit" does help if you are following history
with "git log -p -M", where rename detection logic compares
trees stepwise.  I think somebody confused this with the rename
detection done by the merge machinery to start the myth.  Please
do not spread it any further.
