Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D279DC
	for <git@vger.kernel.org>; Wed, 29 May 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994446; cv=none; b=r1w6N0gOu0XK489g5Sp2hzL1VIA+90AKil9k1FHR3knOFLTqI2hjH4ICC9BPnw1SpjoXM1AcDz1k9L42aeLKTiu3/dojwEC6M0WEJYR8Qrq799IjnWeyD1n3I4ACmzvcQs4GHCZ0ysASS87j7OahyufirHFb+sk84BZ8bx8OyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994446; c=relaxed/simple;
	bh=ZvxkNXpoakWE4kzWJ/KgZBL2tR9Sw2ODVCWwbb/sslU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpyDuRNibHJv0pIwakqADsjnbGocjEltmxoBx6EPEdqZlku2eL15plGnNiSAPJvFB2n0GeiXODu+q4rHC4u92Wqj5Pm6k37kyYevTSXVJdZMzJVx7dDB6RRa4GuAu0FHRc2AkdjVi8qRGhAvWZaRAbVk3Rj8hJyHI1TOdMPsrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FhpEhv0J; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FhpEhv0J"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5011228C0;
	Wed, 29 May 2024 10:54:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZvxkNXpoakWE4kzWJ/KgZBL2tR9Sw2ODVCWwbb
	/sslU=; b=FhpEhv0JmCVoatYmrwQRKrh0sC80yD5BKK0D0FpvMmt9rsdn0oPf5f
	7O9qJC6k+ahi5ibujkUHt4QBdmPQorq1ogefdM2noLJEebgfz3+KYsypkPPSQyc8
	kzJQRXBW8FFo/atzAz5kdeVGN/k5z7E+DlFUwwo4i/GkburIQml/k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B831F228BF;
	Wed, 29 May 2024 10:54:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 014A5228BD;
	Wed, 29 May 2024 10:54:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  ach.lumap@gmail.com,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,
  git@vger.kernel.org,  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v4 2/2] t/: migrate helper/test-{sha1, sha256} to
 unit-tests/t-hash
In-Reply-To: <ZlbKkMfmWFw59aO8@tanuki> (Patrick Steinhardt's message of "Wed,
	29 May 2024 08:26:24 +0200")
References: <20240523235945.26833-1-shyamthakkar001@gmail.com>
	<20240526084345.24138-1-shyamthakkar001@gmail.com>
	<20240526084345.24138-3-shyamthakkar001@gmail.com>
	<ZlbKkMfmWFw59aO8@tanuki>
Date: Wed, 29 May 2024 07:54:01 -0700
Message-ID: <xmqqed9k1xfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A156066-1DCB-11EF-BB65-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	for (int i = 1; i < ARRAY_SIZE(hash_algos); i++) {
>
> s/int/size_t/

If ARRAY_SIZE(hash_algos) is an unbounded quantity that is
externally controlled, this does make very much sense, but for
hash_algos[]?  It is not worth the patch noise to go and fix it.

>> +#define TEST_HASH_STR(data, expected_sha1, expected_sha256) \
>> +	{ \
>
> These macros should like start with `do {`. The reason why we do this is
> that the compiler will complain if there is no semicolon after the macro.

The idiom is

	#define foo(a,b,c) do { \
		...; \
	} while (0)

so that you can write

	foo(1,2,3);

as if it is a regular function call terminated _with_ a semicolon.
Also this allows us to say

	if (condition)
		foo(1,2,3);
	else
		foo(4,5,6);

which would break if the definition were a mere

	#define foo(x,y,z) { \
		... \
	}

in which case ";" after the first foo() terminates the "if" statement
and "else" triggers a syntax error.

>> +	TEST_HASH_STR(
>> +		"", "da39a3ee5e6b4b0d3255bfef95601890afd80709",
>> +		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
>
> I think these might've been a bit easier to read if they formatted like
> this:
>
> 	TEST_HASH_STR("",
> 	    "da39a3ee5e6b4b0d3255bfef95601890afd80709",
> 	    "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
>
> 	TEST_HASH_STR("a",
> 	    "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
> 	    "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");

Oh, absolutely.
