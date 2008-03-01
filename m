From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Anomaly in git log?
Date: Fri, 29 Feb 2008 22:05:14 -0500
Message-ID: <20080301030513.GV8410@spearce.org>
References: <20080301133554.7a3cbd35.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Sat Mar 01 04:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVI2u-0003d5-Ei
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 04:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbYCADFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 22:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYCADFT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 22:05:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41668 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbYCADFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 22:05:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVI24-00063e-Hx; Fri, 29 Feb 2008 22:05:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C45920FBCA; Fri, 29 Feb 2008 22:05:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080301133554.7a3cbd35.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75604>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> I noticed that under some circumstances "git log <range> -- <file>" will
> not show you all the commits in the range that affected that file.  In
> particular if one of the commits removes the file, previous modifying
> commits are not shown.
> 
> I found this in the current linux-next tree (next-20080229).
> 
> git log stable.. -- arch/avr32/kernel/semaphore.c
> 
> will show the commit that removes this file, but not the commit that
> modifies it.  So, is this a bug in git log or my understanding?
> 
> If you do "git log -p stable.." and search for the file name, you will
> find the other commit.

I have seen this happen on my own day-job repositories.  What is
most likely the case is the path got deleted on one side of a merge,
but was modified on the history of the other side.  Since the file
is deleted in the merge the path limiter prunes the history and
doesn't include search down the other side looking for the modify.

Try adding --full-history to your git-log command line.  But even
with that there are some cases where git-log prunes an interesting
side branch when the path limiter is being used.

-- 
Shawn.
