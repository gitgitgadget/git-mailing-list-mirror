From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 14:07:50 +0200
Message-ID: <49EC6596.8060208@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 14:09:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvsJd-0005MK-93
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 14:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbZDTMIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 08:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbZDTMID
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 08:08:03 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50359 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754712AbZDTMIB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 08:08:01 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EAC8831DE64;
	Mon, 20 Apr 2009 08:07:59 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 20 Apr 2009 08:07:59 -0400
X-Sasl-enc: R6/8gs8yIc9Ur7HGMeQRdl2nvk5TW1iCNKe43yJh/Ycb 1240229279
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1EAA74D49E;
	Mon, 20 Apr 2009 08:07:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090420113216.GC25059@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116976>

Dmitry Potapov venit, vidit, dixit 20.04.2009 13:32:
> On Sun, Apr 19, 2009 at 05:17:52PM +0200, Johannes Schindelin wrote:
>>
>> But it is important to keep in mind that our concept of branches is not 
>> intuitive:
>>
>> http://longair.net/blog/2009/04/16/git-fetch-and-merge/
> 
> I don't see how our concept of branches is any different from what other
> version control systems have; but I see why it is so confusing for many

It is very different, and for a good reason, indeed.

git's branches really are moving tags. As such, there is no single
branch that a commit would be tied to. A commit does not belong to a
specific branch; you commit on a branch (usually), and it may be
contained in 1 or more branches, of course. Which branch (name) may
actually depend on the repository: branch names are not stored in
commits, only (backward) relations between commits.

This is fundamentally different from what is named "branch" in hg, e.g.
There, a commit stores the branch name, which is why you can't delete
branches easily. [For me, this is also why hg branches are useless, but
I don't want to start flames here - for me they are useless, for others
they may still be perfect.]

Branches in cvs etc. are much like the latter: You commit on a specific
branch, *and* you can't change that later. The branch name at time of
creating a commit is stored in the commit.

Hg is introducing "bookmarks" now, corresponding to git branches. I
think this name describes the nature of git branches very well.

> people. We define a branch as a line of development (I'm still think it
> is a pretty good and widely accepted definition of branch), yet when a
> newcomer runs gitk, what he or she sees is not a line but a graph.
> 
> Thus anyone looking at a gitk image may ask you: "Where is this line
> that represents the master branch?" Indeed, it is nearly impossible to
> see it, but it does not mean this line does not exist. If you run:
> gitk --first-parent master
> you can see it.
> 
> Unfortunately, this line is far from being one straight line drawn in
> a single color. Thus, not surprisingly that this line cannot be seen in
> the graph, and here is where the mental image that a new user has about
> branches (based on different books and diagrams) clashes with the image
> presented by gitk. No one will ever draw the mainline like this:
> 
> -o--o--o         o--o--o
>         \       /
>          o--o--o
> 
> but it is not uncommon for gitk to display it in this way, and when
> this line is intervene with many other branches that forking from and
> merging to this mainline, all what you can see a complex graph and
> nothing more.
> 
> There is one more thing. In Git, all branches are equal and that is a
> really good feature from the implementation point of view as it makes
> design simpler and more powerful. But the user point of view, branches
> are never equal -- there is a _big_ difference between the master and
> any feature branch. All diagrams explaining branching and merging will
> show the mainline as a thick straight line running through all history
> (like a tree trunk) while feature branches fork and merge back to it.
> 
> That is the mental image that a new user has, and that image clashes
> with what he or she sees in gitk. BTW, when I started to use Git, I
> strongly preferred qgit over gitk. Admittedly, gitk displays branches
> much better when you have a really bushy tree, but straight lines
> displayed by qgit were much easier to understand and to follow.
> 
> So, I don't think that we have any conceptual problem here. It may be
> a visualization problem, but if you have a really complex tree, it may
> be impossible to present it as nice and simple as artificial diagrams
> in textbooks.
> 
> 
> Dmitry
