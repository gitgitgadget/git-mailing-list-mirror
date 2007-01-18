From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Thu, 18 Jan 2007 21:52:33 +0100
Message-ID: <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 18 21:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7eFj-0003Mt-AN
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 21:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbXARUww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 15:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbXARUww
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 15:52:52 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:49088 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbXARUwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 15:52:51 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 852DD7CC5;
	Thu, 18 Jan 2007 21:52:50 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 70A951F073; Thu, 18 Jan 2007 21:52:33 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37139>

On Thu, Jan 18, 2007 at 09:05:47AM +0000, Catalin Marinas wrote:
> But isn't this too complicated when all you need is a 'rebase'-like command?

Well, I realize that I was not very clear in all this stuff.  There
are indeed 3 things I'm working on, but which are closely related to
each other.  One is rebasing to an arbitrary point; the second is
forking an stgit stack out of another (possibly remote) stgit stack;
the third is that having "stg pull" use git-pull results for my
workflow in a purely broken situation.

Since the 2nd is merely "git-fetch then rebase to new head of remote",
and the 3rd is 100% fixed for me by using git-fetch instead of
git-pull, I tend to somewhat mix all those concepts and that surely
shows in my mails.

That said, let me try to detangle all this :)

> On 16/01/07, Yann Dirson <ydirson@altern.org> wrote:
> >My example is quite similar to the one given by Guilhem: I had a git
> >branch coming from git-cvsimport, and my stgit stack forked atop that
> >branch.  At some point git-cvsimport fucked something, and I
> >regenerated a new mirror branch using it in a fresh repo.  Then I
> >wanted to rebase my stack on that new branch.
> 
> As Jakub said, I would also call this command 'rebase' instead of
> 'pull --to', even if we duplicate a bit of code.
> It would make the implementation even simpler

A new command is fine with me, it's just that I feel "rebase <target>"
may be confusing to beginners.  I'd rather say "rebase [<stack>] --to
<target>", but it's just that I don't see the case for specifying a
different stack than the current one.


> as you won't break other people's workflows using git-pull or
> cg-pull. The main feature of the 'pull' command is to fetch the
> latest changes from a remote repository and merge (fast-forward)
> them into current base.

However, this relates to the 2nd and 3rd items in my list, sorry to
have brought confusion here.


> >> But you want to replace the call to 'git pull' with 'git fetch'. I
> >> think this is fine with my workflow but some people might actually
> >> rely on calling 'git pull' (or cg-pull).
> >
> >Right, it may be possible (and I'd be interested in seeing such a
> >workflow).  Maybe we could keep support for git-pull as an
> >alternative.
> 
> As I said, I use this myself on an exported branch.

I've heard that, but I had understood that you used this because there
was nothing better available now, and that my second item (forking off
a public stgit-managed branch) would address your needs.  If not, I
may have missed something.


> >This could be done, eg. by letting the user use "pullcmd=git-pull" and
> >introduce a new option like "fastforward=<bool>" triggering the
> >fast-forward needed after git-fetch, with the default being "true",
> >and the current behaviour being obtained by changing it to "false".
> 
> >That would not add too much complexity, while setting the default to
> >what I believe to match the most common workflows, and allow anyone
> >relying on the current behaviour to get it back.
> 
> The problem is that I may use different workflows in the same
> repository (but on different branches). Any new config options would
> have to be per branch.

That can be a serious point.  But I fear we would start to seriously
over-enginneer things here - unless the workflows that really require
the current behaviour are really widespread (again this assume I've
correctly understood yours), wouldn't it be better to require the user
to use one workflow per checkout, at least until such workflows are
explicited so we can support them at best ?

BTW, I have started a couple of weeks ago to write things about patch
management and associated workflows in the GIT wiki [1].  This has a
wider scope than just StGIT, and I have not finished to write down
everything I wanted to, but that could be a place to start from.
Especially, I only listed a couple of workflows without extended
description, and it would be great to have a page for each, with
several ways to put them in action, with different sets of tools.

[1] http://git.or.cz/gitwiki/PatchManagement

Best regards,
-- 
Yann.
