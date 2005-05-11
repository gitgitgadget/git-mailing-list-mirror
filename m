From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 18:00:52 -0400 (EDT)
Message-ID: <2780.10.10.10.24.1115848852.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 23:54:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVz93-0003wQ-8D
	for gcvg-git@gmane.org; Wed, 11 May 2005 23:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVEKWBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEKWBA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:01:00 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:53935 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261274AbVEKWAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:00:53 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050511220052.RLVZ11606.simmts5-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 18:00:52 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4BM0nht003031;
	Wed, 11 May 2005 18:00:50 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 18:00:52 -0400 (EDT)
In-Reply-To: <1115847510.22180.108.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 5:38 pm, Thomas Gleixner said:
> This is an initial attempt to enable history tracking for multiple
> repositories in a consistent state. At the moment this can only be done
> by heuristic guessing on the parent dates and the committer names.
> This fails for example with Dave Millers net-2.6 and sparc-2.6 trees, as
> in both cases the committer name is the same. It fails also completely
> in cases where the system clock of the committer is wrong and the merge
> is a head forward. The old bk repository contains entries from 1999 and
> 2027, which will happen also with git over the time.
>
> To identify a repository commit-tree tries to read an environment
> variable "GIT_REPOSITORY_ID" and has a fallback to the current working
> directory. The environment variable keeps the door open for managed
> repository id's, but the current working directory is certainly a quite
> helpful information to solve the origin decision for history tracking.
>
> Adding a line after the committer should not break any existing tools
> AFAICS.

To make this useful you're also going to have to change the parent entries
to something like:

parent SHA1 REPOID

At least when the referenced commit has a repoid that doesn't match the
repository from which you obtained the object, ie. fast forward heads. 
This implies that you know the repoid of the repository you pulled the
object from!

Otherwise, you still haven't solved the problem of identifying fast
forward heads as you traverse the history.

Sean


