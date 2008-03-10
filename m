From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Branch bar in resource history.
Date: Mon, 10 Mar 2008 19:14:04 -0400
Message-ID: <20080310231404.GF8410@spearce.org>
References: <1204954828-3937-1-git-send-email-rogersoares@intelinet.com.br> <200803100100.28927.robin.rosenberg@dewire.com> <47D4C384.3030703@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Dave Watson <dwatson@mimvista.com>, git@vger.kernel.org
To: Roger Carneiro Soares <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Mar 11 00:16:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYrDm-00009f-VQ
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 00:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398AbYCJXOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 19:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757396AbYCJXOL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 19:14:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33068 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbYCJXOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 19:14:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYrBr-00067x-00; Mon, 10 Mar 2008 19:13:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 31D4C20FBAE; Mon, 10 Mar 2008 19:14:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47D4C384.3030703@intelinet.com.br>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76768>

Roger Carneiro Soares <rogersoares@intelinet.com.br> wrote:
> >Another idea would be to allow the user to filter which branches and I 
> >think
> >one could combine this indicator with that functionality through e.g. a 
> >poup menu. 
>   
> This would be really nice :)
> 
> Some time ago I wrote a quick hack to show only the commits in the 
> current branch and it's been very useful for us. It isn't implemented 
> the proper way but I consider it simple and safe and others may find it 
> useful too... I'll review it later and post a patch for you to decide.

Now that we have index v2 support implemented my current project
has been "proper" revision machinary for jgit.  Mostly because I
found the History pane too damn slow to be useful, but also as I
need it for the packer for a push implementation.

I have most of the machinary implemented and am right now working on
the path limiter / history simplification.  I already have features
like "--author" and "--grep" working to filter commits, as well
as the commit set difference like "^A ^C B D".  Its wicked fast;
about the exact same speed as C Git, from the time my test "main"
gets invoked to the time I have the full results.

Not unsurprisingly jgit bottlenecks in about the exact same major
areas that C Git bottlenecks, and in about the exact same ratio.
If I remember what JProbe was telling me correctly its about 30%
in zlib's inflate(), 30% in commit parsing, and 30% in the rest of
the lookup-packed-object code.

Pack v4 was being created to reduce the 60% inflate()+parse costs,
as that is the major impact to C Git.

In short, I'm not sure I can squeeze too much more out of jgit.
Given that I'm really close to C Git I think we're nearing the
point where it just can't get faster.

The above mentioned revision machinary is a completely new set of
code in jgit.  I'm basically abandoning the work Robin has done on
this previously.  I also am moving away from the Commit and Tree
classes in favor of smaller, lighter abstractions that perform
better when faced with 17,000 commits.

Most of this code is in my spearce fork of egit in my sp/revwalk
branch, but a good chunk isn't pushed up there yet.  Its not ready
to be merged, but maybe in another week.

-- 
Shawn.
