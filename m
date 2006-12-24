From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git reflog show
Date: Sun, 24 Dec 2006 01:11:51 -0500
Message-ID: <20061224061151.GE7443@spearce.org>
References: <20061223101956.GD9396@spearce.org> <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 07:12:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMae-0003MP-Ul
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 07:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbWLXGMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 01:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbWLXGL7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 01:11:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54437 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbWLXGL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 01:11:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMaQ-0002al-8H; Sun, 24 Dec 2006 01:11:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D596620FB65; Sun, 24 Dec 2006 01:11:51 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35346>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I wonder if it would make sense to teach the revision walking machinery 
> about reflogs. A commit could be marked as coming from a reflog entry, and 
> in that case the parents could be determined by the reflog rather than the 
> commit itself.

The revision machinery already knows about reflogs with --reflog,
used by git-pack-objects via git-repack.  But here its really only
useful to seed the list of commits to be walked as part of a pack
generation, to make sure the things referenced by the reflog stay
around after a repacking.  And it implies --all.

Rewriting the commits in memory to appear to have parents based
on their order of appearence in the reflog would nicely generate
a single strand of perls, but it makes it difficult to then access
the same commit's real parents, doesn't it?  So that may make the
revision machinary somewhat limited in some applications.

Besides we want the reflog message entry and not the commit message
when we perform pretty output, etc.  So really we are then talking
about generating synthetic commit objects for the reflog data.

-- 
Shawn.
