From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] git-svn: Document branches with at-sign(@).
Date: Wed, 28 Nov 2012 15:43:22 +0100
Message-ID: <50B6230A.2040503@drmicha.warpmail.net>
References: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:43:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdirU-0004cw-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 15:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab2K1OnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 09:43:25 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49854 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753964Ab2K1OnY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2012 09:43:24 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A519420E20;
	Wed, 28 Nov 2012 09:43:23 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 28 Nov 2012 09:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=t+XdHA0iByYBzTjw4ZhEe6
	0ubKg=; b=ZSZhdvnaqg+THNL2+2KgjCc1gmZUkcqEF2mSBW/CDiQswtflUSTIi9
	U92+5J6/G66bZBi6pqwGDe2xsssO9/J2OM4ZSCF8skUVV5mypOIOQb78RjJG4xnB
	6RFu4OivxokLcygCNpSiKQIb95y5yREjRcOCm42+QuFkuEDLEUZKY=
X-Sasl-enc: WKaDnq0HgcrWt1lAKl6azVVP2p/iYy0kNCJjN22mI3Ab 1354113803
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id ED3A48E05AE;
	Wed, 28 Nov 2012 09:43:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210733>

Sebastian Leske venit, vidit, dixit 18.11.2012 18:08:
> git svn will sometimes create branches with an at-sign in the name
> (branchname@revision). These branches confuse many users and it is a FAQ
> why they are created. Document when git svn will create them.
> 
> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
> 
> I found various important features of git-svn that are not documented.
> Thus I created a series of patches to add and update documentation for
> git-svn. I am sending this as four patches (of which this mail is the
> first). I have tried my best to make the patches ready for inclusion
> into git, but if there's any feedback, I'll gladly incorporate it.
> 
> 
>  Documentation/git-svn.txt |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 8b0d3ad..482d60d 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -881,6 +881,32 @@ different name spaces.  For example:
>  	branches = stable/*:refs/remotes/svn/stable/*
>  	branches = debug/*:refs/remotes/svn/debug/*
>  
> +If 'git svn' is configured to fetch branches (and --follow-branches
> +is in effect), it will sometimes create multiple branches for one SVN
> +branch, where the addtional branches have names of the form
> +'branchname@nnn' (with nnn an SVN revision number).  These additional
> +branches are created if 'git svn' cannot find a parent commit for the
> +first commit in the branch, to connect the branch to the history of the
> +other branches. Normally, 'git svn' will find the git commit that
> +corresponds to the SVN revision a branch was created (copied) from and
> +use that as the parent. However, it is possible that there is no
> +suitable git commit to serve as parent.  This will happen, among other
> +reasons, if the SVN branch is a copy of a revision that was not fetched
> +by 'git svn' (e.g. because it is an old revision that was skipped with
> +'--revision'), or if in SVN a directory was copied that is not tracked
> +by 'git svn' (a branch that is not tracked at all, or a subdirectory of
> +a tracked branch). In these cases, 'git svn' will still create a git
> +branch, but the branch will not be connected to the history of the other
> +branches.  'git svn' will also create a commit from the SVN revision the
> +branch was copied from, and use that as the parent commit of the branch
> +(this is indicated by the message "Initializing parent: <branchname>").
> +Additionally, it will create a special branch named
> +'<branchname>@<SVN-Revision>', where <SVN-Revision> is the SVN revision
> +number the branch was copied from.  This branch will point to the
> +specially created parent commit.
> +If in SVN the branch was deleted and later recreated from a different
> +version, there will be multiple such branches with an '@'.
> +
>  BUGS
>  ----
>  
> 

In fact, the most typical reason for at-branches is a botched branching
or tagging operation on the svn side: since they are simply "copy"
operations it's too easy to copy a tree into the wrong directory.

Michael
