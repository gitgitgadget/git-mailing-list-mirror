X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 14:23:39 -0500
Message-ID: <20061030192339.GA5504@spearce.org>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 19:35:01 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30514>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gecjm-0001eu-KQ for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161311AbWJ3TXy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWJ3TXy
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:23:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32468 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161311AbWJ3TXx
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:23:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GecjO-0008Gq-Cm; Mon, 30 Oct 2006 14:23:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 DF51420FB0C; Mon, 30 Oct 2006 14:23:39 -0500 (EST)
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

Holy cow.  Since this is now in 'next', 'next' is now seriously
broken if you have a .keep file.

> So... what is the --unpacked=<pack>.pack switch supposed to mean?  It is 
> not documented anywhere and it certainly doesn't produce the expected 
> result with a repack.

Junio introduced --unpacked=<pack>.pack a while ago for this
application.  What it does is skip an object unless its a loose
object file or it is in the named pack.  The idea being that
pack-objects would only consider object files which are loose or
ready to be repacked.

In your example above we should have copied all objects from your
first pack into the new pack during the final destructive repack,
but we didn't.  I don't know why.

-- 
