From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 09:31:36 +1000
Message-ID: <1113780698.11910.8.camel@localhost.localdomain>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:28:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJBf-0005y1-Gd
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVDQXcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVDQXcK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:32:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49096 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261553AbVDQXcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:32:00 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNJF6-0003Jm-OP; Mon, 18 Apr 2005 00:31:59 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 at 10:04 -0700, Linus Torvalds wrote:
> So I'd _almost_ suggest just starting from a clean slate after all.  
> Keeping the old history around, of course, but not necessarily putting it
> into git now. It would just force everybody who is getting used to git in 
> the first place to work with a 3GB archive from day one, rather than 
> getting into it a bit more gradually.
> 
> What do people think? I'm not so much worried about the data itself: the
> git architecture is _so_ damn simple that now that the size estimate has
> been confirmed, that I don't think it would be a problem per se to put
> 3.2GB into the archive. But it will bog down "rsync" horribly, so it will
> actually hurt synchronization untill somebody writes the rev-tree-like
> stuff to communicate changes more efficiently..

Note that any given copy of a tree doesn't _need_ to keep all the
history back the beginning of time. It's OK if the oldest commit object
in your tree actually refers back to a parent which doesn't exist
locally. I can well imagine that some people will want to keep their
trees pruned to keep only a few weeks of history, while other copies of
the tree will keep everything.

However, if we _don't_ base our current work on an existing import of
the kernel, then we don't retain that option. We can't just change the
'parent' field of your 2.6.12-rc2 import, without changing the sha1 hash
of _everything_ that happens thereafter. 

So I'd say we should take Thomas' import, and base new work on that --
but then possibly leave out the older objects from the 'working'
repository which everyone is rsyncing from; just make them available in
a 'linux-history.git' object database elsewhere.

-- 
dwmw2

