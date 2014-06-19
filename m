From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] alloc.c: remove alloc_raw_commit_node() function
Date: Thu, 19 Jun 2014 10:55:38 +0100
Message-ID: <53A2B39A.6040902@ramsay1.demon.co.uk>
References: <53A1EE0E.6040000@ramsay1.demon.co.uk> <20140618200854.GA23098@sigill.intra.peff.net> <53A2131A.30900@ramsay1.demon.co.uk> <20140619091924.GA29478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 12:01:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxZ9f-0003xb-Is
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 12:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926AbaFSKBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 06:01:11 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:36601 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756876AbaFSKBK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 06:01:10 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jun 2014 06:01:10 EDT
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id E9DCA6F8C28;
	Thu, 19 Jun 2014 09:21:11 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id B63486F8C08;
	Thu, 19 Jun 2014 09:21:11 +0100 (BST)
Received: from [192.168.254.9] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Thu, 19 Jun 2014 09:21:11 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140619091924.GA29478@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252106>

On 19/06/14 10:19, Jeff King wrote:
> On Wed, Jun 18, 2014 at 11:30:50PM +0100, Ramsay Jones wrote:
> 
>> So, the patch below is a slight variation on the original patch.
>> I'm still slightly concerned about portability, but given that it
>> has been at least a decade since I last used a (pre-ANSI) compiler
>> which had a problem with this ...
> 
> For a while some people were compiling git with pretty antique
> compilers, but I do not know if that is the case any more (Junio noted
> recently that we have had trailing commas on arrays and enums in
> builtin/clean.c for the past year, and nobody has complained).
> 
> Maybe those systems have all died off, or maybe those people only
> upgrade every few years, and we are due for an onslaught of portability
> fixes soon. :)

:-P You never know ...

>> [I have several versions of the C standard that I can use to check
>> up on the legalise, but I'm not sure I can be bothered! ;-) ]
> 
> It was actually pretty easy to find. I only have C99, but "empty macro
> arguments" are listed as one of the changes since C89 in the foreward.

Ah yes, having prompted me to look, it took all of 2 minutes to find it
in the C11 .pdf file I have right here ...

>> diff --git a/alloc.c b/alloc.c
>> index eb22a45..5392d13 100644
>> --- a/alloc.c
>> +++ b/alloc.c
>> @@ -18,9 +18,12 @@
>>  
>>  #define BLOCKING 1024
>>  
>> -#define DEFINE_ALLOCATOR(name, type)				\
>> +#define PUBLIC
>> +#define PRIVATE static
>> +
>> +#define DEFINE_ALLOCATOR(scope, name, type)			\
> 
> I am not sure offhand whether this is more portable or not (it would
> depend on order of macro expansion, and I am not brave enough to read
> through the preprocessor section of the standard carefully).

I suspect it is _slightly_ more portable, but I wouldn't bet any money
on it! I may take a look at the standard (it wouldn't be the first time
I've looked this up), but it would not help in this situation anyway.
The fact that a given compiler does/does-not conform to the standard
is useless knowledge if we need to support them.

>                                                               Quick
> reading online suggests that it's OK, but that an extra level of macro
> expansion would not be. And of course the Internet is never wrong. :)

;-)

> I'm inclined to go with it, and deal with it later if we get a
> portability complaint (at which point we are no worse off than we are
> right now).

Hmm, well my initial reaction was to send the more conservative patch
first. I wasn't so worried about inlining the code from the macro
(I doubt it will change), but I understand (and would often agree with)
your concern.

I would be happy with either solution, so I'll let yourself and Junio
decide! (sloping shoulders, or what. :) ).

ATB,
Ramsay Jones
