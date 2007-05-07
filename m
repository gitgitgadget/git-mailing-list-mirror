From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 'upstream' branches.
Date: Mon, 07 May 2007 09:51:01 +0100
Message-ID: <1178527861.11851.110.camel@pmac.infradead.org>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	 <20070505174416.GA2898@steel.home>
	 <1178387429.17680.35.camel@shinybook.infradead.org>
	 <20070505225249.GE2898@steel.home>
	 <7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
	 <1178436926.17680.74.camel@shinybook.infradead.org>
	 <7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
	 <1178440759.17680.112.camel@shinybook.infradead.org>
	 <7vabwh8m5e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 10:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkyw4-000819-JY
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbXEGIvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbXEGIvI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:51:08 -0400
Received: from canuck.infradead.org ([209.217.80.40]:37799 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbXEGIvH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:51:07 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1Hkyvv-00062T-W1; Mon, 07 May 2007 04:51:04 -0400
In-Reply-To: <7vabwh8m5e.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46434>

On Sun, 2007-05-06 at 18:20 -0700, Junio C Hamano wrote:
> Of course not.  Why are you even _PUBLISHING_ what your
> upstreams' origins are to begin with? 

I have the master mtd-2.6.git tree on the server, of course. 
I have a bunch of clones of that, on various computers I might be
sitting in front of. On each of those, I might pull from the upstream
tree (directly or indirectly) and push to my server. On each of those, I
might pull from my server and then set about pushing stuff to linus,
which starts with 'git-diff linus..' to vet it for sanity and 'git-log
linus..' to create a pull request.

I don't _care_ how commits from Linus' tree get into my tree. I just
want to know which is the latest commit in my tree that came from
upstream. How it got there is an implementation detail.

The other thing it's used for is excluding upstream commits from being
sent to the MTD commits list. Anything in the 'linus' branch won't get
sent. I _do_ have a fallback which also excludes any commits in the
local mirror of upstream -- but that mirror is pulled by git:// and only
daily, while my merges are usually from ssh://master.kernel.org/... so
when I merge and push to the server, the 'linus' branch may be many
commits ahead of the local mirror of upstream.

> By this, you are effectively getting the origin as seen by other
> people, and taking the most advanced one as the union of the
> origins.
> 
> But step back and think about the reason why you would even want
> to know about the origin of each of your buddies 

I don't. Except when I've pulled from them, and they've pulled from
Linus since I did. When I prepare for a merge to Linus, I don't _care_
about the last time _I_ pulled from upstream. I just care about the
latest commit which came from upstream, by whatever route.

Likewise, when I'm working on the OLPC git tree and I want to see what
we've got outstanding from Linus' tree.

> ... On the other hand, the earlier "diff" now needs to be written like
> this:
> 
> 	$ git diff $(git merge-base linus A)..A
> 
> Because this is the right thing to do in regular cases anyway,
> we even have a short-hand for that in the "three dot" form:
> 
> 	$ git diff linus...A
> 
> I think you already know these two things: "git-log linus..A is
> the right way to ask what A did relative to Linus, even when
> 'linus' is ahead of what A based his work on" and "the three-dot
> notation linus...A is the right thing to use when 'linus' could
> be ahead of what A is based on". 

OK, that works for much of the local tracking stuff -- I wasn't
previously aware of the 'linus...A' notation.

So I can just 'git-fetch linus; git-log linus...' when preparing to
merge upstream, instead of trying to keep track of the merge-base across
many repositories. Thanks.

It doesn't solve the problem of what to exclude from the commits list. 
But it does at least reduce the scope of the problem -- I only need to
handle that on my own trees, and it _will_ only ever go forward (because
I only ever do 'git-pull linus' in my clone of the mtd tree if it's
going to be immediately followed by 'git-push origin'.

-- 
dwmw2
