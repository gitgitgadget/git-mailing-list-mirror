Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4F31A67
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229093; cv=none; b=sSrlhslpjzpPuNT+pcEF0spcQs+EpTEexAfFYALSTvJTwoApR5zojVRGgBSdn9UdVZyqpR529pWnFXa9AVyR09J9WH8K+ot5xrtNK+ShZzVTTm7gEmRj9B5b5/c9JGuVvgJQ+iX02UhZX/jfpfJOrU0Vs/+PXJu8ViVk8cHhiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229093; c=relaxed/simple;
	bh=hG/KpqOHpNZF+CXLA+hrf/3IzfCep9ZIUeHrNDKKgQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rtq1GR66u9dgURBwJN9md+c8yEGiA3XuJr8fcNIT/TIMhEktWpwnYcg7zgQC6hi27MfutNNv2s3ZJ9nWLF77qbtJy1jcfKjPSi1SsjbnIRVJ580h0P9+Jg27/1Y2rymYBhcdr6lKc4gjsDRnMGPFWSCn/samWU0c2RagQ9n7VSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DaHnJMKd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DaHnJMKd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0030233404;
	Wed, 12 Jun 2024 17:51:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hG/KpqOHpNZF
	+CXLA+hrf/3IzfCep9ZIUeHrNDKKgQw=; b=DaHnJMKdoU159gB36R8PiPZvFg4H
	WZLTVWdEiEusiemWAS/6c27HmF7MsxpgcrTSf2UNyXAeSwwaEjASqntNnpvSfdaJ
	oZdSey5lhTZvn3RGOZBqu76dxzfUlQ7VVYgD2R9KdN9XmeFS8scvtMdT9FuIAqsP
	NVnkTBiZ0yBTrCw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB03133402;
	Wed, 12 Jun 2024 17:51:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 594EB33401;
	Wed, 12 Jun 2024 17:51:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] t/lib-http: add serve-git.py
In-Reply-To: <20240612115028.1169183-2-cmn@dwim.me> ("Carlos =?utf-8?Q?Mar?=
 =?utf-8?Q?t=C3=ADn?= Nieto"'s
	message of "Wed, 12 Jun 2024 13:50:25 +0200")
References: <20240612115028.1169183-1-cmn@dwim.me>
	<20240612115028.1169183-2-cmn@dwim.me>
Date: Wed, 12 Jun 2024 14:51:22 -0700
Message-ID: <xmqqzfrpomn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E914EC32-2905-11EF-BFA0-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:

> This is a basic HTTP server that is able to serve Git content via
> calling out to the underlying git commands. This avoids relying on CGI
> which can add complexity when trying to replicate some behaviours, in
> particular when the bidirectional stream and its directions being open
> or closed are important.

You wrote it in the cover letter already, but it won't be available
to "git log" readers. =20

Give a bit of explanation on the reason why we do this in the first
place, in other words, what we are shipping an HTTP server with our
source for, before introducing "this is a server".

E.g. "instead of relying on an overly complex Apache with CGI, add a
simple HTTP server based on http.server class that offers THIS AND
THAT BENEFIT FOR OUR PURPOSE to help testing" or something like
that.



