X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 12/10] Teach bash about git-repo-config.
Date: Tue, 28 Nov 2006 02:53:25 -0500
Message-ID: <20061128075325.GB9056@spearce.org>
References: <20061127094447.GA19273@spearce.org> <7vodqscqty.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 07:53:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vodqscqty.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32492>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoxmW-0001FC-Rd for gcvg-git@gmane.org; Tue, 28 Nov
 2006 08:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935764AbWK1Hxa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 02:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935765AbWK1Hxa
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 02:53:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:61604 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S935764AbWK1Hx3
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 02:53:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoxmP-0007Hq-TJ; Tue, 28 Nov 2006 02:53:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8F85620FB7F; Tue, 28 Nov 2006 02:53:25 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >  Yes, that's it.  I'm finally done tinkering with bash
> >  completion support for this week.  Total of 12 patches.
> 
> Thanks.  I saw a funky behaviour when I tried this:
> 
> 	$ git pull . ap<TAB>
> 
> ==>
> 	$ git pull . apfatal: Not a git repository: '.'

Doh.  Its the commit titled "Support bash completion of refs/remote".
The problem is I'm invoking git-for-each-ref wrong:

	git --git-dir=. for-each-ref ...

Clearly "." isn't a git directory.  But ./.git is.  The breakage is
the switch from git-peek-remote to git-for-each-ref.  git-peek-remote
nicely realized that "." wasn't a git directory but "./.git" was
and went into ./.git to get the refs.  I switched to for-each-ref
to get a potential speed boost (no need to dereference tags) but
broke the damn thing in the process.

I thought I had tested this for-each-ref change out.  Apparently I
missed a case.

I'll fix it tomorrow.

-- 
