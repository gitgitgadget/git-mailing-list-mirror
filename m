Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642112FB27
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803130; cv=none; b=RkNhYedX986UwTteFUSO3nWbt/oXIaESGv9NtE4xNLOaCaxIUNDQikXBUym0pIjHLqDNeSpx7kqBCnIsnf4z/xC4CpuolxEc6zyg1yqgq59CLhuZsAul7W5jWzn2AkCIq5eekqDKiAQiosEhpd40L6gYykfZY1Z/Inl4qkdxiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803130; c=relaxed/simple;
	bh=moVDenTHYuHOwinDGzU7VO9S+qVqzmZmWGDJiOWbGDs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Vk1l2YPKxcaYHXfin528VW3lapVfnGO05UUgq7QEqmTWZVKfYv3CZpoOxOlnp5h4DhIx5AQ1qTKwYogxcJxcyzoc/Jg9wyv0KNOrJ/PLqh3ZMTaereLDBzytYnGI2aQZOLJsy0aOzu5ff0zS+w3eEhl3bmZRDuS4NvkY6zsmmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=raXIktSW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="raXIktSW"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718803120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxXYRmu+UFJ9+8aGhLMLPrpaEs3Sa82IVb1E5EtAsRs=;
	b=raXIktSWZPlHZsQgMSayObz5yAbVDiyM5rvhBbsOTgartoASVmZV8BUFsY/29JZK4DtsKN
	WrZZSpoyu7j3gNUPBVEA3RHPd6XEvs0g5XCgUa0SFLFu0JYP7/QTC6FYMzQW5dY08vPN9Q
	y74167IdPoCBExqApMPbTVuKAsoErGgSrz07hKfqtG9LaoIF0yodFGObzCT+1N3Zy1FLru
	jEpjA4qlHd31RKCbE7g6lgCGKPeWtM6nKZ6kvTrKquM3w6OsxlCTqrs5Fn3/S2kGHfrFnf
	Ok2EVfIdIYaQLM9fcS0OhQfp5FWMMsmvSQxNcHY/in/sQOg0kGXdMZH+Q31HaQ==
Date: Wed, 19 Jun 2024 15:18:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
In-Reply-To: <20240619125708.3719150-1-christian.couder@gmail.com>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
Message-ID: <0448495385b009f25a66b0712afb28f1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christian,

On 2024-06-19 14:57, Christian Couder wrote:
> For debugging and statistical purposes, it can be useful for Git
> servers to know the OS the client are using.
> 
> So let's add a new 'os-version' capability to the v2 protocol, in the
> same way as the existing 'agent' capability that lets clients and
> servers exchange the Git version they are running.
> 
> This sends the same info as `git bugreport` is already sending, which
> uses uname(2). It should be the same as what `uname -srvm` returns,
> except that it is sanitized in the same way as the Git version sent by
> the 'agent' capability is sanitized (by replacing character having an
> ascii code less than 32 or more than 127 with '.').

This may probably be a useful debugging feature, but I strongly
suggest that a configuration knob exists that makes disabling it
possible.  For security reasons, some users may not want to
publicly advertise their OSes and kernel versions.  Count me in
as one of such users. :)

> CI tests are currently failing on Windows as it looks like uname(1)
> and uname(2) don't report the same thing:
> 
> 
> -os-version=MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64.2024-02-14.20:17.UTC.x86_64
>   +os-version=Windows.10.0.20348
> 
> (See: https://github.com/chriscool/git/actions/runs/9581822699)
> 
> Thoughts?
> 
> Christian Couder (3):
>   version: refactor strbuf_sanitize()
>   version: refactor get_uname_info()
>   connect: advertise OS version
> 
>  Documentation/gitprotocol-v2.txt | 18 +++++++++
>  builtin/bugreport.c              | 13 +------
>  connect.c                        |  3 ++
>  serve.c                          | 12 ++++++
>  t/t5555-http-smart-common.sh     |  3 ++
>  t/t5701-git-serve.sh             |  3 ++
>  version.c                        | 67 ++++++++++++++++++++++++++++----
>  version.h                        | 10 +++++
>  8 files changed, 111 insertions(+), 18 deletions(-)
