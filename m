From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Patch editing
Date: Tue, 27 Feb 2007 12:35:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702271201400.6485@iabervon.org>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702270205540.6485@iabervon.org>
 <Pine.LNX.4.63.0702271247000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 18:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM6En-00056D-9U
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 18:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbXB0Rfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 12:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbXB0Rfc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 12:35:32 -0500
Received: from iabervon.org ([66.92.72.58]:1417 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbXB0Rfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 12:35:31 -0500
Received: (qmail 31026 invoked by uid 1000); 27 Feb 2007 12:35:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2007 12:35:28 -0500
In-Reply-To: <Pine.LNX.4.63.0702271247000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40764>

On Tue, 27 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 27 Feb 2007, Daniel Barkalow wrote:
> 
> > For much the same reason, I wrote a script that entirely ignores the 
> > intermediate commits in a throw-away head, and lets you trim down the 
> > diff between the mainline and your head, and arrange it into a new patch 
> > series.
> 
> It looks to me like you just start a new branch, get the state of an 
> existing commit *1*, and then "git add -i" your way through that diff.

Essentially, yes.

> This is slightly different from my work flow:
> 
> - I can have overlapping changes (i.e. one commit fixes something which 
>   gets refactored in the next), and

That's true; I occasionally add some change that will go away in the next 
patch (or a later patch). This goes in between applying the cut-down 
patch and committing it (I also often build and test at this point, to 
make sure that my intermediate states work; so I can leave thing not 
working in the patch, and fix the build errors to generate the temporary 
intermediate state).

> - I try not to touch the code when editing the patch series. Only in the 
>   conflicting case, I _have_ to edit it.
> 
> The latter means, of course, that the commits in the throwaway branch 
> _must_ be a superset of the commits I want to have in the cleaned up 
> branch. (Meaning that I never commit two unrelated things with the same 
> commit.)
> 
> To achieve that, I use my own version of "git add -i" quite often while 
> composing the throwaway branch. For example, when I found a bug with an 
> easy fix, in the middle of something different, and the fix touches a file 
> that is already changed, I only commit the appropriate hunks of that file.

One nice thing about my method is that, if you've had to make a dozen 
unrelated changes to get something to compile and run far enough to test 
whether any of the changes are actually correct, you can be sure to get 
that work preserved. I'd be a lot less comfortable preparing intermediate 
states if I didn't have the final state securely tucked away.

I don't really trust myself to not lose some partially-working state 
before I reach a state that's worthy of a commit, so I generate a lot of 
unworthy commits as part of the process of generating a state worth 
committing. I also sometimes want to use multiple computers in the course 
of reaching a state worthy of a commit; using git's state-distribution 
mechanism for that is really nice.

> *1* It is not really as easy as "git diff ..other-branch | git apply", 
> since you would lose valuable information about added files, so you have 
> to be very careful there.

"git apply --index" actually recovers the information about added files.

	-Daniel
*This .sig left intentionally blank*
