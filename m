From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Mon, 26 Sep 2011 11:10:59 +0200
Message-ID: <201109261110.59940.trast@student.ethz.ch>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <CALkWK0mggSNoxxqzUaGp1-AxGWSpCb0HnRmBxSkcVrHnhwMr1Q@mail.gmail.com> <alpine.DEB.2.00.1109242148570.24369@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	<git@vger.kernel.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 11:11:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R87Dc-0003v9-K8
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 11:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab1IZJLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 05:11:04 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:53885 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab1IZJLC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 05:11:02 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 26 Sep
 2011 11:10:58 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 26 Sep
 2011 11:11:00 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.1109242148570.24369@debian>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182097>

Martin von Zweigbergk wrote:
> 
> If I understand correctly, [rebase --root] was introduced to solve
> exactly the same reason problem that made Francis start this thread
> -- to avoid re-applying patches that are already in $onto.

Not quite; I wrote it because at the time, there was no way to
transplant git history onto a git-svn "make empty subdir" commit for
later dcommitting.  So the main point was really

> After my patches (that are not yet ready) that calculate revisions as
> "git cherry $onto $orig_head $upstream", I don't think there should be
> any need for the --root flag. The only place the flag is checked now
> (in my current work tree, that is) is when deciding how to interpret
> the remaining arguments. Although I have not tried (temporarily)
> rewriting all the test cases from
> 
>   git rebase --root --onto upstream branch
> 
> to
> 
>   git rebase upstream branch
> 
> , I think it should work. What do you think, Thomas?

I still think it would be natural for a user to want a way to say "all
the way back to the root commit".  At least for me the "full" rebase
invocation is

  git rebase --onto onto base branch

In that mindset it comes natural to replace 'base' with --root if you
want to go all the way.

Maybe I don't trust rebase enough to do what I want ;-)

> I saw that
> "--root" is also passed to the hook. Should that value be passed to
> the hook also when the old base is not explicitly a root (by "rebase
> --root"), but only implicitly so (by an $onto that is disjoint from
> $branch)?

I think I did it that way because if you use --root, the base/upstream
argument is missing, and the hook needs to know that.

If the user specifies an upstream that is disjoint from the branch
itself, the hook gets the upstream argument and can presumably work it
out from there.  So you could perhaps save the hook some trouble if
you *know* that it's a disjoint rebase, but I wouldn't spend too much
time on that.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
