From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 13:10:12 -0400
Message-ID: <20060920171012.GF23260@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org> <20060920163437.GC23260@spearce.org> <Pine.LNX.4.64.0609200942550.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 19:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5af-0000HE-Jc
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWITRK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWITRK0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:10:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:6048 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751968AbWITRKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 13:10:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ5aJ-0007kr-5N; Wed, 20 Sep 2006 13:10:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0FFF920E48E; Wed, 20 Sep 2006 13:10:12 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200942550.4388@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27381>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 20 Sep 2006, Shawn Pearce wrote:
> > I worked on a project not to long ago in which a user tried `git
> > push`, received a "not a fast-forward" error, didn't know what it
> > meant, tried `git push --force`, found that worked, and proceeded
> > to force every push he did from then on.  To much gnashing of teeth
> > from everyone else.
> 
> Ouch. That implies that we made it a bit too easy to force things, or that 
> we have an insufficiently clear error message.

I've been lucky that I've only run into two people in my life that
when faced with an error message they don't understand immediately
try adding "-f" and "--force" to the command line until something
happens.  Its entertaining to read their terminal scrollback and
see what they did in response to errors; its less so when they've
done mildy destructive things that you now must cleanup.

Sometimes I wonder if they've managed to reformat their root
filesystem while they had it mounted.  Never asked.  Not sure I
want to hear the answer.
 
> I think the current error message is fairly good: it says
> 
> 	"remote '%s' is not a strict subset of local ref '%s'. maybe you 
> 	 are not up-to-date and need to pull first?"
> 
> which should be clear enough, but I'm hoping this was a long time ago when 
> we weren't as clear (we added the "maybe you're not up-to-date .." 
> language later)

Yes; this problem was back with Git 1.2 so the newer language is
much better and should help new users better.
 
> > Of course an update hook finally took care of the problem, but having
> > non fast-forward pushs be permitted on a shared, bare repository
> > by default is interesting to say the least.  :-)
> 
> Yeah, well, it's not permitted "by default", but obviously "--force" ends 
> up being a client-side decision, so with clueless clients, the default 
> behaviour may not be enough to save you.

I'm wondering if maybe git-receive-pack should deny forcing an
update in a shared repository unless there's either an update hook
that its going to run (which would get to vote yea or neigh) or
there's a configuration setting enabled which isn't set by default.

I'd think most users of a shared repository wouldn't want to allow
forcing an update except in some very special cases.  For those
they could install an update hook or just push a new temporary
branch name and then use git-update-ref or git-branch directly on
the remote repository.

-- 
Shawn.
