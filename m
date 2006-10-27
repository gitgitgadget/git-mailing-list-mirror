X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Question on multi-level git repository heiarchy.
Date: Fri, 27 Oct 2006 01:25:17 -0400
Message-ID: <20061027052517.GB29057@spearce.org>
References: <45419529.3010207@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 05:25:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45419529.3010207@candelatech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30293>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdKDm-0004V0-UI for gcvg-git@gmane.org; Fri, 27 Oct
 2006 07:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422962AbWJ0FZX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 01:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422967AbWJ0FZX
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 01:25:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:17834 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422962AbWJ0FZW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 01:25:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdKDn-0002CB-QE; Fri, 27 Oct 2006 01:25:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7B11F20E45B; Fri, 27 Oct 2006 01:25:17 -0400 (EDT)
To: Ben Greear <greearb@candelatech.com>
Sender: git-owner@vger.kernel.org

Ben Greear <greearb@candelatech.com> wrote:
> I want to create an intermediate level..something like:
> 
> kernel.org git tree
>       |
> my git master tree
> /                          \
> work-station-1   work-station-2  ....
 
> I then did a git  checkout -f master on the
> pub server and did a pull from the upstream kernel.
> This seemed to work fine.

Ah, what you really want here is to make your "my git master tree"
a bare repostiory and use fetch instead of pull.  This way you
don't need to maintain a working directory of files associated
with that repository.  So assuming you have "mygitmastertree"
as the directory do:

	mv mygitmastertree/.git mygitmastertree.git
	rm -rf mygitmastertree

and update your workstation .git/remotes/origin files such
that the URL line reads ".../mygitmastertree.git" rather than
".../mygitmastertree/.git".

Then to update "mygitmastertree" with recent changes you can use
git fetch rather than git pull:

	git --git-dir mygitmastertree.git fetch
 
> Then, on the work-station, I did a git checkout -f master, and also did 
> a pull.
> In this case, it seems that it is trying to merge with changes in the 
> lf_v2.6.18 branch
> instead of the the main 'master' tree (see below).

When you use "git pull" with no additional arguments the first
branch listed in a Pull: line of .git/remotes/origin will be the
branch merged into the current branch.  I don't know what that
branch is listed as in your workstation tree but from what you
described it sounds like it may be that lf_v2.6.18 branch, which
is why its trying to merge it.

-- 
