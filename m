X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 15:42:24 -0800
Message-ID: <7vejr0n2u7.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<eluhk3$pv7$1@sea.gmane.org> <7vhcvwomde.fsf@assigned-by-dhcp.cox.net>
	<200612152348.17997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 23:42:32 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612152348.17997.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 15 Dec 2006 23:48:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34575>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvMhB-0002yA-BF for gcvg-git@gmane.org; Sat, 16 Dec
 2006 00:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964826AbWLOXm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 18:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWLOXm0
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 18:42:26 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56278 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964826AbWLOXm0 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 18:42:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215234225.LNPM97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 18:42:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zBic1V00v1kojtg0000000; Fri, 15 Dec 2006
 18:42:37 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I'm just used to the way revisions are specified to other history
> viewers: git-log (via git-rev-list), gitk, qgit. git-show-branch
> is a bit odd man out here. "git-show-branch ref1 ref2 ref3"
> is (without --more=n) like 
>
>   git rev-list ref1 ref2 ref3 --not $(git merge-base ref1 ref2 ref3)
>
> Which is handy for git-show-branch, but odd.

I hate to sound harsh, but...

Then you do not understand show-branch at all.  Not having to
say the "--not merge-base" part is NOT about being handy, but is
the central part of what show-branch does.  The command is about
showing the commits that are on only some of the branches but
not on others.

Other commands you listed above are all based on rev-list logic
of painting commits in two colors (either UNINTERESTING or
~UNINTERESTING) and being able to combine the set using "A..B",
"^A B", and "A B --not C" notations all make sense.  All
combinations work as set operation -- start from union of
commits reachable from positive (i.e. not prefixed with ^) refs,
and subtract set of commits reachable from any negative ref.

What show-branch does cannot be expressed with that two-color
logic; it needs to use N colors for N input refs.  After digging
from the tips deep enough, you would find the common merge-base
and after that point it is not interesting to show anything
anymore, and that is how it stops output.
