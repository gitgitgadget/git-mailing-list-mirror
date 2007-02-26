From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Mon, 26 Feb 2007 10:54:42 -0500
Message-ID: <20070226155442.GA1639@spearce.org>
References: <45E1E47C.5090908@verizon.net> <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net> <45E1F6B5.8030907@verizon.net> <20070226020657.GA1884@spearce.org> <7v649pr60q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 16:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLiBj-0007Mq-PP
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 16:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbXBZPyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbXBZPyw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 10:54:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39636 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbXBZPyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 10:54:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLiBT-0004eC-28; Mon, 26 Feb 2007 10:54:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9D20B20FBAE; Mon, 26 Feb 2007 10:54:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v649pr60q.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40624>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Hmm.  Probably not.  In pg I used to compare HEAD^{tree} to the
> > tree output by git-write-tree and refuse to make the commit if
> > they had the same value.  git-gui just blindly assumes that if a
> > file is staged for committing then it won't make an empty commit;
> > this is also the behavior in git-commit.sh.
> >
> > Yet in the case of a merge you may want the same tree and not even
> > realize it...
> 
> git-commit has been raised with all of these logic during its
> evolution.  Is it a possibility to reuse it somehow?
 
Anything's possible.  ;-)

I'd rather not reuse git-commit in git-gui.  git-commit is strictly
porcelain-ish, while git-gui tries hard to only rely on the plumbing
layer[*1*], while also trying to autodetect and honor status data
used in the porcelain-ish (e.g. MERGE_HEAD, MERGE_MSG).

With the exception of this empty-commit case git-gui's commit
path is stable and doing the same actions as git-commit, only the
git-gui way.  I'd rather not churn that code just to avoid an empty
commit case.  Its easy enough to check the trees, and git-gui knows
if there are additional parents (and what those are) at the time of
commit, so its easy enough to not do the tree comparsion if there
is more than one parent.


I actually just found another way to make git-gui create an empty
commit.  I'm going to patch it to check the trees - because this
shouldn't be allowed.


*1*: With the exception of git-fetch, git-push, git-merge and
     git-repack.  The latter two of which I would like to get
	 rewritten in pure Tcl, as I want more control over what
	 is happening.
-- 
Shawn.
