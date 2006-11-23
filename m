X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Pull and fetch
Date: Thu, 23 Nov 2006 15:36:24 -0500
Message-ID: <BAYC1-PASMTP11EB389CA59410315B2F8AAEE20@CEZ.ICE>
References: <20061123203950.5d47421f@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 20:36:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061123153624.ed92d4f6.seanlkml@sympatico.ca>
In-Reply-To: <20061123203950.5d47421f@paolo-desktop>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 Nov 2006 20:46:10.0234 (UTC) FILETIME=[681C09A0:01C70F40]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnLJR-0007YV-8a for gcvg-git@gmane.org; Thu, 23 Nov
 2006 21:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757461AbWKWUg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 15:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757463AbWKWUg2
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 15:36:28 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:29056 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1757461AbWKWUg1
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 15:36:27 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Thu, 23 Nov
 2006 12:46:09 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GnKMx-0003Za-QU; Thu, 23 Nov 2006 14:36:23 -0500
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, 23 Nov 2006 20:39:50 +0100
Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:


> OK, make sense. So let's try with an experiment:
> paolo@paolo-desktop:~$ mkdir test
> paolo@paolo-desktop:~$ cd test
> paolo@paolo-desktop:~/test$ git-init-db 
> defaulting to local storage area

At this point your "master" branch will be empty.  You can see
this by doing a "git log"

> paolo@paolo-desktop:~/test$ git fetch ../git master:testbranch
> warning: no common commits
> remote: Generating pack...

If you do "git log" at this point you'll see your master branch
is still empty.  All you've done is fetched the remote branch
into your new repo as "testbranch"

> [skip]
> paolo@paolo-desktop:~/test$ git pull ../git master:testbranchpull
> * refs/heads/testbranchpull: storing branch 'master' of ../git
>   commit: e945f95

This command is different than fetch.  After fetching the remote
branch into your repo as "testbranchpull", it then merges it with
your currently checked out branch (master).  At this point if
you do a "git log"  you'll see your master is now populated with
the results of the merge (well in this case a fast forward).

So this nicely shows the difference of fetch and pull, and explains
how your "master" branch came to have something in it.

 
> Now I have 3 branches:
> paolo@paolo-desktop:~/test$ git branch
> * master
>   testbranch
>   testbranchpull
> 
> All the branches have the same content, I expect to see differences between testbranch 
> and testbranchpull. The first one is the end result of a fetch, the second one is
> the end result of a pull.

Yes, they will all have the same content.  As your local repo diverges
from the remote (as you make local commits) the difference between
fetch and pull will become more obvious and pronounced.

> git status always says:
>   nothing to commit
> 
> Why?

This just means you have no uncommitted local changes in your repo.  Edit
one of the file, and before committing the change, do "git status" again
and it will list the file as modified.

> What will happen if I repeat the same commands:
>   git fetch ../git master:testbranch
>   git pull ../git master:testbranchpull
> after a change in the git master branch?

Try it out :o)

Afterward, both testbranch and testbranchpull will be direct copies
of the other repo's master.  The fetch command will do nothing to
"master".  However, after updating your testbranchpull, the pull
command will merge (or fast forward) its contents into "master".

Cheers,
