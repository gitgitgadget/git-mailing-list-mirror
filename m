Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC91B85F5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202930; cv=none; b=UpuRNfg8KYxJUbclGiny1s1oFcGRHOOt/s8u3Pd1eHczoRfTm2pujlNm6oGS3Mypcag/dxs7ddqo+CCYcD5PZfhaxtzJagbdAPue2EmuwQnpgaG5d6t9WIBjEf+1Blu3xTsmLNx0cjFhrAfDLSWdoy17siDpwmJJG4jIQXIpzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202930; c=relaxed/simple;
	bh=SwrlrLxueWRjzUyHRumD7e8lbDoUob3lb7wfVULVufA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5fD9oUjMw4ZXkMOkjGKsQiDNkucWXjRleR9mZnyIsBrgjqVDu/to1Rl8cQVVcZ2sR+4er4zIKF+enH9c6JV65KB3nfcphaX+3cp4WGW6oY8oLRe78PCjkjpdZLN/bc6s0k8QOrqiOwZC0VT013Qp8GEKmTzFtUdmhkJ6IFbndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=neI7PIyT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="neI7PIyT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3405C1B95B;
	Tue, 24 Sep 2024 14:35:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SwrlrLxueWRjzUyHRumD7e8lbDoUob3lb7wfVU
	LVufA=; b=neI7PIyTf/rE/fIJMv3UeHQxCQIBq/Sw4aTVcKQ1Wlz0FKw4hAH59d
	/Hf3ylrwBLuf5eSKJRqdE7UW5/fuwhuhaN0tKdin6kwClnzMEsh9eWMZ78hLWDn4
	8w1CyVHDPz//sDQOrexl48nduqk1o0aGtTTgWRmoE7kRb6nYcpEcE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 276181B95A;
	Tue, 24 Sep 2024 14:35:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E5751B959;
	Tue, 24 Sep 2024 14:35:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 4/4] archive: remove the_repository global variable
In-Reply-To: <f6c32ec609cca56f1c02a75929dc7cc19d4834cd.1727185364.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Tue, 24 Sep 2024 13:42:44
	+0000")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<f6c32ec609cca56f1c02a75929dc7cc19d4834cd.1727185364.git.gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 11:35:25 -0700
Message-ID: <xmqq34loucgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C46A4AB8-7AA3-11EF-8733-9B0F950A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  int cmd_archive(int argc,
>  		const char **argv,
>  		const char *prefix,
> -		struct repository *repo UNUSED)
> +		struct repository *repo)
>  {
>  	const char *exec = "git-upload-archive";
>  	char *output = NULL;
> @@ -110,7 +109,7 @@ int cmd_archive(int argc,
>  
>  	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
>  
> -	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
> +	ret = write_archive(argc, argv, prefix, repo, output, 0);

Exactly the same comment applies here as [3/4]
