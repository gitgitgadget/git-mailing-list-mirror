Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE815A49C
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566522; cv=none; b=dRrTjgvsSasP2givosNPbFHCs7wr7WmHmy5Zobqd3wX8EJvP3YUHCYWAPGy6MQjlJTHmfhFJx2uiuSkj+GcEVrY74xJNVyVcLKJrkrPWwtKRF6fXhEUrVHK00EBmF0JL4OAptNkXPGTYnrC54JXNHlPAO4NzArpD77SM6wDLy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566522; c=relaxed/simple;
	bh=X2vm+Xt2R7Pvmvox20eu3s1lGnTUoV6o8/iAXtViOJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rMyJoTulRAs6fymdFPE0PiUAbiB0a92xWAPF61jGL61mW73h7Su0MVgCCLPa6XEZ8GtZBmK05v08DzNWIYD7U+pYM27bIX/6MlgqGJ/WwbyfH70x8CZyC8dpvHxCG79mn3sZUbOc4WWcNTYbNW1UK+OexkP1cewT4bywNEYlVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PgH9u8TV; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PgH9u8TV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C7C2922843;
	Mon, 29 Jan 2024 17:15:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X2vm+Xt2R7Pv
	mvox20eu3s1lGnTUoV6o8/iAXtViOJ0=; b=PgH9u8TVgHGtaLeYuyNa6xsGZ/46
	BN8p6SuIZtJl7JeTgn+qhG4EniKm1JBq9w2dGy0TJ5QuSKhAH0YwnZ8swTlhyIrh
	jzK8+HjajuWj0XJyqxiX2Ycsu5vCKF05jULLm1xcNxCwhniRdvIwyjLwn+eVXGV7
	EzG+3zvzxbxnKso=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C09D322842;
	Mon, 29 Jan 2024 17:15:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 484C322840;
	Mon, 29 Jan 2024 17:15:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] t0080: mark as leak-free
In-Reply-To: <4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 29 Jan 2024 22:08:23 +0100")
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
	<4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com>
Date: Mon, 29 Jan 2024 14:15:15 -0800
Message-ID: <xmqqa5onhjm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E200B042-BEF3-11EE-9CF7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> This test is leak-free since it was added in e137fe3b29 (unit tests: ad=
d
> TAP unit test framework, 2023-11-09)
>
> Let's mark it as leak-free to make sure it stays that way (and to reduc=
e
> noise when looking for other leak-free scripts after we fix some leaks)=
.

For other tests in this series, that rationale is a very sensible
thing, but does it apply to this one?

The point of the t-basic tests is to ensure the lightweight unit
test framework that requires nothing from Git behaves (and keeps
behaving) sensibly.  The point of running t[0-9][0-9][0-9][0-9]
tests under leak sanitizer is to exercise production Git code to
catch leaks in Git code.

So it is not quite clear if we even want to run this t0080 under
leak sanitizer to begin with.  t0080 is a relatively tiny test, but
do we even want to spend leak sanitizer cycles on it?  I dunno.

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  t/t0080-unit-test-output.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
> index 961b54b06c..6657c114a3 100755
> --- a/t/t0080-unit-test-output.sh
> +++ b/t/t0080-unit-test-output.sh
> @@ -2,6 +2,7 @@
> =20
>  test_description=3D'Test the output of the unit test framework'
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  test_expect_success 'TAP output from unit tests' '
