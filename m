From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 13:39:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705091322180.18541@iabervon.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
 <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
 <20070509134151.GT4489@pasky.or.cz> <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 09 19:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlq8y-0002iA-DE
	for gcvg-git@gmane.org; Wed, 09 May 2007 19:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbXEIRj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 13:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756245AbXEIRj5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 13:39:57 -0400
Received: from iabervon.org ([66.92.72.58]:2315 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224AbXEIRj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 13:39:56 -0400
Received: (qmail 26396 invoked by uid 1000); 9 May 2007 17:39:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2007 17:39:55 -0000
In-Reply-To: <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46759>

On Wed, 9 May 2007, Linus Torvalds wrote:

> Many people seem to enjoy per-hunk commits, but I seldom do that. Maybe 
> it's just because I'm *so* comfortable with diffs, that when I clean up an 
> ugly sequence of commits, what I do is literally:
> 
>  - I make sure that my ugly sequence of commits is on some temporary 
>    branch, but that the _end_result_ is good and clean (ie I will have 
>    tested the end result fairly well, and made sure that there are no 
>    debug statements etc crud left).
> 
>    I would call this branch something like "target", because the end 
>    result of that branch is what I'm looking for - even if the commits in 
>    the sequence that gets me there are individually ugly!
> 
>  - I just switch back to my starting point (and now I'm usually on 
>    "master"), and do
> 
> 	git diff -R target > diff
> 
>    to create a diff of my current tree (which is initially the starting 
>    point) to the good result.
> 
>  - I actually edit the "diff" file by hand, and edit it down to the part I 
>    actually want to commit as the first in the series. And then I just do 
>    a "git-apply diff" to actually apply that part to my working tree.
> 
>  - I then edit any missing parts in the actual working tree (for example, 
>    if there were mixed hunks that I want to get to in later commits, and I 
>    edited out above, or that I need to partially undo), to do any 
>    finishing touches.
> 
>  - I now have a tree I can compile and test, and has the "first part" of 
>    the journey towards the final "target" state. If compiling/testing 
>    shows that I missed something, I can still fix things, and/or go back 
>    to doing another "git diff -R target" to see if I missed something).
> 
>  - I commit that first case, and repeat the sequence from step 2 (and 
>    at every step, the "diff" file ends up shrinking and shrinking).
> 
> The above sounds like it's a complicated sequence, but it really isn't. 
> Partly because I just am very comfortable with diffs indeed (probably more 
> than most people), but partly because at all times "git diff" works fine 
> to see what I've done, and what the diff to "target" is.

It only sounds like a complicated sequence because you didn't write a 
script to do it...

$ git checkout -b clean origin
$ git-refine target
  (edit the patch in the editor that pops up)
$ git-refine
Test changes and commit
$ make test
...
$ git commit
  (write message)
$ git-refine
  (edit the patch, etc)
  ...
$ git commit
$ git-refine
All done.

I actually wrote it years ago, but I couldn't describe my workflow well 
enough, so I didn't submit it. If everybody seems to be doing the same 
thing, I can submit my script...

	-Daniel
*This .sig left intentionally blank*
