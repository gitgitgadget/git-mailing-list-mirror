From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 22:55:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 22:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8kfS-00058f-3v
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 22:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXAUVzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 16:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbXAUVzy
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 16:55:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:53047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751690AbXAUVzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 16:55:53 -0500
Received: (qmail invoked by alias); 21 Jan 2007 21:55:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 21 Jan 2007 22:55:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37347>

Hi,

On Sun, 21 Jan 2007, Junio C Hamano wrote:

>  - 'git pack-refs' appeared in v1.4.4;

You should probably mention that it is not necessary to run git-pack-refs 
by hand: git-gc is what you want.

BTW have I praised y'all for inventing git-gc? It is _awesome_. I think I 
will turn into a DWIM geek yet; it is soooo much more convenient to issue 
"git gc" from time to time, than to think exactly about what I want to 
clean up right now.

>  - 'git repo-config', 'git grep', 'git rebase' and 'gitk' were
>    seriously enhanced during v1.4.0 timeperiod.

Should we introduce "git config" in time for the "let's please end-users" 
release (1.5.0)?

>  - git-clone always uses what is known as "separate remote"
>    layout for a newly created repository with a working tree;
>    i.e. tracking branches in $GIT_DIR/refs/remotes/origin/ are
>    used to track branches from the origin.  

... instead of $GIT_DIR/refs/heads/, making the difference between 
remotely tracked and local branches more obvious.

>  - git-branch and git-show-branch know remote tracking branches.

... (use the command line switch "-r" to list only tracked branches.)

>  - git-push can now be used to delete a remote branch or a tag.
>    This requires the updated git on the remote side.

... (use "git push <remote> :refs/heads/<branch>" to delete "branch".)

>  - git-push more agressively keeps the transferred objects
>    packed.  Earlier we recommended to monitor amount of loose
>    objects and repack regularly, but you should repack when you
>    accumulated too many small packs this way as well.  Updated
>    git-count-objects helps you with this.

It might make sense to enable something similar for git-fetch in time for 
1.5.0.

> * Reflog
> 
>  - Reflog records the history of where the tip of each branch
>    was at each moment.

It might make sense to reformulate that:

	Reflog records the history from the view point of the local 
	repository. In other words, regardless of the real history,
	the reflog shows the history as seen by one particular repository
	(this enables you to ask "what was the current revision in _this_
	repository, yesterday at 1pm?").

>  - There is a toplevel garbage collector script, 'git-gc', that
>    is an easy way to run 'git-repack -a -d', 'git-reflog gc',
>    and 'git-prune'.

Did I mention that I really _love_ git-gc?

>  - The original implementation of git-merge-recursive which was
>    in Python has been removed; we have C implementation of it
>    now.

I am no native speaker, but should that not be "we have a C 
implementation" instead?

>  - The default suffix for git-format-patch output is now ".patch",
>    not ".txt".  This can be changed with --suffix=.txt option,
>    or "format.suffix = .txt" in the configuration.

I fully expect people to complain that a config like this

	format.suffix = .txt

does not work. better say ...

	or setting the config variable "format.suffix" to ".txt".

>  - Better error messages for often used Porcelainish commands.

Amen. I think this really helped a lot of people already.

>    - Cloning and fetching _from_ a shallow clone are not
>      supported (nor tested -- so they might work by accident but
>      they are not expected to).

Maybe we should go the "restrict first, and loosen later" approach? I.e. 
forbid git-upload-pack to run if is_repository_shallow()?

>    - Pushing from nor into a shallow clone are not expected to
>      work.

Maybe forbid git-push and git-receive-pack to run if 
is_repository_shallow()?

(I _think_ git-push should be safe, but not git-receive-pack.)

Ciao,
Dscho
