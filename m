From: Junio C Hamano <junkio@cox.net>
Subject: Re: newbie question - git-pull and local branch merge
Date: Fri, 22 Dec 2006 02:46:48 -0800
Message-ID: <7vejqs1a3r.fsf@assigned-by-dhcp.cox.net>
References: <6bb9c1030612220227h2dc83a78u2e31e0f4e6801412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 11:46:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxhvR-0000tA-3s
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 11:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946023AbWLVKqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 05:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946024AbWLVKqu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 05:46:50 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63066 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946023AbWLVKqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 05:46:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222104649.QUSL22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 05:46:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1mm61W0041kojtg0000000; Fri, 22 Dec 2006 05:46:07 -0500
To: "Pelle Svensson" <pelle2004@gmail.com>
In-Reply-To: <6bb9c1030612220227h2dc83a78u2e31e0f4e6801412@mail.gmail.com>
	(Pelle Svensson's message of "Fri, 22 Dec 2006 11:27:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35160>

"Pelle Svensson" <pelle2004@gmail.com> writes:

> 8. git-pull <- Problem!

And the problem is...???

> Accidentally I had 2 files not committed and one of these also
> had changes in the git-pull master branch which git could
> not merge automatically.

So you had changes to fileA that you already committed, and
further changes in your working tree, and Linus side updated
that same file since you started working on it?

If that is the case, I suspect that the pull stopped saying
something like "Entry ... not uptodate. Cannot merge."  If that
is the case I think your working tree has what you had before
you started the pull.  Deal with your own changes in the files
you dirtied (say, commit them first) and pull again.

Otherwise, what happened was you had changes to fileB that you
already committed, and Linus side also updated the same file in
the meantime, and you did _not_ have any change to that fileB in
your working tree (you might have had some other files locally
modified).  And the pull would have reported something like
"CONFLICT (content)" in such a case.

$ git diff

will show you an output that looks like diff but not really (you
can tell by its hunk header that have three '@' letters instead
of normal two); you have a conflicted merge result, and have the
usual conflict markers in that file.  Edit the file to resolve
conflict.  Then say:

$ git update-index conflicted-file-1.c conflicted-file-2.c ...
$ git commit

to record the merge commit.  Do not update-index the files that
you had your own changes before pulling -- those changes do not
have anything to do with this merge and you do not want to
record them as part of the merge.
