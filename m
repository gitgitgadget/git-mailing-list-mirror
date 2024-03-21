Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E185660
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041167; cv=none; b=fsEmC+b0iN4MtjYVfx5Qm20s33sGPpE0RB+fOUPWFPU+lHZxOGEyiq8K0sGQdwIvTYWdzvzpDzmnmiwpwUpZ84TaI8K9Zb3NH3YgITvO3Wb8jwXciHXSctfeampYrRZGKIHmHYvTS4+M6WI+61Hrdk++K5tCkIqR2qg0uDAzzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041167; c=relaxed/simple;
	bh=duSvRDPiu2t+zl4+4gtPXTb4tXJVQVGN2UXY/MNiRk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vyy3GvCcaFxSAowvoTlb2MHCx0XsODCxLXnrNAloO1XtJsnxPN1LbL/QEEptXxABWWqdrLlNi0w6NIJEsgqXF9nRm8mQHRE+EjGwDtOII22QHfj3/pl/D21+Ckj9elwo5By1SrH32AuaLuFW6mkE6xG56tGCkZpk1dt7hsRfxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ja4b6uTY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ja4b6uTY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C4642C679;
	Thu, 21 Mar 2024 13:12:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=duSvRDPiu2t+zl4+4gtPXTb4tXJVQVGN2UXY/M
	NiRk8=; b=Ja4b6uTYy/2An04TQVQs0OljkkWZ77YYBVEnc87/iEMTcOg9d6bgjR
	oPHK6jS/kbLWjDLREsCzdkN4SVCPbdKzkBG/pLPk7lHbkZLEkgUlMGizXvijeRJ1
	Q4LfhsbsAtcfdcwRMdGWTkuNAmtrRWxGXR29BIthnoUK8DVR/J2Uc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2583D2C678;
	Thu, 21 Mar 2024 13:12:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A320B2C677;
	Thu, 21 Mar 2024 13:12:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] t/README: document how to loop around test cases
In-Reply-To: <326fb7965036fccc1c23ad02f200251f6388e6dd.1711028473.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 Mar 2024 14:47:33 +0100")
References: <cover.1711028473.git.ps@pks.im>
	<326fb7965036fccc1c23ad02f200251f6388e6dd.1711028473.git.ps@pks.im>
Date: Thu, 21 Mar 2024 10:12:40 -0700
Message-ID: <xmqqzfur8q5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 39E2F2AE-E7A6-11EE-9140-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In some cases it makes sense to loop around test cases so that we can
> execute the same test with slightly different arguments. There are some
> gotchas around quoting here though that are easy to miss and that may
> lead to easy-to-miss errors and portability issues.
>
> Document the proper way to do this in "t/README".
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/README | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/t/README b/t/README
> index 36463d0742..d56401a254 100644
> --- a/t/README
> +++ b/t/README
> @@ -721,6 +721,25 @@ The "do's:"
>     Note that we still &&-chain the loop to propagate failures from
>     earlier commands.
>  
> + - Repeat tests with slightly different arguments in a loop.
> +
> +   In some cases it may make sense to re-run the same set of tests with
> +   different options or commands to ensure that the command behaves
> +   despite the different parameters. This can be achieved by looping
> +   around a specific parameter:
> +
> +	for arg in '' "--foo"
> +	do
> +		test_expect_success "test command ${arg:-without arguments}" '
> +			command $arg
> +		'
> +	done
> +
> +  Note that while the test title uses double quotes ("), the test body
> +  should continue to use single quotes ('). The loop variable will be
> +  accessible regardless of the single quotes as the test body is passed
> +  to `eval`.

We also want to say that they are not equivalent, don't we?

        for var in '' a 'b"c'
        do
                test_expect_success "with dq <$var>" "
                        echo \"$var\"
                "
        done

breaks, but if we use

                test_expect_success "with sq <$var>" '
                        echo "$var"
                '

in the loop, it works as expected.

Other than that, all three patches do make sense.

Thanks.
