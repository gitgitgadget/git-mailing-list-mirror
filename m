X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 07 Dec 2006 11:48:07 -0800
Message-ID: <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net>
References: <20061207100152.GA12966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:48:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207100152.GA12966@spearce.org> (Shawn O. Pearce's message
	of "Thu, 7 Dec 2006 05:01:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33619>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPE6-0000wW-0M for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163245AbWLGTsK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163241AbWLGTsK
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:48:10 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46122 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163245AbWLGTsJ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:48:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207194808.KYSR22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 14:48:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vvoJ1V00c1kojtg0000000; Thu, 07 Dec 2006
 14:48:19 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I have recently observed a rather large number of users who forget
> to specify the base revision when they start a new branch with
> git-checkout -b.  Many of these users are shocked many hours and
> commits later when their prior branch is now also part of the new
> branch.  Nasty words about Git usually follow the discovery.
>
> This introduces a new config option: checkout.requireSourceBranch,

I'm not sure about this.

Often after you started to code something while on 'master' you
realize that work is not trivial and needs its own branch and
then "checkout -b" without having to say 'master' (or HEAD) is
very handy.

I think requring an explicit fork-point when you are _not_ on
'master' might be a better behaviour.

In other words, you allow "checkout -b" (and "branch") to
default to HEAD only while on the branches marked in your
configuration file:

Then:

	[branch]
        	allowbranchbydefault = main
        	allowbranchbydefault = test

can be used to say "while on 'main' and 'test' branch, 'git
checkout -b' and 'git branch' without branch point defaults to
the current branch".

You could turn it around and make it a per-branch configuration,
like:

	[branch "main"]
        	allowbranchbydefault = true

