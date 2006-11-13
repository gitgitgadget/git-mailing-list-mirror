X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: should git download missing objects?
Date: Mon, 13 Nov 2006 15:10:27 -0500
Message-ID: <20061113201027.GE17244@spearce.org>
References: <ej7fgp$8ca$1@sea.gmane.org> <7vwt60bggs.fsf@assigned-by-dhcp.cox.net> <20061113194532.GA4547@steel.home> <20061113195414.GD17244@spearce.org> <20061113200358.GF7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 20:11:39 +0000 (UTC)
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061113200358.GF7201@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31318>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gji8m-000574-6e for gcvg-git@gmane.org; Mon, 13 Nov
 2006 21:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754324AbWKMUKp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 15:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbWKMUKp
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 15:10:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:11956 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754324AbWKMUKo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 15:10:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gji8M-00008f-8C; Mon, 13 Nov 2006 15:10:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8B57720FB0B; Mon, 13 Nov 2006 15:10:27 -0500 (EST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Nov 13, 2006 at 08:54:14PM CET, Shawn Pearce wrote:
> > Copying the one bad object from another repository immediately fixed
> > the breakage caused, but it was very annoying to not be able to run a
> > "git fetch --missing-objects" or some such.  Fortunately it was just
> > the one object and it was also still loose in another repository.
> > scp was handy.  :-)
> 
> If it's over ssh, this is still where the heavily dusty (and heavily
> "plumby") git-ssh-fetch command is useful, since it can get passed an
> undocumented --recover argument and then it will fetch _all_ the objects
> you are missing, not assuming anything.

Interesting.  Since its undocumented I didn't know it existed
until now.  :)

I'm thinking though that a --recover should just be part of
git-fetch, and that it should work on all transports, not just SSH.

Of course you could get into a whole world of hurt where you keep
doing fsck-objects --full (listing out the missing), fetching them,
only to find more missing, etc.  After a coule of cycles of that it
may just be better to claim to the other end that you have nothing
but want everything (e.g. an initial clone) and get a new pack from
which you can pull objects.

But I think that was sort of Junio's point on this topic.  I'm just
trying to throw in my +1 in favor of a feature that would have
recovered that sole missing object without making the end user
reclone their entire repository and move pack files around by hand.
And I'm being more verbose about it than just +1.  :)

-- 
