From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] what should "git push remote.host:path" do?
Date: Thu, 12 Jan 2006 11:00:18 -0800
Message-ID: <7v64opp8zh.fsf@assigned-by-dhcp.cox.net>
References: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP099ED34B41FFA02EDEEF25AE270@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 20:00:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex7gR-00078Y-4Q
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 20:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWALTAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 14:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWALTAW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 14:00:22 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13047 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030317AbWALTAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 14:00:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112185745.WXWI20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 13:57:45 -0500
To: "Sean" <seanlkml@sympatico.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14578>

"Sean" <seanlkml@sympatico.ca> writes:

> What about assuming a refspec of  "current-branch:current-branch" ?
> That is, if the branch name that is currently checked out locally
> also exists upstream, push into it (only if fast forward).
>
> This should allow multiple branches to be updated locally, and pushed
> upstream selectively.

Requiring at least one refspec to be given to the command has
the same property.  Ways to give refspec to the command are:

 (1) give one or more from the command line
 (2) give --all from the command line
 (3) give none from the command line, but in this case you need
     at least one "Push:" the "remotes" file you use.

So it really boils down to "is pushing the current branch a
better default"?

Even if a project uses CVS style shared repository setup,
individual developers would want to use topic branches to
prepare things that they eventually push to the shared common,
and I suspect that it would lead to more mistakes if we default
the push to push the current branch.  "Push: master" in the
remotes/ file to publish your results to the shared repository
would be safer; "git push" when you are still in your topic
branch and have not merged things up into your master branch for
publication would be no-op, as opposed to pushing the topic
branch, probably resulting in the topic branch in the shared
repository, even though the topic was meant to be internal to
his repository.
