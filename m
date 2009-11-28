From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unable to checkout a particular SVN revision
Date: Sat, 28 Nov 2009 16:03:09 +0100
Message-ID: <4B113BAD.8090604@drmicha.warpmail.net>
References: <718EEBA2-FA4B-402D-B2FC-A8F14D79F6FF@entropy.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Liyanage <marc@entropy.ch>
X-From: git-owner@vger.kernel.org Sat Nov 28 16:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEOpX-0000lx-3m
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 16:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZK1PDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 10:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbZK1PDL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 10:03:11 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44262 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768AbZK1PDK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 10:03:10 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 393A9C2293;
	Sat, 28 Nov 2009 10:03:16 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 28 Nov 2009 10:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OHUlnIlPmMnpPgoV4ddXsXVxz/M=; b=rZYUuLwJWzIPvytQOUh92ROxX2cE86TIlBT+WZJc3CeJ8o6R9RlQWhCSa1vfDulps0Npg+cnOaVntpUs+HKAbF4rvi1cNpayhHy+xg2XmD91UJroYMBFEtKAxdUSxY0RudyxZGCkA6/G8el349DyKjBU3lkEMFKrdRR3VH47um4=
X-Sasl-enc: Gz2OPgzBwHIRphLMIJuy86hekdVbtPHU9T4F1V3OA166 1259420595
Received: from localhost.localdomain (p5DCC12B9.dip0.t-ipconnect.de [93.204.18.185])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8C5DF9E4;
	Sat, 28 Nov 2009 10:03:15 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <718EEBA2-FA4B-402D-B2FC-A8F14D79F6FF@entropy.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133961>

Marc Liyanage venit, vidit, dixit 28.11.2009 03:05:
> 
> I'm trying to clone a specific SVN revision with git-svn:
> 
>     git svn clone -r 12345 https://host/svn/foo/branches/bar xyz
> 
> but it doesn't check out any files, I see just this:
> 
>     Initialized empty Git repository in /Users/liyanage/Desktop/xyz/.git
> 
> If I try the same thing with SVN like this:
> 
>     svn co -r 12345 https://host/svn/foo/branches/bar xyz
>     
> then I get what I expect, it checks out all the files and "svn info" gives me this revision.
> 
> 
> I think it's because this particular revision wasn't committed on this branch, i.e. it doesn't show up in "svn log". If I try a revision that is listed in the log, it works as expected.
> 
> 
> Is there a way to make this work?

No. Because "this" is different in the two cases above: "git svn clone"
clones the history of an svn repo, and the command above clearly gives
you the history of that branch in the specified revision range
(consisting of 1 revision). It is empty.

"svn co" checks out a specific revision.

You cannot "clone" a revision.

If all you want is a git repository with no history, but with the files
of a specific svn revision, you can
svn co -r 12345 https://host/svn/foo/branches/bar xyz
cd xyz
git init
find . -name .svn -print0 | xargs -0 rm -Rf
git add .
git commit -m "r12345 of branch bar"

Michael
