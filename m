From: Andreas Ericsson <ae@op5.se>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 13:28:22 +0100
Message-ID: <43AA9BE6.7000601@op5.se>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de> <7vek465cev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de> <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 13:29:11 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpPZD-0000SF-AP
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 13:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVLVM2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 07:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVLVM2Y
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 07:28:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:6018 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932335AbVLVM2X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 07:28:23 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4C9C76BD02; Thu, 22 Dec 2005 13:28:22 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13945>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 22 Dec 2005, Andreas Ericsson wrote:
> 
> 
>>Johannes Schindelin wrote:
>>
>>>Hi,
>>>
>>>On Wed, 21 Dec 2005, Junio C Hamano wrote:
>>>
>>>
>>>
>>>>Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>>
>>>>
>>>>
>>>>>If you don't use git-shell, because the same machine is used for other
>>>>>purposes, it makes sense to introduce
>>>>>
>>>>>	[core]
>>>>>		umask = 0002
>>>>
>>>>I agree the setting should not be limited to git-shell, but I do
>>>>not think setting "umask" from git configuration is the right
>>>>way either.  For files and directories under $GIT_DIR, maybe
>>>>imposing the policy git configuration file has is OK, but I
>>>>think honoring the user's umask is the right thing for working
>>>>tree files.
>>>
>>>
>>>As we worked out in another thread, you should not have a working directory
>>>when you write-share the repository.
>>>
>>
>>Which thread was that? I see no particular problem with having a working
>>directory in a write-shared repo. The same care has to be taken there as
>>everywhere (pull before push), but that's nothing new.
> 
> 
> It was the thread "How to set up a shared repository".
> 
> Okay, so there you are. You have a write-shared repository with the HEAD 
> checked out. Somebody wants to push to that with different credentials 
> than the user who checked out the files. Do you plainly deny updating the 
> current HEAD?
> 
> If you do, then you better give the pushing user (pun intended) a way to 
> update the checked out files. You can do this by (tadaah) setting the 
> umask to 0002 also for working files.
> 

Ahh. Sorry. We use this method a lot, really, but always only for 
running gitk and archaeology tools to check newly pushed changes, so the 
write-shared repo is only write-shared for remote users, and the local 
one never does a commit. It's perhaps a bit of a weird setup, but it 
lets you get an overview faster than gitweb and works well enough with 
samba. Noted should be that having the repo checked out is merely a 
convenience thing to let one browse the files at leisure. People know to do
	git checkout -f HEAD

whenever they want to dig around.

> Yes, we could find out exactly where writes happen inside GIT_DIR and plug 
> in shared.umask which is only applied in these cases, but I am totally 
> unconvinced that this is worth the hassle. In my cases, I am perfectly 
> helped by a umask which is respected throughout git, and the patch is 
> simple enough to be reviewed in 5 minutes.
> 

But adding

	umask 002

to /etc/bashrc would do exactly the same thing, so why have it a setting 
for the repository only? In my experience, most servers used for hosting 
git repos host *lots* of them (look at master.kernel.org), so a 
server-wide setting really makes much more sense. If the server admin 
can't be bothered you can always change $HOME/.bashrc.

So long as people remember that .bash_profile isn't read for 
non-interactive shells this should do nicely. If they can't remember 
that they won't remember adding the setting to the repository either.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
