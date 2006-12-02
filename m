X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Resolving conflicts
Date: Fri, 01 Dec 2006 23:55:04 -0800
Message-ID: <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
References: <456FD461.4080002@saville.com>
	<Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
	<456FDF24.1070001@saville.com>
	<Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 07:55:14 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33004>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqPiJ-0006Ru-Bp for gcvg-git@gmane.org; Sat, 02 Dec
 2006 08:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162825AbWLBHzH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 02:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030734AbWLBHzH
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 02:55:07 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:23487 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1162825AbWLBHzF
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 02:55:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061202075505.IXXV296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sat, 2
 Dec 2006 02:55:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tjvE1V0021kojtg0000000; Sat, 02 Dec 2006
 02:55:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> [ Tangentially related.. ]
>
> On Thu, 30 Nov 2006, Wink Saville wrote:
>> 
>> Earlier had a problem with git wanting merge but didn't have it and
>> couldn't figure out which package it was in Ubuntu:( So I symlinked merge
>> to kdiff3 which worked at the time:
>
> Btw, what's the status of the xdl_merge() thing in "pu"?

I am *BEHIND*.  There are too many distractions these days
(read: day job) and I haven't touched git in any significant
ways for the last several days.

I haven't looked at the code any further than minimally checking
its external interface to be able to interface it with
merge-recursive and no more.  Namely:

 - I haven't read the algorithm to judge its correctness;

 - I haven't looked for leaks;

 - I haven't used the resulting merge-recursive in any real
   merge; some of our tests do rely on a correctly working
   merge-recursive, so it is not like the algorithm is always
   emitting "boo ha ha" and returning no conflicts ;-).

 - I haven't benched it to see how much performance is gained
   by bypassing an extra fork+exec.

Among the four patches Johannes sent out to the list and Davide,
one was already in his original patch I have in 'pu', another
makes the same return value change I did myself when interfacing
the code with merge-recursive.  I have queued the remaining two
in 'pu', so there should be nothing missing.

One of them is marked as "fix off by one error" but it was about
more than off by one (the code walks two arrays using one index
for each, but the original code incorrectly used the same index
to access both arrays at one point, which was also fixed).  I
did mind the lack of explanation and wanted to reword the log
message, but as I said, I haven't read the algorithm to
understand what the code is doing enough, so I cannot write
anything useful there yet X-<, which is one of the reasons why
it is still queued in 'pu'.


