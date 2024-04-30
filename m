Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09E6FB1
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714458279; cv=none; b=YQDhpmrMuuy96j383YgoJaSkIMu9hYlWPUUZwZEDUkURyBXncJPa1u7sDljl1v/1PPchELQqUONbEkJdg3UmbcCtoBjwJC9+x41XzEZ00ybj+UY8LO2TiLH3IpgCchp48mvn4ED8TRiznFQLe/RVJDB3sXRk1swk80AWYs5K4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714458279; c=relaxed/simple;
	bh=kq1JT6TTlNK+TLELA92yrQXMUSfvKRF6bgU0a4RZHio=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Bvs4XG9J+iqOeHLm8Mw4Xd+s3YWqGDXS3iaEONi333tHD4ds2nnPNgITqEZJRAf0WuFNIv3TtD/ygL90SAiH3y37zl6ADzKTrOEIgRLdbVnSeBeKnnOI32zf0JjIntKKQWY54ukCbOk+xYac3yxHJnYlLYEBuK6XZ3zdpPN/kow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=p/ZFEGTA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="p/ZFEGTA"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714458273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xv32/DVo4ezrqzWXYBVv+5mncoEzKUSN+v7FFuNz5J0=;
	b=p/ZFEGTAoaCSXW/y/2VerLsddDeAxhK7k/jY+sk3RHVVEGV8iPZaWNFwBmqS4pLI7BApoF
	ZBzgCBOdrc4Lgu4jeRshEkDTVTO5Dppol3tjap9LgKxI/qZlRyjkQkCLoLYFlDqX9SVfoa
	7oYywtChYvka/CpJcZAzkgpnJ2HMua1tE7GuNmsSvLkndNXUi5YOUzYe3JCuuM4xqeT+i0
	uRrMt3D3VniNNQpvyjVlKJcxafHeVUisCoMou8uS9+C2S/ytP0e/ahfzS0eftxoPs18QE+
	techeuAzVoroAyv18Uh0y37qOR2NjutjTLLDmxoi3w7nW1P4X3Xs5eB1amxKaQ==
Date: Tue, 30 Apr 2024 08:24:33 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] advice: add --no-advice global option
In-Reply-To: <ZjB_OJUQt7lbkOgz@tanuki>
References: <20240429010925.93205-1-james@jamesliu.io>
 <20240430014724.83813-1-james@jamesliu.io>
 <20240430014724.83813-2-james@jamesliu.io> <ZjB_OJUQt7lbkOgz@tanuki>
Message-ID: <8bbb043a6259d94312fdbcecb991da33@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello James,

On 2024-04-30 07:18, Patrick Steinhardt wrote:
> On Tue, Apr 30, 2024 at 11:47:24AM +1000, James Liu wrote:
>> +/*
>> + * Environment variable used to propagate the --no-advice global 
>> option to the
>> + * advice_enabled() helper, even when run in a subprocess.
>> + * This is an internal variable that should not be set by the user.
>> + */
>> +#define GIT_ADVICE "GIT_ADVICE"
> 
> Almost all of the other defines in this file have an "_ENVIRONMENT"
> suffix. We should probably do the same here to mark it as the name of
> the environment variable, which otherwise wouldn't be obvious.

Just for the record, I already pointed that out... [1]

> We could add two more tests that explicitly set the environment
> variable, once to `true` and once to `false`. This would at least
> somewhat represent the case of running Git subcommands, even though we
> cannot test whether Git actually knows to set the envvar like this.

... and this as well. [1]

[1] 
https://lore.kernel.org/git/37512328b1f3db4e8075bdb4beeb8929@manjaro.org/
