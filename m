From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Diff-tree does not work for initial commit
Date: Mon, 15 Sep 2008 22:49:06 +0200
Message-ID: <48CECA42.1050209@drmicha.warpmail.net>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:50:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfL1Y-0003r5-Gl
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 22:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbYIOUtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYIOUtN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 16:49:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44056 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753085AbYIOUtM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 16:49:12 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id B860F162E34;
	Mon, 15 Sep 2008 16:49:11 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 15 Sep 2008 16:49:11 -0400
X-Sasl-enc: Z811otcTQWGnhBVGby5lvu2QJ7cH/nk8AexC4uS31wiB 1221511751
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F2FE921E2;
	Mon, 15 Sep 2008 16:49:10 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95940>

Anatol Pomozov venit, vidit, dixit 15.09.2008 22:01:
> Hi, It looks like I found a bug in git.
> 
> The problem: In my script I need to know what files were modified by 
> given commit. I use diff-tree for it. Although it works for most 
> cases, for initial commit it does not. Here is a sequence of actions.
> 
> 
> anatol:~ $ mkdir mkdir initialcommitissue anatol:~ $ cd
> initialcommitissue/ anatol:initialcommitissue $ git init Initialized
> empty Git repository in /home/anatol/initialcommitissue/.git/ 
> anatol:initialcommitissue $ echo "First commit" > 1.txt 
> anatol:initialcommitissue $ git add 1.txt anatol:initialcommitissue $
> git commit -m "First commit" Created initial commit 31ccc6a: First
> commit 1 files changed, 1 insertions(+), 0 deletions(-) create mode
> 100644 1.txt anatol:initialcommitissue $ git diff-tree HEAD     <<<<<
> PROBLEM IS HERE

>From the man page:

       Compares the content and mode of the blobs found via two tree
objects.

       If there is only one <tree-ish> given, the commit is compared
with its parents (see --stdin below).

       Note that git-diff-tree can use the tree encapsulated in a commit
object.


The initial commit has no parent, so diff-tree does not know which tree
to compare to.

You can do

git diff-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904 HEAD

but I guess you suggest that diff-tree should do that automatically for
a single parentless treeish: bug -> RFE

diff-tree is plumbing. Would this change break anything?

Michael
