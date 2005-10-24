From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFE: git rm
Date: Mon, 24 Oct 2005 17:38:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510241725370.25300@iabervon.org>
References: <435D2FE0.3060307@pobox.com> <7virvmodhz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 23:41:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUA23-0007Y6-ER
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 23:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVJXVjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 17:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVJXVi7
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 17:38:59 -0400
Received: from iabervon.org ([66.92.72.58]:35078 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751311AbVJXVi7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 17:38:59 -0400
Received: (qmail 9056 invoked by uid 1000); 24 Oct 2005 17:38:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Oct 2005 17:38:25 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virvmodhz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10562>

On Mon, 24 Oct 2005, Junio C Hamano wrote:

> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > It would be nice to say "git rm files..." and have two operations occur:
> >
> > * list of files is passed to rm(1)
> > * list of files is passed to git-update-index --remove
> 
> This is not a big problem *if* your index always matches the
> HEAD tree (i.e. no intermediate git-update-index in between
> commits) --- you can just say "rm -f files..." at the point of
> removal, continue your work, and either pass these files from
> the command line, or -a flag when running 'git commit'.
> 
> Running git-update-index in between commits is a valid thing to
> do, and it helps reducing the clutter when viewing 'git diff' to
> see what your changes look like since your last update-index.
> The workflow would go like this:
> 
>     1$ git checkout
>     ... work work work
> 
>     ... what have I done so far?
>     2$ git diff
>     ... the intermediate result looks OK, so record what we have
>     ... done so far...
>     3$ git-update-index --add --remove files...
> 
>     ... work work work
>     ... go back to step 2 as many times as needed.
> 
>     ... now what is the sum of changes since the last commit?
>     4$ git diff HEAD
> 
>     ... everything looks OK.  record the last bits and commit.
>     5$ git-update-index --add --remove files...
>     6$ git commit
> 
> Previously Linus stated that his index almost always matches the
> HEAD tree, and I personally do not do intermediate update-index
> ever myself, but I am curious how other people use git [*1*].
> If some of you run update-index in between commits, "git rm
> files..."  would make a lot of sense.

I often do "git add something" when I happen to think of it, not 
necessarily right before committing, which means that I have these files 
changed in my index while working. I may quit this, however, now that git 
status lists the ones I missed.

Incidentally, the new git status entry for --others really ought to say 
something different from "Ignored files", like "Exist but not tracked", 
since it doesn't include the contents of .gitignore, which you'd expect to 
be "Ignored". (And, of course, any files it lists are hardly being 
ignored.)

	-Daniel
*This .sig left intentionally blank*
