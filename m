Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26278C7F
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456058; cv=none; b=lFuaWSFSx4k4h/jswQ6GyHCM3aah+4KHb45/uts3AR91DvhAn5JzIwfCYQsfwiNmRTzh/wbwLlcFgvnWm/Miq5aAAIuJMi98k3XlMvwYOhr5L/OcJuRJG+Aw3c2jv76r6IgXjShmtg3y6TfCR3d+p//uOiuSCcfY00JnaU9dd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456058; c=relaxed/simple;
	bh=s5hrA4wu4h20HXq/71vhncdw/z8WgS8CITBicH3r1sI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2OjMy8JMAdOWwf9/YOaMWtYRt4i0lAEfa/nGBESaRZrymxO1qq0REO8awjctdQdyGBE4+8JuRdA3NAh09YpKUjL42NqvZhaIiPWm5vYbhHkTab+izrhKAtiZAPDmt+mKMZAe9tJox1YwXINQcOH7Og5oT2L625DpwnHN9sPm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 468GRV6m3229157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 16:27:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Konstantin Khomoutov'" <kostix@bswap.ru>, "'ellie'" <el@horse64.org>
Cc: <git@vger.kernel.org>
References: <20240708143239.vq47dg7mgh33hykf@carbon> <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org> <20240708154457.jpt2aa5orzxy6kqh@carbon>
In-Reply-To: <20240708154457.jpt2aa5orzxy6kqh@carbon>
Subject: RE: With big repos and slower connections, git clone can be hard to work with
Date: Mon, 8 Jul 2024 12:27:24 -0400
Organization: Nexbridge Inc.
Message-ID: <001b01dad153$ba880ca0$2f9825e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIOcuJNQOiJMkQZvscuPTyr1NeGYwK0gGVSAP6SUzqxaCgigA==
Content-Language: en-ca

On Monday, July 8, 2024 11:45 AM, Konstantin Khomoutov wrote:
>On Mon, Jul 08, 2024 at 05:14:33PM +0200, ellie wrote:
>
>[...]
>> > > error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>> > > CANCEL (err 8)
>> > [...]
>> > > It seems extremely unlikely to me to be possibly an ISP issue, for
>> > > which I already listed the reasons. An additional one is HTTPS
>> > > downloads from github outside of git, e.g. from zip archives, for
>> > > way larger files work fine as well.
>> > [...]
>> > What if you explicitly disable HTTP/2 when cloning?
>[...]
>> Thanks for the idea! I tested it:
>>
>> $  git -c http.version=HTTP/1.1 clone
>> https://github.com/maliit/keyboard
>
>Over there at SO people are trying all sorts of black magic to combat a
problem
>which manifests itself in a way very similar to yours [1]. I'm not sure
anything from
>there could be of help but maybe worth trying anyway as you can override
any (or
>almost any) Git's configuration setting using that "-c"
>command-line option, so basically test round-trips should not be
painstakingly
>long.
>
>[...]
>> fetch-pack: unexpected disconnect while reading sideband packet
>[...]
>> Sadly, it seems like the error is only slightly different.
>
>I actually find it interesting that in each case a sideband packet is
mentioned. But
>quite possibly it's a red herring anyway.
>
> 1. https://stackoverflow.com/questions/66366582

I have customers who hit this problem frequently setting up git. It is 99%
of the time a firewall or proxy configuration issue, not specific to GitHub,
and changes to those usually resolve the problem. The firewall and proxy can
be implemented in the ISP's modem if coming from a home network. That is why
I really think the OP's issue is the network, not something that can
reasonably fixed in git. I think the network speed is also a potential
red-herring unless the speed issue relates to the ISP's configuration.

