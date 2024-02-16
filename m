Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD3133410
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107159; cv=none; b=oUhvhGHr+hGE4y6eUAkewUi9pa2GoZFOozCXi4tAxWhER1qkoHepUtSFT3LUOgtAEDSbBlDYaNMbBjMhQSeVAP+0evVAqFLBwBJgype3Hndn1x2yFBk1z81XS0Dzn3tQikCKVti6F6FySZ07itzmz2vKpN4hD4qN5+jWbG/EEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107159; c=relaxed/simple;
	bh=hstUD3/fAz9ItAL2W4KcskQFqJfJgEkdSJB12Wi62b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GXldtuNgl2zW2b4qAPoOlsjfZGYvK+4+K14wS2Fyavz3vWG5okZZzwUPWvo/oXpenkTP3asK4RUap55hx8j5Nmc4Ni+np2BlT4xMUarpGIkm4yBpzlq/myc7jNbrQt5df5vC4sDXAoTNAaNQw4PsN5uTYOGIyfUsUk0PFihaE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ft/tWAVA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ft/tWAVA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5761235188;
	Fri, 16 Feb 2024 13:12:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hstUD3/fAz9I
	tAL2W4KcskQFqJfJgEkdSJB12Wi62b0=; b=ft/tWAVAvoY5of+UC02npgIpqVCH
	f4J2cKzm8U05vd2SZ8Sfr7KyX++J4wMJL7hjXGvn96cNCOWueswKo4r3p7AQZaJE
	7MajwWLP2K38zZifwRKFJM45Qrh7Ef2WQUVqrQFCW2ssYDAEweB6/17b7UB5j1Nu
	y3dSW0T3sBwBO8k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F4D735187;
	Fri, 16 Feb 2024 13:12:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C844B35186;
	Fri, 16 Feb 2024 13:12:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-R=C3=A9my?= Falleri
 <jr.falleri@gmail.com>, David
 Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] git-difftool--helper: honor `--trust-exit-code` with
 `--dir-diff`
In-Reply-To: <c071e44c52171b9b19a04d91666be48d762d19bf.1708072576.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 16 Feb 2024 09:39:18 +0100")
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
	<c071e44c52171b9b19a04d91666be48d762d19bf.1708072576.git.ps@pks.im>
Date: Fri, 16 Feb 2024 10:12:32 -0800
Message-ID: <xmqqttm8i8hb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F4EEA1D0-CCF6-11EE-A2FE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> The `--trust-exit-code` option for git-diff-tool(1) was introduced via
> 2b52123fcf (difftool: add support for --trust-exit-code, 2014-10-26).
> When set, it makes us return the exit code of the invoked diff tool whe=
n
> diffing multiple files. This patch didn't change the code path where
> `--dir-diff` was passed because we already returned the exit code of th=
e
> diff tool unconditionally in that case.
>
> This was changed a month later via c41d3fedd8 (difftool--helper: add
> explicit exit statement, 2014-11-20), where an explicit `exit 0` was
> added to the end of git-difftool--helper.sh. While the stated intent of
> that commit was merely a cleanup, it had the consequence that we now
> to ignore the exit code of the diff tool when `--dir-diff` was set. Thi=
s
> change in behaviour is thus very likely an unintended side effect of
> this patch.
>
> Now there are two ways to fix this:
>
>   - We can either restore the original behaviour, which unconditionally
>     returned the exit code of the diffing tool when `--dir-diff` is
>     passed.
>
>   - Or we can make the `--dir-diff` case respect the `--trust-exit-code=
`
>     flag.
>
> The fact that we have been ignoring exit codes for 7 years by now makes
> me rather lean towards the latter option. Furthermore, respecting the
> flag in one case but not the other would needlessly make the user
> interface more complex.
>
> Fix the bug so that we also honor `--trust-exit-code` for dir diffs and
> adjust the documentation accordingly.
>
> Reported-by: Jean-R=C3=A9my Falleri <jr.falleri@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

Sounds sensible.

The last time David was on list seems to be in April 2023; just in=20
case let's CC him for an Ack (or something else).

>  Documentation/git-difftool.txt |  1 -
>  git-difftool--helper.sh        | 14 +++++
>  t/t7800-difftool.sh            | 99 ++++++++++++++++++----------------
>  3 files changed, 68 insertions(+), 46 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftoo=
l.txt
> index c05f97aca9..a616f8b2e6 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -105,7 +105,6 @@ instead.  `--no-symlinks` is the default on Windows=
.
>  	`merge.tool` until a tool is found.
> =20
>  --[no-]trust-exit-code::
> -	'git-difftool' invokes a diff tool individually on each file.
>  	Errors reported by the diff tool are ignored by default.
>  	Use `--trust-exit-code` to make 'git-difftool' exit when an
>  	invoked diff tool returns a non-zero exit code.
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index e4e820e680..09d8542917 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -91,6 +91,20 @@ then
>  	# ignore the error from the above --- run_merge_tool
>  	# will diagnose unusable tool by itself
>  	run_merge_tool "$merge_tool" false
> +
> +	status=3D$?
> +	if test $status -ge 126
> +	then
> +		# Command not found (127), not executable (126) or
> +		# exited via a signal (>=3D 128).
> +		exit $status
> +	fi

So these errors spawning the tool backend are always reported,
regardless of the trust-exit-code settings.  OK.

> +	if test "$status" !=3D 0 &&
> +		test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" =3D true
> +	then
> +		exit $status
> +	fi

I found this somehow harder to reason about than necessary.  Just

	if test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" =3D true
	then
		exit $status
	fi

would have been a more straight-forward expression of what we want
to happen here, i.e. "if we are told to report the tool's exit
status, we do so, regardless of what the exit status is".

Not that the construct in your patch is wrong---we will exit with 0
at the end even when "trust-exit-code" thing is true and the tool
returned success.
