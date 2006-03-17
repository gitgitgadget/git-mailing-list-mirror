From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git-reset and clones
Date: Fri, 17 Mar 2006 13:19:02 -0600
Message-ID: <1142623141.17536.225.camel@cashmere.sps.mot.com>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
	 <7v4q1x95yo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: paul@hibernia.jakma.org, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 17 20:20:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKKUX-0006p1-Fd
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 20:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWCQTUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 14:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWCQTUA
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 14:20:00 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:43244 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030270AbWCQTT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 14:19:59 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k2HJXNjg008929;
	Fri, 17 Mar 2006 12:33:23 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k2HJTdK7020677;
	Fri, 17 Mar 2006 13:29:39 -0600 (CST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q1x95yo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17668>

On Thu, 2006-03-16 at 20:10, Junio C Hamano wrote:

> 
> You used to have something like this:
> 
> 
>                  o---o---o---A
>                 /            ^ your HEAD used to point at here
>     ---o---o---o
> 
> and you forgot other people already have the commit chain up to
> commit A.   But you rewound and did cleanups:
> 
>                  o---o---o---A
>                 /
>     ---o---o---o---o---o---B
>                            ^ your HEAD now points at here
> 
> People who track your HEAD have A and your updated head B does
> not fast forward.  Oops.
> 
> The recovery consists of two steps.  The first step is more
> important.  To find what commits you lost that others already
> may have.  You may be lucky and remember A's commit object name,
> but when I did that I had to ask around on the list X-<.
> 
> The second step is a single command:
> 
> 	$ git merge -s ours 'Graft the lost side branch back in' \
> 		HEAD A
> 
> where A is the object name of that commit.  On your current
> branch, this creates a merge commit between A and B (your
> current HEAD), taking the tree object from B.
> 
>                  o---o---o---A
>                 /             \
>     ---o---o---o---o---o---B---M

Junio,

Can you explain a bit more why the "ours" strategy
comes into play here?  I _think_ I understand, but
I'd like to hear a bit more explanation, please.
How is this different from just merging in A directly?

> You want to keep the contents of the cleaned-up HEAD, so that is
> why you are taking the tree from B.

And the "ours" strategy effectively says, "Favor the B
side of things when pulling in the A parts", right?

>   With this commit M, you are
> telling the outside world that it is OK if they start from a
> commit on the now-recovered side branch.

This is mystical to me.  How is the "A" (ie, side branch)
now in a "recovered" state?

Thanks,
jdl
