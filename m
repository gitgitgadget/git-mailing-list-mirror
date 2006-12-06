X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Wed, 6 Dec 2006 14:51:42 -0500
Message-ID: <20061206195142.GE20320@spearce.org>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com> <20061206192800.GC20320@spearce.org> <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com> <20061206194258.GD20320@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 19:52:02 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061206194258.GD20320@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33515>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2o6-0004xn-Kx for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937584AbWLFTvr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937586AbWLFTvr
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:51:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54861 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937584AbWLFTvq (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 14:51:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gs2nZ-0006H7-Pc; Wed, 06 Dec 2006 14:51:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E3BC720FB7F; Wed,  6 Dec 2006 14:51:42 -0500 (EST)
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> wrote:
> I think all you may need is:
> 
> 	#include "revision.h"
> 	...

You'll also need to call:

	setup_git_directory();

before any of the below; but that should be done once per process.

> 	struct rev_info revs;
> 	init_revisions(&revs, prefix);
> 	revs.abbrev = 0;
> 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
> 	argc = setup_revisions(argc, argv, &revs, NULL);

Although now that I think about it the library may not be enough
of a library.  Some data (e.g. commits) will stay in memory forever
once loaded.  Pack files won't be released once read; a pack recently
made available while the application is running may not get noticed.

Perhaps there is some fast IPC API supported by Qt that you could
use to run the revision listing outside of the main UI process,
to eliminate the bottlenecks you are seeing and remove the problems
noted above?  One that doesn't involve reading from a pipe I mean...

-- 
