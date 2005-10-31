From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Question on GIT usage.
Date: Mon, 31 Oct 2005 18:03:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0510311749080.25300@iabervon.org>
References: <4362C700.6020901@candelatech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:05:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWihW-0003zq-Cx
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 00:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVJaXDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 18:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVJaXDb
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 18:03:31 -0500
Received: from iabervon.org ([66.92.72.58]:44306 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964883AbVJaXDa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 18:03:30 -0500
Received: (qmail 23166 invoked by uid 1000); 31 Oct 2005 18:03:08 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2005 18:03:08 -0500
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <4362C700.6020901@candelatech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10896>

On Fri, 28 Oct 2005, Ben Greear wrote:

> I have a kernel GIT tree to hold my developing patches...
> 
> I need to build this kernel for 4-5 different processors (c3, p2, p4, p4-smp,
> etc).
> 
> Is there any clever way to have this one git repository keep these
> other source trees in sync so that I can do incremental builds?

The following is not at all standard; AFAICT, I'm the only person who does 
it. But...

You can have a single repository shared between multiple working trees, by 
having the repository somewhere and making 
.git/{objects,refs,info,remotes} be symlinks to the corresponding 
directories in the repository. I've got a script to set this up, if you 
want.

The system will be unhappy if you commit to a branch that is checked out 
elsewhere (because the head of that branch will change out from under the 
checked out version), like having someone push to a repository with the 
branch checked out.

You need to think about this as there only being one repository that has 
multiple working trees, rather than having working tree/repository pairs, 
where the repositories are connected as an optimization; anything you do 
in one of the working trees will automatically affect what the others see.

This isn't official supported, but it actually works quite well, except 
that things that should be shared are occasionally added to the .git 
directory (like remotes not too long ago).

	-Daniel
*This .sig left intentionally blank*
