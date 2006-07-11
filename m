From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why doesn't git-rerere automatically commit a resolution?
Date: Mon, 10 Jul 2006 23:58:51 -0700
Message-ID: <7v8xn06310.fsf@assigned-by-dhcp.cox.net>
References: <20060711061626.GB11822@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 08:59:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0CDH-0006q4-EN
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 08:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWGKG64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 02:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWGKG64
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 02:58:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:63116 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030221AbWGKG6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 02:58:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711065852.YBVP27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 02:58:52 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060711061626.GB11822@spearce.org> (Shawn Pearce's message of
	"Tue, 11 Jul 2006 02:16:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23692>

Shawn Pearce <spearce@spearce.org> writes:

> I'm curious... I have a pair of topic branches which don't merge
> together cleanly by recursive (due to conflicting hunks in the
> same line segments).  I enabled git-rerere, ran the merge, fixed
> up the hunks and committed it.  git-rerere built its cache, as
> the next time I pulled the two topic branches together and got
> the same conflicts it correctly regenerated the prior resolution
> (and printed a message saying as much).

After all your merge is conflicting, so it should be sanity
checked.  At least you would want to run a compile test and
preferably a whole test cycle if your project has one, before
making the result into a commit.

You _could_ make it to automatically make a commit, and run a
test then if the test does not succeed fix the mismerge with "git
commit --amend", but people are lazy.

> So I'm wondering why doesn't it try to finish the merge?  Was there
> a really deep rooted reason behind it or was it simply easier/safer
> to let the user sort out the working directory state every time?

The philosophy is to optimize the tools to support disciplined
workflows better, and make sure that the users do not have to
worry about automated tools makeing mismerges.

Now, I am not against helping lazy workflows per se, but only on
one condition.  Doing so should never make more disciplined
workflows harder or more difficult.

Not merging the index after rerere re-applies a previous
resolution to the working tree file is a deliberate design
decision.  During conflict resolution, "git diff" against
unmerged index file is the second most useful command to check
your hand-merge result, and running update-index on these path
automatically robs this useful tool from the user.  So, in order
to help more disciplined workflow, a bit of convenience for
lazier people is sacrficed here.
