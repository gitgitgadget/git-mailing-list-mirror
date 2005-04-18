From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] General object parsing
Date: Mon, 18 Apr 2005 14:45:36 +1000
Message-ID: <1113799537.11910.76.camel@localhost.localdomain>
References: <Pine.LNX.4.21.0504171958520.30848-100000@iabervon.org>
	 <Pine.LNX.4.58.0504171807590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 06:42:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNO5J-0001do-JJ
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 06:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVDREp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 00:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVDREp7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 00:45:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55756 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261662AbVDREpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 00:45:55 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNO8t-0004GX-25; Mon, 18 Apr 2005 05:45:52 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171807590.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-17 at 18:15 -0700, Linus Torvalds wrote:
> In particular, is there some easy way to walk backwards by time? "git log"  
> definitely needs that, and merge-base clearly wants something similar. 

Actually the ideal output of 'git log' isn't strictly chronological.
IIRC my bkexport scripts used to make a chronologically sorted list, and
I ended up changing it.

Simple example: if there are changesets which have been lurking in some
tree for months waiting for you to pull, and the only thing you did
since I ran 'git log' on your tree yesterday is pull from that tree,
then those changesets are what I want to see at the top of 'git log'
output.

In fact this probably means that the depth-first tree walking of the
original gitlog.sh is probably the right thing to do, but when we hit a
merge we want to try to make sure we process the _remote_ parent first.

Are we sorting the 'parent' links in merges so that two merges of the
same branches are guaranteed to be identical (assuming identical
contents otherwise)? Or is it just that we didn't think about it, and so
merges are putting the local and remote parents in the 'wrong' order by
coincidence?

-- 
dwmw2

