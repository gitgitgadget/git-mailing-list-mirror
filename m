From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Short "git commit $file" syntax fails in the face of a resolved
   conflict
Date: Wed, 21 Jan 2009 22:35:29 +0100
Message-ID: <49779521.9040208@drmicha.warpmail.net>
References: <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, nathan@creativecommons.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkla-0007hC-9E
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbZAUVf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbZAUVfz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:35:55 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53576 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751924AbZAUVfy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 16:35:54 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id AFD9A24A198;
	Wed, 21 Jan 2009 16:35:52 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 21 Jan 2009 16:35:52 -0500
X-Sasl-enc: QakvfRKc6nVA48dwkH87S7NrLuHnPPm+UFvT+lNxSVIk 1232573750
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2866A30718;
	Wed, 21 Jan 2009 16:35:37 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106681>

Asheesh Laroia venit, vidit, dixit 01/21/09 22:00:
> I have found what seems to be a bug in the short "git commit $file" mode 
> of interaction with git. To reproduce it, you can:
> 
> 1. Create a repository with some content.
> 
>  	$ (mkdir a ; cd a ; git init ; echo hi > file ; git add file ; git commit -m 'initial commit')
>  	Initialized empty Git repository in /tmp/playground.2009-01-21.w15613/a/.git/
>  	Created initial commit 276d6eb: initial commit
>  	 1 files changed, 1 insertions(+), 0 deletions(-)
>  	 create mode 100644 file
> 
> 2. Clone that repository.
> 
>  	$ git clone a b
>  	Initialized empty Git repository in /tmp/playground.2009-01-21.w15613/b/.git/
> 
> 3. Create changes in "a" that are not yet cloned into "b".
> 
>  	$ (cd a ; echo ho > file ; git add file ; git commit -m update)
>  	Created commit 91deff9: update
>  	 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 4. Make changes in "b", the clone.
> 
>  	$ echo lol > file
>  	$ git add file ; git commit -m 'Some changes'
>  	Created commit 5d74b5b: Some changes
>  	 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 5. Fetch and merge (AKA pull) from the first repo.
> 
>  	$ git pull
>  	remote: Counting objects: 5, done.
>  	remote: Total 3 (delta 0), reused 0 (delta 0)
>  	Unpacking objects: 100% (3/3), done.
>  	From /tmp/playground.2009-01-21.w15613/a/
>  	   276d6eb..91deff9  master     -> origin/master
>  	Auto-merged file
>  	CONFLICT (content): Merge conflict in file
>  	Automatic merge failed; fix conflicts and then commit the result.
> 
> 6. Resolve the conflict (in our case, by discarding the changes in the "b" 
> clone).
> 
>  	$ echo ho > file
> 
> 7. Commit the resolved conflict.
> 
> NOTE: The normal way to do step 6 is to "git add file ; git commit -m 
> yay". But I will now try to use the "git commit file" shorthand:
> 
>  	$ git commit file -m 'Resolved conflict'
>  	fatal: cannot do a partial commit during a merge.
> 
> 8. Declare a bug.
> 
> I believe that the "git commit file" command issued in step 6 should have 
> worked as well as the "git add file ; git commit" that us old-time git 
> users do.
> 
> 9. Discuss on the git list.
> 
> Do y'all agree that the git behavior is strange and unnecessarily 
> user-impeding here?
> 
> Cheers!
> 
> -- Asheesh.
> 
> P.S. I'm not the one who ran into the bad behavior here; Nathan (CC:d) is 
> the one who did. You don't have to keep him CC:d, though.
> 

You want git commit -i:

       -i, --include
           Before making a commit out of staged contents so far, stage
the contents of paths given on the command line as well.
           This is usually not what you want unless you are concluding a
conflicted merge.

Without -i, git commit path ignores the index, which would be bad in the
middle of a merge, which is why git refuses to do so. You may argue for
git commit to use -i automatically here, but I don't think it's a good idea.

So, out of
1) git add path && git commit
2) git commit path
3) git commit -i path
only 1) and 3) are always equivalent.

Michael
