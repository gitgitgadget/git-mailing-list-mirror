X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 16:10:50 -0800
Message-ID: <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net>
References: <20061120215116.GA20736@admingilde.org>
	<ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 00:11:10 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> (Linus
	Torvalds's message of "Mon, 20 Nov 2006 15:05:47 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31963>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmJE3-0002qs-2u for gcvg-git@gmane.org; Tue, 21 Nov
 2006 01:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030550AbWKUAKx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 19:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030557AbWKUAKw
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 19:10:52 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36343 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1030550AbWKUAKv
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 19:10:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061121001051.TXBR27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 19:10:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pCAM1V00b1kojtg0000000; Mon, 20 Nov 2006
 19:10:22 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Now, to get everything to work seamlessly within such a commit thing 
> might be a fair amount of work, but I'm not sure you even _need_ to. It 
> might be ok to just say "subproject 'xyzzy' differs" in the diff, for 
> example, and have some rudimentary support for "git status" etc talking 
> about subprojects that need to be committed.

I agree with the static "diff" part, and probably "checkout" and
"merge" are not all that difficult.

However, if I recall correctly, it was rather nightmarish to
make this also work for reachability traversal necessary for
pack generation.  It was painful enough even when the bind was
at the commit level (which was way simpler to handle), but to do
this the right way, the bind needs to be done at the tree level,
and "rev-list --objects foo..bar" would need some way to limit
the commit ancestry chain of subproject at the same time, by
computing the commit ancestry of the embedded commits in the
trees.
