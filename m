From: Andreas Ericsson <ae@op5.se>
Subject: Re: new to git
Date: Mon, 27 Aug 2007 22:22:40 +0200
Message-ID: <46D33290.20405@op5.se>
References: <46D32973.8030104@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Kyle Rose <krose@krose.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPl79-0004aC-TB
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 22:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565AbXH0UWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 16:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758305AbXH0UWx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 16:22:53 -0400
Received: from mail.op5.se ([193.201.96.20]:50880 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755624AbXH0UWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 16:22:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2A3ED1943F2;
	Mon, 27 Aug 2007 22:22:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.000, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UgZ5PBLdxP2D; Mon, 27 Aug 2007 22:22:42 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 17BF4194020;
	Mon, 27 Aug 2007 22:22:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <46D32973.8030104@krose.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56876>

First of all, welcome to git :)

Having been away from the mailing list for too long, I can't answer all
your questions. I'll take a stab at the ones I've got a clue about though.

I also recommend that you upgrade your git installation to at least 1.5.3,
as most of the people figuring on this list will most likely give advice
that matches that version.

For reference, the git documentation can be found at
http://www.kernel.org/pub/software/scm/git/docs/

J. Bruce Fields et al have written some really excellent introductory
documents which are a must to anyone who wishes to flatten the initial
learning curve a bit.

Kyle Rose wrote:
> After many years of dissatisfaction with the limitations of CVS, and
> after getting fed up with the complexity of configuring and maintaining
> a SVN setup, I just started using git for my own personal projects.  I
> have to say it's quite nice and fits the UNIX philosophy well: fast,
> simple, powerful.
> 
> I've been playing with it for a few weeks and generally understand what
> is going on, but I do have a few usage questions that I couldn't find
> answered in the docs:
> 
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

git pull = git fetch + git merge. The notation you use above is obsoleted
and no longer works in git 1.5.3. Instead you'd have to replace

	git pull . foo

with

	git merge foo

which will most likely clear up some confusion.

> * refs/remotes/origin/master: fast forward to branch 'master' of
> /home/krose/git-repository/baz/
>   old..new: 7cf088c..d344f98
> 
> ), but makes no changes locally since I have the latest revision. 
> Another subsequent git pull does, in fact, say everything is up to date.
> 

It should have made changes to your local tree, namely the ones you added
to branch foo that weren't in master before you merged.

The fact that it turned out to be a fast forward only means that you had
no additional commits on top of master, so the history in foo could be
applied on top of master without any file-level merging taking place.

> (2) Any way to disable this warning:
> 
> Warning: No merge candidate found because value of config option
>          "branch.local.merge" does not match any remote branch fetched.
> 

Yes. Edit your .git/config file to add a merge candidate for your local
branch.

> (3) I notice I can't reset --hard a single file.  So, if I want to
> revert a single file to some revision, blowing away my changes, what is
> the accepted way of doing this?  Is there a way to do the equivalent of
> a p4 print foo@some_revision?
> 

	git checkout treeish path/to/file

according to the man-page at least. "treeish" here can be substituted
for a revision, which in git is represented by a 40 byte SHA1 hash, but
also has a lot of short-hand options. See "git help rev-list" for more
info on that.

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
> 
> ?
> 

Here I'm clueless, except that this matches old syntax which is no longer
valid. I'd recommend you to upgrade to 1.5.3 so that you get to use
git-merge for local merges. The "use push/pull for merging" has caused
enough confusion, I think.

> (5) Are there any tools for managing some of the metadata (e.g., the
> origin URL) or is it expected that one edit it directly?
> 

See the git-remote man page. It's available online if you don't have it.

> Thanks for all your work on this: git fills a need I didn't know I had
> until I actually found myself using it: a completely decentralized patch
> management system.
> 

It's more than that, but many of us share your feeling about it filling
a need we didn't know we had.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
