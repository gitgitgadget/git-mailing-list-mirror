From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: interactive rebase not rebasing
Date: Wed, 1 Oct 2008 09:52:25 -0500
Organization: Exigence
Message-ID: <20081001095225.d28de16a.stephen@exigencecorp.com>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com>
	<48E078BF.5030806@op5.se>
	<20081001010306.01cc34eb.stephen@exigencecorp.com>
	<48E32BD4.1050107@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:53:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl35D-0004tn-6p
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 16:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYJAOw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 10:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbYJAOw3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:52:29 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:50027 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYJAOw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 10:52:28 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 8FFCF24D788;
	Wed,  1 Oct 2008 10:52:27 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 261A224DA1E;
	Wed,  1 Oct 2008 10:52:27 -0400 (EDT)
In-Reply-To: <48E32BD4.1050107@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97227>


> >> I don't think you can have a single command that does all the
> >> things you want, because the possible differences in input makes it
> >> very nearly impossible to always do "the right thing".
> > 
> > Ah, you are too pessimistic. :-)
> > 
> 
> Perhaps, although I think you're being overly optimistic if you think
> rebase can do all of this intelligently while still retaining clear
> semantics. I'd start with writing a separate tool for it, probably
> based on git sequencer.

I would agree with this, except that --preserve-merges is already in
the codebase and does what we want. I'm not fundamentally changing how
it works (e.g. how it decides what commits to keep/rewrite/etc.), I just
found and patched a bug in it.

> When that works out ok, get it to do what rebase does today and then
> incorporate the new tool as an option to rebase and get ready to
> answer complex questions for the cases where it doesn't do what the
> user wanted it to do.

Yeah, I'm sorry, I did not mean my "pessimistic" comment that
seriously. I understand `git rebase` can never do what everyone wants
in all scenarios.

But given /this/ scenario (hehe), with the implementation's existing
explicit usage of "--left-right --cherry-pick" to drop no-op commits,
but then it's forgetting of this information later, leading to `git
rebase` not performing a rebase at all, I think it is an obvious bug,
and one that can be fixed without changing any of `git rebase`s
existing semantics.

> Merely that you should think hard about it and then make sure it
> doesn't break anything people are already doing today with the current
> toolset.

I've attempted to do that. Now that I sent in the patch, if you could
review it, I would appreciate your feedback. I do need to rework the
test case because I realized including the origin/pull aspects (which
is what caused us to find it) is just noise and the bug can be
reproduced with just local branches.

Thanks,
Stephen
