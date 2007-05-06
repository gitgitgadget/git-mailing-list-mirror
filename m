From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 'upstream' branches.
Date: Sun, 06 May 2007 08:35:26 +0100
Message-ID: <1178436926.17680.74.camel@shinybook.infradead.org>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	 <20070505174416.GA2898@steel.home>
	 <1178387429.17680.35.camel@shinybook.infradead.org>
	 <20070505225249.GE2898@steel.home>
	 <7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 09:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkbH1-000192-8D
	for gcvg-git@gmane.org; Sun, 06 May 2007 09:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbXEFHfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 03:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755331AbXEFHfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 03:35:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51310 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbXEFHfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 03:35:08 -0400
Received: from shinybook.infradead.org ([90.155.92.197])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HkbGq-0006m0-6M; Sun, 06 May 2007 08:35:04 +0100
In-Reply-To: <7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46310>

On Sat, 2007-05-05 at 23:36 -0700, Junio C Hamano wrote:
> I think David's use of linus ref is bogus.  What is he really
> trying to "track"?  If he is trying to track where the tip of
> Linus's tree is, he should not let fetch from mtd to muck with
> that remote tracking ref that he uses to track Linus's tree.

I'm trying to track "the latest commit in this tree which comes from
Linus, either directly or indirectly".

So that 'git-diff linus..' or 'git-log linus..' will show me what's
outstanding against the master('s) tree. And scripts feeding the commits
list can ignore those commits, etc. 

> On the other hand, I think it is perfectly reasonable thing to
> want to track where the tip of Linus's tree is "from mtd tree's
> point of view".  Then diff between "mtd's idea of Linus's tip"
> and "mtd's tip" would represent what mtd people did, regardless
> of what Linus did in his tree, before mtd people had a chance to
> sync again with Linus. 

Right. That's what I'm trying to track. And that 'idea of Linus' tip'
needs to get updated whenever we pull from Linus' tree into our
mtd-2.6.git tree on the server -- by whatever route, even if it's
indirectly through another repo.

Obviously we never actually _work_ on the tree on the server; we only
ever push to it from a working repo somewhere.

So those working repositories need to have this 'linus' branch which is
updated when they pull directly from kernel.org, and which is pushed to
the mtd tree when they push.

Furthermore, when unprivileged users create their own clone with commits
they want me to push, and if _they_ also pull from Linus' tree for some
reason, that information should also make it into my working repo when I
pull, and then into the mtd-2.6.git tree when I push. Those unprivileged
users will probably want an 'mtd' branch too, to keep track of their
_own_ outstanding changes.

And when we do other things like the olpc-2.6.git tree ,which pulls from
various other repositories (mtd, mmc, etc.), it should use the 'linus'
branches of each of those repositories we pull from.

Is that possible? I'm fairly sure it used to be.

-- 
dwmw2
