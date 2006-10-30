X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 15:26:11 -0500
Message-ID: <20061030202611.GA5775@spearce.org>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 20:34:21 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610301332440.11384@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30519>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gedi8-0001NU-I8 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 21:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751969AbWJ3U0R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWJ3U0R
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 15:26:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49888 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1751969AbWJ3U0Q
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 15:26:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gedht-0002uC-Q3; Mon, 30 Oct 2006 15:26:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0A9AD20FB0C; Mon, 30 Oct 2006 15:26:12 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 29 Oct 2006, Shawn Pearce wrote:
> 
> > During `git repack -a -d` only repack objects which are loose or
> > which reside in an active (a non-kept) pack.  This allows the user
> > to keep large packs as-is without continuous repacking and can be
> > very helpful on large repositories.
> 
> Something is really broken here.
> 
> Here's how to destroy your GIT's git repository.
> 
> WARNING: MAKE A COPY BEFORE TRYING THIS!  I'm serious.
> 
> First, let's make a single pack just to make things simpler and 
> reproducible:
> 
> $ git-repack -a -f -d
> $ git-prune
> $ git-fsck-objects --full

Actually the breakage is easier to reproduce without trashing
a repository.

Do the above so you have everything in one pack.  Now use rev-list
to simulate the object list construction in pack-objects as though
we were doing a 'git repack -a -d':

  git-rev-list --objects --all \
    --unpacked=.git/objects/pack/pack-*.pack \
	| wc -l

gives me 102 (WRONG WRONG WRONG WRONG!!!!!!)

and
 
  git-rev-list --objects --all | wc -l

gives me 31912 (correct).  The --unpacked flag is horribly broken.

-- 
