Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33C944F
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166714; cv=none; b=KuYgt+uPvNqTodCP/U+XzUQtdmUSfPq+faEifSeo9DJtB4q1MMWFs7qLQqAQYpP+w1l+NloEMWitMXPycm/SydsKGXdZOnV/annvTKiv8fk9kjNfwUw0MeRHN9oAJEYetIsb5tMsMvKOpUUSVpxynUy805dD/GHA/JtRwn28iL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166714; c=relaxed/simple;
	bh=SrflohcswyNutySy8Da5u+tAWky6uJOQYcPGXNZ/2tU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lsx+1SZTeOop6B7sXw8bBOTfEzXN5qwXPah6Pq0c/UZHUEhCbaxPb60rUlyajQhLAhs8pj2DYIA+u+D5kG2QCXpWO5Itllj7ZF1uyrq4PqdEF+j+np+kmOKAt4NAetAu7HvMQ0xrAWO8u7rs7BBa6AVTICFRafT8bsMToNcKF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gLI67NVC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gLI67NVC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 41DC027732;
	Thu,  8 Aug 2024 21:25:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SrflohcswyNu
	tySy8Da5u+tAWky6uJOQYcPGXNZ/2tU=; b=gLI67NVCPBLSHr8qEUQCwQIaWEgq
	HsFryx+49+WpbddDK9hWBSPdFF+64CMIAYKZq/8ErCquVgx00w/+5ZrDLS3PoJ2c
	2U+2LCrYsrl1wV6VfvJ0XYHptFaCcpIXmi35TEEW6MGN8GxEGcKd2OA9vgUhdgM8
	zhTKMbXaygdnymw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BCDA27731;
	Thu,  8 Aug 2024 21:25:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C5EB327730;
	Thu,  8 Aug 2024 21:25:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tests: drop use of 'tee' that hides exit status
In-Reply-To: <93e6fdd3-4a15-4cc5-929a-aa5e79f44e1c@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 9 Aug 2024 02:37:29 +0200")
References: <xmqq4j7uhfvm.fsf@gitster.g>
	<93e6fdd3-4a15-4cc5-929a-aa5e79f44e1c@gmail.com>
Date: Thu, 08 Aug 2024 18:25:07 -0700
Message-ID: <xmqqjzgqfpxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3730811E-55EE-11EF-85E2-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> In none of these tests, I do not see a reason why we want to hide a
>
> This double negative caught my attention.  The message is
> understandable; perhaps "In none of these tests I see ..." would have
> been clearer.

You're absolutely right, and it is not just "would have been
clearer"---your fix makes a nonsense double-negation into a correct
sentence.  I'd go with "In any of ... I do not see" while queuing.

Thanks.
