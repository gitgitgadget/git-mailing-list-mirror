X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 9/10] Allow completion of --committer and --author arguments to git log.
Date: Mon, 27 Nov 2006 15:49:13 -0500
Message-ID: <20061127204913.GB7331@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org> <20061127084228.GI19745@spearce.org> <7vy7pwfxp8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 20:49:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7pwfxp8.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32449>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GonPl-0000pL-MZ for gcvg-git@gmane.org; Mon, 27 Nov
 2006 21:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933635AbWK0UtS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 15:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933629AbWK0UtS
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 15:49:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:22184 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S933635AbWK0UtR
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 15:49:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GonPX-0002dg-9y; Mon, 27 Nov 2006 15:49:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 16E3520FB7F; Mon, 27 Nov 2006 15:49:14 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > This is just a cute hack, but we can (easily) complete the parameter
> > to --author or --committer in bash by asking for all possible authors
> > or committers in this project from git log and offering them up as
> > valid choices.
> 
> Easily but slowly ;-).  Try this in the kernel repository
> 
> 	git log --author=Andre<TAB>
> 
> and watch the paint dry.  You might want to have an extra shell
> to run top before you hit the TAB key.

When I put that in there I was thinking about how slowly that would
run on the kernel repository.  But I think its useful for git commit
--author, even if it is a tad turtleish.  I'm considering creating
a cache of names under .git/ and only dynamically generate the log
entries which are newer than the cache head.  That way we're only
wading through the most recent commits to build up the completion
set.

Apparently the bottleneck is bash.  If I add in | sort | uniq to
the end of the sed then I can generate author completions in about 7
seconds for the kernel repository.  Without them it is taking about
30 seconds.  (Both approximate as I just counted it out in my head.)

You can also see this in top.  We spend a bit of time in both git
and sed, then suddenly bash takes over for a while as it makes the
resulting list unique.

Using perl (instead of sed | sort | uniq) appears to improve things
slightly, but I'm getting some odd results that I don't have time
to debug right now.

> It indeed is cute, but I think most people would wonder if the
> terminal went dead, especially without any progress indicators.

Yes.  And in completion support mode you cannot give progress.  :-(

-- 
