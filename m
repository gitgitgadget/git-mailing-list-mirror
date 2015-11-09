From: Marc Haber <mh+git@zugschlus.de>
Subject: Re: how to check for uncommitted/unstaged changes on remote side
 before pushing
Date: Mon, 9 Nov 2015 10:31:24 +0100
Message-ID: <20151109093124.GB18762@torres.zugschlus.de>
References: <20151108212320.GA18762@torres.zugschlus.de>
 <1447057500.5074.8.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 10:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvioE-0006Vm-M6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 10:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbbKIJcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 04:32:04 -0500
Received: from torres.zugschlus.de ([85.214.131.164]:55682 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbbKIJb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 04:31:26 -0500
Received: from mh by torres.zugschlus.de with local (Exim 4.80)
	(envelope-from <mh+git@zugschlus.de>)
	id 1ZvinM-0007d5-FZ; Mon, 09 Nov 2015 10:31:24 +0100
Content-Disposition: inline
In-Reply-To: <1447057500.5074.8.camel@kaarsemaker.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281046>

Hi Dennis,

thanks for your comments. I appreciate that.

On Mon, Nov 09, 2015 at 09:25:00AM +0100, Dennis Kaarsemaker wrote:
> On zo, 2015-11-08 at 22:23 +0100, Marc Haber wrote:
> > Hi,
> > 
> > I am trying to abuse git as a code distribution channel and would
> > like
> > to be able to trigger redistribution just by git push.
> 
> [insert obligatory remark about git not being a deployment tool]

That's why I said "abuse" ;-)

Abusing git here has the advantage that one can save local changes and
merge them, which is handy for the task at hand (which is deploying my
dotfiles to "my" servers).

> > The idea is to push to a remote to the branch that is currently
> > checked out followed by a git reset --hard in the post-receive hook.
> > I
> > have already figured out that I need to set receive.denyCurrentBranch
> > to ignore to be able to push to the currently checked out branch.
> 
> You'll need a new enough git, so you can set it to updateInstead (and
> maybe use a push-to-checkout hook).

That's a nice new feature. Unfortunately even the git 2.1.4 which is
in current Debian stable does not support that yet, but I think I can
live with a backport, and in the past git has shown to be reasonably
easy to backport.

> > I am also aware that it is a good idea to git pull before git push
> > just in case there were local commits on the remote.
> 
> No, hooks should never pull, merge or do anything that could be
> interactive.

I mean that I would manually pull on the master before pushing to the
remote, thus making sure that the push will go through fine. With the
pull, I would get all committed remote changes merged locally on the
master, leaving uncommitted and unstaged changes to worry about.

> > git reset --hard will unconditionally throw away local uncommitted
> > changes. I would like to detect this situation on the remote and
> > abort
> > the receive progress. But my pre-receive hook does not work as
> > intended. Here is my code:
> >
> > [snip code]
> >
> > What is going wrong here?
> 
> You mention a post-receive hook first, but have written a pre-receive
> hook. Not sure if that's what you intended (or even if that's what's
> going wrong).

My intention was having a pre-receive hook check for uncommitted or
unstaged changes and abort the process if there were any. If there
were none, the push would go through and a post-receive hook would
update the working copy.

With updateInstead, I could probably go without the post-receive hook,
but in my understanding, the check for uncommitted/unstaged changes
would still be handy and helpful.

> > If my entire approach is wrong, what is the recommended way to 
> > prevent a repository with unstaged or uncommitted changes from being 
> > pushed to?
> 
> Push-to-checkout is a very simplistic way of deploying and while it
> works in simple cases, I'd not recommend it.
> 
> Two safer/saner approaches are:
> - Have a separate non-bare repo, and make the post-receive hook in a
>   bare repo trigger a fetch+reset in the non-bare one
> - Use git archive and symlink trickery for even better deploys

Both these approaches would make it harder or even impossible to merge
local changes done on the remotes.

> Questions like this come up in #git all the time, so I wrote up a few
> more detailed recipes here, including working hooks and config for all
> three ways of deploying: 
> http://git.seveas.net/simple-deployments-with-git.html

Thanks, that is appreciated. I refrained from coming to #git since my
experience is that complex issues are hard to manage on IRC. I have,
however just joined as Zugschlus, so if you want to talk to me
directly feel free to do so.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
