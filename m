Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43075130AC8
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733318; cv=none; b=lGjB4ge7IwsCfSGgbc93/VUqh2xyRj0chi2GE/RqaGt4T2hvmOsiSHDJz+1mBmYUwAjKQBIdLt9M8W4/kKk23rLCyvF3WNX8vkgeRMbWRqBrPlqAWKaJFBGHu2U2kuzDAlPesq4OfkQTZLsCt9HMArN+Z1p7w+F2VTHKAQZ6Npc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733318; c=relaxed/simple;
	bh=ysw+ZItk82KG9nn8wp8r3ZSxwTlfUGuZhmk03gXOtYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6UZgYeEr+R1KdZsjBGhmlbSY2SjTQRfO1fI03uPdrgKJu41T3dWACJSPDSSRfdkdx+qUck5shC6RxcQO+ujMLkZdu9mFrdHhTB3+Dg/tcHvlgb2eL33mOOr9iFhHrcpdA2rv2bV/Jr11r8bBmBtqMC30V89h5/mszsp5TaD2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iaKAuSP1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iaKAuSP1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 131CD1E5D44;
	Fri, 29 Mar 2024 13:28:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ysw+ZItk82KG
	9nn8wp8r3ZSxwTlfUGuZhmk03gXOtYk=; b=iaKAuSP1/k20FUM2GiMQzvoJqEu2
	yhFVlc9PeGXH6tTs0/aAJmnFyfBo1bciKAvOJqck3+RrB4EXOBIJpyBCsx+ox6yb
	a2gyYmJCUxHBGh9BDFzpfj8KRJdNYAj9MheehkKOkGV/Cilgk8raiqshCrMGkLl/
	Dk/uaBnWJr7BKsA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 09CBB1E5D43;
	Fri, 29 Mar 2024 13:28:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7395A1E5D42;
	Fri, 29 Mar 2024 13:28:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] add: use advise_if_enabled
In-Reply-To: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 29 Mar 2024 05:14:53 +0100")
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Date: Fri, 29 Mar 2024 10:28:34 -0700
Message-ID: <xmqq1q7t0wxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C5B496BA-EDF1-11EE-8D3E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> This series is a simple change, in builtin/add.c, from:
>
> 	if (advice_enabled(XXX))
> 		advise(MMM)

I wonder if a coccinelle rule can automatically identify and rewrite
these ...

>
> to the newer:
>
> 	advise_if_enabled(XXX, MMM)

... to this form automatically.
