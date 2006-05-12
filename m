From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tracking branch history
Date: Fri, 12 May 2006 16:45:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 01:48:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FehMW-0007PA-HX
	for gcvg-git@gmane.org; Sat, 13 May 2006 01:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWELXrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 19:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWELXpz
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 19:45:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932199AbWELXpr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 19:45:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4CNjhtH007336
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 16:45:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4CNjgHX032754;
	Fri, 12 May 2006 16:45:43 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19921>



On Fri, 12 May 2006, Daniel Barkalow wrote:
>
> One feature that might make git more intuitive to people is if we were to 
> additionally track the history of what commit was the head of each branch 
> over time. This is only vaguely related to the history of the content, but 
> it's well-defined and sometimes significant.
> 
> E.g., if you know that two weeks ago, what you had worked, but it doesn't 
> work now, you can use git-bisect to figure out what happened, but first 
> you have to figure out what commit it was that you were using two weeks 
> ago. Two weeks ago, we had that information, but we didn't keep it.

Note that this is possible, but it must be done literally as a separate 
history from the commit history. 

IOW, a good (?) way to do it is to literally have a commit hook that 
basically just does

	echo $new >> .git/$branch-commit-history

possibly together with a datestamp thing (ie it could be something like
"echo $new "$USER" $(date)" rather than just the commit SHA1).

Make sure that not just "git commit", but anything else that changes the 
branch (notably, "git fetch" and a fast-forward merge as a result of an 
explicit merge or a "git pull") would also do this same thing.

But realize that this is really purely a per-repository logging thing, and 
not really bound to the actual git history any way.

			Linus
