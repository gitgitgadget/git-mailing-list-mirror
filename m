Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A50482D3
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361434; cv=none; b=cHMybh/cB8gihww/yETpE4QWoUz4mg8ckfkEdwDUgpRoTKe2c8KUu6eEaux+rjA8cAz/5fGK7LK1apW5xefs+WNykKQHldCXj8thkCJAy8oidBPvnd3aWYA0f5vEbAa0jesysHTOjEWgNIpYt+SaGjGiatwH1B3uH87Da93WtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361434; c=relaxed/simple;
	bh=0zEgmSSG3UYfYQfX0T4bI5W3IQ5pHoYwufd691rRyGE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UqIJKHDYH3tsWVEE79xlPUcbhB0Th74qLXjqzMc6kEHwdoX8bLxIQyDQ5lBjR8Rp0S0YaUagifICpNcXEpG9Jcvry8RoaWj3q29Zu57BifM+dlbtCmyKx6g6EPlN+4OPSPWPCAF6nrVZSg7yrc6dVhYKOD4pFFB4hDxR34ivoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GFSEi8kD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GFSEi8kD"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710361428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zs1ytbrFcy2r+4ZHJ6Chmfg3bQArMyLosw7Tu0zjcY4=;
	b=GFSEi8kD/XypdXjCy+uTaoujgMvz8vOWGGAzILMejIG96Yh1RZYlI4diwQ9Lu3HMhqyQMz
	vvYNt2lC5sVxDMdpqjHQOTD99rsPktlR71ty5lPsXZGSthVrO/EYFOUL/FYD2g2OtzCPvL
	K+m8domEhTuT2lacb17dtfwSd9HDV/HQ9VRYoahG+dCPxL409ad8Mx6jPlo5BPDn/RcBS/
	thkgyLUgg14oHVbj7xaH1JrqcuyScLmMP8KQRPDPlyxngpa/aaWYydEv7DCqLO6JY7nFia
	k8yLW8TLjBmdKEhrxO3BfrlOqQcTqm42COy752oFtAUCvu9WtlU9S3fgPWKqLg==
Date: Wed, 13 Mar 2024 21:23:47 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Peter Hutterer
 <peter.hutterer@who-t.net>, git@vger.kernel.org, David Heidelberg
 <david@ixit.cz>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <xmqqbk7if8vj.fsf@gitster.g>
References: <20240312231559.GA116605@quokka>
 <f8565251-2af1-470b-9b2d-798e3504b0d1@gmail.com>
 <xmqqbk7if8vj.fsf@gitster.g>
Message-ID: <dc87a2c7e596b1bdca6c1c16b11d74c9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-13 16:29, Junio C Hamano wrote:
>  Documentation/diff-options.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git c/Documentation/diff-options.txt 
> w/Documentation/diff-options.txt
> index aaaff0d46f..62eaa46d84 100644
> --- c/Documentation/diff-options.txt
> +++ w/Documentation/diff-options.txt
> @@ -864,9 +864,10 @@ endif::git-format-patch[]
>  	Do not show any source or destination prefix.
> 
>  --default-prefix::
> -	Use the default source and destination prefixes ("a/" and "b/").
> -	This is usually the default already, but may be used to override
> -	config such as `diff.noprefix`.
> +	Use the hardcoded default source and destination prefixes
> +	("a/" and "b/").  This is designed to be used to override
> +	configuration variables such as `diff.noprefix` and
> +	`diff.srcPrefix`.

How about this instead:

     Ignore any configuration variables that control source and
     destination prefixes, which includes `diff.noPrefix`, 
`diff.srcPrefix`
     and `diff.dstPrefix` (see `git-config`(1)), and use the default
     prefixes `a/` and `b/`.

>  --line-prefix=<prefix>::
>  	Prepend an additional prefix to every line of output.
