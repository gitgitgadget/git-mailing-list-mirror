X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Optionally check for uncommitted changes before switching branches.
Date: Thu, 07 Dec 2006 11:38:26 -0800
Message-ID: <7vu007sdhp.fsf@assigned-by-dhcp.cox.net>
References: <6ed9774cb95e873e76a4ac406dd740caf954bd3b.1165485618.git.spearce@spearce.org>
	<20061207100224.GB12966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:38:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207100224.GB12966@spearce.org> (Shawn O. Pearce's message
	of "Thu, 7 Dec 2006 05:02:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33614>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsP4n-0007kA-Rn for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163233AbWLGTi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938006AbWLGTi2
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:38:28 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60690 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S938004AbWLGTi1 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:38:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207193827.IEWF15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 14:38:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vved1V0071kojtg0000000; Thu, 07 Dec 2006
 14:38:37 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Git shouldn't cause the user to make mistakes when it can help to
> prevent them.  So now users may set checkout.requireCleanDirectory
> to true in their config file to have git-checkout verify the working
> directory is clean before switching branches.

A lot of times the reason to switch branches is because the user
starts to make a trivial change in the worktree and realizes
that the change belongs to another branch.  Other times it is
done by mistake and making it easier to notice that mistake is a
laudable goal.

Your patch allows -m to override this, but that destroys one
very useful feature of -m.  In the above "ah, this trivial thing
belongs to the other branch, so let's switch to the branch to
commit only that trivial piece and come back to the current
branch to continue what I'm doing" workflow, I usually first say
"git checkout" without -m to switch, and if it does not allow me
to switch, it is an indication that "the trivial thing" I
thought was trivial was not trivial.  I take it as a cue that I
should instead do it "the right way" (i.e. finish or stash away
what I am doing, switch to the branch in a clean state and fix
it properly).

Other times, when all (or most of) the changes in the work tree
logically should have started on a different branch, I do force
it with -m (and take the conflict markers in my worktree), but
being able to forbid the worktree merge by not giving -m is
important.

People with this new configuration set and has to override it
with a command line switch will lose this ability if you
overload that on '-m'.
