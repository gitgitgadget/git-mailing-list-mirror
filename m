From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Ensure that commit/status don't stat all files when core.ignoreStat
 = true
Date: Tue, 27 May 2008 22:21:52 +0200
Message-ID: <483C6D60.7090705@trolltech.com>
References: <1211880549-15758-1-git-send-email-marius@trolltech.com> <7v7idf1pqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 22:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15hD-0002yT-0r
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759131AbYE0UVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758972AbYE0UVG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:21:06 -0400
Received: from hoat.troll.no ([62.70.27.150]:39386 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759586AbYE0UVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:21:03 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 1DD4420B0A;
	Tue, 27 May 2008 22:20:56 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id E905220B07;
	Tue, 27 May 2008 22:20:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7v7idf1pqy.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83040>

Junio C Hamano said the following on 27.05.2008 22:00:
> Marius Storm-Olsen <marius@trolltech.com> writes:
> The description for core.ignorestat in Documentation/config.txt is quite
> bogus.  That single bit does _not_ determine globally if we lstat(2) or
> not.  The description in Documentation/git-update-index.txt about it (look
> for the section "Using assume unchanged bit") accurately describes what it
> is meant to do.  The rules are:

Aha! Thanks for the detailed explanation of core.ignoreStat. Given 
your description, the patch is certainly bogus.

> Would it be sufficient for what you are trying to do if you changed that
> test to something like this?
> 
>         /*
>          * CE_VALID means the user promised us that the change to
>          * the work tree does not matter and told us not to worry.
>          */
> 	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
>         	ce_mark_uptodate(ce);
> 		return ce;
> 	}

I'll give it a shot tomorrow, to see how it affects my use-cases.
Thanks.


>> diff --git a/wt-status.c b/wt-status.c
>> index a44c543..72db466 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
...

> The core.ignorestat variable does not have anything to do with showing
> untracked files.  It is about "do we mark the added path as CE_VALID,
> meaning that we do not have to lstat(2) them?"  IOW, it is about tracked
> files.
> 
> While it might be useful in certain workflows to ignore untracked files, I
> do not think it is a good idea to overload such an unrelated meaning to
> the variable.

Indeed. I'll resend a new patch tomorrow with a new variable which 
will only affect the stat'ing of untracked files, if you think that's 
reasonable. IMO, we certainly need a way of avoiding to stat the whole 
filetree on commits and status. I mean, that's what you have the -u 
option for, right? :-) In any case, an opt-in feature, of course.

Thanks for checking the patch!

--
.marius
