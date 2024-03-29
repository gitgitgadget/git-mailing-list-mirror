Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FF135A50
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734017; cv=none; b=K79pJMjCeKWsL4ZByhfvc0n/QcddtQvIZOo6JxdEC2Xqe4NpE3iFTB6fRCmEDV1G9z20t6SBdFGcz93PSxAlh5tLKh9hKNEP2eAl68l22gyc8fFlD3VXA5wyDh+tGd7MmqAbm0IdlnaFhWrXQVwdQ71TUpw9/u4/6IZ3rvTOOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734017; c=relaxed/simple;
	bh=ndZm6O9Huj3iiepe+QKujdsNZaj6FZotDOp//rkuyFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7KZg26erPucXE4974CczYw2LcvcCRYTrZ2+d4oamCbPjpAuCsw91gs8Ofho8401bNFTy8N/w1KOAma1NkfIgojxGYvu1b3PzvXenAMV6dT6P85jvXmddBPHxUIQYeZWV2jguSv9w9DJLkokS1ni4sT5xBjo4nn1i4F2y8dsKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dHx0S1cR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dHx0S1cR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A66226704;
	Fri, 29 Mar 2024 13:40:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ndZm6O9Huj3i
	iepe+QKujdsNZaj6FZotDOp//rkuyFQ=; b=dHx0S1cRRcZ5DQMnrmW5dIkl3GIv
	6KGezBiQc+9W2MBIwr8++4EQqQzXJ18yEm/3h5/tcnJ/WZfG/u0qt431R6W50UP3
	dKs4YWPqk9Dt7eFR6YRtxAkjBNIqBxFtNCptkFxSTqQqntwFyjdP4EyqfGVnRAqV
	C6xBs3ScPFHeZxY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 83DBD26703;
	Fri, 29 Mar 2024 13:40:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 189E626702;
	Fri, 29 Mar 2024 13:40:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
In-Reply-To: <37f79186-b849-496a-ae91-f5e05a280dae@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 29 Mar 2024 05:19:03 +0100")
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
	<37f79186-b849-496a-ae91-f5e05a280dae@gmail.com>
Date: Fri, 29 Mar 2024 10:40:05 -0700
Message-ID: <xmqqv855ym16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 61F1BEB2-EDF3-11EE-9C56-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> -		if (advice_enabled(ADVICE_ADD_IGNORED_FILE))
> -			advise(_("Use -f if you really want to add them.\n"
> -				"Turn this message off by running\n"
> -				"\"git config advice.addIgnoredFile false\""));
> +		advise_if_enabled(ADVICE_ADD_IGNORED_FILE,
> +				  _("Use -f if you really want to add them."));

Good.

>  		exit_status =3D 1;
>  	}
> =20
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index f23d39f0d5..76c2c9e7b0 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -370,8 +370,7 @@ cat >expect.err <<\EOF
>  The following paths are ignored by one of your .gitignore files:
>  ignored-file
>  hint: Use -f if you really want to add them.
> -hint: Turn this message off by running
> -hint: "git config advice.addIgnoredFile false"
> +hint: Disable this message with "git config advice.addIgnoredFile fals=
e"

Funny that we weremanually crafting the hint to turn it off.  Nice
to see that code go.

>  EOF
>  cat >expect.out <<\EOF
>  add 'track-this'
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 00c1f1aab1..5c4a89df5c 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -212,8 +212,7 @@ test_expect_success 'submodule add to .gitignored p=
ath fails' '
>  		The following paths are ignored by one of your .gitignore files:
>  		submod
>  		hint: Use -f if you really want to add them.
> -		hint: Turn this message off by running
> -		hint: "git config advice.addIgnoredFile false"
> +		hint: Disable this message with "git config advice.addIgnoredFile fa=
lse"
>  		EOF
>  		# Does not use test_commit due to the ignore
>  		echo "*" > .gitignore &&
