X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 15:36:10 -0500
Message-ID: <20061103203610.GB7585@spearce.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 20:36:53 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061102224549.499610d1.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30882>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg5m9-0004dT-82 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 21:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932086AbWKCUg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 15:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWKCUg0
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 15:36:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53908 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932086AbWKCUgZ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 15:36:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gg5mE-0006Vy-H7; Fri, 03 Nov 2006 15:36:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B99EF20E491; Fri,  3 Nov 2006 15:36:10 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Thu, 02 Nov 2006 18:40:30 -0800
> Junio C Hamano <junkio@cox.net> wrote:
> 
> > which is efficient (guaranteed to do only one fetch from remote)
> > and convenient.  Also I have Push: mapping set up on my
> > main machine to do master:origin, next:next, maint:maint, and
> > +pu:pu so that I can replace the first "git pull" on the
> > secondary machine with "git push secondary" on my main machine.
> 
> One thing that would make separate-remotes nicer to work with
> is to have an automatic mapping between any local branch and
> one of the same name in remotes.
> 
> So for instance, if you have a local branch named pu checked
> out and you pull from origin, remotes/origin/pu would be merged
> after the fetch unless a manual mapping was defined in the
> remotes or config file.
> 
> Maybe even going as far as automatically creating a local branch
> for each remote branch on clone is worth considering.

Nack.

I work with a workflow where our central repository has 2 important
branches (vmtip and vmvt), and a bunch of transient developer
topic branches (e.g. sp/foo).  We only have a master branch in this
repository so that git-clone will clone it without choking during
the clone.  Users tend to do immediately after a clone:

	git branch -D master
	git branch -D origin
	git branch -D ... other topic branches not interested in ...
	edit .git/remotes/origin ... delete topic branches ...

Why?  Because vmtip and vmdvt have meaning to these users, much as
pu has meaning.  Really vmtip is roughly equal to master in Git and
vmdvt is roughly equal to maint but not having the mental mapping of
"vmtip == master" just makes things easier.

Creating a local branch for every remote branch would just make
things worse in the above workflow; not to mention it makes it
confusing for other users who might be fetching into a repository
and expecting their local "next" to to update automatically after
a fetch...
 
> On a peripherally related topic, someone on the xorg list was
> complaining that after the initial clone, there is no easy way
> to track branches that get added/deleted from the remote repo.
> It would be nice if pull had an option to automatically add
> and remove remote branches from the remotes/<remote>/xxx
> namespace.

Or at least deleting/skipping over a branch you listed to fetch
from the remote that no longer happnes to be on the remote.  This is
causing some pain due to the topic branches noted above.

-- 
