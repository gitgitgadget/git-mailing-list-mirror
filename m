From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Wed, 11 Nov 2015 20:58:24 +0000
Message-ID: <5643ABF0.5080207@ramsayjones.plus.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
 <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
 <56437F3F.7050305@ramsayjones.plus.com>
 <CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwcTQ-0007VO-I5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbbKKU63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:58:29 -0500
Received: from avasout01.plus.net ([84.93.230.227]:50347 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbKKU63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:58:29 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout01 with smtp
	id gLyS1r0072GQ2gJ01LyTfc; Wed, 11 Nov 2015 20:58:27 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MbeRwMLf c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=YL1Y2-_7U29ySGZvYYUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281203>



On 11/11/15 20:31, Eric Sunshine wrote:
> On Wed, Nov 11, 2015 at 12:47 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> On 11/11/15 01:22, Eric Sunshine wrote:
>>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>>> <ramsay@ramsayjones.plus.com> wrote:
>>> My machine is 64-bit, though, so perhaps it's misleading to
>>> characterize this as a fix for 32-bit builds. In particular, off_t is
>>> 'long long' on this machine, so it complains about the "long" format
>>> specifier.
>>
>> ... but this seems to imply that sizeof(long) is 4 on your machine, right?
>> (on x86_64 linux it's 8, which is why I hadn't noticed before).
> 
> This code on my Mac:
> 
>     printf("sizeof(long)=%zu\n", sizeof(long));
>     printf("sizeof(long long)=%zu\n", sizeof(long long));
>     printf("sizeof(off_t)=%zu\n", sizeof(off_t));
> 
> produces:
> 
>     sizeof(long)=8
>     sizeof(long long)=8
>     sizeof(off_t)=8
> 
> The fact that 'long' and 'long long' happen to be the same size (in
> this case) is immaterial. What is important is that the code is just
> wrong to be using the "%l" specifier for 'long' when the actual
> datatype is 'long long' (which is what 'off_t' is under-the-hood in
> this case).

Ah. OK, so %ld for long and %lld for long long, I suppose.

Hmm, not that it matters, but I wonder what the PRId64 macro is. ;-)

ATB,
Ramsay Jones
