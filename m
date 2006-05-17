From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Wed, 17 May 2006 11:28:15 -0700
Message-ID: <7viro4ecao.fsf@assigned-by-dhcp.cox.net>
References: <e4f1ta$e07$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 20:28:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgQkt-0007xn-RM
	for gcvg-git@gmane.org; Wed, 17 May 2006 20:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWEQS2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 14:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWEQS2R
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 14:28:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61317 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750853AbWEQS2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 14:28:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517182816.KBSC25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 14:28:16 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e4f1ta$e07$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	17 May 2006 13:37:19 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20217>

Jakub Narebski <jnareb@gmail.com> writes:

> In #git channel somebody asked about 'branches' and 'heads' and was referred
> to the glossary. I had taken then a look at appropriate glossary entries.
>
> In 'Documentation/glossary.txt' we have:
> ----  
> branch::
>         A non-cyclical graph of revisions, i.e. the complete history of
>         a particular revision, which is called the branch head. The
>         branch heads are stored in `$GIT_DIR/refs/heads/`.
>
> head::
>         The top of a branch. It contains a ref to the corresponding
>         commit object.
>
> head ref::
>         A ref pointing to a head. Often, this is abbreviated to "head".
>         Head refs are stored in `$GIT_DIR/refs/heads/`.
>
> revision::
>         A particular state of files and directories which was stored in
>         the object database. It is referenced by a commit object.
> ---- 
>
> It is just me or the glossary entry for `branch` is unnecessary 
> complicated? 

While technically it might be correct, the above description for
"branch" completely misses the point in the context of other
entries.  I do not recall when this entry was first written, but
I suspect it probably predates other entries that talk about the
same thing.

As you point out it talks primarily about the mesh of all
possible histories (i.e commit DAG), without talking much about
what "branch" means and what role "branch" plays.

I cannot easily do a glossary entry to describe that specific
term, but maybe somebody else can split the following up and
paraphrase.

        A project history is born by recording a particular
        state ("revision") as a root commit, and built up by
        recording subsequent states ("revisions") on top of the
        previous commits.  Thus, a group of commits connected by
        their parent fields form a directed acyclic graph
        ("DAG").  Often this linkage between commits by their
        parent fields is called "ancestry chain", and a commit
        that has another commit in its "parent" field is called
        a "child commit" of the latter.

        There can be multiple root commits in the history of a
        project.  In other words, projects born independently
        can later be glued together to become a single project.

        The history is grown by building on top of previous
        commits, and by the nature of distributed development,
        many lineages of histories are grown simultaneously.
        Each lineage is called a "branch".

        A commit that can be reached by following the ancestry
        chain from a commit that is "on the branch" is also "on
        the branch", and a commit that cannot be reached by
        following the ancestry chain from any commit that is "on
        the branch" is not "on the branch".  The commit that
        bootstraps this recursive definition of "on the branch"
        is called its "branch head", the "tip of the branch", or
        the "top commit".  In other words, it is topologically
        the latest commit on the branch.

	The above does not mean the top commit of a branch does
	not have any child commit in the global project
	histories.  It just means that these children are not on
	the branch; they may be on some other branches, forked
	from it.  To create a branch whose "on the branch"
	commits are strict superset of "on the branch" commits
	of another branch is called "forking" the branch.
