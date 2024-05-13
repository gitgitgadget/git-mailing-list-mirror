Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B61E4B3
	for <git@vger.kernel.org>; Mon, 13 May 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632394; cv=none; b=Je2/YiffvtC5VyeKeSGrD5HzZlaOo+C9fmfPsiSOypXAR1WhTuIC6dn2jf/BaXCZT1wvEtKceJEpFAI8Kuh/OAzQFbzrG6XioVAWdPZ11arXfAUoRcAaBhLr5ktDOTV8qGw8cMa0JQrfb2LMqb7syKnjodgzFmsf4Q4lazW54Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632394; c=relaxed/simple;
	bh=jkepXT03PvMg49vnAqaI4enn+TxXRaLxOvqZrZExCwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KHzxudQRdsvgP471705bIJ7KWuiGe0noNMVM6+mZgEsk0Rkj4KQZPtM7Db4qODhadFQN9pER7pSy/TmjibRgbKC7L5Ns4o5fyhePbJ06S+nbNOi+hvr+WQxedE56aIzg4axM24xo3AlS65adNcI5D0Wawi2aVfVnALqQiSg7eBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cwsPvqgv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cwsPvqgv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 339352813F;
	Mon, 13 May 2024 16:33:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jkepXT03PvMg49vnAqaI4enn+TxXRaLxOvqZrZ
	ExCwI=; b=cwsPvqgvC5kqU9rpacg6kWv6YYVpIqQ+ZbcgKZsfM1+BGvU+CyZ2kJ
	f2nVMI8V3RSNGecBm4sOkubX6FeN8gmLHlyXbQ58rjY5rTnGB4MjWAjgB/xQr/R4
	VLa9aRk+RemDCandl6HGD2KwCibEjn0dvEIHu1bgAi+We+bRnOz00=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B3472813E;
	Mon, 13 May 2024 16:33:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72ED52813D;
	Mon, 13 May 2024 16:33:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] t1517: test commands that are designed to be run
 outside repository
In-Reply-To: <CAO_smVg7mdQHp+sg4-vVUEOVRBEoZjqXZu=Kk8PuYc9mtYeMXg@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 13 May 2024 12:57:11 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240513192112.866021-1-gitster@pobox.com>
	<20240513192112.866021-3-gitster@pobox.com>
	<CAO_smVg7mdQHp+sg4-vVUEOVRBEoZjqXZu=Kk8PuYc9mtYeMXg@mail.gmail.com>
Date: Mon, 13 May 2024 13:33:09 -0700
Message-ID: <xmqqy18de9kq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 03813C02-1168-11EF-9A28-25B3960A682E-77302942!pb-smtp2.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> Do we only expect failure because of a temporary condition (the bug
> that is mentioned in the commit message)? If so, we should probably
> add a TODO, FIXME, or some other similar style of comment that
> describes that this should be fixed.

test_expect_failure is description enough for that purpose.

If a command should NOT work outside the project we will write a
test more like so:

	test_expect_success 'foo does not work outside' '
		... prepare that $cwd is outside ...
		test_must_fail git foo
	'
