From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Fri, 23 Sep 2005 22:26:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter TB Brett <peter@peter-b.co.uk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 07:24:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJ2WL-00087O-2s
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 07:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVIXFYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 01:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVIXFYS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 01:24:18 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:60034 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751434AbVIXFYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 01:24:17 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A0DDB> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Fri, 23 Sep 2005 22:25:05 -0700
X-X-Sender: davide@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9228>

On Fri, 23 Sep 2005, Linus Torvalds wrote:

> But looking at send_pack() or fetch_pack(), for example, they are both
> _very_ traditional fork()+exec() calls, with just a few close() calls in
> between.
>
> Looking a bit closer at the diff() usage, I actually think that we could
> move the fork() closer to the exec - we'd just have to move it _into_ all
> the different cases (ie you'd have two different fork() calls: one for
> the "builtin" case, one for the external pgm case, but then the child in
> both cases would be very simple).
>
> Oh. Actually, I wonder if we could mke them "vfork()" calls. Does anybody
> know if cygwin has an easier time with vfork() + eventual exec? That
> _should_ map better to a non-UNIX process model, so maybe we could do it
> that way?

If you have only to run diff/patch, just use the native Win32 CreateProcess().
You abstract that on a git_exec(), and you use fork/exec on Unix and 
CreateProcess() on Winblows. If fork() is slow on Cygwin, fork+exec is 
pathetic. They do all that work to give you a fork(), and you throw it 
away with an exec().


- Davide
