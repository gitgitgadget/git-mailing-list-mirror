From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Fri, 01 Sep 2006 20:52:57 -0700
Message-ID: <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	<20060829175819.GE21729@spearce.org>
	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	<20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 05:53:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJMZY-00073Q-Fd
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 05:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWIBDw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 23:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWIBDw7
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 23:52:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:6577 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750776AbWIBDw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 23:52:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902035258.ZDEP12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Sep 2006 23:52:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HFsy1V00U1kojtg0000000
	Fri, 01 Sep 2006 23:52:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26319>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 1 Sep 2006, Junio C Hamano wrote:
>>
>> 	[...] Instead make sure they are not corrupt, but
>> do so only when we are not streaming to stdout, [...]
>
> Hmm. I see you making pack_to_stdout available to those functions, but I 
> don't actually see you using it - looks like you revalidate regardless.
>
> Which is safe, of course, but it doesn't match your description ;)

But "git repack -a -d", which you now consider almost being
free, in the recent kernel repository counts 300k objects, and
reuses 298k objects or so.  That means we expand and recompress
that many objects, totalling 120MB.

It might be worthwhile to disable revalidate reused objects
individually and instead scan and checksum the entire .pack file
when the number of objects being reused exceeds certain
threshold, relative to the number of objects in existing pack,
perhaps.



-- 
VGER BF report: U 0.5
