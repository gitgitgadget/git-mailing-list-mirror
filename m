Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05981CE0A1
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954854; cv=none; b=UV2D/itSZioznzKwM/6eReb0xHvy/rLgltPY/bCePPCPz2HobwZRr3PBbqO8AKAn/IYOrU+Gj4gxsK9lV7Dr2/LUbIN6muNB8lZd4xdGe6NOqzA+jo8hTuMilFXbdtC+9Ngd97Qfak4PWwPvFW6lqsCRcP8zqSixqyBPbjTz1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954854; c=relaxed/simple;
	bh=vodQ8ieMGayzzUQgHJGOqrwZ9WK2cgsOC4VoBVKeJuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0Q65MNRHf/QfPqYqeXiye0+4SeWWHb0FJd1gMjM8Gp0+H44sJbQM2P+PbDnnubxLUACI+JN0nDuk40SQQZNZbyDNth4QWos14ze7XsVyNt3W9Tn9mGLy3M30/vRJFFicyJnKDoG0asHRtYTD8Q+zQuYtBZF/bX/OWQOtCTEUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fjSailct; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fjSailct"
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 462LDraZ707908
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 2 Jul 2024 14:13:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 462LDraZ707908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719954834;
	bh=WYUIk1R3jS/eqM+G1qa2/+kfQ2H3dhyxwtEUDFjXm+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fjSailctpgNuDa6PnN36Im+EcZohDMJEnc7qDZZu7BqVvoxbD2fq4wAWjonYF2AMZ
	 xosTH3rydYppCoT6k9ooQYacJtZEzCiIjpp7DSnUIcWgTCXAn8TcU8kRyWSGnF+NCl
	 CMKrlOkMfZChIluUVQuxotwDBNXtQ8vYzq16QmXpXWf5srvbCkX/326oi9ExboY2EX
	 c93mE8ijlTovaJpkQcLfESWl4f88X5UidQRt7o8ydBePNBvCcBN/Y7hfZ9bAoR6n5P
	 Rr9O34nma7rVaD7RDTbdHRsS1Iw+neE2s9ayj4RvGHryrAXWWCVbXxs0K3fHwAGFyK
	 eTW9a6tGWP96w==
Message-ID: <ada57994-b7cc-4a21-b41d-400d63b243d5@zytor.com>
Date: Tue, 2 Jul 2024 14:13:47 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git remote origin leaks user access token
To: Jeff King <peff@peff.net>,
        "brian m. carlson"
 <sandals@crustytoothpaste.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>, limin <1159309551xcz@gmail.com>,
        git@vger.kernel.org
References: <CALFtjBBvk+JPmU_GzrnM=ANwaQDdiLtzh4YkZFbcVENyCu9fxA@mail.gmail.com>
 <ZoKW-yDJMsz9JPSI@google.com> <ZoLY_yxpQBjmp8O3@tapette.crustytoothpaste.net>
 <20240701183515.GF3199@coredump.intra.peff.net>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240701183515.GF3199@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 11:35, Jeff King wrote:
> On Mon, Jul 01, 2024 at 04:27:43PM +0000, brian m. carlson wrote:
> 
>> I do want to point out that several people, not just me, have worked
>> together to make using a credential helper as easy and robust as
>> possible.  I mention this not to contradict Jonathan, who I think is
>> also trying to help in this regard, but mostly to mention that as a
>> project we've been trying to gently nudge people into doing the more
>> secure thing.  If people have further suggestions on how to make this
>> easier for users in the future, I'm very eager to hear them.
> 
> One thing we could do is refuse to store credentials in plaintext
> config. That helps people who aren't aware of the recommendations you
> mentioned end up more secure (though at the expense of convenience, as
> subsequent fetches won't work if you don't have a credential helper set
> up).
> 
> Some old discussion and possible patches here if anybody wants to pick
> up the topic:
> 
>    https://lore.kernel.org/git/nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet/
> 

That could be a default, but please in that case add an override option. 
I can't even begin to list the number of fail whales that have been 
committed in the name of "security" without some kind of No Dammit I 
Really Mean It™ override. Everything from MTAs refusing to deliver to 
shared mailboxes for role accounts (due to giving group access) to being 
unable to connect to old embedded devices because "SSL 3 is dangerous 
and deprecated" -- which, of course, is true, but when you are on an 
isolated network and can't downgrade the existing device to unencrypted 
and can't upgrade it to TLS, it is an amazing headache.

	-hpa

