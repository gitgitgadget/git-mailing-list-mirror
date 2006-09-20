From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 17:49:03 -0400
Message-ID: <20060920214903.GF24415@spearce.org>
References: <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org> <20060920163437.GC23260@spearce.org> <Pine.LNX.4.63.0609202321390.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920212747.GB24415@spearce.org> <Pine.LNX.4.63.0609202333320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:49:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9wk-000463-Ft
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWITVtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWITVtJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:49:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:14553 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932171AbWITVtG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:49:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ9w7-0008JI-FU; Wed, 20 Sep 2006 17:48:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 151FF20E48E; Wed, 20 Sep 2006 17:49:03 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609202333320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27415>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 20 Sep 2006, Shawn Pearce wrote:
> > The server side could also check if the current value in the ref
> > (if it exists) is contained within the new value of the ref.  Yes,
> > I know it doesn't today, but the point is it could.  And I was
> > saying maybe it should when there is no update hook present.
> 
> The point being that this check is not necessarily inexpensive.

But its not _that_ expensive.  If the option is set to refuse
non-fast forwards then you take the hit and do the check; if its
set to allow them then you can bypass the check entirely and let
the client direct it (like it does today).  Speed vs. safety.

I currently use "git rev-list $2..$1" in my update hooks to make sure
the update is strictly a fast-foward type update for all branches.
Enabling this option and having the check run in receive-pack would
be faster than what I'm doing now (one less fork).

> But you 
> are right, we could introduce this as a security measure. But is it really 
> intuitive to skip this test when an update hook is added?

Now that you say it, no.  These two things (update hook and non-fast
forward update) are unrelated.  If the update hook wants to make
the decision on a per branch basis then the option to allow a
non-fast forward push must be enabled in the config file.
 
> I'd rather set another config variable with --shared, which tells git to 
> refuse receiving non-fast-forwards. This could be a sensible setting in 
> other setups than shared ones after all. Thoughts?

Agree completely.

-- 
Shawn.
