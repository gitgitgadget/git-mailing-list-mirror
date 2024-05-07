Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68390E570
	for <git@vger.kernel.org>; Tue,  7 May 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103022; cv=none; b=kiWiooqFY2y8pZK2zjBYlCEljEn5+Nu1b/0HMd606q3QoZBOQd2sr4FEVGrxzlD32MQcYkMTf+s6QWLtWWWPZReRboz2O8+f8eGJBLrcZ+A9ZUupgiogVKQUcgCZgV7VxP9H7/QkEs7Z+zakstU7Sf0ox4/u2z5zyFXzK4QeiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103022; c=relaxed/simple;
	bh=Nfmtd92yo0IVejkF+HVr4utHlGrnFe7LWsWDYi2jETg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5fVDWGKS3GNKv/EpxaEHvRwb9DbcYI7xtJcfo3Iljlepwc+afALQa+J8z0dRJ2Gs1JIVLcfk8fH1MTlgTIxexViUuvdMBcrIsE6rQPL6VHzH0PsKqIy2UAy7vojuy/1XFEGr9hesio6tGl54MElPD9VgHyaRte50n60bHqg8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pIoed8Uq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pIoed8Uq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 06D7D35CAE;
	Tue,  7 May 2024 13:30:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Nfmtd92yo0IV
	ejkF+HVr4utHlGrnFe7LWsWDYi2jETg=; b=pIoed8UqG4dH7KWW4XAg5SV4WUg2
	eG4Qc0qf+FozpcV3b5eq7k9UDGqyG/gfd/iLwMnFfDIHIMSQwMGIvhI++qzrH6L9
	vxfarHxPi5TDHSeFnEwRLe3bEf2QMslrb25QdxvFwQp4U9wd7+1esLe/ap5ig0FQ
	asA7+l0YNxlukJ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F3C1335CAD;
	Tue,  7 May 2024 13:30:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85C0C35CAA;
	Tue,  7 May 2024 13:30:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v1 1/2] t0050: ls-files path fails if path of workdir is
 NFD
In-Reply-To: <20240507084429.19781-1-tboegi@web.de> (tboegi@web.de's message
	of "Tue, 7 May 2024 10:44:29 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240507084429.19781-1-tboegi@web.de>
Date: Tue, 07 May 2024 10:30:16 -0700
Message-ID: <xmqq1q6dpm1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 78A7B11C-0C97-11EF-9C0D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Add a test case for this bug report, slightly edited and shortened:
>
> ls-files path' fails if absolute path of workdir contains NFD (macOS)
> On macOS, 'git ls-files path' does not work (gives an error)
> if the absolute 'path' contains characters in NFD (decomposed).
> I guess this is a (minor) bug of git.
>
> $ cd /somewhere         # some safe place, /tmp or ~/tmp etc.
> $ mkdir $'u\xcc\x88'    # =C3=BC in NFD
> $ cd =C3=BC                  # or cd $'u\xcc\x88' or cd $'\xc3\xbc'
> $ git init
> $ git ls-files $'/somewhere/u\xcc\x88'   # NFD
>   fatal: /somewhere/=C3=BC: '/somewhere/=C3=BC' is outside repository a=
t '/somewhere/=C3=BC'
> $ git ls-files $'/somewhere/\xc3\xbc'    # NFC
> (the same error as above)
>
> In the 'fatal:' error message, there are three =C3=BC;
> the 1st and 2nd are in NFC, the 3rd is in NFD.
>
> The added test case here follows the error description,
> with the exception that the '=C3=BC' is replaced by an '=C3=A4',
> which we already have as NFD and NFC in t0050.
> A fix will be done in the next commit.

That will break bisection.  I think combining the two commits into
one would make sense for a small change like this, consisting a
focused and straight-forward fix plus a clean and concise test.

> Reported-by: Jun T <takimoto-j@kba.biglobe.ne.jp>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/t0050-filesystem.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 325eb1c3cd..bb85ec38cb 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -156,4 +156,16 @@ test_expect_success CASE_INSENSITIVE_FS 'checkout =
with no pathspec and a case in
>  	)
>  '
>
> +test_expect_success 'git ls-files under NFD' '
> +	(
> +		mkdir somewhere &&
> +		mkdir somewhere/$aumlcdiar &&

Would a single "mkdir -p" suffice?

		mkdir -p "somewhere/$aumlcdiar" &&

> +		mypwd=3D$PWD &&
> +		cd somewhere/$aumlcdiar &&
> +		git init &&
> +		git ls-files "$mypwd/somewhere/$aumlcdiar"  2>err &&

We do not control what is in "$mypwd".  Can it have funny characters
that can confuse Git?  Quoting the path with a pair of double quotes
protects the shell from getting confused with $IFS whitespaces, but
we may want to protect the pathspec handing in Git with something
like

	git --literal-pathspecs ls-files "..."=20

here.

> +		>expected &&
> +		test_cmp expected err
> +	)
> +'
>  test_done
> --
> 2.41.0.394.ge43f4fd0bd
