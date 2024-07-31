Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C135288B1
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461957; cv=none; b=IQDdhhWm9YQeEkV+j0jtltKFgZgVFH1bNhoqp1mso76Hf43Pxnf8fTRkyLgwJNrvgqUWbkXb0RI15RUXrTPol1K+8VeR20ABiKTZPAFpAFS9wabSMrce8gbtUbhCMJ1BVSEXkvjOtSc+Ab9kJkIJpMnms1bL7ZKv26IlTL+aYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461957; c=relaxed/simple;
	bh=EH6QTd3dV+uh+l9PZO1XHISIK9+EsgtgiDrFvCD940k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V1CoRDs9UChSSKXn1UhuvSTxZ+CZjGyD5khXxE0N6rvtRVajtPsXrXQkONMsoV8we+bkUeK+LslX1aHBUQwmYpyJlEcRg0Zi+TyIADC9W445MdW5KVq7noaR1ygmdghtH+Qq0vvCm96w7524jIG+SHgRfzgUvRTyllS32f+JrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dZylTjOC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZylTjOC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E7813C0A6;
	Wed, 31 Jul 2024 17:39:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EH6QTd3dV+uh+l9PZO1XHISIK9+EsgtgiDrFvC
	D940k=; b=dZylTjOCX2P6f06YH4TmpDlDbh4rVD8JhfQ4TNTngK9t+Krd3JCoLM
	Bfi0/JxvS75fFO+nBY/lBT3CMuudDUvMhggUSI9P+UPhfqcM8krB5C8W0iMdacyj
	jJ8bEnZI4LUQprJ8TglPMWOK5r2cTXjFgo0NXBJhqoivsCuET/ezw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 268643C0A5;
	Wed, 31 Jul 2024 17:39:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9057C3C0A4;
	Wed, 31 Jul 2024 17:39:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 2/3] Makefile: wire up the clar unit testing framework
In-Reply-To: <xmqqbk2d7ax9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	31 Jul 2024 10:01:38 -0700")
References: <cover.1722415748.git.ps@pks.im>
	<5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
	<xmqqbk2d7ax9.fsf@gitster.g>
Date: Wed, 31 Jul 2024 14:39:13 -0700
Message-ID: <xmqqmslx1bsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 54F0A4AA-4F85-11EF-929A-BAC1940A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> A trivial fix-up to be squashed into this step.

I won't be able to address this today, but "make sparse" and other
auxiliary targets also seem to break, due to their lack of
dependence on the generated clar.suite file.


