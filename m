From: Jon Nelson <jnelson-git@jamponi.net>
Subject: Re: Branches and all commits
Date: Mon, 19 Dec 2005 11:39:06 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0512191104080.6812@gheavc.wnzcbav.cig>
References: <Pine.LNX.4.63.0512190908140.6812@gheavc.wnzcbav.cig>
 <43A6DC90.3040403@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 18:41:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoOyq-0002Wz-59
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 18:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVLSRjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 12:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVLSRjP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 12:39:15 -0500
Received: from mxsf20.cluster1.charter.net ([209.225.28.220]:27052 "EHLO
	mxsf20.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932242AbVLSRjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 12:39:14 -0500
Received: from mxip05a.cluster1.charter.net (mxip05a.cluster1.charter.net [209.225.28.135])
	by mxsf20.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jBJHd6sH021610
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 12:39:11 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip05a.cluster1.charter.net with ESMTP; 19 Dec 2005 12:39:07 -0500
X-IronPort-AV: i="3.99,268,1131339600"; 
   d="scan'208"; a="1622833768:sNHT16587268"
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 4DC12C092; Mon, 19 Dec 2005 11:39:06 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id 34F1AC091
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 11:39:06 -0600 (CST)
In-Reply-To: <43A6DC90.3040403@op5.se>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13829>

On Mon, 19 Dec 2005, Andreas Ericsson wrote:

> Jon Nelson wrote:
> > Should *all* commits be reachable via at least one branch? I ran into a
> > situation this weekend that has me a little confused. I had performed a
> > number of commits and such and I noticed that the author and committer info
> > had suboptimal values. A bit of searching led me to a comment made by Linus
> > that basically said "go hack git-convert-objects", which I did. After
> > performing git-convert-objects on every commit object in .git/refs/heads and
> > the requisite pruning, etc... just about everything looked fine. However, I
> > still had a long series of commits that contained the wrong information.
> > Further inspection makes it appear as though these commits are not reachable
> > via any branch, although they are /all/ reachable via a series of tags. I
> > worked around the problem by further modifying git-convert-objects to also
> > understand tags (at least the basic ones I've got) and that's all taken care
> > of, but the question remains: should *all* commit objects be reachable by at
> > least one branch?
> > 
> 
> AFAIU, yes.
> 
> For future reference, what you should have done is this;
> 
> $ git format-patch --mbox <first-unscrewed-commit-ish>
> # edit commit-messages in generated patches
> $ git reset --hard <first-unscrewed-commit-ish>
> $ for i in 00*.txt; do git apply < $i; done
> $ git prune;# to get rid of the unreachable objects AFTER you've checked
> everything's all right
> 
> If things fail, do
> 
> $ git reset --hard ORIG_HEAD
> 
> and ask again.
> 
> I'm afraid I can't help you fix up your repository from the state it's 
> in now. AFAIK, there's no tool to do it automagically.

The repository seems just fine with this single exception - no branch 
contains a reference to the commit that forms the chain of commits that 
would otherwise be described as a branch. As I understand it, then, the 
only thing that is missing is an entry in .git/refs/heads.

Experimentally, I added that entry by determining the first commit in 
that chain and echoing that sha1 into .git/refs/heads/some_name and that 
works as expected.

I suspect that the root cause was a 'git branch -D' I issued a while 
back. My question is this: if deleting a branch in that manner caused me 
to enter this situation, is that a bug or no? The commits in question 
*are* referenced by various tags, but not by any branch that exists any 
more.  The echo command effectively re-created the branch and all seems 
well.

--
Jon Nelson <jnelson-git@jamponi.net>
