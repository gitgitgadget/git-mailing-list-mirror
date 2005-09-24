From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 12:12:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter TB Brett <peter@peter-b.co.uk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 21:11:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJFPb-0008Tr-Rl
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 21:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVIXTJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIXTJz
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 15:09:55 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:19334 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750750AbVIXTJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 15:09:54 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A0F0E> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 24 Sep 2005 12:11:02 -0700
X-X-Sender: davide@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9243>

On Sat, 24 Sep 2005, Linus Torvalds wrote:

>
>
> On Fri, 23 Sep 2005, Davide Libenzi wrote:
>>
>> If you have only to run diff/patch, just use the native Win32 CreateProcess().
>> You abstract that on a git_exec(), and you use fork/exec on Unix and
>> CreateProcess() on Winblows. If fork() is slow on Cygwin, fork+exec is
>> pathetic. They do all that work to give you a fork(), and you throw it
>> away with an exec().
>
> CreateProcess doesn't work all that well, since we want to dup file
> descriptors around and close them in the child.

You can do that (dup stuff and pass them around) even with CreateProcess(),
if you want. Yes, the interface sucks (zillions of parameters/flags) ;)



> In general, CreateProcess() is a totally crap interface. I realize it's
> common (and especially in the VMS/Windows world it's how things are done),
> but hey, at that point it's better if somebody just waits until git is
> stable, and just makes a totally separate "git for windows" thing. The
> interfaces are certainly simple. There's no point in trying to maintain
> one tree.
>
> However, vfork() really _is_ a nice interface. It's faster even on UNIX,
> and at least in theory it should be possible to do an efficient vfork()
> implementation on top of crap like windows. Does cygwin support that well?
>
> Yes, git uses lots of filesystem stuff, and they suck under windows. Maybe
> cygwin adds its own overhead, but from everything I've ever been able to
> tell, filesystem access sucks under Windows regardless of any cygwin
> stuff. Add to an already slow FS interface the fact that virus checkers
> tend to hook into it and make it _even_slower_, and hey, you have a truly
> sucky OS.

I also realized that git plays/handles with unix permissions too, and this 
might make the "interface layer" not so small. Dunno about vfork() on 
Cygwin, but if you really care about performance on Windows, I'd rather 
remove the external program execution and use an in-process diff library.



- Davide
