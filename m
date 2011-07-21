From: Phil Hord <hordp@cisco.com>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 20:39:28 -0400
Message-ID: <4E277540.7080408@cisco.com>
References: <20110720221632.14223.qmail@science.horizon.com> <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm> <alpine.LFD.2.00.1107201931510.21187@xanadu.home> <4E276DF8.8030301@cisco.com> <alpine.DEB.2.02.1107201714140.6412@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>, anthonyvdgent@gmail.com,
	git@vger.kernel.org, torvalds@linux-foundation.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Jul 21 02:39:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjhIt-0006TY-T3
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 02:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab1GUAjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 20:39:32 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:3417 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab1GUAjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 20:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2901; q=dns/txt;
  s=iport; t=1311208771; x=1312418371;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=CV0pfyDPQOIaS17sb/YrMZMgutApLiSwwI8iR2hG8JY=;
  b=NRS9Zk+Eat0BuQX3hzuYPtyZRrPIfc9Vr2CRP22d7Km1ZRpdvjr5BpK9
   LTfOqhNc2VzGc7Wuo6epazWUOGrC/5K5D2kmxgdy5WqdPGx1D4yyBgWhM
   PHNqkIJHuJpqV2ggJK+AlNyDflo2kXwMOrjJs+xAbzxuT5ooyH3OGWxhf
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ag4HAGx0J06tJV2Z/2dsb2JhbABTmF2PB3eIfJ13nhyGPQSSboUHi3I
X-IronPort-AV: E=Sophos;i="4.67,238,1309737600"; 
   d="scan'208";a="4921624"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-2.cisco.com with ESMTP; 21 Jul 2011 00:39:30 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p6L0dT7g011213;
	Thu, 21 Jul 2011 00:39:30 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <alpine.DEB.2.02.1107201714140.6412@asgard.lang.hm>
X-TagToolbar-Keys: D20110720203928909
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177567>

On 07/20/2011 08:18 PM, david@lang.hm wrote:
> On Wed, 20 Jul 2011, Phil Hord wrote:
>
>> On 07/20/2011 07:36 PM, Nicolas Pitre wrote:
>>> On Wed, 20 Jul 2011, david@lang.hm wrote:
>>>
>>>> If the generation number is part of the repository then it's going to
>>>> be the same for everyone.
>>> The actual generation number will be, and has to be, the same for
>>> everyone with the same repository content, regardless of the cache 
>>> used.
>>> It is a well defined number with no room to interpretation.
>>
>> Nonsense.
>>
>> Even if the generation number is well-defined and shared by all 
>> clients, the only quasi-essential definition is "for each A in 
>> ancestors_of(B), gen(A) < gen(B)".
>>
>> In practice, the actual generation number *will be the same* for 
>> everyone with the same repository content, unless and until someone 
>> develops a different calculation method.  But there is no reason to 
>> require that the number *has to be* the same for everyone unless you 
>> expect (or require) everyone to share their gen-caches.
>
> and I think this is why Linus is not happy with a cache. He is seeing 
> this as something that has significantly more value if it is going to 
> be consistant in a distributed manner than if it's just something 
> calculated locally that can be different from other systems.

It will only be used locally, so it needn't be consistent with anyone 
else's.

>
> if it's just locally generated, then I could easily see generation 
> numbers being different on different people's ssstems, dependin on the 
> order that they see commits (either locally generated or pulled from 
> others)
>
> If it's part of the commit, then as that commit gets propogated the 
> generation number gets propogated as well, and every repository will 
> agree on what the generation number is for any commit that's shared.
>
> I agree that this consistancy guarantee seems to be valuable.

I can't see why.

>> Surely there will be a competent and efficient gen-cache API.  But 
>> most code can just ask if B --contains A or even just use rev-list 
>> and benefit from the increased speed of the answer.  Because most 
>> code doesn't really care about the gen numbers themselves, but only 
>> the speed of determining ancestry.
>
> in that case, why bother with generation numbers at all? the improved 
> data based heristic seems to solve that problem.

Does it?  Surely the ruckus would've died down in that case.  But I 
haven't been reading pu.

It seems to me that the main drawback to a gen-cache is that it slows 
down the first operation after even a local clone (with just hardlinks).

On the other hand, I see too many nails in the distributed-gen-numbers 
coffin:  legacy commits can't catch up (and therefore suffer), and 
legacy clients can trash or corrupt even "new-style" commits.

Phil
