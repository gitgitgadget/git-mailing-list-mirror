X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 21:35:17 -0800
Message-ID: <7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
	<7virhhy76h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142048350.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 05:35:29 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611142048350.2591@xanadu.home> (Nicolas Pitre's
	message of "Tue, 14 Nov 2006 23:32:06 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31417>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkDQk-0003dv-3P for gcvg-git@gmane.org; Wed, 15 Nov
 2006 06:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966658AbWKOFfV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 00:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966657AbWKOFfU
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 00:35:20 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60413 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S966658AbWKOFfS
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 00:35:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115053518.QTTR7157.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 00:35:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mtbQ1V0021kojtg0000000; Wed, 15 Nov 2006
 00:35:24 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> What is the point of hiding tracking branches?  Why just not making them 
> easier to use instead?  There are currently so many ways to specify 
> remote branches that even I get confused.

Ok, I think in essence we are saying the same thing except I
went overboard by suggsting to extend sha1_name to also look at
.git/remotes/$name which is not necessary, because we already
have the .git/refs/remotes/%s/HEAD magic there.  Consider the
suggestion of "upstream#next" syntax retracted, please.

> 1) make "git init" an alias for "git init-db".

Or even better, have "gh init".

> 2) "pull" and "push" should be symmetrical operations

I think that makes a lot of sense to have "gh pull" and "gh
push" as symmetric operations, and make "gh merge" do the
fast-forward and 3-way merge magic done in the current "git
pull".  These three words would have a lot saner meaning.

> 3) remote branch handling should become more straight forward.
>
> OK! Now that we've solved the pull issue and that everybody agrees with 
> me (how can't you all agree with me anyway) let's have a look at remote 
> branches.

I would probably prefer making the default namespace under
.git/refs/remotes/remote-name for the tracking branches this
proposal creates, but other than that I agree with the general
direction this proposal is taking us, including branch groups.
We have .git/refs/remotes/%s/HEAD magic so I do not think we
even need to treat one branch repository any specially as you
suggsted.

The reason I am suggsting "gh" instead of "git" is primarily to
deal with stale documentation people would find googling.  I can
easily see people get confused by reading "pull = fetch + merge"
from either mailing list archive or Git cheat sheet various
projects seem to have developed.

It does not mean we need to redo _all_ UI.  I think most of the
archaeology commands have sane UI so during the transition
period (git 1.99) we can have "git log" and "gh log" which are
one and the same program, and perhaps git 2.0 can be shipped
with clear distinction between plumbing (i.e. git-update-index
and friends) and porcelain (e.g. "gh pull" that only fetches but
with the user friendliness you outlined here), with backward
compatibility wart to help old timers (e.g. "git pull" that
still does "git fetch" followed by "git merge").

