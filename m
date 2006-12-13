X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: svn versus git
Date: Wed, 13 Dec 2006 17:56:27 -0500
Message-ID: <20061213225627.GC32568@spearce.org>
References: <200612132200.41420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 22:56:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612132200.41420.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34248>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gud1g-0005Ms-0T for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751667AbWLMW4d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWLMW4d
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:56:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38111 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751667AbWLMW4c (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 17:56:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gud1Q-0002NJ-Tb; Wed, 13 Dec 2006 17:56:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4DDC520FB6E; Wed, 13 Dec 2006 17:56:28 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> svn cat::
> Output the contents of specified files or URLs.  Optionally at a
> specific revision.
> git cat-file -p $(git-ls-tree $REV $file | cut -d " " -f 3 | cut -f 1)::

better:

  git cat-file -p $REV:$file

not sure how much easier it gets than that.  Load in the bash
completion from contrib/completion and you can even tab complete
the $file part.

> Subversion wins.  This is a distinctly non-user friendly way of reading
> a file.

Documentation flaw that the above wasn't clear?  Or is "-file" and
"-p" the losing part for Git?
 
> svn cleanup::
> git fsck-objects::
> git prune::
> git repack::
> 
> Subversion wins, as it only has one command and you don't need to
> understand the repository in order to understand what its doing.

True, but I'm not sure its fair to Git.  svn cleanup is also a
technical command that one needs to learn either when something
went wrong or later once the user has gotten used to using SVN.
Git's fsck-objects, prune and repack aren't usually needed until
the user has had a chance to use it for a while and accumulate a
number of loose objects.

The last time I ran fsck-objects was when I was trying to debug
that empty tree object missing in git-merge-recursive.  Usually I
don't see repository corruption, and even there wasn't any.

> svn merge::
> Apply the differences between two sources to a working copy path.
> git pull::
> Pull and merge from another repository or a local branch.
> 
> It could be argued that "pull" is a bad name for this command.  Apart
> from that however, git-pull is significantly easier to use than svn
> merge.  It's output isn't as easy to understand, as it dumps loads of
> confusing information to the user.

or git merge now.  :-)
 
> Git wins.  Once you've used it, it's nowhere near as terrifying to use,
> because it can be easily undone.  It's harder to do damage because git
> tracks merges whereas svn doesn't.  It's better at merging.  You will
> spend a good five minutes thinking about what you must type for an
> svn-merge.  git-pull is a no-brainer.

This is one of Git's killer features over SVN.  Git does merges
right.  SVN doesn't.  Though I keep hearing its on their TODO list.

> svn mkdir::
> Create a new directory under version control.
> [no git equivalent]::
> Git doesn't track directories, so doesn't need this command.  Simply
> adding content that is in a subdirectory is sufficient.
> 
> Git wins.   It does the right thing for you and you needn't remember to
> wrap your "mkdir"s with your VCS.  Also, one-less-command.

Some people like having the empty directory tracked by the VCS, as
then the build system doesn't need to create it.  I perfer keeping
all object files in a single directory which the build system
creates, as cleaning up is just "rm -rf output" (or whatever it is)
so I could care less about empty directory tracking; I think most
people are that way.
 
>  - svn cat: the git equivalent is too complicated.
>    It wouldn't be hard to write a git-cat; if git's aliases allowed
>    pipes, it could be done instantly.

See above.

>  - svn list: this only wins because the default output of git-ls-tree is
>    so user unfriendly.

How is it unfriendly?  What specifically would you change to make
it more friendly?

>  - svn cleanup: git-fsck-objects, git-prune and git-repack all need too
>    specific knowledge of git.
>    
>    They also need running too often on the user's initiative.  It would
>    be nice, for example, if git-reset, git-rebase and git-branch could
>    detect when a prune is going to be needed and give the user a hint.

You don't want to prune every time these happen.  When you start to
make use of the reflog pruning too often is a huge loss.  I actually
maybe prune my active repositories once every couple of months,
the extra garbage hanging out is usually peanuts.
 
>    As to git-repack and git-fsck-objects - when _should_ these be run?
>    How is the user meant to know?

As to the former it depends on your OS (Windows you want to pack
more often) but git-count-objects gives you a good indication of how
many loose objects exist.  git-fsck-objects probably only needs to
be run if something is not working right and you suspect an object
is missing.

-- 
