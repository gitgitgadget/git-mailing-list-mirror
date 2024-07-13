Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE11B960
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861963; cv=none; b=c3/om7v73Js2UPjd+wRPT2ZG2jHsPve6dp9UonT+rkyCu9KlMQckH+8d2pGkj/dUdPBmfpw+q/3qXdxxA/1GJ77lLHeJdv+GL5TLWbjkvYSdVpZzgHIvMGf1KjDUeqA7mUuKhR1QMgVgyQEZiNqhcuEKUv7v++LDr9VGA1TX4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861963; c=relaxed/simple;
	bh=E02lVAgofGaoMGFUDuW3v95F+ubCMVqUK5qTICKVoaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGBBXGPBijXgrTD5+WWlIE+CJJ9aAnOVDSIMPGx/mTtZfLKdtojLWXH+AHrBblvGJ/E9e6UkeD0bGSQf7UPR8w/KSUGrayb49Ls9Ip6Ljxbr/p8R1/7C69Jk90A9md/xbRPCnypHWOsNccq6ya6s65cdYJHnLyjv+uLG/tVrhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sGXApxT3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sGXApxT3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C80841A01C;
	Sat, 13 Jul 2024 05:12:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E02lVAgofGao
	MGFUDuW3v95F+ubCMVqUK5qTICKVoaM=; b=sGXApxT3eNTqOQhYXclbhOovdJxe
	6IyY01BJwFjx1Htz3HRtL4JH25llX6Q6I9OsFbSosxVt2kLQMEsucPJMQfuLNaFX
	0wO8CmJmypINzcGM1c2+2r/BiqUEV0dkMd1BPZzwgkYcAaf32WtOTZMYibLOF5g2
	MozeZiSlda3NEpE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFC551A01B;
	Sat, 13 Jul 2024 05:12:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 379781A019;
	Sat, 13 Jul 2024 05:12:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] add-patch: render hunks through the pager
In-Reply-To: <ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sat, 13 Jul 2024 01:24:32 +0900")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
	<803b10ed-1cb3-4314-82c9-cf48d5d0bb90@gmail.com>
	<ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
Date: Sat, 13 Jul 2024 02:12:38 -0700
Message-ID: <xmqqsewdd5a1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0DFBC93A-40F8-11EF-AD25-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> What is huge_file doing and what happens to the single line of pager o=
utput?
>
> The huge file is to make sure we are receiving a SIGPIPE.  We don't
> really care about the line "head -1" produces, only that we don't
> break due to the SIGPIPE that occurs.

That deserves to be explained in the proposed log message, I think.

Thanks.

