X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: If I were redoing git from scratch...
Date: Sat, 4 Nov 2006 14:16:51 -0500
Message-ID: <20061104191651.GC2517@spearce.org>
References: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611040829040.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 19:17:09 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611040829040.25218@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30938>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgR0r-0003rA-J6 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 20:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753660AbWKDTRC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 14:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbWKDTRC
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 14:17:02 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:13798 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753660AbWKDTRA
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 14:17:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgR0X-0002A0-8Q; Sat, 04 Nov 2006 14:16:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1B87920E491; Sat,  4 Nov 2006 14:16:51 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> or for somebody who re-implements git in Java (where 
> performance isn't going to be the major issue anyway, and you probably do 
> "small" things like "commit" and "diff", and never do full-database things 
> like "git repack"), _then_ you can happily look at having something 
> fancier. Right now, it's too easy to just look at cumbersome interfaces, 
> and forget about the fact that those interfaces is sometimes what allows 
> us to practically do some things in the first place.

Yes and no.  :-)

As the only person here who has hacked on some of Git and also
reimplemented the core on disk data structures in Java I can say
I mostly agree with Linus.

Abstractions like the repository (to allow different GIT_DIRs to
be used in the same process) isn't really a big deal and is not
a large impact on performance.  They could be implemented in the
current C core.

But trying to abstractly represent an object in Java the same
way that it is represented in Git costs a huge amount of memory.
Java is at least 16 bytes of overhead per object, before you get to
store anything in it.  Translation: Linus is right, doing a real
implementation of "git repack" in Java is nuts.  It would barely
be able to handle git.git, let alone linux.git or mozilla.git.

-- 
