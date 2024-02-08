Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864136B0A
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423399; cv=none; b=qfcEn0ixaoyhO1TYYFt7P3SVyQM7U5P0nSL4Raj4Wdpd6d3RtBlyGrUzD/3+0xQeB6e6WYDWbj3vd+Y2hKOCaMNzKl4vXtUG0r7uIbz4fVARFZnT0vjIt+5jR7/DNE1OrB9jxo84BQxrUHG9t3wZg1GuGXIkbhHjZdMjG7saFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423399; c=relaxed/simple;
	bh=z7BWFwOkZc5R3hOGyMz76HfP0yUCittf6yW6C/J29cQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ixMabNlzUII+8074Otk2c7TgGW8J+AXsMkj2Xgsrrm6h4upyNe/u9bHDWOSK4ckxwPau3PENjId0e2uVnekaSXL7VQC08hvUq6p7mu12Zbd5npti54UHc1uWpiHmLtP8kaSLQXO5oc96LuwAT9zprGw8u4oTl7rFUsrw01JFsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IypZ11zD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IypZ11zD"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707423391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3GtL+1RRytM+56bZXa1dDSatJeIDo+FvTTZrYc9+bg=;
	b=IypZ11zDTaF8rMqETVUnYAZvM/z12nzW5ID5ztvfwKR4PP8PYzrI/T6iGelnAyJvjOpIy1
	oB0yGDdSG9l3rUJQaGwMz8FAC4tCj8lF5he0HPcl/bfceEstqrbe31RCRZ2S4SSB+u+2Yz
	vRW7xPakWmQpjcQgy432oPisKKkA3TEUXgkYUto6XNPZYCjnlfGyVEJObRj/16iam1+cd/
	epuId3B6er/p+3PqrjP5Zn03wNk0Uf9TYwmhaAnBDQHoZK12vrHDkVphFkBkjI7uSZUWWR
	dC5900TbzMZDxKlKj0Zu5LLouPbFB4OFAgYkHmTNW11nUKECZ6j39915NKfLrA==
Date: Thu, 08 Feb 2024 21:16:31 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: cloning the linxu kernel repo at a VPS with small RAM
In-Reply-To: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>
References: <2f773980-70ec-4ad0-a49c-3ac12c294a39@gmx.de>
Message-ID: <6c4e309aa77e534cffdba9ae56032b99@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Toralf,

On 2024-02-08 18:32, Toralf Förster wrote:
> Situation:
> 
> The command
>     git clone
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> fails at a virtual server with about 2 GiB RAM under a recent Debian
> bookworm with git 2.39.2. What works for me:
>       git clone --depth=1
> https://git.kernel.org/pub/scm/linux/kernel/git/stable
>       cd ./linux
>       git config gc.auto 0
>       git config pack.threads 1
>       git fetch --tags
> as seen in [1].
> 
> Q:
> I do wonder if Git could automatically try to deal with only 1.5 GiB
> available RAM?

Here's an excerpt from my ~/.bashrc, which sets the things up
on my Pinebook Pro laptop with an RK3399 SoC and 4 GB of RAM,
which is also thermally constrained:

# Missing nproc(1) is handled properly
REASONABLE_THREADS=$(nproc 2> /dev/null || echo 1)
REASONABLE_THREADS=$((${REASONABLE_THREADS} / 2))
((${REASONABLE_THREADS} == 0)) && REASONABLE_THREADS=1

export GIT_CONFIG_COUNT=3
export GIT_CONFIG_KEY_0='grep.threads'
export GIT_CONFIG_VALUE_0=${REASONABLE_THREADS}
export GIT_CONFIG_KEY_1='index.threads'
export GIT_CONFIG_VALUE_1=${REASONABLE_THREADS}
export GIT_CONFIG_KEY_2='pack.threads'
export GIT_CONFIG_VALUE_2=${REASONABLE_THREADS}

export ZSTD_NBTHREADS=${REASONABLE_THREADS}
unset REASONABLE_THREADS

Obviously, this does a bit more than configuring git only.

Perhaps modifying this to additionally take the amount of RAM
into the calculation of REASONABLE_THREADS could be a solution
for your use case?
