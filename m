From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-export hg mutt (24M vs 184M)
Date: Thu, 3 May 2007 17:18:24 -0400
Message-ID: <20070503211824.GB16538@spearce.org>
References: <20070503185623.GA11817@cip.informatik.uni-erlangen.de> <20070503191716.GB11817@cip.informatik.uni-erlangen.de> <20070503210112.GE3260@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu May 03 23:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjih8-000580-0j
	for gcvg-git@gmane.org; Thu, 03 May 2007 23:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031350AbXECVSb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031352AbXECVSa
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 17:18:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40900 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031350AbXECVS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 17:18:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hjigs-0005YI-BN; Thu, 03 May 2007 17:18:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E820220FBAE; Thu,  3 May 2007 17:18:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070503210112.GE3260@artemis>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46108>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Thu, May 03, 2007 at 09:17:16PM +0200, Thomas Glanzmann wrote:
> > Hello,
> > git-repack -a -d -f got it down to 19M. I missed the -f parameter
> > before. Sorry for the noise.
> 
>   You may want to use git gc that does that (and a bit more) for you.

Actually, in this case, no.

git-gc by default doesn't use the -f option.  -f to git-repack
means "no reuse deltas".  That particular feature of git-repack is
basically required to be used after running git-fast-import with
anything sizeable.

The reason you need -f is git-fast-import does not write optimally
compressed blobs (file revisions) when it creates the packfile.
Instead it does a reasonable best effort while using a minimum
amount of memory.  The Git packfiles get most of their compression
benefits from being able to see all of a project's data at once;
this is impossible in fast-import as we're only seeing a small part
of the incoming data stream at any single point in time.

If you had a lot of tags imported you might want to also use `git
pack-refs` (one of the chores that git-gc does), or `git pack-refs
--all` if you have a lot of dangling branches imported.  The other
chores in git-gc aren't actually useful after running fast-import
(reflog expire, prune, rerere gc).

-- 
Shawn.
