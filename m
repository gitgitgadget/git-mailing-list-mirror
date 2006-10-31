X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Teach receive-pack how to keep pack files based on object count.
Date: Tue, 31 Oct 2006 15:11:48 -0500
Message-ID: <20061031201148.GD23671@spearce.org>
References: <20061031075704.GB7691@spearce.org> <Pine.LNX.4.64.0610311447250.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 20:12:32 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610311447250.11384@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30596>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gezxm-0007fn-Aa for gcvg-git@gmane.org; Tue, 31 Oct
 2006 21:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945968AbWJaULz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 15:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945969AbWJaULz
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 15:11:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:28894 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1945968AbWJaULy
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 15:11:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GezxW-0001gy-Sa; Tue, 31 Oct 2006 15:11:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 F0B4C20FB0C; Tue, 31 Oct 2006 15:11:48 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 31 Oct 2006, Shawn Pearce wrote:
> 
> > Since keeping a pushed pack or exploding it into loose objects
> > should be a local repository decision this teaches receive-pack
> > to decide if it should call unpack-objects or index-pack --stdin
> > --fix-thin based on the setting of receive.unpackLimit and the
> > number of objects contained in the received pack.
> 
> This works fine when used with my replacement patch for your [1/2] one.
> 
> > Currently this leaves every received pack as a kept pack.  We really
> > don't want that as received packs will tend to be small.  Instead we
> > want to delete the .keep file automatically after all refs have
> > been updated.  That is being left as room for future improvement.
> 
> I think this should be solved before rx packs are actually stored as 
> packs though.  Otherwise people will end up with unwanted .keep files 
> left around.  Maybe having a much bigger default for object number 
> treshold for the time being?  (unless this patch is applied to "next" at 
> the same time as another one that actually deals with those .keep 
> files).

Its next on my list of things to do.  Hopefully I'll be able to
implement it today.

I'm thinking of just brute forcing it: put enough identifying data
into the .keep file to make it unique, then go through every local
pack and look at their .keep file; if the content matches what
receive-pack asked index-pack to put there then remove it.

-- 
