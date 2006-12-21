From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Thu, 21 Dec 2006 15:01:21 -0800
Message-ID: <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 00:01:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxWum-0003nK-MC
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 00:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423107AbWLUXB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 18:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423108AbWLUXB0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 18:01:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49998 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423107AbWLUXBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 18:01:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221230124.WLBU25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 18:01:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1b1a1W0161kojtg0000000; Thu, 21 Dec 2006 18:01:35 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> (Nicolas Pitre's
	message of "Thu, 21 Dec 2006 17:17:02 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35091>

Nicolas Pitre <nico@cam.org> writes:

> [ Hmmm... there used to be many more (remote) branches before.  Where 
>   are they? Looking into .git/refs I see a remote/ directory and all 
>    remote branches are there.  But I'm cheating now because a newbie 
>    might not even think of looking there.
>
>    Ah? there is -a and -r options to git-branch.  Fair enough. ]

A newbie might not even expect to see "many more branches"
because there is no "before" for him.

> $ git checkout origin/next
> git checkout: to checkout the requested commit you need to specify
>               a name for a new branch which is created and switched to
>
> [ Hmmmmmmmm.... /me stares at the message wondering.
>   I just want to _see_ and maybe _install_ the code from "next". ]

Rewording to suggest "checkout -b newbranchname origin/next", perhaps?

> $ git checkout -b local_next origin/next

"git checkout -b next origin/next" should work just fine, I
think.

There was a talk about allowing "checkout -b <new> <track>" to
add branch.<new>.merge and branch.<new>.remote if <track> can be
proven to corresond uniquely to one remote and one branch from
that remote; I think that would match the expectation most of
the time but that "most" would not be 100% nor even 80%, so I
think that should be an optional feature.  In any case, there
was a talk but there is no code yet.

> And there was a discussion about allowing checkouts to be made from a 
> remote branch but not allowing any commit on it.  What happened of this 
> idea?

It remains to be an idle talk without any code.  Contributions
appreciated.

> $ git pull origin/next
> fatal: The remote end hung up unexpectedly
> Cannot get the repository state from git://git.kernel.org/pub/scm/git/git.git/next
>
> [ WTF?  Where that ...pub/scm/git/git.git/next comes from?  Hmmm... ]

This comes from ancient request by Linus to allow:

	$ cat .git/remotes/jgarzik
	URL: master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/
	$ git pull jgarzik/misc-2.6

See http://article.gmane.org/gmane.comp.version-control.git/6181
for the full text.

Personally I thought this was confusing when I implemented it
the first time, and I still find it confusing.

I suspect nobody uses it.  I am all for removing this "URL
prefix shorthand" feature in v1.5.0.

> $ git pull . remotes/origin/next
> Already up-to-date.
>
> [ Woooh!  But since I always hated this syntax let's try merge instead. ]
>
> $ git merge origin/next
> Already up-to-date.

Yes, that is one of the reasons that you would prefer 'merge'
when you are working locally.

> $ git pull origin
> Warning: No merge candidate found because value of config option
>          "branch.local_next.merge" does not match any remote branch fetched.
> No changes.
>
> So this means that branch.local_next.merge should be set to origin/next?  

No, the message says "any REMOTE branch" -- refs/heads/next is
what it is called at the remote, and that is how the value is
expected to be spelled; I think somebody added an example to
config.txt recently to stress this.  The above error messasge
obviously was not clear enough.  Rewording appreciated.
