From: Jon Nelson <jnelson-git@jamponi.net>
Subject: Re: Branches and all commits
Date: Mon, 19 Dec 2005 12:59:55 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0512191257240.6812@gheavc.wnzcbav.cig>
References: <Pine.LNX.4.63.0512190908140.6812@gheavc.wnzcbav.cig>
 <43A6DC90.3040403@op5.se> <Pine.LNX.4.63.0512191104080.6812@gheavc.wnzcbav.cig>
 <43A6F378.6010503@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 20:08:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoQKk-0006x6-W9
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 20:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVLSTGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 14:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVLSTGB
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 14:06:01 -0500
Received: from mxsf12.cluster1.charter.net ([209.225.28.212]:43705 "EHLO
	mxsf12.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932367AbVLSTGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 14:06:01 -0500
Received: from mxip04a.cluster1.charter.net (mxip04a.cluster1.charter.net [209.225.28.134])
	by mxsf12.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jBJJ5uqx025172
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 14:05:58 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip04a.cluster1.charter.net with ESMTP; 19 Dec 2005 13:59:56 -0500
X-IronPort-AV: i="3.99,268,1131339600"; 
   d="scan'208"; a="1091952848:sNHT35809060"
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id B7AE5C092; Mon, 19 Dec 2005 12:59:55 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id A0A6FC091
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 12:59:55 -0600 (CST)
In-Reply-To: <43A6F378.6010503@op5.se>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13832>

On Mon, 19 Dec 2005, Andreas Ericsson wrote:

> Jon Nelson wrote:
> > On Mon, 19 Dec 2005, Andreas Ericsson wrote:
> > 
> > 
> > >Jon Nelson wrote:
> > >
> > > >Should *all* commits be reachable via at least one branch? I ran into a
> > > >situation this weekend that has me a little confused. I had performed a
> > > >number of commits and such and I noticed that the author and committer
> > > >info
> > > >had suboptimal values. A bit of searching led me to a comment made by
> > > >Linus
> > > >that basically said "go hack git-convert-objects", which I did. After
> > > >performing git-convert-objects on every commit object in .git/refs/heads
> > > >and
> > > >the requisite pruning, etc... just about everything looked fine. However,
> > > >I
> > > >still had a long series of commits that contained the wrong information.
> > > >Further inspection makes it appear as though these commits are not
> > > >reachable
> > > >via any branch, although they are /all/ reachable via a series of tags. I
> > > >worked around the problem by further modifying git-convert-objects to
> > > >also
> > > >understand tags (at least the basic ones I've got) and that's all taken
> > > >care
> > > >of, but the question remains: should *all* commit objects be reachable by
> > > >at
> > > >least one branch?
> > > >
> > >
> > >AFAIU, yes.
> > >
> > >For future reference, what you should have done is this;
> > >
> > >$ git format-patch --mbox <first-unscrewed-commit-ish>
> > ># edit commit-messages in generated patches
> > >$ git reset --hard <first-unscrewed-commit-ish>
> > >$ for i in 00*.txt; do git apply < $i; done
> > >$ git prune;# to get rid of the unreachable objects AFTER you've checked
> > >everything's all right
> > >
> > >If things fail, do
> > >
> > >$ git reset --hard ORIG_HEAD
> > >
> > >and ask again.
> > >
> > >I'm afraid I can't help you fix up your repository from the state it's in
> > >now. AFAIK, there's no tool to do it automagically.
> > 
> > 
> > The repository seems just fine with this single exception - no branch
> > contains a reference to the commit that forms the chain of commits that
> > would otherwise be described as a branch. As I understand it, then, the only
> > thing that is missing is an entry in .git/refs/heads.
> > 
> > Experimentally, I added that entry by determining the first commit in that
> > chain and echoing that sha1 into .git/refs/heads/some_name and that works as
> > expected.
> > 
> 
> Lucky thing. I expect you still had all the objects required for the tree to
> do this. If you had run 'git prune' on the repo they would have been lost for
> good though.

That's the thing. I *had* run 'git prune' numerous times.

> > I suspect that the root cause was a 'git branch -D' I issued a while back.
> > My question is this: if deleting a branch in that manner caused me to enter
> > this situation, is that a bug or no?
> 
> It's not a bug. You probably meant to do
> 
> 	$ git branch -d
> 
> -D forces removal even if there are objects reachable only through that
> branch. The man-page says so, but in git'ish, which isn't always intuitive
> until you've grown familiar with the glossary.txt doc.

I tried 'git branch -d' initially and it refused to delete the branch.
So I tried 'git branch -D'.

Re-reading your last paragraph makes it clear what happened, then.
I'll note that I ran 'git branch -D' *days* ago and I've run git-prune 
literally a couple dozen times since then. Is it possible the objects 
weren't removed because they were still referenced by tags?

--
Jon Nelson <jnelson-git@jamponi.net>
