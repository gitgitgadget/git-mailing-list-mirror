From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 12:59:31 -0400
Message-ID: <20060920165931.GE23260@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.64.0609200902190.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 19:01:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5QQ-00060D-8I
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWITQ7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWITQ7n
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:59:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52381 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751930AbWITQ7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:59:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ5Py-0006AI-ER; Wed, 20 Sep 2006 12:59:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3A4CD20E48E; Wed, 20 Sep 2006 12:59:31 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200902190.4388@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27379>

Linus Torvalds <torvalds@osdl.org> wrote:
> The thing is, if you don't understand how rebasing etc destroys history, 
> you may do things like do a "git pull" or a "git merge" of a branch that 
> the other side WILL THROW AWAY! That will later result in major pain, 
> because when you then try to merge it later, you will get all kinds of 
> nasty behaviour, because the history you merged earlier no longer matches 
> the history you're now trying to merge again, and the work you merged 
> earlier is simply not there any more.

Yet people (typically those new to Git) will still pull or merge
the wrong branch in, work on top of that merge, publish it, others
will build on that... and wham; that topic branch head which you
wanted to rebase prior to merging is now wedged 50 commits deep in
your history.

Just yesterday I found such a case in a shared repository.  Now I
have a branch wedged in our shared mainline that I can't get out
and shouldn't have been there in the first place.


If only the shared repository had a way of advising clients that
commits stored in ref 'BAAAD' may not survive and thus shouldn't
be merged.  So that git-merge wouldn't let you merge them in.
Unfortunately there isn't a way to do this that's sane so I'm not
even going to try.


Probably what I should have done (now that I think about it) was to
put a check into our update hook on the shared repository to look for
a rebaseable branch (which are listed in some info file) being pushed
into a non-rebaseable one.  If that happens then abort the update.

Unfortunately our current Git client (1.4.2)/Git server version(1.3.1)
combinations means we get no output from our update hook when it
fails, so I can't tell the newbie what they did wrong.

-- 
Shawn.
