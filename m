X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 12:49:19 -0800
Message-ID: <7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<200611010953.57360.andyparkins@gmail.com>
	<7vpsc710oy.fsf@assigned-by-dhcp.cox.net>
	<200611012029.41869.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 20:49:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611012029.41869.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 1 Nov 2006 20:29:27 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30655>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfN1g-0006se-IN for gcvg-git@gmane.org; Wed, 01 Nov
 2006 21:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752333AbWKAUtW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbWKAUtV
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 15:49:21 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:53757 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1752333AbWKAUtU
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 15:49:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101204920.UOOC2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 15:49:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hYpQ1V00Z1kojtg0000000 Wed, 01 Nov 2006
 15:49:24 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006, November 01 18:28, Junio C Hamano wrote:
>
>> So from that point of view, the above commandline perfectly
>> makes sense.  However, giving anything but HEAD with path makes
>> us go "Huh?"  It is unclear what this should mean:
>>
>> 	git-reset [--hard | --mixed] HEAD^ oops/file1
>
> I don't understand.  Why wouldn't that mean reset oops/file1 to the state it 
> had in HEAD^?

Path limiters everywhere in git means "do this only for paths
that match this pattern, and empty path means the pattern match
every path -- the command's behaviour is not different in any
other aspect between the case you gave no limiter and the case
you gave _all_ paths as limiters".  So the other paths remain as
they were (both index and working tree), and HEAD needs to be
updated to HEAD^ in the above example.

While that perfect makes sense from mechanical point of view, I
am not sure what it _means_ to keep some paths from now
abandoned future while having some other paths reset to the
rewound commit, from the point of view of end-user operation.

In other words, I do not have a good explanation on what "git
reset [--hard|--mixed] <commit> <path>..." does that I can write
in the documentation.

Now I admit I am not the brightest in the git circle, but if I
have trouble understanding what it does, can we expect other
people to grok it?

>> On the other hand, we already have --again, so maybe we have
>> already passed the point of no return.  So I am inclined to
>> agree with your "update-index --reset" approach, unless somebody
>> else injects sanity into me.
>
> Actually; you've talked me out of it.   Given that git-reset is already 
> porcelain, and none of the solutions are screaming "right"; it seems better 
> to slightly bend git-reset than git-update-index.

Well, now I am not sure of anything anymore ;-).
