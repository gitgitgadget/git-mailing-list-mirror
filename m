From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 12:28:10 -0400
Message-ID: <20060920162810.GB23260@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:29:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4w7-0005yF-I5
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWITQ2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWITQ2W
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:28:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27542 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751756AbWITQ2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:28:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ4vd-0002bh-PB; Wed, 20 Sep 2006 12:28:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 279FC20E48E; Wed, 20 Sep 2006 12:28:10 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27368>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 20 Sep 2006, Petr Baudis wrote:
> > 
> >   I personally don't think "throwing away" history is an issue. You can
> > print the old sha1 and it is still in the database so you can recover
> > it.
> 
> No it isn't. Once you've lost the reference, you can't really depend on it 
> any more in the long run.
> 
> A lot of people do things like "git repack -a -d" by hand, and we've tried 
> to encourage people to do so in cron-jobs etc. We've even had patches 
> floating around that do it automatically after a pull.

Ouch.  That's really bad.

I knew it but didn't realize it until just now.

	git repack -a -d
	git branch -D foo
	git repack -a -d

and *poof* no foo.  Even if you somehow have its SHA1 and haven't
used `git prune` you still have just pruned the thing away and
can't look it up anymore.

git branch -D is just the obvious way of doing it.  git rebase is
slightly less obvious for some people (perhaps more so for others).
git fetch with a '+' in a Pull: line is even less obvious, especially
if you have reflog enabled for exactly that reason.


So we've managed to encourage people to run prune without actually
running prune.  Should we just integrate prune and repack -a -d with
the 'rm -rf /' command?  Perhaps a kernel module at the VFS layer
would do the trick?  I hear we have some kernel folks nearby.  :-)

-- 
Shawn.
