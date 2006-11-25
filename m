X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 25 Nov 2006 01:53:38 -0500
Message-ID: <20061125065338.GC4528@spearce.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org> <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net> <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 06:53:58 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32259>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnrQ7-00016V-Gz for gcvg-git@gmane.org; Sat, 25 Nov
 2006 07:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757851AbWKYGxs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 01:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757853AbWKYGxs
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 01:53:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:15532 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757851AbWKYGxr
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 01:53:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GnrPw-0002j2-DN; Sat, 25 Nov 2006 01:53:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0FA2C20FB09; Sat, 25 Nov 2006 01:53:39 -0500 (EST)
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

Yann Dirson <ydirson@altern.org> wrote:
> On Tue, Nov 21, 2006 at 10:40:56PM -0500, Shawn Pearce wrote:
> > Yet we still want to be able to efficiently perform operations like
> > "git bisect" within the scope of that submodule, to help narrow down
> > a particular bug that is within that submodule.  To do that we need
> > the commit chain (all 10,000 of those commits) in the submodule.
> > To get those we really need a commit-ish and not a tree-ish, as
> > going from a tree-ish to a commit-ish is not only not unique but
> > is also pretty infeasible to do (you need to scan *every* commit).
> 
> We don't need to have commits in the tree for this.  We'll just have
> submodule commits which are not attached to a supermodule commit, and we
> can access the whole submodule history through the submodule .git/HEAD,
> just like we do for a standard git project.

No.  You cannot do that.

How do we setup .git/HEAD when bisecting the supermodule?
Or merging it?  Or doing anything else with it?

Ideally the .git/HEAD of every submodule should seek to the commit
that points at the tree of the submodule which the supermodule
is referencing.  This lets you then perform a bisect within the
submodule when you identify the supermodule commit which caused
the breakage.

We need the submodule commits to do this.  Doing it without is
too expensive.

-- 
