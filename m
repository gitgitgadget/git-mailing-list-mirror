Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416C4204F
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785924; cv=none; b=u5AIYknpUHlkELK/5VnkiG7sAJkAc0CJ6smzOrZvVUXYEgpjnZi/xzcZzxzw/tuUhYeH08y1DvNcJAYOiQtZNmnBntQCuKFNjj1klgKW+nJYRYfBFIf9fXUgvo02JZcbwQr+qGTicsFlkUgtOhcIO0JgCBKXQEoQMouqmOEkjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785924; c=relaxed/simple;
	bh=gWaf4yScdx9Ustm6mZSWIACieBjRyJyeVC3/N88xPEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZ5BjagD+wuZS1QNfQkkKyTJK3456NPX2z0hCKfsS9FXOY8g8DCuJtGswzAve9656ha9DL6c1aXe7ZQA2+7iziw6KZ5tFXn3YZ0+wCu28qU1khOtbYRAVROIq5uKMPDOFrwfWGPNZDPQr6CbDwVBuO+/+1EACT+kmYbZsus8mjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x+s7nQlz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x+s7nQlz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 697242D178;
	Fri,  7 Jun 2024 14:45:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gWaf4yScdx9Ustm6mZSWIACieBjRyJyeVC3/N8
	8xPEY=; b=x+s7nQlzStKc+bP843APOaP7w0B2xDl6VHAkjhfVo4xog47JSiCW8A
	9E2jio+Uajidy8VbEo+jQGihZleFWJvjix+nL5jJ/eWqdAhlexBHx2fcKsQGKNvX
	5A8+QP38W8M/KMA2XdDYJWprvRWWFq8NU2wAQKXByOffC79g5HMJI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 61E082D177;
	Fri,  7 Jun 2024 14:45:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E4FD2D176;
	Fri,  7 Jun 2024 14:45:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
In-Reply-To: <ZmKalkqR3GqCXfqz@tanuki> (Patrick Steinhardt's message of "Fri,
	7 Jun 2024 07:28:54 +0200")
References: <20240606080552.GA658959@coredump.intra.peff.net>
	<cover.1717662814.git.ps@pks.im>
	<bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
	<xmqqplsum2cz.fsf@gitster.g> <ZmKalkqR3GqCXfqz@tanuki>
Date: Fri, 07 Jun 2024 11:45:18 -0700
Message-ID: <xmqqikykd22p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 16D80DF4-24FE-11EF-84E8-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We're unlikely to break existing workflows though if we name this
> variable something like `OPTIMIZATION_LEVEL`.

Yeah, being more explicit is always good.

> We could also generalize this a bit and introduce `CFLAGS_APPEND`
> instead. Optimization levels are last-one-wins anyway, so people can use
> that to append their own flags without overriding existing values. It
> would also mean that we can avoid repeating the CFLAGS that we already
> have in our Makefile in our CI scripts.

Yup, Peff's $(O) cannot serve as such, but my $(O) is already being
used as such.  Naming the variable that gives additional CFLAGS as
such is probably a good way to go.

Thanks.

