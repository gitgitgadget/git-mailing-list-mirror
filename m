From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: History messup
Date: Mon, 9 May 2005 18:08:59 -0400 (EDT)
Message-ID: <3772.10.10.10.24.1115676539.squirrel@linux1>
References: <1115657971.19236.33.camel@tglx>	      
    <1115659677.16187.393.camel@hades.cambridge.redhat.com>	      
    <1115660903.19236.39.camel@tglx>  <427FB3A7.8050906@zytor.com>      
    <1115665598.12012.422.camel@baythorne.infradead.org>      
    <427FBB53.1000801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David Woodhouse" <dwmw2@infradead.org>, tglx@linutronix.de,
	git@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 00:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGK5-0005BW-8v
	for gcvg-git@gmane.org; Tue, 10 May 2005 00:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVEIWJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 18:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVEIWJL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 18:09:11 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:44691 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261540AbVEIWJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 18:09:04 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050509220859.MYSH1623.simmts8-srv.bellnexxia.net@linux1>;
          Mon, 9 May 2005 18:08:59 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j49M8o0P010849;
	Mon, 9 May 2005 18:08:53 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 9 May 2005 18:08:59 -0400 (EDT)
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <427FBB53.1000801@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2005 3:34 pm, H. Peter Anvin said:
> I'm particularly thinking of when you copy and clone directories, you
> have to define your semantics more specifically.  When do you want to
> *copy* this ID, and when do you want to make sure a new one is created?

What question will a repoid let you answer?

Isn't the real problem, where to store "repoid"?  Obviously it would be
stored in each commit created in a repo, but that's not really the
problem.   The problem is identifying which repo each branch belongs to as
you traverse the history.  This lets you ask questions like, "was this
commit created on this branch, or is it just a copy".

But just as the committer information in each object doesn't help you
identify the branch, nor will having a repoid inside each commit.   The
problem is labelling the branch, not the commits found in it.  And there
is no place to store the repoid for each branch.

Using the repoid of the first commit found on a branch is pretty close,
but fails because it might be a fast-forward HEAD rather than a genuine
local commit of the source repository.  So there is no way to know as you
embark down a branch its repoid, so you have nothing to compare against
the repoid inside each commit you find along its path.

Seems the only solution is a full search of the history, unless there is
some clever way to label branches or detect fast forward heads.

> One possible answer to that is to have .git/repoid and have it
> auto-created (from /dev/urandom) if it doesn't exist, but I also observe
> that at least two people (davem and pavel) have managed to clone "Linus'
> kernel tree" as their description on http://www.kernel.org/git/ ...

:o)

sean


