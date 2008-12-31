From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 11:24:47 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812311103000.19665@iabervon.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local> <alpine.LNX.1.00.0812302143210.19665@iabervon.org> <alpine.LNX.1.00.0812302236190.19665@iabervon.org> <gjfnsb$5ph$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 17:26:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI3ta-0004Az-MC
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 17:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbYLaQYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 11:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756033AbYLaQYt
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 11:24:49 -0500
Received: from iabervon.org ([66.92.72.58]:38857 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbYLaQYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 11:24:48 -0500
Received: (qmail 24399 invoked by uid 1000); 31 Dec 2008 16:24:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Dec 2008 16:24:47 -0000
In-Reply-To: <gjfnsb$5ph$4@ger.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104280>

On Wed, 31 Dec 2008, Zorba wrote:

> Ok, now I'm following you, cos I just "broke" checkout again by deleting 
> files from working dirs before running it.
> 
> git-checkout takes into account the state of the working tree in the commit 
> it is run FROM, as well as the commit it is checking out.
> 
> It relies on the working tree being in synch with the commit it is run from.
> If I delete files, I screw around with this initial state.
> Files that git-checkout is relying on to be there are not copied in by it, 
> so if I've deleted (or modified) those files, hard luck.

It's not relying on these files to be there; it's actually aware that 
they're not there. It thinks that any modifications you've made might be 
important work, and carefully preserves it.

Actually, it should be telling you the changes that it's carrying over 
with lines like:

D	ABC.txt

(which indicated that you've deleted ABC.txt, and it's keeping that 
modification)

> I remember s/o saying git minimizes file I/O, and this whats happening here.
> 
> It puts a big demand on the user, to keep their index & working dir in synch 
> with whats in the commit.

The user is hopefully not going to make a lot of random undesired changes 
in general. It's hard to get much done that way. If you have made changes, 
you can use "git checkout ." to get the versions back from the index, or 
"git checkout HEAD ." to get them back from the commit. 

> Ah,
> 
> $ git checkout .
> 
> will restore the state of the working dir to be in synch with the CURRENT 
> commit, so it will be safe to checkout other branches
> 
> BINGO !!
> what I need to do is run the sequence
> 
> $ git checkout .                    // tidy up current commit
> $ git checkout <version>     // roll back
> 
> n'est pas ?

Either that, or:

$ git checkout <version>
$ git checkout .

(it doesn't matter whether you get rid of the local modifications and 
deletions before switching, or switch first, and then get rid of any 
remaining local modifications and deletions)

You may also want:

$ git clean

To get rid of untracked files you may have around (use "git clean -x" if 
you also want to get rid of files you've told git to ignore).

Incidentally, if your goal is to give someone a copy of the state as of a 
particular version, you can use:

$ git archive --format=zip <commit> > version.zip

This doesn't involve your working directory at all, and just generates a 
zip file out of the history. I find that this means I rarely actually care 
about having a working directory that's free of random junk.

	-Daniel
*This .sig left intentionally blank*
