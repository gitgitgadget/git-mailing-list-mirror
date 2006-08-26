From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problem: unexpected files/diffs in commit
Date: Sat, 26 Aug 2006 00:33:54 -0700
Message-ID: <20060826073354.GB10801@localdomain>
References: <m2u040n5e2.fsf@ziti.local> <20060825191516.GA8957@localdomain> <m2lkpcfhml.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 09:35:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGshR-00079F-Nd
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 09:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWHZHd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 03:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWHZHd5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 03:33:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35989 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751007AbWHZHd4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 03:33:56 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8F7847DC02E;
	Sat, 26 Aug 2006 00:33:54 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 26 Aug 2006 00:33:54 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m2lkpcfhml.fsf@ziti.local>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26034>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:

> > Outside of the SSL problems, the mis-commit isn't strictly user-error,
> > but git-svn is confusing in this case, as the documentation is unclear
> > about what git-svn should do in this case :x
> 
> > I usually check with git log remotes/git-svn..HEAD instead of git
> > diff.  Perhaps adding --no-merges would be more correct?

No, --no-merges is not correct (see below).

> I'm not sure how to reproduce the situation I was in, but what would
> git log have shown me that git diff didn't -- IOW, would it have been
> obvious that the commit op was going to add extra stuff and
> effectively undo a rev in svn?

> > I've been really slacking on the git-svn documentation the past few
> > months, help would be much appreciated.
> 
> I will try to send some doc patches.  But I may have a few questions ;-)

> I think commit-diff might be what I want to be using too, but I need
> to contribute some documentation for it before I can read the man page
> and start using it ;-)
> 
> An example call to git-svn commit-diff would be very helpful, I
> suspect.

git-svn commit-diff <a> <b>
(git diff-tree <a> <b> to check the result)

My new command, 'dcommit' wraps it.

'commit-diff' very low-level command that does exactly what you tell
it to do, compute the delta of two trees, and send it to the SVN repo.
The <a> tree doesn't even have to strictly match what's in the SVN repo
at the given moment if you're using the SVN:: libs.

'commit' was the original command, that meant: write this tree to SVN.
Period.  This was before SVN:: library support was available, so it had
to be stupidly simple.

foo..bar notation was supported, which in hindsight was a mistake
that has probably confused lots of people....

> I will have a look...
> 
> While I'm thinking of it, it would be really nice for git-svn's commit and
> commit-diff to have a dry-run type of flag.  Commits to your own git
> repos are easy to correct, but those made on some other public scm are
> less pretty.

I think everything is somewhat documented in the commit logs, but most
of those were back when git-svn was in contrib/

Otherwise, git-svn help attempts to be reasonably self-documenting, and
I've tried to keep the code to git-svn fairly readable (except the code
to generate the aforementioned help output :)

-- 
Eric Wong
