From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/6] Fix some "printf format" warnings.
Date: Wed, 14 Mar 2007 22:57:11 +0000
Message-ID: <45F87DC7.7020503@ramsay1.demon.co.uk>
References: <45E9BE46.1020801@ramsay1.demon.co.uk>	<7v4pp29eok.fsf@assigned-by-dhcp.cox.net>	<45EAFD21.6010002@ramsay1.demon.co.uk> <45F55DC5.8060702@fs.ei.tum.de> <7vfy8as129.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRcUC-0002c9-6B
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbXCNXCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbXCNXCW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:02:22 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:3589 "EHLO
	anchor-post-30.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422748AbXCNXCV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2007 19:02:21 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1HRcU7-000E8r-0d; Wed, 14 Mar 2007 23:02:19 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vfy8as129.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42246>

Junio C Hamano wrote:
> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:
> 
>> Ramsay Jones wrote:
>>>>> -        printf("%s%06o %s %d\t",
>>>>> +        printf("%s%06lo %s %d\t",
>>>>>                 tag,
>>>>>                 ntohl(ce->ce_mode),
>>>> I think we should do this instead:
>>>>
>>>>     printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...
>>> Oops, yes you are right.
>>> (cygwin typedef's uint32_t as unsigned long.)
>>>
>>> However, I would hate to add all those casts! Casts are not always
>>> evil, but should be avoided if possible. Having said that, I don't
>>> see another solution ...
>> shouldn't it be something like this?
>>
>> printf("%s%06"PRIo32" %s %d\t", tag, ntohl(ce->ce_mode), ...)
>>
>> that's the correct and allegedly portable way I guess.
> 
> Yes, except that that is only portable across platforms with
> inttypes.h, and we would need a compatibility definition in
> git-compat-util.h next to PRIuMAX definition we already have.
> 

Hmmm, I only have the 1.5.0 code, and so I don't know what the
current code looks like; so if this is rubbish, please ignore...

In version 1.4.4, the only files to depend on <stdint.h> were
{arm,ppc}/sha1.[ch]. If this was a problem on any given arm/ppc
platform, you could configure the software to use the OpenSSL
or Mozilla versions instead.

In 1.5.0, however, git-compat-util.h _unconditionally_ includes
<inttypes.h>, which in turn includes <stdint.h>. Now the files
which depend on definitions in <stdint.h> includes:
    {arm,ppc}/sha1.[ch]
    cache.h
    pack.h
    builtin-pack-objects.c
    fast-import.c
    sha1_file.c
(the symbols being: uint32_t, uint64_t, uint16_t, uintmax_t)
Version 1.5.0 does not seem to depend on any symbols in the
<inttypes.h> header file...

So, at least for 1.5.0, those header files are already
required.

I don't know if that is desired ;-)

ATB,

Ramsay Jones
