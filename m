From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Fix git-diff --cached to not error out if HEAD points to a nonexistant branch
Date: Sun, 25 Feb 2007 00:22:15 -0800
Message-ID: <7vvehqtzns.fsf@assigned-by-dhcp.cox.net>
References: <20070224172037.GA31963@xp.machine.xx>
	<7vvehrw9mz.fsf@assigned-by-dhcp.cox.net>
	<20070224221622.GA3897@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 25 09:22:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLEeK-0006Yt-HC
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 09:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXBYIWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 03:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbXBYIWR
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 03:22:17 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:39552 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbXBYIWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 03:22:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225082214.YBDH3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 03:22:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TkNF1W0021kojtg0000000; Sun, 25 Feb 2007 03:22:16 -0500
In-Reply-To: <20070224221622.GA3897@xp.machine.xx> (Peter Baumann's message of
	"Sat, 24 Feb 2007 23:16:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40545>

Peter Baumann <waste.manager@gmx.de> writes:

> I tend to agree, but I'd like to also have somethin in the spirit of
> "log.showroot = true" which handles the diff of the first commit like
> diffing against an empty tree. Why should diff --cached differ from
> this? At least it is easier to explain, just mention that diff --cached
> shows everything which would become the next commit.

I think it is _actively wrong_ to explain that "diff --cached
shows everything which would become the next commit".  It
instills an incorrect mental model to new users.  What would
become the next commit is "git tar-tree $(git-write-tree)".  A
commit records the tree state, not difference from _the_
previous _single_ commit.

Having said that, showing an "add everything" patch when the
user says "git diff --cached" or even "git diff --cached HEAD"
on a yet-to-be-born branch might actually make sense, although I
am a bit afraid that the added inconsistency makes the command
more confusing and harder to explain at the end.

The output would become indistinguishable from the case where
your previous commit indeed was with an empty tree.  In essense,
this is about making the state before the first commit less
special.  That may or may not be a good thing, and I agree that
the preference on this may be related to what log.showroot
controls.
