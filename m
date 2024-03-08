Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAD1D699
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937386; cv=none; b=oN3937KjVk6APA2hYzRUyF+RyphJUnoChRh3cfkimiuzAqssUoEGotfu3spUp2uHIXRTrL1gj3B+54b9CfUar8iYvKTb5R9PuSBjTZ6/kC4UBvJSfp7tQuaAOCdkTL7mlwbc9eBK9QUzfb0ejdEIZdLxDxPNITxh1W1vsGJk8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937386; c=relaxed/simple;
	bh=/p+fe/gVLDSiZz3BqMjRAgwkjrqNlP0OImjDc/7VozY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rh2SvtpEt9Nri0soLtXU2Mcjv+KjcnfZvigmjN+4d4RdiLhU0NuTaf64ca4Qo8BIX3jlyrHz9CRZ3hm1+LugEGq1zV1W2UqVWqkIA4676wYPVqO4IaUeAa0jHH7G/ny/4fU+ykx6QR3cqSBH9nUcjb9xyZtTAA7Xrq/p9ZYx8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LU5NL4fM; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LU5NL4fM"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 075AE1E2E68;
	Fri,  8 Mar 2024 17:36:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/p+fe/gVLDSi
	Zz3BqMjRAgwkjrqNlP0OImjDc/7VozY=; b=LU5NL4fMHBJN93O8M8HdovlozN0y
	Xjw0fhUN/rrdYn+Q7Xq51/E08KOfZ396yMbj6qavQsMEuycNJBopYoGFU4IgaBhB
	VxrOCS4fJBrctkLKx2Qc7cv20PYGUh7jTRK0orhbCgJq0aMOLA0ZAsMKo3/caUMM
	aDb1rH1P94NKGxE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F387B1E2E67;
	Fri,  8 Mar 2024 17:36:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 636C61E2E66;
	Fri,  8 Mar 2024 17:36:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  =?utf-8?Q?Jean-?=
 =?utf-8?Q?R=C3=A9my?= Falleri
 <jr.falleri@gmail.com>
Subject: Re: [PATCH v2] git-difftool--helper: honor `--trust-exit-code` with
 `--dir-diff`
In-Reply-To: <20240308221229.GA1908@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Fri, 8 Mar 2024 23:12:29 +0100")
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
	<0fac668f8fc021af9f9c4df5134da59816307ccc.1708423309.git.ps@pks.im>
	<20240308221229.GA1908@szeder.dev>
Date: Fri, 08 Mar 2024 14:36:22 -0800
Message-ID: <xmqqcys4fj15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4AC681BC-DD9C-11EE-815D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> -test_expect_success 'difftool honors exit status if command not found=
' '
>> -	test_config difftool.nonexistent.cmd i-dont-exist &&
>> -	test_config difftool.trustExitCode false &&
>> -	test_must_fail git difftool -y -t nonexistent branch
>> -'
>> +	test_expect_success "difftool ${opt} honors exit status if command n=
ot found" "
>> +		test_config difftool.nonexistent.cmd i-dont-exist &&
>> +		test_config difftool.trustExitCode false &&
>> +		if test "${opt}" =3D '--dir-diff'
>
> The quoting doesn't quite work here.

Thanks for looking at them carefully.

In general, when you want to interpolate an variable that exists
outside test_expect_success, you should write it this way:

	for var in a "b c"
	do
		test_expect_success "message with $var interpolated" '
			command and "$var" as its argument
		'
	done

The last parameter to test_expect_{success,failure} is eval'ed, so=20
enclose it within a pair of single quotes, and let the eval to
interpolate references to $variables at runtime (as opposed to when
the parameters to test_expect_success are formulated) avoids a lot
of surprises and headaches.

Perhaps we should have something like the above as a hint in
t/README?
