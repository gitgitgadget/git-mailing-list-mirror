Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5A1D680
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705619888; cv=none; b=ugsqlfky1g2D6CqmlS1+1AAOD8EI52aYn70VuXKX2v+n+EJ2Lfhv30cCSHMD6WvImeQATXXJqLqcOD388Zbg/VrWwlXu1jMbLG1rAdlhKS9SFEZO/MR7yo5f8R4WlNtBeaLOiNpSANTBPInC+g1Sga8Cb/h14Q/LSjiDvuMvyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705619888; c=relaxed/simple;
	bh=aVdsXWMwpWuwnxMaGoIG6egKg1zOyJbyYRnJCXEMXnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DunB3tsvX1VZnoxxvsmBniYaFx5kWVcN3NtdFH2q/3a6vbVPZ5Sh+0fpI7Lfa/0zSa1iDN3jl57NxlgDg7oih2FTepFztZmeLxZV8fSWawxWVsHZclEkENeNfehuZEF5aAEc3keda98qA0IjBPZETN6FLUdahzA3bHc5tdVqhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z0+KcbtG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z0+KcbtG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3570C1CD956;
	Thu, 18 Jan 2024 18:18:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aVdsXWMwpWuwnxMaGoIG6egKg1zOyJbyYRnJCX
	EMXnQ=; b=Z0+KcbtGV+vaHfMJ35gR4XGSLMlQnq3w2loY7vyM0BscUizOe0dbTj
	+TNdGxdhxHw7E38NQALxAW6ViuB9EX5Dbnm8jLNFhgGggdj/UjhKKPvh4oaK3L+u
	gTJ+sB3tFDWwhh8KuAaKycxcdx8Jvcyx+tbq5CBEKO+ywDFJXZAlc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 202881CD955;
	Thu, 18 Jan 2024 18:18:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 261461CD954;
	Thu, 18 Jan 2024 18:18:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] t0024: refactor to have single command per line
In-Reply-To: <20240118215407.8609-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Fri, 19 Jan 2024 03:23:40 +0530")
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
	<20240118215407.8609-2-shyamthakkar001@gmail.com>
Date: Thu, 18 Jan 2024 15:18:02 -0800
Message-ID: <xmqqfryunsd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D4AF5DB6-B657-11EE-9054-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Refactor t0024 to avoid having multiple chaining commands on a single
> line, according to current styling norms.
>
> e.g turn
>     ( mkdir testdir && cd testdir && echo "in testdir" )
> into:
>     mkdir testdir &&
>     (
>         cd testdir &&
>         echo "in testdir"
>     )
>
> This is also described in the Documentation/CodingGuidelines file.

Sure.  

	Subject: t0024: style fix

	t0024 has multiple command invocations on a single line,
	which goes against the style given by CodingGuidelines.

would be sufficient.


> -	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
> +	mkdir untarred &&
> +	(
> +		cd untarred &&
> +		"$TAR" -xf ../test.tar
> +	) &&

I think we assume "$TAR" is modern enough to know about the "C"
option (see t/t5004-archive-corner-cases.sh), so

	mkdir untarred &&
	"$TAR" Cxf untarred test.tar

without even a subshell may be sufficient.

> @@ -30,7 +34,11 @@ test_expect_success UNZIP 'zip archive' '
>  
>  	git archive --format=zip HEAD >test.zip &&
>  
> -	( mkdir unzipped && cd unzipped && "$GIT_UNZIP" ../test.zip ) &&
> +	mkdir unzipped &&
> +	(
> +		cd unzipped &&
> +		"$GIT_UNZIP" ../test.zip
> +	) &&

I do not think we assume "$GIT_UNZIP" to always know about the
equivalent of "C" (is that "-d exdir"?), so what you wrote is the
best we can do.

Thanks.
