From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Tue, 28 Mar 2006 21:23:30 -0500
Message-ID: <20060329022330.GA15359@spearce.org>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 04:23:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOQLV-0008S1-4h
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 04:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWC2CXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 21:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWC2CXi
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 21:23:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:7605 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750788AbWC2CXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 21:23:37 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FOQLF-0007xO-2E; Tue, 28 Mar 2006 21:23:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9010320FBB4; Tue, 28 Mar 2006 21:23:30 -0500 (EST)
To: Matt McCutchen <hashproduct@verizon.net>
Content-Disposition: inline
In-Reply-To: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18155>

Matt McCutchen <hashproduct@verizon.net> wrote:
> Dear git people,
> 
> I made a customized Linux kernel based on 2.6.15.6 by cloning the stable
> 2.6.15 kernel repository (which was then at version 2.6.15.6) and making
> several commits.  Now I would like a Linux kernel based on 2.6.16 with
> the same customizations.  This seems to be a very simple task, but I
> have been trying various combinations of git commands for several days
> and have not figured out how to do it.
> 
> I believe that means I should pull the 2.6.16 kernel into the "origin"
> branch and then rebase the "master" branch, merging my customizations
> with 2.6.16.  To this end, I switched my remote file to point to the
> 2.6.16 stable repository and tried to pull.  The result was not what I
> wanted.  The situation is complicated by the fact that 2.6.15.6 is not
> an ancestor of 2.6.16.  The warning in the man page about branches that
> are modified nonlinearly seems to apply.
> 
> How do I make my customized 2.6.16 kernel?

I think you want to use `git-fetch --force` to download origin but
not immediately merge it yet.  This will bypass the not-an-ancestor
check you are running into.

Then you can perform the rebase yourself with:

	# Export your local changes into a series of patches.
	#
	git-format-patch -k --stdout --full-index v2.6.16.6 >changes.mbox

	# Checkout the new origin (2.6.16) into master.
	#
	git-reset --hard origin

	# Now apply your patches.
	#
	git-am --binary -3 changes.mbox

If you get merge conflicts fix them up and restart with
`git-am --resolved`.


Note this is the logic of `git-rebase` except it doesn't require
you to actually have a common ancestor, while `git-rebase` does.

-- 
Shawn.
