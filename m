X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] send-pack --keep: do not explode into loose objects on the receiving end.
Date: Sun, 29 Oct 2006 02:56:38 -0500
Message-ID: <20061029075638.GB3847@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <7vwt6j4l77.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 07:57:01 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vwt6j4l77.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30418>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge5XL-0007GY-2N for gcvg-git@gmane.org; Sun, 29 Oct
 2006 08:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965138AbWJ2H4q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 02:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWJ2H4q
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 02:56:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:7406 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965138AbWJ2H4q
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 02:56:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge5XO-0004jr-J5; Sun, 29 Oct 2006 02:56:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6EC4D20E45B; Sun, 29 Oct 2006 02:56:38 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> This adds "keep-pack" extension to send-pack vs receive pack protocol,
> and makes the receiver invoke "index-pack --stdin --fix-thin".

I'm torn on this.  I see that keeping a pack vs. exploding to loose
objects is a local repository decision and thus should be determined
by the receiving repository, not the sending one.

I was thinking of just reading the pack header in receive-pack,
checking the object count, and if its over a configured threshold
call index-pack rather than unpack-objects.  Unfortunately I just
realized that if we read the pack header to make that decision then
its gone and the child process won't have it.  :-(

-- 
