From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 23:31:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcFor-0000s6-Ng
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbWJXGbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWJXGbW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:31:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752088AbWJXGbV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 02:31:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9O6V7aX001206
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 23:31:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9O6V6M1022026;
	Mon, 23 Oct 2006 23:31:07 -0700
To: Lachlan Patrick <loki@research.canon.com.au>
In-Reply-To: <453DAC87.8050203@research.canon.com.au>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29932>



On Tue, 24 Oct 2006, Lachlan Patrick wrote:
> 
> Can I ask the git folks what Sean meant in the above about a 'command'.
> Are you talking about shell scripts? Is 'git' the only program you need?

Historically, "git" was _only_ a wrapper program. When you did

	git log

it just executed the real program called "git-log", which was often a 
shell-script. That was just so that things could easily be extended, and 
you could use shell-script for simple one-liner things, and native C for 
more "core" stuff.

For example, "git log" used to be a one-line shell-script that just did

	git-rev-list --pretty HEAD | LESS=-S ${PAGER:-less}

but it ended up being a lot more capable, and eventually just rewritten 
as an internal command..

These days, most of the simple things like "git log" are all built into 
the "git" program, although for anything not built in, it still acts as 
just a wrapper, which allows not only random functionality to still be 
written in shell (or sometimes perl), but also ends up being the simplest 
possible plug-in mechanism: you can define your own commands by just 
writing a shell-script thing, calling it "git-mycommand", installing it in 
the proper place, and it ends up being accessible as "git mycommand".

That allows for easy prototyping in your language of choice.

> AFAIK, 'bzr' is the sole program in Bazaar, and everything is done with
> command line options to bzr. Is that true of git? To what extent is git
> tied to a [programmable] shell? I've heard someone say there's no
> Windows version of git for some reason, can someone elaborate?

Almost all of "core" git is pure C, which unlike something like python or 
perl obviously tends to have a fair amount of system issues. That said, 
much of it really is fairly portable, so doing the built-in git stuff 
should _largely_ work even natively under Windows with some effort.

The problem ends up being that few enough people seem to develop under 
Windows, and the cygwin port works better (because it handles a number of 
the portability issues and also handles the scripts that are still shell). 
Those two issues seem to mean that not a lot of effort has been put into 
aiming for a native windows binary (or into moving away from shell 
scripts).

Most of the shell scripts really are fairly simple. So if somebody 
_really_ wanted to, it would probably not be hard to spend some effort to 
either just write them as C and turn them into built-ins, or porting them 
to some other scripting language.

Of course, most Windows users don't seem to really want a command line 
interface at all. IDE integration would appear to be more interesting to 
some people.

		Linus
