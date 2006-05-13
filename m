From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tracking branch history
Date: Sat, 13 May 2006 00:27:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605122358490.6713@iabervon.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
 <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <Pine.LNX.4.64.0605121656350.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 06:26:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Felhf-0008OG-7K
	for gcvg-git@gmane.org; Sat, 13 May 2006 06:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWEME0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 00:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWEME0E
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 00:26:04 -0400
Received: from iabervon.org ([66.92.72.58]:43793 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750824AbWEME0B (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 00:26:01 -0400
Received: (qmail 2127 invoked by uid 1000); 13 May 2006 00:27:00 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2006 00:27:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605121656350.3866@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19924>

On Fri, 12 May 2006, Linus Torvalds wrote:

> Btw, the real problem with this is how to use it.
> 
> The only really valid use I see is to use it for date-based things, ie if 
> given a date, look up the most recent commit ID that is older than the 
> date in question. No other op seems to really make sense, but that one 
> does.
> 
> Now, the one other operation that is semantically sensible is to use the 
> list of commits to figure out a "path" through the commit space. However, 
> that path won't actually even be well-defined (a fast-forward pull/merge 
> can and often /will/ update the history in a way where it's impossible to 
> select one particular path to the previous commit listed in the commit 
> log).

I think that jumping around with reset is necessary to make this actually 
complicated; a fast-forward only happens if the new value descends from 
the old value, and a merge obviously descends from the old value. Sure, 
the non-linear history added by a merge will still be non-linear, but 
from the local user's point of view, it was all added in bulk by the 
merge.

I think the program creating the history should note the tricky cases, 
where the new value doesn't descend from the old value, which should be 
easy to identify. I'm not sure what should actually be done to report a 
reset in a changelog, either. The section of the log just before the reset 
is clearly a false start of some sort, and you probably want to do 
something special to list the commits which don't actually lead to the 
current state, but you probably want to report them, in case the reason 
you'd looking through this is that there was some benefit to a version 
that you ended up discarding, and you want to revisit that attempt.

I think in the always-forward case, there's a useful optimization to be 
had by having the rev-list-equivalent actually binning commits by the 
earliest points that descend from them, so you don't trace the local 
branch back to where other branches forked off over and over. But it seems 
to me otherwise pretty simple.

	-Daniel
*This .sig left intentionally blank*
