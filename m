X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Protect commits recorded in reflog from pruning.
Date: Mon, 18 Dec 2006 09:08:13 -0500
Message-ID: <20061218140813.GA32446@spearce.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 23:36:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34765>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwJAL-0005jx-P7 for gcvg-git@gmane.org; Mon, 18 Dec
 2006 15:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754041AbWLROIR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 09:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbWLROIR
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 09:08:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38346 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754041AbWLROIQ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 09:08:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwJA2-0004kE-Tw; Mon, 18 Dec 2006 09:08:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 51B1F20FB65; Mon, 18 Dec 2006 09:08:13 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> This teaches fsck-objects and prune to protect objects referred
> to by reflog entries.

Nice!

But its not enough.

  $ git-repack -a -d
  $ git reset --hard HEAD^
  $ git-repack -a -d
  $ git reset --hard HEAD@{1}

that last reset would fail now, wouldn't it?  pack-objects needs
to know it should be pulling in the objects stuff reachable from
reflogs too.

-- 
