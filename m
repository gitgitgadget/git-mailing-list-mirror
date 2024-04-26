Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC81173F
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159906; cv=none; b=fqR8ono4KRSSRk+lTfJrziEzy3z8QI2cVzNFUtnQhQaIPEOENej4ZoE7sXTTxOsbvl00sqCP7N5KvBwU8503D4GxCvaJNTOWQF68p4wCRobXSrgJRuVXrND2EhJ44S3eNnJCmh1O9tJQan5bCk2nZl0vhE+M302QwTf+gI8D+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159906; c=relaxed/simple;
	bh=Lc94BwUr/slWlrgDIHTACEj96GwLSi/0r1HVsAy/iz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gp79A5a5rWQ1FdnN5/uJ3r/uebCHLV6CKZZLMIx/Nl9nAx1Z2BNbI9ad8+BokXf2qu4Ljen/rN2mwsc4271qPJXD9F2Uk0Ur6dbyDaF9McrGUNQaPuRonSmo1KspVmZKJiSlw5axhPcpcCCdrc0XNoDPrgtOIl0j969ctTxiduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xgi1R07G; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xgi1R07G"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 26C1A2CE52;
	Fri, 26 Apr 2024 15:31:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Lc94BwUr/slWlrgDIHTACEj96GwLSi/0r1HVsA
	y/iz4=; b=xgi1R07GZiGK1zGUuRGTcCphLqDaXJ0hqsf/+xDI3yP+H1LeFvXjtR
	0GaAbtC8TGcF/t5RAH6bx+XSSGHoZllqrzyw0przLqXcYx8aCNn9labIqn6gUPFx
	DzE40crfqylnE03PTNLteyt2nnN73OyS3huV6L9otlq6WiWYzP4TI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D7B32CE51;
	Fri, 26 Apr 2024 15:31:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83CA92CE50;
	Fri, 26 Apr 2024 15:31:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
In-Reply-To: <20240426152449.228860-2-knayak@gitlab.com> (Karthik Nayak's
	message of "Fri, 26 Apr 2024 17:24:43 +0200")
References: <20240423212818.574123-1-knayak@gitlab.com>
	<20240426152449.228860-1-knayak@gitlab.com>
	<20240426152449.228860-2-knayak@gitlab.com>
Date: Fri, 26 Apr 2024 12:31:36 -0700
Message-ID: <xmqq1q6rc44n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9953A534-0403-11EF-A550-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
> Subject: Re: [PATCH v4 1/7] refs: accept symref values in `ref_transaction[_add]_update`
>
> The `ref_transaction[_add]_update` functions obtain ref information and
> flags to create a `ref_update` and add it to the transaction at hand.

Just a very minor irritation, but ref_transaction_add_update() is a
function used internally in the ref subsystem and is exported only
because its visibility needs to cross file boundaries between refs.c
and refs/*backend.c files.

It would be better to only mention ref_transaction_update() in the
title, and talk about the need to make matching adjustment to
ref_transaction_add_update(), which is an internal function, in the
body of the log message.

This is an unrelated #leftoverbits tangent, but while trying to find
out the reason why "[_add]" in the title looked irritating to me, I
noticed that builtin/show-ref.c includes <refs/refs-internal.h>.  I
do not know what it uses from the "internal" implementation detail,
but the API may have to be cleaned up so that a random "client"
caller do not have to do so.

The patch itself looked good.  Thanks.

