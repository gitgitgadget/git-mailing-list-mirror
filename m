From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing into a repository with working directory?
Date: Mon, 08 Jan 2007 16:57:03 -0800
Message-ID: <7vd55pt3ts.fsf@assigned-by-dhcp.cox.net>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org>
	<7vwt41j1le.fsf@assigned-by-dhcp.cox.net>
	<20070105193646.GC8753@spearce.org> <45A24CE6.5060201@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 01:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H45Ij-0000bP-RL
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 01:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbXAIA5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 19:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXAIA5F
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 19:57:05 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64947 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXAIA5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 19:57:04 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109005703.JNEG29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 19:57:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8owD1W00U1kojtg0000000; Mon, 08 Jan 2007 19:56:13 -0500
To: Andy Whitcroft <apw@shadowen.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36291>

Andy Whitcroft <apw@shadowen.org> writes:

>> Right now pushing into the current branch makes the index become
>> way out of sync from HEAD.  This causes git-runstatus to display a
>> large number of differences, basically undoing any of the changes
>> introduced by HEAD@{1}..HEAD.  The user is left with a dirty
>> working tree that they can commit - and committing it will just
>> revert the prior commits.  The user will later cuss at Git for
>> losing their changes.  Not pretty.
>
> Ok, both seem to be bad.  Can I re-ask if this would be solved by having
> the 'dangling head' support we talked about.  Such that pulling into or
> pushing into the current head could break the link and make the current
> head a dangling head?

Push does not do any working tree operation, so you _could_
detach the HEAD to point at the commit that used to be at the
tip of the branch and advance the tip of the branch as the push
instructs.  The user could start a new branch out of the
detached HEAD (which is behind the tip of the original branch),
make necessary commits and then merge that branch locally to the
branch the push advanced if s/he wants to.

However, I am not sure if that is easy to understand for the
users.  It would be sane to deny pushing into the current branch
for a non-bare repositories by default, and if we do allow it
(perhaps with 'git-push --force'), then detach the HEAD as you
suggest.  On the other hand, pushing into the current branch of
a bare repository should just work; the HEAD pointer in a bare
repository is not about the commit the index and the working
tree are based on, but which branch is the primary branch of the
repository.

I haven't thought things through, but I think the fetch side
could be handled in a similar way.
