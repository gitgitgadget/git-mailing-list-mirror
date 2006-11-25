X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Some tips for doing a CVS importer
Date: Sat, 25 Nov 2006 01:59:49 -0500
Message-ID: <20061125065949.GD4528@spearce.org>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <456359E2.8010403@cc.jyu.fi> <20061121200508.GB22461@spearce.org> <200611232045.06974.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 07:00:09 +0000 (UTC)
Cc: lamikr <lamikr@cc.jyu.fi>, Jon Smirl <jonsmirl@gmail.com>,
	Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611232045.06974.robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32260>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnrWA-00026D-5D for gcvg-git@gmane.org; Sat, 25 Nov
 2006 08:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757769AbWKYHAA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 02:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757863AbWKYHAA
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 02:00:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58540 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757769AbWKYG77
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 01:59:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GnrVw-00035d-S0; Sat, 25 Nov 2006 01:59:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B785520FB09; Sat, 25 Nov 2006 01:59:49 -0500 (EST)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Slow it is. It is somewhat usable though, especially the quickdiff. I worked 
> the whole day with help from quickdiff today. The diff is computed against 
> HEAD^ (i.e. I get to see the changes that my topmost StGit patch introduces).

That's good to hear!
 
> The project contains 20000+ files and six years of history.  Reading the whole 
> history is out of the question with the current performance so I restrict 
> reading to 500 entries which is just about bearable. That's enough for 
> practical use with quickdiff and compare though. Improving jgit's speed 50 
> times will probably be enough to make jgit shine. 

Yes.  I have a plan on how to rewrite the pack reading code which
should help somewhat here.  There's some fundamental limitations
of Java though that are going to keep us from performing as well
as core-Git does (due to the object memory overheads) but I would
like to get close.  :-)

jgit also has a few quirks still.  For example it assumes everything
is encoded as UTF-8 but this isn't true.  The encoding is project
specific and can be set by any user, which isn't that portable.
This is a problem for jgit and I need to go back and refactor the
parsing code...

I'd like to get back to jgit sometime in mid-Decemeber.  I'm trying
to push through git-gui first.  :-)

> Activating the Git connection seems to be a problem with the egit projects, 
> i.e. it works sometimes, but not with my much bigger repo. The only problem 
> is that the first time is dog slow. The structure is different though, as my 
> repo has .project at the top, not one level down.

Hmm.  That's a bug.  Sounds like a thread timing issue if it works
sometimes, as the logic should be completely deterministic.

-- 
