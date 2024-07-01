Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5916F903
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865181; cv=none; b=iOnxqpiIFf3FlezcxuB+yvL1ak9XS4F5bUqm04fgArgxE2rs0B6g2Y1S9Ox84Z7K1bxfJ+MRurMtWeW2ZEriktoIEWqlooX7djmIFGsDeV/mERHRV53s2AubC8btJB1GXhpK4yc9/6vuBDl+QlLOvN8Y9IjJ6gsknEsIl5pHnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865181; c=relaxed/simple;
	bh=uUnr/dYZp52hJaPnqTqqA58esJL9rmHNngdi+I1RyUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvZCdYhLBKD1MdWhVP6jTf70VEA1XQAnWYwCzrf79yw4aVq2H3sTPq9Vzzvc+WaPR/M/JIKgiZNa3DuHXMmZS1GhouGdWz9QyU5MUSx+4TpNacn/XlHJEBDdYeeYutDq4BmC+MNmXSnGuVxHo8MCN0w2LE1X9UQcuZOZjPUdDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mxjz6fyw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mxjz6fyw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E2B462ABBE;
	Mon,  1 Jul 2024 16:19:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uUnr/dYZp52h
	JaPnqTqqA58esJL9rmHNngdi+I1RyUM=; b=mxjz6fywFduUOHQWoQF3EnMmegOR
	7b/wAcIc087kBwTZ2fJ8JcJO7b0PO6CE4hFBLk7vPlR/8F3EjAUE39QAIqqgGFBu
	ggcVWIEJIzQMKaNjaShiT9GAXFd7JaQV9S6oTwp6GtdKe9Nr5aBeWP9oJ9FNijtc
	XJqJIm/U5DziVsM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DB75E2ABBD;
	Mon,  1 Jul 2024 16:19:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 702B72ABBC;
	Mon,  1 Jul 2024 16:19:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
In-Reply-To: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 30 Jun 2024 08:42:06 +0200")
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
Date: Mon, 01 Jul 2024 13:19:34 -0700
Message-ID: <xmqqv81ovp9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3C8F1EBA-37E7-11EF-ABD7-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> In the if-else's chain we have in "check_test_results_san_file_", we
> consider three variables: $passes_sanitize_leak, $sanitize_leak_check
> and, implicitly, GIT_TEST_SANITIZE_LEAK_LOG (always set to "true" at
> that point).

Before this paragraph, we'd probably want to say what problem we are
fixing.  Using the verb "fix" on the subject line without saying what
broken behaviour you see around GIT_TEST_SANITIZE_LEAK_LOG does not
help, either.

Your patch from September 2023 [*] did mention it upfront:

    GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue with a test that leaks, will
    make the test return zero unintentionally.

With that inserted in front of the proposed log message, the
resulting explanation looks reasonable to me.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 79d3e0e7d9..7ed6d3fc47 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1269,9 +1269,12 @@ check_test_results_san_file_ () {
>  	then
>  		say "As TEST_PASSES_SANITIZE_LEAK=3Dtrue isn't set the above leak is=
 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck" &&
>  		invert_exit_code=3Dt
> -	else
> +	elif test "$test_failure" =3D 0
> +	then
>  		say "With GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue our logs revealed a memo=
ry leak, exit non-zero!" &&
>  		invert_exit_code=3Dt
> +	else
> +		say "With GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue our logs revealed a memo=
ry leak..."
>  	fi
>  }

This is outside the scope of this patch simply because it is
inherited from the original, but does ", exit non-zero!"  part of
the message really add any value?  I am wondering if

	else
-		say "With GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue ..., exit non-zero!"
+		say "With GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue our logs revealed a leak."
+		test "$test_failure" !=3D 0 || invert_exit_code=3Dt
	fi

might be what we eventually want to end up with, after the dust
settles from this fix.

Thanks.
