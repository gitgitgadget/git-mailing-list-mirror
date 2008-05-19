From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: submodules workflow aches
Date: Mon, 19 May 2008 14:11:34 -0400
Message-ID: <20080519181134.GA7928@pe.Belkin>
References: <320075ff0805190756x3adf1684i3980aac15e2ddb88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 20:12:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy9qX-0005Pu-4p
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 20:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332AbYESSLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbYESSLh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 14:11:37 -0400
Received: from eastrmmtao105.cox.net ([68.230.240.47]:55542 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132AbYESSLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 14:11:36 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080519181136.ZVCQ23410.eastrmmtao105.cox.net@eastrmimpo02.cox.net>;
          Mon, 19 May 2008 14:11:36 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id TWBb1Z0030epFYL02WBbaK; Mon, 19 May 2008 14:11:35 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1Jy9pe-00026B-Fv; Mon, 19 May 2008 14:11:34 -0400
Content-Disposition: inline
In-Reply-To: <320075ff0805190756x3adf1684i3980aac15e2ddb88@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82438>

On Mon, May 19, 2008 at 03:56:49PM +0100, Nigel Magnay wrote:
> We've been using submodule support for a few months (and I've been
> checking out the list to see what other people are doing); it works
> well, but there's a couple of ache points (in the sense that if I'm to
> convince SVN users to migrate, they're liable to point and laugh).
> 
> The first nuisance is the 'get me up to date' stanza of 'git pull &&
> git submodule update' always leaving you on (no branch), even if you
> were on [master] before, and the head commit now is also equal to
> [master]. Having to remember to go into several submodules and do 'git
> checkout master' to get you back to ready-to-do-work mode isn't nice
> (and is worse if you're on autopilot, and someone has committed a
> submodule on a different branch

It might help if you describe more completely how you expect it to behave
under a wide variety of conditions.  I suspect that the current behavior
is the simplest behavior that remains correct under all conditions.

> The second nuisance is around conflicts in submodules. If I make a
> (non-conflicting) change to a submodule, merge with the head and
> commit, then when I do a 'git pull' in the superproject readiness to
> do a push, I get a conflict. This is presumably because it doesn't
> know that the submodule change is a fast-forward. It'd be nice if it
> could figure that out, and not conflict?

If I follow the scenario correctly, you're essentially pulling into a
dirty working tree.  I guess you're saying that if the submodule
wasn't touched by the merge, you'd like it to leave your working tree
dirty?

> Are people writing their own wrapper scripts for this? I find I have a
> hard time explaining why it's all necessary to svn users who just (by
> and large) do 'svn up' and 'svn ci' on projects..

I'll throw out one nuisance that I hit, perhaps related to your second
one: in the super-module, rebasing a series containing a submodule
update.  I start the rebase with a clean working tree, but since the
rebase doesn't update the submodule, (which I wouldn't really want it
to do anyway) the rebase aborts in the middle with:

$ git rebase --continue 
plugin/submodule: needs update
Working tree is dirty

forcing me to "git submodule update" in order to continue.

Then, when the rebase finishes, my working tree is dirty again because
the submodule is out-of-date, so I have to "submodule update" AGAIN.

Am I just missing the much better way to do this?

-chris
