From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn with multiple remote repositories?
Date: Wed, 03 Dec 2008 09:45:02 +0100
Message-ID: <4936470E.6090500@drmicha.warpmail.net>
References: <20081202213930.GD12716@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 09:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7nNK-0001nK-By
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 09:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbYLCIpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 03:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbYLCIpK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 03:45:10 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49645 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbYLCIpI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 03:45:08 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C26A21CAF5E;
	Wed,  3 Dec 2008 03:45:07 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 03 Dec 2008 03:45:07 -0500
X-Sasl-enc: FhYVjz0hnV4iLa8e6Okz3PbWUmBUWT4nYliktnsjbAsd 1228293907
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0DB7499D8;
	Wed,  3 Dec 2008 03:45:06 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <20081202213930.GD12716@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102230>

Josef Wolf venit, vidit, dixit 02.12.2008 22:39:
> Hello,
> 
> I am trying to create a git repository with two remote svn repositories
> so that I can merge/move patch-sets back and forth between the svn
> repositories.
> 
> This is what I have tried so far:
> 
>   mkdir -p project
>   cd project
>   git-svn init -R private -s https://foo.bar/repos/private
> 
> Then I go and edit .git/config too look like this:
> 
>   [core]
>           repositoryformatversion = 0
>           filemode = true
>           bare = false
>           logallrefupdates = true
>   [svn-remote "private"]
>           url       =   https://foo.bar/repos/private
>           fetch     =      trunk:refs/remotes/private/trunk
>           branches  = branches/*:refs/remotes/private/*
>           tags      =     tags/*:refs/remotes/private/tags/*
>   [svn-remote "public"]
>           url       =   https://foo.bar/repos/public
>           fetch     =      trunk:refs/remotes/public/trunk
>           branches  = branches/*:refs/remotes/public/*
>           tags      =     tags/*:refs/remotes/public/tags/*
> 
> And finally, I do
> 
>   git-svn fetch -R private
>   git-svn fetch -R public
> 
> Both commands seem to fetch the contents from their origins.  But
> git-branch shows me only the local master branch with contents from
> the "private" svn repository.  When I do
> 
>   git checkout public/trunk
> 
> the contents actually change to reflect the "public" svn repository,
> but git-branch says I am on "(no branch)" at all.

You want "git branch -a" if you want to see all branches including
remotes. "master" happens to reflect "remotes/private/trunk" because the
first fetch set it up like that. Further fetches will not change master.

Remote branches are your local copy, but different from local branches:
you're not supposed to check them out, and if you do anyways, you get a
"detached HEAD". Well, your repo gets a detached HEAD...

If you want to work with remote branches, create a tracking branch: a
local branch that is based on a remote one and that is set up to rebase
(or merge) new commits from the remote:

git checkout -b mypublic/trunk remotes/public/trunk

You can name the local branch any way you want, even "public/trunk", but
that may lead to confusion when you look at the output of "git branch
-a" which suppresses the "remote/" part.

Michael
