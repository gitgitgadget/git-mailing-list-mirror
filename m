From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Add git-sequencer documentation
Date: Sat, 26 Jul 2008 16:47:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261623530.26810@eeepc-johanness>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <1217049644-8874-2-git-send-email-s-beyer@gmx.net> <1217049644-8874-3-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMl3f-0003vD-TW
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYGZOqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbYGZOqo
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:46:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:35103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751989AbYGZOqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:46:43 -0400
Received: (qmail invoked by alias); 26 Jul 2008 14:46:42 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp031) with SMTP; 26 Jul 2008 16:46:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3ITgwWYy37VrHIsNfo15aZw3V1uekv7yKI2w8iy
	Ec+gGSF8IQJk8Q
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217049644-8874-3-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90230>

Hi,

On Sat, 26 Jul 2008, Stephan Beyer wrote:

> +-B::
> +--batch::
> +	Run in batch mode. If unexpected user intervention is needed
> +	(e.g. a conflict or the need to run an editor), 'git-sequencer' fails.

Does it abort, or leave a dirty tree?

> +--onto=<base>::
> +	Checkout given commit or branch before sequencing.
> +	If you provide a branch, sequencer will make the provided
> +	changes on the branch, i.e. the branch will be changed.

Whoa, does that mean that

	$ git checkout my-private-branch
	$ git sequencer --onto=master

will change _master_?

> +--continue::
> +	Restart the sequencing process after having resolved a merge conflict.

What about 'edit'?  Does it restart the sequencing process after editing a 
file or commit message, too?

> +--skip::
> +	Restart the sequencing process by skipping the current instruction.

s/ by/,/

> +--status::
> +	Show the current status of 'git-sequencer' and what
> +	operations can be done to change that status.

Nice.

> +--edit::
> +	Invoke editor to edit the unprocessed part of the TODO file.

Nice!

> +If you nonetheless noticed that you made a mistake, you can
> +overwrite `.git/sequencer/todo` with `.git/sequencer/todo.old` and
> +rerun `git sequencer --edit`.

Speaking of "todo": there was an explicit request to change that to 
"git-rebase-todo" for rebase -i, so that syntax highlighting could be 
switched on.

> +-q::
> +--quiet::
> +	Suppress output. Implies `--no-advice`.
> +	(Not yet implemented.)

So this is not meant for application yet.  Okay.

> +-v::
> +--verbose::
> +	Be more verbose.

More?

> +NOTES
> +-----
> +
> +When sequencing, it is possible, that you are changing the history of

s/possible,/possible/  I know that mistake, being a German myself.

> +a branch in a way that can cause problems for anyone who already has
> +a copy of the branch in their repository and tries to pull updates from
> +you.  You should understand the implications of using 'git-sequencer' on
> +a repository that you share.

How about this instead?

	Note that sequencing will rewrite the history of the branch.  
	This will cause problems if you published the branch prior to
	rewriting the history, as the former tip is no longer an 
	ancestor of the new tip.

	In other words, if you rewrite an already published branch, users 
	that pull from you _will_ get a bogus merge.
	
> +'git-sequencer' will usually be called by another git porcelain, like

s/another git procelain/other git programs/

> +TODO FILE FORMAT
> +----------------
> +
> +The TODO file contains basically one instruction per line.

s/basically //

> +edit <commit>::
> +	Pick a commit and pause the sequencer process to let you
> +	make changes.
> ++
> +This is a short form for `pick <commit> and `pause` on separate lines.

It might make sense to explain 'pick' before 'edit', then.

> +mark <mark>::
> +	Set a symbolic mark for the last commit.
> +	`<mark>` is an unsigned integer starting at 1 and
> +	prefixed with a colon, e.g. `:1`.
> ++
> +The marks can help if you want to refer to commits that you
> +created during the sequencer process, e.g. if you want to
> +merge such a commit.

It might make sense to explain 'merge' before that, then.

> +	--mainline=<n>;;
> +		Allow you to pick merge commits by specifying the
> +		parent number (beginning from 1) to let sequencer
> +		replay the changes relative to the specified parent.

Why is this called "mainline", and not "parent"?

> [... talking about 'patch']
>
> +	--exclude=<path-pattern>;;
> +		Do not apply changes to files matching the given path pattern.
> +		This can be useful when importing patchsets, where you want to
> +		exclude certain files or directories.

You might just as well support the new "--directory" option of git-apply, 
too, and/or --recount.

> [talking about 'squash']
>
> +	--collect-signoffs;;
> +		Collect the Signed-off-by: lines of each commit and
> +		add them to the squashed commit message.
> +		(Not yet implemented.)

I really have to wonder how useful that is.  Or how correct, for that 
matter.

> +
> +	--include-merges;;
> +		Sanity check does not fail if you have merges
> +		between HEAD and <mark>.

It may be a commit, too, right?  And why does it make sense to check that 
there are no merges?  I mean, it is just as if I did two cherry-picks, the 
second with -n, and then commit --amend it.  Can make tons of sense...

> +Here are some examples that shall ease the start with the TODO
> +file format.
> +Make sure you have understood the `pick` and perhaps the `patch` command.
> +Those will not be explained further.

This sentence is insulting.  Strike it.

> +------------
> +$ git rev-list --no-merges --reverse A^..E | sed -e 's/^/pick /'`
> +------------

Don't.

$ git log --pretty=format:'pick %h' --no-merges --reverse A^..E

Ciao,
Dscho
