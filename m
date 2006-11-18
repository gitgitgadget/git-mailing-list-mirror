X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 10:38:11 -0800
Message-ID: <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 18:38:22 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	(Marco Costalba's message of "Sat, 18 Nov 2006 10:15:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31786>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlV4y-0006E9-70 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755310AbWKRSiN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbWKRSiN
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:38:13 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:51966 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1755310AbWKRSiM
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:38:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118183812.SERW5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 13:38:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oJdk1V0051kojtg0000000; Sat, 18 Nov 2006
 13:37:44 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

"Marco Costalba" <mcostalba@gmail.com> writes:

> Time needed to execute git-peek-remote in my box with cold cache currently is:
>
> - git tree 2.347 ms
> - linux tree 2.144 ms
>
> And refs are *already* packed in both repos.
>
> Looking at packed-refs file, it contains something like:
>
> d9b0f913ce0508fcc83e642e0241f373428368e5 refs/tags/v1.4.3
> 4314f5982d2aac08001a977fc0b1b611e858e025 refs/tags/v1.4.3-rc1
>
> while I would need something like git-peek-remote output,
>
> d9b0f913ce0508fcc83e642e0241f373428368e5        refs/tags/v1.4.3
> e0b0830726286287744cc9e1a629a534bbe75452        refs/tags/v1.4.3^{}
> 4314f5982d2aac08001a977fc0b1b611e858e025        refs/tags/v1.4.3-rc1
> 1965efb1599f59b8e3380335d1fa395e2008a30b        refs/tags/v1.4.3-rc1^{}
>
> Because the sha value a tag points to is needed to match against
> git-rev-list output so to identify tagged revisions.
>
> Would be possible to store in packed-refs also the dereferenced tag
> info, so that cold opening of a repository would be much faster?
>
> Just to give an idea, with warmed up cache, refs reading times are:
>
> - git tree 43 ms
> - linux tree 28 ms
>
> Thanks
> Marco
>
> P.S: In case it's not clear I don't suggest to read directly the
> packed-refs file with the added info, but always to use
> git-peek-remote that _would_ became much faster.

I think the question is why you would want to run peek-remote.
Do you use the ^{} peeled-onion information and if so how and
why?

