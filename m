From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Help using Git(-svn) for specific use case
Date: Mon, 15 Sep 2008 17:12:49 +0200
Message-ID: <48CE7B71.4090702@fastmail.fm>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pico Geyer <picogeyer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 17:14:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfFm8-0001ft-Kg
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 17:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbYIOPMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYIOPMz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 11:12:55 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56744 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753998AbYIOPMy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 11:12:54 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 135D2162CAB;
	Mon, 15 Sep 2008 11:12:53 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 15 Sep 2008 11:12:53 -0400
X-Sasl-enc: EhEL/010LXZvzOjFNfzNNy4x1QpNU7m1pP9DX7K4XENN 1221491572
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6A63828B0F;
	Mon, 15 Sep 2008 11:12:52 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95913>

Pico Geyer venit, vidit, dixit 15.09.2008 14:50:
> Hi all.
> 
> I'd like to start using Git within our company. I'm still trying to
> determine if Git can work in our scenario.
> May be someone can offer some advice.
> Our scenario is as follows:
> We have a handful of developers which work at a branch office. This
> office has a rather slow internet connection.
> At the head office, we are (still) using a Subversion server to host
> our source code.
> At the branch office, we would like to do the following:
> * Fetch the latest code from the subversion server.
> * Push changes that we have made at the remote office back to upstream
> SVN server.
> * Be able to share source code changes locally (at the branch office)
> between developers.
> 
> The solution that I imagined is that we would setup a server (lets
> call it A) at the branch office with a Git repository, that all the
> developers can access.
> Developers would then clone the server repository A, make mods and
> then push changes back to A.
> It would be nice if git users could commit to a subversion branch.
> A merge master would then (as necessary) use svn dcommit to push the
> changes up to the svn server.
> Is this scenario possible?
> 
> From the git-svn man page: "git-clone does not clone branches under
> the refs/remotes/ hierarchy or any git-svn metadata, or config. So
> repositories created and managed with using git-svn should use rsync
> for cloning, if cloning is to be done at all."

That is true if you mean by "clone" a complete copy.

> Does that mean that one should not push changes to a repository that
> was created with "git svn clone ..."?

What matters is which branches you push into.

Your developers don't need to push/commit to svn, only into A, if I
understood correctly. Do they need svn-metadata (besides svn revision
numbers)?
If not then the interaction between A and the developers can be a normal
git workflow between git managed branches, and "git clone" will do fine.

Merge master at A could do the following:
- use git svn to keep the svn (remote) branches at A in sync with the
central subversion server
- push them to proper git branches in A, which get picked up by
developers' " git clone"
- maintain integration branches for integrating the changes coming fro
the developers
- dcommit the svn tracking branches back to the central svn server

Disadvantage:
If changes are dcommitted to svn, synced back with git svn fetch, and
then fetched/pull by the developers their commit will look different
(addition git svn info in the commit message). This is similar to a
workflow where you submit by e-mail and your integrated patches get a
different sha1.

Advantage:
For all developers, everything is just git. Only megre master needs to
know git svn.

Cheers,
Michael
