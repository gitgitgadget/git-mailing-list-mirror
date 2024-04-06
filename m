Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16772C1B9
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419960; cv=none; b=McRCMLtAXkwMovTUZzF+cbQ7EYF0cZswhLYO/ASJkAFi/em1UgJZcMutbo67MdYiwz5onE3d3UINoEsfcW8YgwtVjTlAidKAfnbKtQ+RFGvfQCth5X1mpYQI2CcPq2vlx5/tA1ba3SsO1+VbaH7D4Bq9lXNA2bOUgw0VxQhiqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419960; c=relaxed/simple;
	bh=ejheFGyTiyt7wY63FteIinxygfFUTS5YO23joJzUChg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nRsSYuh4aKv/eRLzPjd19iwsiEl1Ujb5cTQrVm2cUkc05kFPQZne9zbVbGHDOVLVrP3QGKAp5bh2BAIBR4zLyUm/Fkh+yr9UvkCG5YWyNU0D5RmUoq7fmheMtpXT7UiTSkxK6h4c069PgWehLkMgIN6LfH7ZQ9qUvCc5C7NzEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KwySwvu3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KwySwvu3"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712419954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70s9F1mB41hzKPe9md+cta2oo4dL9Pnbcz5vOfvMdNQ=;
	b=KwySwvu3Gsn1aMVqhAQxDluhmopqRZ+Od7FokZI+SPaKZza/bNiIennBolQXnFdN7X4YFa
	GoL7eTMyx4KU4nbLWKdFYpENnuXYPnQ3a/F49xZOknNVV0ZXGfY37SXEY0WSV2Q4VHEfmo
	7fAn4Lf8vDQ9wRPBcTMcxWcYKYE5pdEr7iY+EeXTSBWwlVakgQ1d68KzQAJVwPzZgC1dhi
	NjAbZNCQi9eU2zVOia0rksY8iL4PozZEmU8wsWi4Sair6rnHRkW1ytzlhpJcEO/3+SBvw3
	ilVogpt/w04oTZyTxX8Prq2Icvt8SLeTrk5Xf+wYk3L0JOXeFd2JnESY32Pddw==
Date: Sat, 06 Apr 2024 18:12:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: prpr 19xx <prpr19xx@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Warning message in remote.c when compiling
In-Reply-To: <CAA1Aqdvj6Eyp9jGaAxTf8p0Eh_rCPydOpin3D5QYHy8sqOoOsw@mail.gmail.com>
References: <CAA1Aqdvj6Eyp9jGaAxTf8p0Eh_rCPydOpin3D5QYHy8sqOoOsw@mail.gmail.com>
Message-ID: <7f0da057773d39add4ede71667e9ff70@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-04-06 16:21, prpr 19xx wrote:
> I get this warning message when compiling remote.c:
> 
> ...
>     CC remote.o
> remote.c:596: warning: 'remotes_remote_get' declared inline after being 
> called
> remote.c:596: warning: previous declaration of 'remotes_remote_get' was 
> here
>     CC replace-object.o
> ...

Could you, please, provide more details about your environment,
i.e. the operating system and compiler?

> This is from the "master" branch, but it's the same on "next". It's
> easily fixed with this patch:
> 
> diff --git a/remote.c b/remote.c
> index 2b650b8..347f504 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -592,7 +592,7 @@ const char *pushremote_for_branch(struct branch
> *branch, int *explicit)
>                                              branch, explicit);
>  }
> 
> -static struct remote *remotes_remote_get(struct remote_state 
> *remote_state,
> +static inline struct remote *remotes_remote_get(struct remote_state
> *remote_state,
>                                          const char *name);
> 
>  const char *remote_ref_for_branch(struct branch *branch, int for_push)
> 
> Thanks.
