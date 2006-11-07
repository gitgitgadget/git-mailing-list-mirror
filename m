X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: If merging that is really fast forwarding creates new commit
Date: Tue, 07 Nov 2006 10:23:23 -0800
Message-ID: <7vwt673ylg.fsf@assigned-by-dhcp.cox.net>
References: <454EAEDB.8020909@gmail.com>
	<7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com>
	<Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
	<Pine.LNX.4.64.0611060928180.3667@g5.osdl.org>
	<45503CFC.7000403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 18:23:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31086>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhVbd-0007jP-7h for gcvg-git@gmane.org; Tue, 07 Nov
 2006 19:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751626AbWKGSX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 13:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754239AbWKGSX0
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 13:23:26 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1710 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1751626AbWKGSXZ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 13:23:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107182324.SQOL12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 7
 Nov 2006 13:23:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id juPV1V00D1kojtg0000000; Tue, 07 Nov 2006
 13:23:29 -0500
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao <yubao.liu@gmail.com> writes:

> I want to separate a branch, not to separate commits by some author,
> for example, many authors can contribute to git's master branch, I
> want to
> know what happened in the master branch like this:
>      good work from A;
>      good work from C;
>      merge from next;   -----> I don't care how this feature is realized.
>      good work from A;
>      ....

So you want to see list of commits that happened to be at the
tip of my 'master' branch.  I would not say that view does not
exist, but it is probably not very useful.  And the uselessness
of it depends majorly on the reason why you say "I don't care
how this feature is realized" in the above picture.  Care to
elaborate why not?

side note: I do not merge next to master so "from next" above in
reality would be "from a topic branch" or "from maint", but it
is otherwise a good example.

What appeared in 'master' recently are three kinds of changes:

 - Many fixes that still apply to 1.4.3 codebase were sent from
   the list (thanks, everybody!), which were applied to 'maint',
   and merged into 'master'.

 - Some other obviously correct fixes and changes that address
   issues on features added after the 1.4.3 release (hence
   missing from 1.4.3 codebase and 'maint' but in 'master') were
   applied directly on 'master'.

 - Yet some other fixes and changes that concern post-1.4.3
   codebase (i.e. 'master only' changes) were forked off of the
   tip of 'master' when the patches were received, cooked in
   their own topic branches (which were merged in 'next'), and
   then merged into 'master'.

So, we have two kinds of obviously correct changes to 'master'
that come both from merges and direct applications.  Things that
happen to address older issues come as merges because they
equally apply to 'maint' and merged into 'master', things that
address newer issues are applied directly.  Put it another way,
things that come as merges to 'master' are also of two kinds.
Obviously correct one that came through 'maint', and the ones
that might have looked slightly wrong in the initial version and
later perfected while in its own topic branch and then merged
into 'master'.

The decision between cooking in a topic branch and immediately
applying to 'master' is not based on the size but more on
perceived usefulness of the change (something that is correct in
the sense that it does not break the system may not deserve to
be merged if it does not do useful things) and quality of the
design and implementation.  The size of the series obviously
affect the perception by me but that is secondary.

Even when a patch is something that I should be able to judge as
obviously correct when I am relaxed and sane, I might lack time
and concentration to follow it fully, and instead decide to drop
it into its own topic branch and later merge it into 'master'
without need for much cooking.  That kind of patch _could_ have
(and should have) been applied directly to 'master' but comes as
a merge.

Sometimes I apply a patch to 'master' and then later realize
that change is needed and applicable to 'maint' as well.  That
is cherry-picked to 'maint', resulting in two independent
commits.  They _could_ have (and should have) come through a
merge from 'maint' to 'master'.

So the change a patch introduces itself may not even have
relevance to the difference between direct application and merge
at all.  In other words, the avenue a particular patch took,
difference between direct application and merge, should not
concern you.  I hope this would illustrate why a view that tries
to summarize what merges brought in and to give full description
of what were applied directly does not make much sense.

By the way, there are two reasons why you cannot have my
ref-logs.  First of all, I do not have one on 'master' nor
'next' myself.  More importantly, I rewind and rebuild these
branches before pushing out (of course I have some safety valve
to prevent me from rewinding beyond what I have already pushed
out), and the ref-log entries for those tips that were rewound
are not useful to you, and something I would rather not have
people to even know about (think of it as giving me some
privacy).

If you really care about the branch tip history of my
repository, you can set up ref-log yourself on your remote
tracking branch.

Strictly speaking, that is the history of fetches by you, not
the history of merges and commits by me, but that is what
matters more to you.  If I pushed my changes out twice a day but
you were away for two days, you would have seen the state of my
repository four rounds back before you left and when you fetched
from me today you would have the latest; three states in between
were not something you can know.  But it does not matter -- your
repository did not have those three states, so not knowing
exactly which commit they were would not hurt you when
bisecting.  "It worked before I pulled yesterday morning but now
it is broken when I pulled this afternoon" would help your
bisect get started, but multiple state changes between the times
you fetched cannot matter.
