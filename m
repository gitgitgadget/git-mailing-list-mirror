From: Petr Baudis <pasky@ucw.cz>
Subject: Re: I'm missing isofs.h
Date: Thu, 28 Apr 2005 09:52:44 +0200
Message-ID: <20050428075244.GE8612@pasky.ji.cz>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz> <Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org> <20050428003246.GV22956@pasky.ji.cz> <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 09:50:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR3lz-0005P6-7e
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 09:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVD1HyB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 03:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVD1HyB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 03:54:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63669 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261784AbVD1Hww (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 03:52:52 -0400
Received: (qmail 16721 invoked by uid 2001); 28 Apr 2005 07:52:44 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 07:27:59AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> PB> Actually, I can't; the patch generator is not on par with mine yet.
> PB> It does not show modes and does not indicate file adds/removals by
> PB> /dev/null - basically, I need something cg-patch can eat (and it should
> PB> be backwards compatible). I think throwing the sha1 hashes away will not
> PB> harm; I got used to the Index: field and === marker, but I don't care if
> PB> I loose it.
> 
> I've looked at what cg-Xdiffdo does.  From the above paragraph,
> I sense that it does more than what cg-patch requires, so I took
> a look at cg-patch, too.  

Yes; that was what the last sentence was about. ;-)

> Can you help me verify if I understand the requirements cg-patch
> has on its input correctly?
> 
>  - Follow the convention of showing newly added files with
>    "--- /dev/null" and removed files with "+++ /dev/null";

Yes.

>  - Label matches this Perl regexp:
> 
>      m|^(---|\+\+\+)\s+[^/]+\/(\S+)\s+.*mode:([0-7]{3,}).*/|
> 
>    and you only care about sign ($1), filename ($2) and mode ($3).

Yes..

>  (modified files)
>  --- a/fs/ext3/Makefile  (mode:0644)
>  +++ b/fs/ext3/Makefile  (mode:0664)
> 
>  (deleted files)
>  --- a/fs/ext3/Makefile  (mode:0644)
>  +++ /dev/null
> 
>  (added files)
>  --- /dev/null
>  +++ b/fs/ext3/Makefile  (mode:0644)
> 
> Is my understanding correct?  If so it should not be too much
> work to generate something like it from within the builtin
> stuff.

Yes, perfectly.

> Provided if that is what the kernel folks can live with (I do
> see why the tool wants the mode bits, but it is unusual to see
> non-timestamp strings after filenames).

There's no reason not to get the timestamps too if you can; just put
them after the attributes. They aren't in the diff now either.

I need the mode bits to set the mode right, surprisingly. :-) Yes, in
part it is a leftover from the old times when we didn't just track the
execute bit; I don't know if it is worth changing this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
