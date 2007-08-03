From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Fri, 03 Aug 2007 00:59:43 -0700
Message-ID: <7vr6mlnj4g.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
	<7v1wemxnkk.fsf@assigned-by-dhcp.cox.net>
	<vpqzm1a2l72.fsf@bauges.imag.fr>
	<7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net>
	<20070803070407.GA17287@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGs4a-0006mt-Fj
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635AbXHCH7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757516AbXHCH7p
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:59:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37623 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243AbXHCH7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:59:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803075943.CYLR2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Aug 2007 03:59:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XKzj1X00B1kojtg0000000; Fri, 03 Aug 2007 03:59:44 -0400
In-Reply-To: <20070803070407.GA17287@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 Aug 2007 03:04:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54687>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 02, 2007 at 12:56:19PM -0700, Junio C Hamano wrote:
>
>> Personally, I almost never run "git status".  The command is
>> there primarily because other systems had a command called
>> "status", and migrant wondered why we didn't.  We do not need
>> it, and we do not have to use it.
>
> So what is the recommended command to summarize which files have been
> modified, which files have been marked for commit, and which remain
> untracked?

Ok, you got me.  If I need such a summary, git-status would
obviously be the choice.  Although I do admit that I added the
interactive commit to support people who want to keep 30 hunks
across 10 different files in the working tree, and make a commit
using only 3 of them, I do not make partial commits myself, so
distinction between staged and unstaged are not something I am
usually interested in.  If your workflow care about that
distinction, and that is a very valid and natural workflow in
git, you would find git-status and git-diff --cached more useful
than they are to me.  I should not used words such as optimum.
It is just "different".

When you think about it, in such a workflow whose work tree that
does not match commits created from it, it is not very useful to
know the "touched but ended up unmodified", because (1) the
worktree changes are full of not-yet-ready changes (to the
immediate commit you are going to create) anyway, and (2) the
"touched but not modified" files may further be modified and
become modified before their changes hit a (later) commit.  The
side effect that "git-status" loses that information suddenly
becomes a useful feature for such a workflow.

On the other hand, if your workflow is "work on one thing at a
time, and never make partial commits", then your diff tends to
be small and more focused to begin with, and you can afford to
care about "touched but ended up unmodified".  Interestingly, it
happens to be a useful correlation that "git status", which
clears such information, is less useful command for such a
workflow.
