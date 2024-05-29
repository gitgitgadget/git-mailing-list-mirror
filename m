Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031315B98B
	for <git@vger.kernel.org>; Wed, 29 May 2024 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006533; cv=none; b=m1dSqn+vNFJQTp8UHFHg+IHm/6QC0AHo38fDzXClg9k0x3onqLng/oMGlay/cwIQ8rY0QYiBlKNqJbXriZEKfduUWfK3MrNOSDQAFCxywgHL6ADOCAPRKOUt59kfzGVJN7u7DpWmRKVwsZG07WOuQ3mu+Ziz/dLrj72C4rKr7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006533; c=relaxed/simple;
	bh=YwLqI/YX5ddRHpq+W/04Tgjl4ElCx7TZ7JnDchS5oW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILllOTAfRZauZhzAPxD6yQddJ2Rok3hijS//rZpeZq5FmLDHqQIRvYR8+FVqSkOJMh4zs5i9+CZnbAT8uvSx36S8pNRn254cO/8tPeG8ASj5opeUebd1//1j0Wkega8eZ7cuqK7D3qvXrKG/6WmFu+AIpGVdPXVbFgM6KP6h960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=X63eqMOx; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="X63eqMOx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=A+e69WipNoiw0yO/nknCeh5Te0b18M1T8l5DCtyCIwg=; b=X63eqMOxYrWrkjSCueR7VlNnm4
	umAybBu2RfpEbL+vq1nHeQspqUguElok02SlLnvRSJlubGipupZlzdVK7VR7KKPPrsKXRxKkDdyC0
	hQqcTj3l1c5NSkikQOnnSKDcfdxp9IAK/IpXJwO9chcdc1gdMhxmRDw2Hb4j7N/HUjmWQEgnBnq3t
	F7gn8cTJagBo52u6UlU96AUPhqdxhL/SdwOKHC8nPuiuPSJegSpsZL8bcN30eqD/8tEzSbARgsQ9I
	7WcIAxS4JM34bAbzycVY6vAKN/GRQSUMlRAsQ47DIchxZLUmzGV0NApGflzR3g9cHKPaQ6j0BQOb9
	P4FZQw2NzWr5SE/Zs3hT2em0xu7ms01w5k+gTtmOK4CGqSfmrIUCdOsfLRmGdxS56QbCLIQQ9ROw6
	Fw1b8E1FyyBxwzixobe8w6IUpvlNvrbqROckcgcJ2e7nsW3WIE1jDt7ICIgel/wfrkid8JeMzFvEX
	PV+XIDayJ32eJqKYe5n42cy8;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1sCNpf-00DtE5-17;
	Wed, 29 May 2024 18:15:27 +0000
Message-ID: <22b487e8-b845-43f9-8abe-5f96a756b376@samba.org>
Date: Wed, 29 May 2024 20:15:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: safe.directory wildcards
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org>
 <xmqqplt4zjw7.fsf@gitster.g>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <xmqqplt4zjw7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 29.05.24 um 18:02 schrieb Junio C Hamano:
> Stefan Metzmacher <metze@samba.org> writes:
> 
>> given the recent importance of safe.directory, it would be great to
>> have something like '/data/git/*' to be supported, not just a single '*'
>> for a server that serves a lot of public git repositories owned by different owners.
> 
> Interesting.
> 
> The original commit that introduced the '*' opt-out, 0f85c4a3
> (setup: opt-out of check with safe.directory=*, 2022-04-13), was
> done to specifically help those who have a large list of shared
> repositories.  We could have moved all the way to allow globs back
> then, and the possibility certainly was brought up.
> 
>    https://lore.kernel.org/git/xmqqk0bt9bsb.fsf@gitster.g/
> 
> But the loosening was done in a context of "brown paper bag fix"
> so it is very much understandable that we did the simplest and most
> obvious thing to avoid making silly mistakes in a haste.

> I am reluctant to use wildmatch() but I would expect that in
> practice "leading path matches" (in other words, "everything under
> this directory is OK") is sufficient, perhaps?

That's exactly what I tried first and then looked
at the sources to check why it doesn't help :-)

I guess it will be useful to have.

Thanks!
metze
