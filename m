From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking
	branches
Date: Thu, 8 May 2008 03:48:24 -0400
Message-ID: <20080508074824.GA2197@pe.Belkin>
References: <20080508013956.GA24956@midwinter.com> <alpine.DEB.1.00.0805072332300.6948@swallowtail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Thu May 08 09:49:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju0sN-0000Nd-IM
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 09:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbYEHHs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 03:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbYEHHs1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 03:48:27 -0400
Received: from eastrmmtao103.cox.net ([68.230.240.9]:46603 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYEHHs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 03:48:26 -0400
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080508074825.YPHQ24465.eastrmmtao103.cox.net@eastrmimpo01.cox.net>;
          Thu, 8 May 2008 03:48:25 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id NvoQ1Z00J0epFYL02voRvL; Thu, 08 May 2008 03:48:25 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1Ju0rY-0000bj-On; Thu, 08 May 2008 03:48:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805072332300.6948@swallowtail>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81514>

On Wed, May 07, 2008 at 11:48:17PM -0700, Asheesh Laroia wrote:
> On Wed, 7 May 2008, Steven Grimm wrote:
>
>> In environments where a lot of people are sharing an svn repository using
>> git-svn, everyone has identical, but individually maintained, tracking
>> branches.
>
> To further muddy the waters, let me talk about my setup, also one with a 
> "central git repository" from which all developers clone, and also one 
> based on a Subversion tree.
>
> The way I handle it is that, hidden somewhere, I have an account with a 
> cron job that does this:
>
> $ git svn fetch
> $ git push origin refs/remotes/*:refs/heads/*
> $ git push origin refs/remotes/trunk:refs/heads/master
>
> The first push synchronizes "origin" to have the same branches as this 
> git-svn copy of the git repository, and the second updates "origin" so that 
> it has a "master"; without that second step, "git clone" will error out 
> when it get to its checkout phase.
>
> Note that in .git/config, the [remote "origin"] section has no "fetch" 
> parameter.  If it did have one, a would end up creating the branch 
> origin/master on the second push, and origin/origin/master on the third, 
> and so on.
>
> After the push, "origin" ends up being a git repository that looks just 
> like the svn repository we're cloning.  When you "git clone" it, the remote 
> has all the tags and branches of the upstream svn repository; and as the 
> upstream svn repository updates its branches, the git branches get those 
> updates.
>
> I'm not saying this patch shouldn't be accepted; I have no comment on it. I 
> just want to see what others think of my approach to this workflow.

This workflow doesn't seem to provide a way for the developers who
clone the "origin" above, to dcommit to svn.  Presumably, with the
right initialization, Steve's patch would allow all those clones to
dcommit to svn directly.

I like your automated mirror setup, but IMO, it becomes a lot more
useful in conjunction with Steve's patch.

-chris
