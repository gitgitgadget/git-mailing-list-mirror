From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: first impressions to git
Date: Sun, 18 Sep 2005 12:56:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509181201220.23242@iabervon.org>
References: <20050918111259.GA10882@schottelius.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 18:53:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH2Oh-0004Cc-G7
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 18:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVIRQwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 12:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVIRQwI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 12:52:08 -0400
Received: from iabervon.org ([66.92.72.58]:6660 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751230AbVIRQwH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 12:52:07 -0400
Received: (qmail 21747 invoked by uid 1000); 18 Sep 2005 12:56:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2005 12:56:21 -0400
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20050918111259.GA10882@schottelius.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8786>

On Sun, 18 Sep 2005, Nico -telmich- Schottelius wrote:

> Hello!
> 
> I was testing git for my needs with the following ideas in my mind:
> 
> - it must be easy to use
> - documentation must be easy to find, understand and remember
> - it should be fast
> - optionally using the filesystem as a database would be nice
> 
> My first impressions are:
> 
> - many commands, reminds me of arch/tla

git's got a lot of internal commands that you shouldn't need to use. If 
you don't count the executables, but rather count the options listed by 
"git"... you still get a lot. But most of those are scripts for doing 
common operations. Maybe we should have a list of the set of commands you 
actually need, without the commands that are unnecessary but streamline 
things you might want to do? (For example, git format-patch generates a 
set of patches in a single command with a single argument; but you can 
also generate a diff with git diff, if you want the primitive operation.)

I think the only ones you actually need are: init-db, add, commit, 
checkout, push, pull, status, diff, log, and tag. But if you're trying to 
track down which commit broke something, bisect will come in handy. And 
there's applymbox for applying an mbox file of patches, and so forth.

>    o it's not clear to me, how I should publish (push)
>       - scp/rsync from outside
>       - git/cogito push

You generally want some public location which allows at least one of 
anonymous rsync, http, and git-daemon (e.g., kernel.org currently serves 
the relevant directories by rsync and http). You then push to that 
location from wherever you actually work.

>    o excluding *.o seems not to work, neither through .gitignore nor through
>      .git/info/exlude
> - How do I check integrity of files, is signed files somehow implemented?
> 
> I've written some notes down in
>    http://creme.schottelius.org/~nico/temp/git-erfahrungen

(Now at .../git-erfahrungen01)

It looks like you managed to be using an *older* version than the 
documentation; git-update-index is the new name, not the old one. I'm not 
sure how that happened, but I'd guess a "make install" bug or a PATH issue 
or something.

We need to fix the error for trying to add a directory, and we should 
probably support it in "add".

Core git doesn't have a .git/info/excludes at all. (And, in general, 
.gitignore makes more sense, I think, because you usually want this to be 
version-controlled; but maybe there should be .git/info/excludes as a 
default for new directories?)

.git/description is actually a gitweb feature, not a core git feature. 
You'd only set it up for public repositories that you want to describe.

I'd be much obliged if you could tell me where the documentation lost you; 
it's really hard to document effectively without the assistance of someone 
who doesn't already know the program.

".git/remotes" is the current one; ".git/branches" is obsolete.

The only "push" protocol is ssh (using an scp-style path). Pull protocols 
are: ssh (using the scp-style path), anonymous rsync, 
http/https/ftp/anything else "curl" supports, and the git daemon protocol 
(that is, you can run a program directly or from inetd to serve files to 
clients that ask with "git://" URLs).

	-Daniel
*This .sig left intentionally blank*
