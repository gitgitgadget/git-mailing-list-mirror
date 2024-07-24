Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C655888
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803824; cv=none; b=dw/zX2t+ViAWYnGa4OPBNU2I5QmSFz7fxpX1CKZyHzgNH4ltD9nYcuI+GudNPuzymPZf7RsIXPVOLHvkgzZix4wYfB43tWQt/YyQf3SYjkxwnkyoG0euFfqL/qRHDvJlxXcPeSwu8dy7E8Sm5IwBwfiqrjGP0JndxXc3HA16ZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803824; c=relaxed/simple;
	bh=IbNlD045cvNkWnzfhRNk7iqC7cbpmHTYIHLTEMGoAY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWe8ot3x4dj07Hbo5Okedhpd5XF5NHrHSu+uvwPe6fiEVGeypJ0rcDhUFy4kcaooS3c1ccKiUhSCB6lBYoAN3y+JWBjlHTBeu+UDn3UZ7Z5vj0NwXibAHyXDQ1A2jyQ9Pi7S7mTKRj1wnWvX25Fsc+2V3mMH1bgPapwH6G5DTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.97] (dynamic-176-003-140-250.176.3.pool.telefonica.de [176.3.140.250])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 7D310180689;
	Wed, 24 Jul 2024 06:42:51 +0000 (UTC)
Message-ID: <bd5ebf84-5d47-437c-b773-580188cfb001@horse64.org>
Date: Wed, 24 Jul 2024 08:42:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: rsbecker@nexbridge.com, 'Konstantin Khomoutov' <kostix@bswap.ru>
Cc: git@vger.kernel.org
References: <20240708143239.vq47dg7mgh33hykf@carbon>
 <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
 <20240708154457.jpt2aa5orzxy6kqh@carbon>
 <001b01dad153$ba880ca0$2f9825e0$@nexbridge.com>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <001b01dad153$ba880ca0$2f9825e0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

For what it's worth, Github support now confirmed to me that it looks 
like they might have a timeout problem on their side, but until more 
people report it they likely won't address it. I appreciate their 
honesty. But I think it shows the vulnerability of a process without 
resume well.

(Sorry to harp on, I thought this extra info might be interesting.)

Regards,

Ellie

On 7/8/24 6:27 PM, rsbecker@nexbridge.com wrote:
> On Monday, July 8, 2024 11:45 AM, Konstantin Khomoutov wrote:
>> On Mon, Jul 08, 2024 at 05:14:33PM +0200, ellie wrote:
>>
>> [...]
>>>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>>>>> CANCEL (err 8)
>>>> [...]
>>>>> It seems extremely unlikely to me to be possibly an ISP issue, for
>>>>> which I already listed the reasons. An additional one is HTTPS
>>>>> downloads from github outside of git, e.g. from zip archives, for
>>>>> way larger files work fine as well.
>>>> [...]
>>>> What if you explicitly disable HTTP/2 when cloning?
>> [...]
>>> Thanks for the idea! I tested it:
>>>
>>> $  git -c http.version=HTTP/1.1 clone
>>> https://github.com/maliit/keyboard
>>
>> Over there at SO people are trying all sorts of black magic to combat a
> problem
>> which manifests itself in a way very similar to yours [1]. I'm not sure
> anything from
>> there could be of help but maybe worth trying anyway as you can override
> any (or
>> almost any) Git's configuration setting using that "-c"
>> command-line option, so basically test round-trips should not be
> painstakingly
>> long.
>>
>> [...]
>>> fetch-pack: unexpected disconnect while reading sideband packet
>> [...]
>>> Sadly, it seems like the error is only slightly different.
>>
>> I actually find it interesting that in each case a sideband packet is
> mentioned. But
>> quite possibly it's a red herring anyway.
>>
>> 1. https://stackoverflow.com/questions/66366582
> 
> I have customers who hit this problem frequently setting up git. It is 99%
> of the time a firewall or proxy configuration issue, not specific to GitHub,
> and changes to those usually resolve the problem. The firewall and proxy can
> be implemented in the ISP's modem if coming from a home network. That is why
> I really think the OP's issue is the network, not something that can
> reasonably fixed in git. I think the network speed is also a potential
> red-herring unless the speed issue relates to the ISP's configuration.
> 
