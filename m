From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: way to automatically add untracked files?
Date: Sat, 4 Aug 2007 23:58:54 -0400
Message-ID: <20070805035854.GF9527@spearce.org>
References: <873ayymzc1.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 05:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXGv-000584-Hy
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 05:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758627AbXHED67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 23:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbXHED67
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 23:58:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45212 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356AbXHED67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 23:58:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHXGN-0004DI-1l; Sat, 04 Aug 2007 23:58:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C47B820FBAE; Sat,  4 Aug 2007 23:58:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <873ayymzc1.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54930>

Miles Bader <miles@gnu.org> wrote:
> One way to do this seems to be just "git add .", but I'm always slightly
> nervous using it because it sits there and churns the disk for an awful
> long time (whereas "git status" is instantaneous).  Is this the right
> thing to do?  Is there something funny causing the churning?

That's the correct way to add those new files that aren't ignored.
The problem is actually a small bug in git-add; we did not take the
obvious performance optimization of skipping files that are stat
clean in the index.  So what is happening here during `git add .`
is we are reading and hashing every single file, even if it is
already tracked and is not modified.  In short we're just working
harder than we need to during this operation.

I believe this has been fixed in git 1.5.3-rc3 or rc4.  Not sure
which one; I don't have access to a git repository right now to
look it up.

-- 
Shawn.
