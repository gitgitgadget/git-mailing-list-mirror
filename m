From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 22:59:48 +0200
Message-ID: <20050722205948.GE11916@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 23:01:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4cp-0004kD-CP
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVGVU7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVGVU7z
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 16:59:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61958 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262169AbVGVU7v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 16:59:51 -0400
Received: (qmail 24393 invoked by uid 2001); 22 Jul 2005 20:59:48 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 22, 2005 at 10:39:06PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Porcelains need to agree on what is placed where and used in
> what way.

Yes, I always try to make things as Cogito-unspecific as possible.

>   - Per user.  A user may want to use different environment
>     settings for different projects [*4*].
> 
>   - Per repository (or work tree).  A user may have more than
>     one work tree for the same project, and want to use
>     different "preference" items per tree.

I wouldn't distinct between those two. You as a user can copy things
around when you clone the repositories (if you ever do so), or the
Porcelain can do it, but having global per-user _combined with
per-project settings sounds nightmarish. After all, how do you identify
a project?  What if projects merge? I wouldn't open this can of worms.

Obviously, there have to be just per-user settings (independent of
"project").

> About the "where" part, one proposal I have off the top of my
> head is something like this:
> 
>   - Have a directory at the root of the tree, "_git" (I do not
>     care about the name at this moment.  The point being it can
>     be revision controlled as part of the project and propagate
>     to other repositories), to store per-project configuration.

Fine, but I would probably prefer having it hidden. .gitinfo?

>   - Use $GIT_DIR/conf/ as a convention to store per repository
>     configuration files.  This does not propagate with
>     pulls/pushes/merges across repositories.

That's fine by me. I'd prefer the hooks staying in $GIT_DIR/hooks/.

>   - Use $HOME/.gitrc (could be a directory or a file in .ini
>     style like StGIT uses -- again, I do not care about the
>     details at this moment) to store per-user configuration.

As long as I can sanely parse it in shell... ;-)

> Which configuration is read first, what can be overridden, and
> if the configuration is cumulative would be specific to each
> preference item, I suspect.  Some project may not want a user to
> override the pre-commit hooks, for a bad example.  But normally
> the per-repository one would take precedence over per-user one
> which in turn would take precedence over per-project one.

What about just running all the hooks in the order you specified?

> [Footnotes]
> 
> *1* Technically this does not involve the core at all, but the
> core people can act as objective, Porcelain-neutral referees.
> They'll need to know the outcome of the discussion anyway, since
> they are the ones that end up maintaining the Porcelain-neutral
> tutorial document.
> 
> *2* Unless we are talking about the kind that shows and lets you
> edit the diff to be committed, which somebody else's Porcelain
> may support, that is.

FWIW, I'm planning something like this in cg-commit (when called
explicitly with -d) in short-term future.

> *3* .gitignore in the cwd is used in Cogito, if I am not
> mistaken.

Yes. There were several discussions about this in the past, with no
clear outcome, IIRC. I would prefer:

  ~/.git/ignore per-user
  /.git/ignore per-repository
  .gitignore per-directory (cummulative with parent directories)

Note that I also want to make use of some special characters in this
file. In particular /^# and /^!, to make it at least as powerful as CVS'
ignore.

> *4* E.g. I would commit for GIT project with junkio@cox.net
> while using junio@twinsun.com for my day-job projects.

.git/author in current Cogito (.git/conf/author or something in the
Brave New World ;-).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
