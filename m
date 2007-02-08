From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: git-am and workflow question
Date: Thu, 8 Feb 2007 10:07:31 -0600
Message-ID: <9A55745B-03D2-47B3-8359-FF2D9575502E@kernel.crashing.org>
References: <FA0FC64E-75D2-4722-8BD9-F7E6C8C9AFA7@kernel.crashing.org> <7vodo5153j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 17:09:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFBpj-0002OI-Eh
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 17:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423118AbXBHQIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 11:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423121AbXBHQIY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 11:08:24 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:64574 "EHLO
	nommos.sslcatacombnetworking.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423118AbXBHQIX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 11:08:23 -0500
Received: from [72.183.106.80] (helo=[192.168.1.100])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.63)
	(envelope-from <galak@kernel.crashing.org>)
	id 1HFBor-0001SG-HU; Thu, 08 Feb 2007 10:08:21 -0600
In-Reply-To: <7vodo5153j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.2)
X-PopBeforeSMTPSenders: kumar-chaos@kgala.com,kumar-statements@kgala.com,kumar@kgala.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39061>


On Feb 8, 2007, at 1:27 AM, Junio C Hamano wrote:

> Kumar Gala <galak@kernel.crashing.org> writes:
>
>> I poked around the docs and mailing lists but didn't find an  
>> answer to
>> my question some simple searches so I figured it might be easier  to
>> just post a query to the list.
>>
>> So my problem is that I'm applying some patches from a mbox and want
>> to be able to do some slight modifications before actually committing
>> the change.  I was wondering how people solve this problem (if at  
>> all).
>
> I am one of the two people who have been applying e-mailed
> patches to a repository using git for the longest time, so I am
> probably qualified to comment.  The other person is obviously
> Linus, but our workflows are a bit different.
>
> Linus's first pass is to read his mails in his usual e-mail
> client; he saves potentially worthy patches in a separate
> mailbox for later review.  In the second pass, he opens the
> saved mailbox in an editor, while fixing up bits in the commit
> messages and diff text.  Then after making another pass for the
> final review, he applies them in a single batch.
>
> I tend to work more incrementally.  My "first pass" is to read
> mails and fire off kibitzing responses without doing anything
> other than marking potentially worthy patches for later review.
> My second pass is actually applying the patch by piping each
> e-mail message from my e-mail client to "git am -3 -s", and if I
> do not like something in the patch, I make corrections and then
> run "git commit --amend".  My final pass is "git log -p", and if
> I find something I want to fix, I do "git format-patch -$N" and
> "git reset --hard HEAD~$N", fix it up in the editor by editing
> the commit message and the diff text, and "git am" to rebind the
> branch.
>
> In short, there are two different approaches:
>
>  - If a fix is something trivial, and if you are comfortable
>    editing diff text in your editor, then edit it before
>    applying.
>
>  - If a fix is more involved, you are probably better off
>    stopping immediately after applying the patch you want to fix
>    up, make the fix in your working tree, and commit it with
>    "git commit --amend".

Thanks.  Have there been any thoughts on having git-am apply the  
patch and then let the user do some modifications before the commit?   
I kinda did this by hand by doing the following:

git-am -i ...
< suspend >
patch -p1 < .dotest/patch
< modify >
git-diff > .dotest/patch
< cleanup >
< resume >

- k
