From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 20 Apr 2007 04:14:01 -0700
Message-ID: <7vmz13z4au.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	<20070419100757.GB27208@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Her4J-0002Tl-2n
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbXDTLOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 07:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbXDTLOF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:14:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61024 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbXDTLOD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 07:14:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420111403.TCO1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 07:14:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pPE11W00G1kojtg0000000; Fri, 20 Apr 2007 07:14:01 -0400
In-Reply-To: <20070419100757.GB27208@admingilde.org> (Martin Waitz's message
	of "Thu, 19 Apr 2007 12:07:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45086>

Martin Waitz <tali@admingilde.org> writes:

> Now, how to go on?
> The next thing we need is a real checkout & merge support -- but that
> is not that hard.

As git.git is the project that everybody who is interested in
making the feature to materialize fetches, looks at and works on
anyway, once the support at the plumbing level is complete, an
obvious thing to do is to use it in git.git tree itself.

For example, I would like to eventually be able to remove
git-gui/ subdirectory and bind git-gui.git as a subproject.
Another possibility that is probably of a smaller impact is to
bind what is known as 'todo' branch at Meta/ directory, as that
is where I have the branch checked out in my worktree.  People
who are not interested in what are in 'todo' would not mind
having an empty directory there in their checkout, and
interested ones can use the same layout as I do.

Making git.git the first guinea pig has a unique bootstrapping
problem involved, however.  These kind of changes in git.git
itself has to wait at least until what we have in 'next' today
is in everybody's hands.  Otherwise, people who want to use git
for their real work need to first grab a tarball snapshot that
has the plumbing subproject support, and then update to
'master', because we are still too fast moving for any distro
binary packaged version to be satisfactory solution for people
who want to have all the bells and whistles.  Also, I cannot
have subproject in git.git until kernel.org starts running git
with subproject support -- otherwise nobody can clone or pull
from git.git X-<.

If there was a project of lessor importance that can afford to
say "if you want to track this project, you have to use git from
'next', which has not yet been officially released, but we are a
small closely knit group and we can live with this limitation",
it would be easier, but that would not be as effective guinea
pig as git.git itself would be.

Eating our own dog food is how git has evolved since its early
days.  There was no Porcelain to speak of back then; Linus gave
a recipe for keeping track of your work using 'update-index',
'write-tree', 'commit-tree' and 'echo' (we did not even have
'update-ref' to advance the tip of the branch; instead we did
"commit=$(commit-tree) && echo $commit >.git/HEAD"), and people
first followed that recipe, and later wrote a set of thin shell
wrappers around that recipe.

> Then we need to think about how to handle the submodule object
> database, e.g. when fetching.

With the clear separation of connectivity rules between modules,
I do not think this is an issue at all.
