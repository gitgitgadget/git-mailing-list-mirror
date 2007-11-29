From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: surprising behaviors/bugs?
Date: Thu, 29 Nov 2007 00:10:31 -0800
Message-ID: <20071129081031.GF32277@soma>
References: <bf7b2dda0711220537h3f37c84ag899b74daa9a8fe1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 09:11:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxeUB-0007Nl-VT
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 09:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXK2IKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 03:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXK2IKp
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 03:10:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42642 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbXK2IKo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 03:10:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EFDC17DC0FE;
	Thu, 29 Nov 2007 00:10:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bf7b2dda0711220537h3f37c84ag899b74daa9a8fe1f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66516>

Gustaf Hendeby <hendeby@gmail.com> wrote:
> I've been running git for most my stuff for some time now, and am
> really pleased with what it has to offer.  However, all my coworkers
> aren't gitified yet, and therefore I sometimes have to work with svn.
> I've learned to appreciate git-svn for this, since it lets me utilize
> the strengths of git and still allows for my coworkers to think I use
> their svn setup.  Thanks to all who contribute to this wonderful
> tools!
> 
> In my work with git-svn I have stumbled upon the following two
> unexpected behaviors.  Basically, am I doing/understanding something
> wrong, or is this buggy behavior in git-svn?  (I'm presently using git
> 1.5.3.6, but have been experiencing these things for a while.)
> 
> 
> 1.  I don't really like svn's committer info, so I got an authorsfile
> set.  This works great when I'm fetching/dcommitting from the
> top-directory in my git checkout (the one with .git in), however, if
> I'm in a subdirectory the authorsfile doesn't kick in and I get the
> svn commiter info.  This is not a big deal, but a bit surprising and
> my history gets a bit ugly.

I see you've already fixed that.  Thanks.

> 2.  My second problem involves getting the support in git-svn for tags
> and branches to work.  Having a standard layout of the svn repository,
> in this case
>    /source/project/(trunk|branch|tags)
> svn clone -s only works as expected sometimes.  Sometimes I only get
> the revision history, not including any actual content (ie none files
> of the files under control turns up in git) from the clone.  When I
> get this problem I usually clone the trunk only, and add tags myself.
> This is far from optimal, and also error prone.  Other times, the
> clone works as expected and gives me the tags and branches and all the
> content.

Any chance there's a BOFH at the other end playing around with
permissions while you were testing?

> I think the problem occurs when I'm not the owner of the svn
> repository, and only have access (read/write) to the
> project/(trunk|branch|tag) part, and don't have any access at all to
> source.  Ie, svn ls works for /source/project and
> /source/project/trunk etc, but not /source (where I returns 403
> Forbidden access).  All svn access is through a svn-server that I
> can't control myself.

I'll have to look into that some other time.

Does `svn log -v' work for /source/project ?

Am I correct in what you have is currently like this?

[svn-remote "svn"]
	url = http://domain/
	branches = source/project/branches/*:refs/remotes/*
	tags = source/project/tags/*:refs/remotes/tags/*
	fetch = source/project/trunk:refs/remotes/trunk


If so, can you change it to something like this?

[svn-remote "svn"]
	url = http://domain/source/project
	branches = branches/*:refs/remotes/*
	tags = tags/*:refs/remotes/tags/*
	fetch = trunk:refs/remotes/trunk

And see if that works all the time?

Thanks,

-- 
Eric Wong
