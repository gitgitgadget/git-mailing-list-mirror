From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn: how to connect SVN branches?
Date: Fri, 18 Jan 2008 11:04:21 +1300
Message-ID: <478FD0E5.2080006@vilain.net>
References: <alpine.LNX.0.999999.0801171237110.3479@mojave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: dherring@ll.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 17 23:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFcrH-0001Y1-FT
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 23:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451AbYAQWE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 17:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbYAQWE2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 17:04:28 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:44249 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754502AbYAQWE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 17:04:27 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id A06D521C866; Fri, 18 Jan 2008 11:04:25 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 2FB9621C852;
	Fri, 18 Jan 2008 11:04:22 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LNX.0.999999.0801171237110.3479@mojave>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70932>

dherring@ll.mit.edu wrote:
> Hi,
> 
> The project I'm tracking changed servers a couple months ago.  To simulate 
> the svn-switch, I edited the svn-remote.url to the new location.  `git-svn 
> fetch`, `git-svn dcommit`, and the like seemed to work ok.
> 
> When a new release branch came out, I tried adding
> svn-remote.branches = releases/*:refs/remotes/svn/*
> 
> `git-svn fetch` pulled the new branch.  However, it created a whole new 
> history for this branch (new git commits from the beginning of the SVN 
> repo).
> 
> Is there some way to tell git/git-svn to connect these two histories?

git-svn doesn't yet support arbitrary mapping of paths like that.  You
need to add a separate git-svn remote, and you might have to graft to
get it started - see below.

> Pictorially, I have
> 
> SVN1@a---SVN2@a---SVN3@b---SVN4@b---SVNtrunk
> SVN1@b---SVN2@b---SVN3@b---SVN4@b---SVNbranch

That's unfortunate.  There are many things that git-svn does to try to
avoid this happening.  You can fix it using the .git/info/grafts
facility - check the Documentation/ for information on that.  Once
you've got it looking right, git filter-branch can be used to make it
permanent, though you should certainly delete the git-svn metadata after
using that.

> Similarly, if someone cloned a git repo full of git-svn-id's (which 
> indicate that an svn --switch occurred) but without any matching git-svn 
> data, is there a way to `git-svn fetch` from the new SVN repo and 
> autoconnect the git commits?

You basically have to fool git-svn by making commits in the history
which have the git-svn-ids that you want.  This can be done without
changing the "real" history as above, using grafts.

Good luck,
Sam.
