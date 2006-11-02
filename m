X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how to pass ssh options to git?
Date: Thu, 2 Nov 2006 15:22:30 -0500
Message-ID: <20061102202230.GA21456@spearce.org>
References: <20061102110639.G523a966f@leonov.stosberg.net> <20061102112720.GA8469@mellanox.co.il> <Pine.LNX.4.64.0611020801160.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 20:22:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611020801160.25218@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30765>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfj5D-0008WN-HA for gcvg-git@gmane.org; Thu, 02 Nov
 2006 21:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752148AbWKBUWg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 15:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbWKBUWf
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 15:22:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:13194 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1752327AbWKBUWe
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 15:22:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gfj4y-0005Xa-QW; Thu, 02 Nov 2006 15:22:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9652F20E491; Thu,  2 Nov 2006 15:22:30 -0500 (EST)
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> It's really better to use a ".ssh/config" file instead.
> 
> I realize that you want to use different options "dynamically", but what 
> you can do is to just have different "fake hostnames". For example, you 
> can do
> 
> 	Host private.host.com
> 		User myname
> 		Hostname host.com
> 		IdentityFile /home/myname/.ssh/private-identity
> 	Host public.host.com
> 		User groupname
> 		Hostname host.com
> 		IdentityFile /home/myname/.ssh/public-identity

I often setup not only multiple fake hostnames in my .ssh/config
but I also setup multiple remote files under any given repository's
.git/remotes directory, using one file per fake hostname.

That way I can pick which options to apply at the time of git push
or git fetch by just changing the name passed to it.

	$ ls .git/remotes
	private public

	$ cat .git/remotes/private
	URL: private.host.com:/path/to/repo
	Pull: refs/heads/master:refs/heads/origin

	$ cat .git/remotes/public
	URL: public.host.com:/path/to/repo
	Pull: refs/heads/master:refs/heads/origin

	$ git push private
	$ git fetch public

I often need this to traverse around firewalls and whatnot.
It works pretty well, assuming I can remember where I'm currently
connected to.  :-)

-- 
