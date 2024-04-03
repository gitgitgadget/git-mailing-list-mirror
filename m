Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92F14F9C1
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161288; cv=none; b=m/m/3VhPHpxJOrugfuRZI9UiKSMunb2yAhriPj53/kALfrwh20XF3856Vephab3zSh1JKYqEMZR4KLXDkweXmvh7uNE/tH3i/AR+8nLiyFKw2wUebL3mw+dnhpU+WfIx7CPNCXbekEVAQNlgjKRy8nACRiTuZ/HWBbrbNnYCITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161288; c=relaxed/simple;
	bh=dRNIg7et2qERqFnFczoc0t0iIsX+jzNvIZ26nRQ+uMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JXs1TjtpoHJPz/BMjucaTAKwrATvlrlxnbmO2yxBoqn2P4X98e6U0AxazHHJ2o27Adffv38WOy4yBZv1+nOYLzc0tkg0qyEB5jYTvs7Mdm8BZaJYQTCmSR/r3Wdqj2KiG0IYTtGC85nfrDzkoXsg0l5ksiZkwFEcDjiG6Z+OwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aoZUf5Di; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aoZUf5Di"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5785F32BDF;
	Wed,  3 Apr 2024 12:21:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dRNIg7et2qERqFnFczoc0t0iIsX+jzNvIZ26nR
	Q+uMA=; b=aoZUf5DivjrC9nKWsySYT/RazkTNlijI4Ezn2dGOOi4OjEF+v3v9nH
	HebkeA+2BNv3on+6h6L+veutZzDJ2tzQ0GxUee/+xbwEvguSWcUPTh/JVKtAOBNi
	Ey10tGOBLW5QFtfIgs+rdiSAJH7en7f+fFj1L0XyfSSALfnCr5o5s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 500EB32BDE;
	Wed,  3 Apr 2024 12:21:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDD5532BDB;
	Wed,  3 Apr 2024 12:21:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,  git <git@vger.kernel.org>
Subject: Re: Subject: [PATCH 3/9] refs/reftable: skip duplicate name checks
In-Reply-To: <Zg07vKzkeXt7l8RW@tanuki> (Patrick Steinhardt's message of "Wed,
	3 Apr 2024 13:21:32 +0200")
References: <CAOw_e7YspBkOo7QE0Z3QqWXd6P1OVnF9j3q7ircrce25KNbKLw@mail.gmail.com>
	<Zg07vKzkeXt7l8RW@tanuki>
Date: Wed, 03 Apr 2024 09:21:21 -0700
Message-ID: <xmqq7chea03i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36223898-F1D6-11EE-9835-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> My assumption is that as soon as there is going to be a second user of
> this library we'll have to do some cleanups regardless. So I'm inclined
> to delete the code now and potentially bring it back if we ever see that
> it's indeed important for external users.

The less code we need to carry, the better.

Thanks for the suggestion (and renewed involvement), Han-Wen.
