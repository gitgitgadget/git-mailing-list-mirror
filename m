From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Mon, 14 Nov 2005 10:23:26 +0100
Message-ID: <4378578E.5090409@op5.se>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>	<43730E39.6030601@pobox.com> <7v64qzni9c.fsf@assigned-by-dhcp.cox.net>	<4375DD4A.5050103@op5.se> <7vwtjb3c4i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 10:25:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbaZN-0007TM-Ep
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 10:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVKNJX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 04:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVKNJX2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 04:23:28 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:40640 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751013AbVKNJX1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 04:23:27 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 4CB7E6BCBE
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 10:23:26 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vwtjb3c4i.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11776>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>>Also places we execute git-upload-pack and git-receive-pack over
>>>an SSH connection need to be updated to execute 'git' with the
>>>first parameter 'upload-pack' and 'receive-pack' to make sure it
>>>would keep working with older or newer git on the other end.
>>
>>I've cooked up a patch that takes care of this if;
>>	git daemon
>>is executed (rather than git-daemon)...
> 
> 
> Actually I was more worried about these git native protocols
> going over ssh, which is not helped by git-daemon.  I think
> teaching the libdir to git-shell would make sense for "git
> restricted shell" users, but most users coming from ssh to run
> git native protocols would need to have some way of running the
> executable on the other end.
> 
> My current thinking about this problem is that the handful
> programs that need to run "on the other end" should stay in
> /usr/bin, even after we move most things out of /usr/bin, if
> only to avoid configuration hassles.  They are:
> 
> 	receive-pack, upload-pack
>         ssh-fetch, ssh-pull, ssh-push, ssh-upload
> 

I liked your suggestion of deprecating the /usr/bin use a month or two 
before it's effected better. We could then provide symlinks for the 
necessary programs that point to their real locations in GIT_EXEC_PATH 
and (someday) drop those links when they're no longer needed.

> 
> Somehow libdir reminds me of where libraries are installed by
> the Makefile, which usually does not mean executables, and that
> was the reason I mentioned --exec-path.  Although I do not have
> strong preference myself either way, I do not think the list
> cares too much either, so in order not to waste time by
> indecision, let's just say we use this one:
> 
> 
>>The form will be
>>	exec_path=$(prefix)/lib/git-@@VERSION@@
>>	GIT_EXEC_PATH
>>	--exec-path
>>
>>for Makefile, environment and 'git', respectively. Substitute the 
>>obvious part with whatever you prefer.
> 
> 
>>..., although I'm implementing Linus' idea of prepending the
>>GIT_EXEC_PATH to $PATH so the porcelainish scripts in git-core
>>shouldn't have to do it.
> 
> 
> This sounds good to me; let's go with it.  Thanks.
> 

I'll get busy then.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
