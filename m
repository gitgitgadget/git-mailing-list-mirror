Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34191422CF
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037230; cv=none; b=MV9kLIm8Hv0msxKsOha0Ej8WC//lt3e64AwWf79uv8ciCf8S+rRtCLPVvz5jdHx9O6oxRiF1GqLNeu0neIMx+f0QZvwa+9NF6ybooAGGzGa320KUD7AmNMVkG6BugS+mwNmCkFDd3XUYG2zOLXgWPnkRpVhDxc0ch6lCVp79Nzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037230; c=relaxed/simple;
	bh=PWoZxJkI/kQtR2TTIShO9OyfUZceMXqKG26DeFl+2pI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLclUKrlXvoFsF9EzB6iXBm5I6/j6G8EITopXUBQ9OoCQdCjmq7CDPTxTIRuB5MMAyDBUf2shZiM7ap88ivUn09Tpu2dfydw3wSLDqxUkyMgjzPiI0m9Fl3fXr3a15FMZgnmBIh6CwNokAjHYov1oOevNWQrm9S8ZCorMTb+hJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n/XebSco; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n/XebSco"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B3341E379;
	Mon, 10 Jun 2024 12:33:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PWoZxJkI/kQt
	R2TTIShO9OyfUZceMXqKG26DeFl+2pI=; b=n/XebScoFz0cxyCzvv+BVilnb+QT
	AcrpeeQIfkoOXFOfpU9vRjqOJJF7ui1p6Ig5bixms3dpyAqlDoHNxtnFaeNz8KEZ
	e3BE37KhT8Kj5+9LHgHw08J0KAwf79NW/5NDXEz6gVCer3yV/0M843CwXYOPOU2R
	yLYyXr4xTHJjdkw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 237431E378;
	Mon, 10 Jun 2024 12:33:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2E301E373;
	Mon, 10 Jun 2024 12:33:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,  German Lashevich <german.lashevich@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 1/3] t4020: test exit code with external diffs
In-Reply-To: <79a951f8-cf35-4159-a90e-f95d69773413@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 9 Jun 2024 09:38:24 +0200")
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>
	<e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
	<168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
	<79a951f8-cf35-4159-a90e-f95d69773413@web.de>
Date: Mon, 10 Jun 2024 09:33:43 -0700
Message-ID: <xmqqmsns4v14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 34812372-2747-11EF-AD17-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> +check_external_diff () {
> +	expect_code=3D$1
> +	expect_out=3D$2
> +	expect_err=3D$3
> +	command_code=3D$4
> +	shift 4
> +	options=3D"$@"

Tiny nit, but I'd prefer to see "$@" reserved for its magic and all
other times where it is equivalent to "$*", see the latter used.

Other than that, all three patches looked good to me.  Thanks.
