From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a manual page for git-stash
Date: Sat, 30 Jun 2007 10:44:13 -0700
Message-ID: <7vps3dcp76.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
	<200706300539.l5U5dHLh003989@mi1.bluebottle.com>
	<Pine.LNX.4.64.0706301644190.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4gzi-00018r-12
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbXF3RoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbXF3RoQ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:44:16 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39517 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbXF3RoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:44:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630174414.XZPW22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 13:44:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HtkD1X00J1kojtg0000000; Sat, 30 Jun 2007 13:44:14 -0400
In-Reply-To: <Pine.LNX.4.64.0706301644190.4438@racer.site> (Johannes
	Schindelin's message of "Sat, 30 Jun 2007 16:44:39 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51231>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +DESCRIPTION
> +-----------
> +Use 'git stash' when you want to record the current state of the
> +working directory and the index, but want to go back to a clean
> +working directory.
> +
> +For example, if you have to pull, but are in the middle of some
> +interesting work, not yet ready to be committed, use git-stash.
> +
> +The default operation (when called without options), is to save
> +the changes away.
> +
> +
> +OPTIONS
> +-------
> +clear::
> +	Undo _all_ stashes (dangerous!).
> +
> +list [<stashname>]::
> +	List all stashed states.
> +

I suspect that is not what the implementation intends to do.
"list -n 4", "list --since=1.hour" would make sense, but "list
stash@{12}" would probably not.

> +show [<stashname>]::
> +	Show a combined diff of the stashed working directory, index and
> +	HEAD.

Is that what it does?  I had an impression that "show stash@{2}"
shows a regular diff between the base and the stashed working
tree state.

> +apply [<stashname>]::
> +	Try to apply the stashed changes to the current HEAD. You need
> +	a clean working directory for that, i.e. you must not have changes
> +	relative to HEAD in your working directory or index.

The implementation appears to apply on a clean index without
restriction to where the HEAD is.  I hinted that that behaviour
is fine in my previous message, but on the other hand haven't
convinced myself enough to say that it would not confuse end
users.  Maybe insisting on not just clean index but no changes
from the HEAD would reduce confusion?  I dunno.

> +<stashname>::
> +	A name of a stashed state. Typically something like 'stash@{2}'
> +	or 'stash@{2.days.ago}'.

Probably this should be defined in DESCRIPTION, along with the
definition of what a stash is ("records the difference between
the HEAD when the stash was created and the working tree state
in such a way that it can be applied to a different state
later").

> +DISCUSSION
> +----------
> +
> +The state is saved as three commits:
> +
> +- HEAD,
> +- a commit which contains the state of the index, which has HEAD as a
> +  parent, and
> +- a commit which contains the state of the working directory (only the
> +  tracked files, though), which has both HEAD and the second commit
> +  as parents.
> +
> +The third commit holds the complete information of the stash, and is
> +stored as the ref 'refs/stash'.
> +
> +Since that commit does not have any reference to other stashed states,
> +the stash listing relies on the reflog of 'refs/stash'. Therefore,
> +the stashed states are garbage collected like all the other reflogs.

Nit; s/the other reflogs/the other reflog entries/

> +Author
> +------
> +Written by Johannes E. Schindelin <johannes.schindelin@gmx.de>

You wrote that ;-)?
