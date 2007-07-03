From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Document git-filter-branch
Date: Wed, 4 Jul 2007 00:05:40 +0200
Message-ID: <20070703220540.GN12721@planck.djpig.de>
References: <Pine.LNX.4.64.0707031746400.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:06:09 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qVS-0001en-OQ
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbXGCWF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbXGCWFz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:05:55 -0400
Received: from planck.djpig.de ([85.10.192.180]:2604 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbXGCWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:05:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id B63D588102;
	Wed,  4 Jul 2007 00:05:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMdd3OeQqMMQ; Wed,  4 Jul 2007 00:05:41 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 3EF7488105; Wed,  4 Jul 2007 00:05:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707031746400.4071@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51541>

General note: All the stuff in all uppercase should probably also
have some asciidoc emphasis.

On Tue, Jul 03, 2007 at 05:47:44PM +0100, Johannes Schindelin wrote:
> +DESCRIPTION
> +-----------
> +Lets you rewrite git revision history by creating a new branch from
> +your current branch, applying custom filters on each revision.
> +Those filters can modify each tree (e.g. removing a file or running
> +a perl rewrite on all files) or information about each commit.
> +Otherwise, all information (including original commit times or merge
> +information) will be preserved.
> +
> +The command takes the new branch name as a mandatory argument and
> +the filters as optional arguments.  If you specify no filters, the
> +commits will be recommitted without any changes, which would normally
> +have no effect and result in the new branch pointing to the same
> +branch as your current branch.  Nevertheless, this may be useful in
> +the future for compensating for some git bugs or such, therefore
> +such a usage is permitted.
> +
> +WARNING! The rewritten history will have different object names for all
> +the objects and will not converge with the original branch.  You will not
> +be able to easily push and distribute the rewritten branch on top of the
> +original branch.  Please do not use this command if you do not know the
> +full implications, and avoid using it anyway, if a simple single commit
> +would suffice to fix your problem.
> +
> +Always verify that the rewritten version is correct before disposing
> +the original branch.
> +
> +Note that since this operation is extensively I/O expensive, it might
> +be a good idea to redirect the temporary directory it off-disk, e.g. on
                                                    ^^^^^^
The "it" probably doesn't belong there.

> +tmpfs.  Reportedly the speedup is very noticeable.
> +
> +
> +Filters
> +~~~~~~~
> +
> +The filters are applied in the order as listed below.  The <command>
> +argument is always evaluated in shell using the 'eval' command.
> +The $GIT_COMMIT environment variable is permanently set to contain
                                           ^^^^^^^^^^^
I find the use of this word in this context odd and a little confusing.
Maybe better "always" or "each time"?

> +the id of the commit being rewritten.  The author/committer environment
> +variables are set before the first filter is run.

Maybe give the actual names of the environment variables here?

> +A 'map' function is available that takes an "original sha1 id" argument
> +and outputs a "rewritten sha1 id" if the commit has been already
> +rewritten, fails otherwise; the 'map' function can return several
> +ids on separate lines if your commit filter emitted multiple commits.
> +
> +
> +OPTIONS
> +-------
> +
> +--env-filter <command>::
> +	This is the filter for modifying the environment in which
> +	the commit will be performed.  Specifically, you might want
> +	to rewrite the author/committer name/email/time environment
> +	variables (see gitlink:git-commit[1] for details).  Do not forget
> +	to re-export the variables.
> +
> +--tree-filter <command>::
> +	This is the filter for rewriting the tree and its contents.
> +	The argument is evaluated in shell with the working
> +	directory set to the root of the checked out tree.  The new tree
> +	is then used as-is (new files are auto-added, disappeared files
> +	are auto-removed - .gitignore files nor any other ignore rules
> +	HAVE NO EFFECT!).

Is "nor" correct here? Not just "or"?

[...]
> +--subdirectory-filter <directory>::
> +	Only regard the history, as seen by the given subdirectory. The
                              ^^^
Does this comma belong there?

> +	result will contain that directory as its project root.
> +
> +-d <directory>::
> +	Use this option to set the path to the temporary directory used for
> +	rewriting.  When applying a tree filter, the command needs to
> +	temporary checkout the tree to some directory, which may consume
> +	considerable space in case of large projects.  By default it
> +	does this in the '.git-rewrite/' directory but you can override
> +	that choice by this parameter.
> +
> +<rev-list-options>::
> +	When options are given after the new branch name, they will
> +	be passed to gitlink:git-rev-list[1].  Only commits in the resulting
> +	output will be filtered, although the filtered commits can still
> +	reference parents which are outside of that set.
> +
> +
> +Examples
> +--------
> +
> +Suppose you want to remove a file (containing confidential information
> +or copyright violation) from all commits:
> +
> +-------------------------------------------------------
> +git filter-branch --tree-filter 'rm filename' newbranch
> +-------------------------------------------------------
> +
> +A significantly faster version:
> +
> +-------------------------------------------------------------------------------
> +git filter-branch --index-filter 'git update-index --remove filename' newbranch
> +-------------------------------------------------------------------------------

Even if your code goes beyond 80 chars, the surrounding "---" doesn't
have to and makes it even harder to read when reading the original
asciidoc text.

> +
> +Now, you will get the rewritten history saved in the branch 'newbranch'
> +(your current branch is left untouched).
> +
> +To "etch-graft" a commit to the revision history (set a commit to be
> +the parent of the current initial commit and propagate that):
> +
> +----------------------------------------------------------------------
> +git filter-branch --parent-filter sed\ 's/^$/-p <graft-id>/' newbranch
> +----------------------------------------------------------------------

Wouldn't have 'sed s/^$/-p <graft-id>/' exactly the same effect, since
the quotes are interpreted by the original shell anyway and not the
filter shell? Just wondering why it uses such a complicated way to
express it.

> +(if the parent string is empty - therefore we are dealing with the
> +initial commit - add graftcommit as a parent).  Note that this assumes
> +history with a single root (that is, no merge without common ancestors
> +happened).  If this is not the case, use:
> +
[...]

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
