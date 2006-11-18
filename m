X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 02:41:19 -0500
Message-ID: <20061118074119.GA2338@spearce.org>
References: <20061118041137.6064.75827.stgit@machine.or.cz> <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net> <20061118045323.GK7201@pasky.or.cz> <7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 07:41:38 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31763>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlKpU-0002yg-CZ for gcvg-git@gmane.org; Sat, 18 Nov
 2006 08:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754174AbWKRHl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 02:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755987AbWKRHl1
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 02:41:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46514 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754174AbWKRHl1
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 02:41:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GlKp8-0002Hk-LF; Sat, 18 Nov 2006 02:41:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2B46520E469; Sat, 18 Nov 2006 02:41:20 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Personally I established a convention to treat heads/??/* as
> "private namespace" while using heads/* as public refs for my
> own work (I do that for git.git as people know, and I do that
> for my day job project as well).  I do not think it is a great
> enough convention to be promoted as the official BCP, but it has
> been good enough for me, especially commands like "show-branch"
> and "tag -l" understands the shell-style filegrobs (e.g
> "show-branch master heads/??/*" would show what's yet to be
> polished and merged).

We use refs/heads/??/* as "developer specific" namespaces.

That is we use an update hook in our central repository to control
who can push into refs/heads/??/*.  If ?? matches the unix account
holder's initials then they can push into that name, otherwise
they can't.  This prevents any sort of naming collisions between
developers.

To make things slightly easier I've also suggested that people name
their local branches with the same ??/ prefix as they need to use
on the central repository, thereby making the branch name the same
everywhere.  This is actually one reason why git-completion.bash
suggests "??/foo:??/foo" when completing a branch name to git-push.
:)

So I don't think its a great idea to assume by default that
refs/heads/??/* is private to this repository.


Though on second thought maybe we should be using developer private
repositories with object alternates pointing at a central repository.
But that means users have to manipulate URLs to fetch another
developer's branch vs. just using an existing remote.<nick>.url,
which is the main reason we put everything into one repository.

-- 
