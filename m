X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 23:23:11 -0500
Message-ID: <20061126042311.GB30001@spearce.org>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org> <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 04:23:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32328>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoBY9-00088B-Lp for gcvg-git@gmane.org; Sun, 26 Nov
 2006 05:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967286AbWKZEXT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 23:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967297AbWKZEXT
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 23:23:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49900 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S967286AbWKZEXS
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 23:23:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoBXk-0000jc-K3; Sat, 25 Nov 2006 23:23:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C33FD20FB09; Sat, 25 Nov 2006 23:23:11 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Needing to put + in front of a refspec (or needing to fetch it with
> > --force) is the user agreeing that something _evil_ is going on with
> > the upstream and that they acknowledge this may cause problems for
> > them locally.
> >
> > I would prefer to see the upstream be able to publish a short
> > description of each branch, where the repository owner can describe
> > the policy of that branch, as well as have a machine readable
> > setting on each branch indicating if that branch will be rewound
> > from time to time, or never rewound.
> >
> > git-clone should skip rewinding branches by default, unless the user
> > adds an option (e.g. --include-rewinding-branches).  This way new
> > users to git.git don't get the `pu` branch unless they really mean
> > to get it, at which point they have hopefully also read the upstream's
> > description of the `pu` branch and its rewinding policy, and can
> > at least start to grasp what is going to happen if they start to
> > work with the branch.
> 
> I like this approach very much.

I think the idea of glob'ing off the remote during clone (and
using the glob for future fetches) is a good idea.  So I think what
I'm suggesting above is to make glob'ing by default not copy the
rewinding branches, unless the glob spec itself starts with '+'
(which is what say --include-rewriting-branches would do).

So now we're at a point of:

 * how do we get this branch information from the remote?
 * how does the remote store this branch information?

I'm leaning towards the repo config for the latter, with say:

	[branch "pu"]
		rewinds = true
		description = This branch contains some proposed updates to git.\n\
	It rewinds often, as different updates are proposed or merged into 'next'.

but looking at that think its rather horrible looking.  :-)

However for the former it may be useful if the client can download
the repo config from the remote repository, such as to fetch
the branch description data.

-- 
