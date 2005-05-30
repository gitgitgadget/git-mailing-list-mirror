From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 00:57:34 -0700
Message-ID: <7vmzqd4041.fsf@assigned-by-dhcp.cox.net>
References: <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
	<20050527195552.GA6541@cip.informatik.uni-erlangen.de>
	<7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
	<20050527203227.GA11139@cip.informatik.uni-erlangen.de>
	<20050529230240.GB12290@cip.informatik.uni-erlangen.de>
	<20050529231053.GD12290@cip.informatik.uni-erlangen.de>
	<20050529231621.GE12290@cip.informatik.uni-erlangen.de>
	<20050529234606.GF12290@cip.informatik.uni-erlangen.de>
	<20050529235630.GG12290@cip.informatik.uni-erlangen.de>
	<7vsm05bkps.fsf@assigned-by-dhcp.cox.net>
	<20050530013056.GH12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcf7J-0006BP-3T
	for gcvg-git@gmane.org; Mon, 30 May 2005 09:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVE3H5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVE3H5o
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 03:57:44 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30170 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261548AbVE3H5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 03:57:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530075733.WZTN20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 03:57:33 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> Note: If I pull into an empty tree (no HEAD) there is only one head in
TG> this array which corresponds to the remote_head. Otherwise the first
TG> element is *always* the local HEAD.

"An empty tree (no HEAD)"?  Is your definition of "an empty
tree" the same as "empty" directory after you do "mkdir empty &&
cd empty && git-init-db", followed by bunch of git-*-pull to get
the objects and commits from other reposititories being involved
in the merge but without touching .git/HEAD?  If so, why cannot
I do the git-*-pull from multiple repositories and merge them
together?  Why "there is only one head in this array that is
remote_head"?  Oh, I guess I am missing your definition of
"remote_head".  Puzzled...

Anyhow I presume that if your ${GIT-.git}/HEAD exists, you
include it as the first element of MERGE_HEADS.

TG> I have a function merge which gets a sorted array of heads. Heads can be
TG> unlimited at the time because some of the heads can be included into
TG> other heads (they're a subset) and so they don't show up in the commit
TG> object. I call this array MERGE_HEADS.

Sorry I am not very good at this "thinking" thing, and I need to
draw pictures.  Please bear with me.

    (line of dev C)-------------C    We are here, trying to merge
    (line of dev B)---(merge)---B    these three lines of devs:
    (line of dev A)---A/             A, B and C

    MERGE_HEADS = (A B C)
    A is actually a "subset" of B

Is this what you mean by "subset"?  Are these "subset" HEAD the
only thing that causes fast forwards?

My gut feeling without thinking much is that it might be easier
to first cull such fast forward heads by using N-way rev-tree
before you do anything else.  If only one head survives after
that, then that head would be your new head and you do not have
to go through any merges.  Otherwise you merge those independent
heads without worrying about fast forwards.  How does that
sound?

