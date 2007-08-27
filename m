From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: new to git
Date: Mon, 27 Aug 2007 16:11:31 -0400
Message-ID: <20070827201131.GK3118@fieldses.org>
References: <46D32973.8030104@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Kyle Rose <krose@krose.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:19:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPkvx-0000cw-53
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 22:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbXH0ULd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758673AbXH0ULd
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 16:11:33 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44808 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757205AbXH0ULc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 16:11:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPkvr-0007h9-J0; Mon, 27 Aug 2007 16:11:31 -0400
Content-Disposition: inline
In-Reply-To: <46D32973.8030104@krose.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56875>

On Mon, Aug 27, 2007 at 03:43:47PM -0400, Kyle Rose wrote:
> I've been playing with it for a few weeks and generally understand what
> is going on, but I do have a few usage questions that I couldn't find
> answered in the docs:

I think I tried to cover most of this in the user-manual
(http://www.kernel.org/pub/software/scm/git/docs/user-manual.html has
the latest version, or it's in Documentation/) but some of it may be
harder to find than it should be.

> (1) Let's say I:
> 
> git clone something
> git branch foo
> git checkout foo
> <make some changes>
> git commit -a
> git checkout master
> git pull . foo
> git push
> git pull
> 
> what is actually happening?  The pull appears to do something (i.e., I get:
> 
> * refs/remotes/origin/master: fast forward to branch 'master' of
> /home/krose/git-repository/baz/
>   old..new: 7cf088c..d344f98

Git caches the value of the remote's "master" in
refs/remotes/origin/master.  That's the thing that's getting updated;
you can actually

	cat .git/refs/remotes/origin/master

before and after you'll see that it got updated from 7cf088c to d344498.

I think newer versions of git actually update that "remote-tracking
branch head" on the push as well, which would prevent you from getting
the message since by the time of the pull that thing will already have
been updated.

> (3) I notice I can't reset --hard a single file.  So, if I want to
> revert a single file to some revision, blowing away my changes, what is
> the accepted way of doing this?

	git checkout some_revision path/to/filename

> Is there a way to do the equivalent of
> a p4 print foo@some_revision?

I don't know p4, but maybe you're looking for

	git show some_revision:foo

> (4) I'm still not clear on when a dst should and should not be used in a
> refspec.  It appears that one can only do non-fast forward updates to
> the branch that is checked out (which makes sense, since you may need to
> resolve), but other than that, what is the difference between
> 
> git checkout foo
> git pull . master
> 
> and
> 
> git checkout master
> git push . master:foo

The latter should forcibly reset the branch head "foo" to point at the
same commit as "master".  The former tries to do a merge between the
two.

In the case where master is a descendant of foo (so there's no commits
in foo that isn't already in master), the two should do the same thing.

> (5) Are there any tools for managing some of the metadata (e.g., the
> origin URL) or is it expected that one edit it directly?

Maybe you want "man git-remote"?  Or see "git-config" for more general
configuration.

But editing .git/config file directly is often simplest, and won't cause
any problem.

--b.
