Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC54F602
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368180; cv=none; b=I8wo/m3lB9YZeTMy+wk6+Fubwki0f43BL2VxoXBkzjaM1d+YFjR3L+KDX5rFs+frTtZl/l0Bl9l8NR3quO9E9mYzcD3Ia38zCdEyRi/VYFNOHd5kg+PCfXDpKlfDOLQmURAlqVNDwlHzm8wdvpy+fDALAosuh4+XAS4oN854+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368180; c=relaxed/simple;
	bh=gfqzMmU+77s/AeA69+J6l/YunPUnly5b88n31NEFa20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYxKCgn6GNTu46Reub84dkigJlVxjwXJUvdOYm7r5Rmh/BlGD0tEXcMLjGriRwyG2r/PT4s2e2FCBvpk65/Pmwih+++l8pi6A81n6As3i2CtYdf3IKcSndDIEdt2Pfx3PK4dopGbWoJDZQa+Rp6SgNic9elgQGoWdeb+4hd/oCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YEYuYDEO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YEYuYDEO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CA216248E1;
	Mon, 19 Feb 2024 13:42:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gfqzMmU+77s/AeA69+J6l/YunPUnly5b88n31N
	EFa20=; b=YEYuYDEOio2rbjjpxobQpxjpM84LjDjdtds6Xrt0OfFmDp7SNkYSDA
	Ldq4wXu8O8RD87yZf4gso4vXdut8VLf4kD9ZHAoLfW1U7Kyc0b3p8VrAv2XOAeqY
	TByobJFJSxG2IIex8Bkay7qxHsZZxpm8Vn4CfwDG4/xf4qHO8VAu0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C2CE3248E0;
	Mon, 19 Feb 2024 13:42:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAD34248DF;
	Mon, 19 Feb 2024 13:42:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Jeff King <peff@peff.net>,  Linus Arver <linusa@google.com>,  Git
 mailing list <git@vger.kernel.org>
Subject: Re: [BUG] git commit --trailer --verbose puts trailer below
 scissors line
In-Reply-To: <ca6a73d3-58b4-e65c-4a8f-e6ddb3e86902@gmail.com> (Philippe
	Blain's message of "Mon, 19 Feb 2024 12:41:13 -0500")
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
	<20240217060434.GE539459@coredump.intra.peff.net>
	<ca6a73d3-58b4-e65c-4a8f-e6ddb3e86902@gmail.com>
Date: Mon, 19 Feb 2024 10:42:45 -0800
Message-ID: <xmqqfrxo9ty2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ACC56FB2-CF56-11EE-8E9D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Peff,
>> ...
>> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
>> index b5bf7de7cd..d8e216613f 100755
>> --- a/t/t7502-commit-porcelain.sh
>> +++ b/t/t7502-commit-porcelain.sh
>> @@ -485,6 +485,24 @@ test_expect_success 'commit --trailer not confused by --- separator' '
>>  	test_cmp expected actual
>>  '
>>  
>> +test_expect_success 'commit --trailer with --verbose' '
>> +	cat >msg <<-\EOF &&
>> +	subject
>> +
>> +	body
>> +	EOF
>> +	GIT_EDITOR=: git commit --edit -F msg --allow-empty \
>> +		--trailer="my-trailer: value" --verbose &&
>> +	{
>> +		cat msg &&
>> +		echo &&
>> +		echo "my-trailer: value"
>> +	} >expected &&
>> +	git cat-file commit HEAD >commit.msg &&
>> +	sed -e "1,/^\$/d" commit.msg >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>>  test_expect_success 'multiple -m' '
>>  
>>  	>negative &&
>
> Thanks for the test case!
>
> Philippe.

Thanks, both, for finding a rather unfortunate regression.  Perhaps
it is worth delaying 2.44 final by a week or so to include a fix (or
a revert if it comes to it).


