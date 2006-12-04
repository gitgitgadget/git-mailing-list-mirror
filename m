X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [checkout-index] Give names to stages
Date: Sun, 03 Dec 2006 18:00:39 -0800
Message-ID: <7v1wngv2rc.fsf@assigned-by-dhcp.cox.net>
References: <651451.91694.qm@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 02:01:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <651451.91694.qm@web31813.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Sun, 3 Dec 2006 01:49:46 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33158>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr38k-0004Tb-Jt for gcvg-git@gmane.org; Mon, 04 Dec
 2006 03:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758738AbWLDCAt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 21:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758690AbWLDCAt
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 21:00:49 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51647 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1758738AbWLDCAr
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 21:00:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204020039.UNZJ18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sun, 3
 Dec 2006 21:00:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uS0p1V0021kojtg0000000; Sun, 03 Dec 2006
 21:00:49 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> One can now say "git-checkout-index --stage=ours ..."  or
> "git-checkout-index --stage=theirs ...", instead of having
> to remember the corresponding number assigned to each stage.

I really do not like to have this in checkout-index; I would
rather keep checkout-index a purely plumbing thing.  If there
are valid and frequently appearing use cases that currently
requires "checkout-index --stage=$n", I think that need should
be addressed as a missing feature in the UI layer.

During a conflicted merge, you may run "diff --cc" in order to
decide that you would want to take yours (or theirs), and that
would be a good reason to wanting to checkout "your" version (or
"their" version; but I do not think of a valid reason to want to
say "checkout-index --stage=1").  From the UI point of view, it
would make more sense to be able to say:

	$ git checkout --ours hello.c
	$ git checkout --theirs Makefile

If the user is interested in looking at raw copies of our and
their version for comparison (not just "diff --theirs" kind of
usage), it _might_ even make sense to be able to do:

	$ git checkout --stdout --ours hello.c >hello.c-ours
	$ git checkout --stdout --theirs hello.c >hello.c-theirs
        $ diff -u hello.c-ours hello.c-theirs

I do not particularly like the above overloaded meaning of
"checkout" myself, but that would be something people who are
used to "cvs up -p" might expect to be able to do.

If we were to do both of the above, then it might even make
sense to make the first form (sans --stdout) to also mark the
index entry after checking out the specified higher stage.

And the UI layer (Porcelain-ish) should be where we should add
the "usability" and "human readability" bits.

