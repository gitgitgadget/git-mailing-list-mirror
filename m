X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:13:11 -0800
Message-ID: <7vmz6sjtw8.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611151000460.2591@xanadu.home>
	<7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
	<200611151902.16358.andyparkins@gmail.com>
	<7vr6w4lcpr.fsf@assigned-by-dhcp.cox.net>
	<87y7qcsbsa.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 21:13:56 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87y7qcsbsa.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	15 Nov 2006 12:19:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31499>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkS4f-0001GI-Ig for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161696AbWKOVN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161697AbWKOVN2
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:13:28 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26753 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1161695AbWKOVN1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:13:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115211327.YKRB97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 16:13:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n9DZ1V0091kojtg0000000; Wed, 15 Nov 2006
 16:13:33 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> I'm not the original poster, but I feel the same way about the line
> being unclear.
>
> Here's a real-world example from last week.
>...
> Anyway, when I announced this I also mentioned how easily someone
> might generate an entire series of reports for a series of
> commits. The command I gave as an example is:
>
> 	for rev in $(git rev-list 1.2.6..HEAD); do
> 	    cairo-perf-diff $rev
> 	done
>
> I think that's a perfectly legitimate one-liner for users to use, and
> it really shows off the easy-scriptability of git. But certainly, no
> "new porcelain" author is going to consider rev-list to be porcelain
> rather than plumbing, right? So as soon as I start teaching people to
> do useful stuff like this, they might have to reach down into the
> "scary" git interface.

That is a very fine example, but I do not see why it is a
problem.  I do not think the goal of Porcelain is to make it
totally unnecessary for users to know about the plumbing.

The one-liner is essentially a new Porcelain command that is
useful in the cairo developers' workflow, and implementing it
with a plumbing command makes perfect sense.  The whole point of
git plumbing is to be friendly for scripted use.  If the user
who learns that one-liner from you gets curious why and how that
one-liner works, that would be a good gentle introduction to the
plumbing, but otherwise the user is not forced to know about it.

Also I do not see a problem if some plumbing commands happen to
be also useful by themselves ("[alias] less = -p cat-file -p"
comes to mind for example).

Some plumbing commands may be too deep magic and users do not
have to directly deal with them every day.  Some other plumbing
commands are so low-level and needs combination with others to
be any useful, and it is cumbersome to type the combination
every day.  For the latter kind, we have Porcelain commands that
implement the frequently used combination and the end users do
not have to know about them.

So it is true that by having a rich and usable set of Porcelain,
there is less need for the users to know about all the plumbing
details, but I consider that is a happy consequence.  It does
not have to be the goal of having a good Porcelain to hide the
whole plumbing.


