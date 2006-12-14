X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/1] Bypass expensive content comparsion during rename detection.
Date: Thu, 14 Dec 2006 06:13:04 -0500
Message-ID: <20061214111304.GF1747@spearce.org>
References: <20061214100746.GA31191@spearce.org> <Pine.LNX.4.63.0612141151220.3635@wbgn013.biozentrum.uni-wuerzburg.de> <20061214110858.GE1747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 11:13:17 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061214110858.GE1747@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34314>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoWY-0003Z1-DV for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932513AbWLNLNL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWLNLNL
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:13:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35498 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932513AbWLNLNK (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 06:13:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuoWN-0006Co-Kq; Thu, 14 Dec 2006 06:13:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5202820FB65; Thu, 14 Dec 2006 06:13:05 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> wrote:
> I'll admit, I don't understand the diffcore rename code very well
> so I'm treading around in code that I'm not used to.  I'm not sure
> why the size member of diff_filespec needs to be initialized to get
> rename and copy detection to work properly, but it apparently does.

This chunk of code is probably a perfect example of why side-effects
can be so bad.  Its fast because the size information is loaded
once and reused later on; its horrible to maintain because you don't
realize that this simple predicate is actually doing something that
matters downstream even though it returned false!

-- 
