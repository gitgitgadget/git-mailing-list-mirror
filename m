X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 16:40:27 -0800
Message-ID: <7virhdh9j8.fsf@assigned-by-dhcp.cox.net>
References: <20061117182157.GC11882@fieldses.org>
	<20061118001355.23488.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 00:40:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118001355.23488.qmail@science.horizon.com>
	(linux@horizon.com's message of "17 Nov 2006 19:13:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31742>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlEG3-00052l-5g for gcvg-git@gmane.org; Sat, 18 Nov
 2006 01:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753660AbWKRAk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 19:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbWKRAk3
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 19:40:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41369 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1753660AbWKRAk2
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 19:40:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118004027.ZFXO296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 19:40:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o0ga1V00K1kojtg0000000; Fri, 17 Nov 2006
 19:40:34 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

> We seem to have developed a consensus on the desirability of allowing
> HEAD to point outside refs/heads, postponing the check until
> commit/merge time.  (At least, junkio and Linus seemed to like it.)

Yes, and I am actually interested in at least doing the initial
damage assessment myself but people are welcome to beat me to
it.  The easies part would be to just try writing a bare SHA-1
to .git/HEAD with:

	H=$(git-rev-parse --verify HEAD)
        echo $H >.git/HEAD

and see what breaks and start picking up the pieces from there.

> I'd like to learn more about the zillion options to git-log.
> If people feel like sharing useful incantations, it would be
> be very helpful to give a concrete example of its usefulness,
> preferably within the git history itself.
>
> (Are there any octopus merges in git's history?  If not, could I ask
> for one for pedagogical value?)

git.git itself is full of them, but the very first octopus (it
actually is a pentapus) is rather nice to watch in gitk:

	211232bae64bcc60bbf5d1b5e5b2344c22ed767e

You can look for them with:

	git rev-list --parents HEAD | grep '..* ..* ..* ..* ..* ..*'

Repeat as many " ..*" as the number of parents you would want to require.
I knew the very first one was pentapus (I did it) so I wrote six ..*
there (one for the commit, one each for parents).

Len's dodecapus in linux-2.6.git is this one:

	9fdb62af92c741addbea15545f214a6e89460865

It is very interesting to watch it with "git show".  Len has
another one in August:

	da547d775fa9ba8d9dcaee7bc4e960540e2be576

