Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6614D108
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865149; cv=none; b=A1RXWTQ6UOLFEsPdNdyx8MvUOkXToEnwYHpKKXEwkZkqODG6++UbkCfCRsXPPD2RiAEGO6KeVBFRX7G1riKiOHJy8ZcMolZLw3r+sK5Q2cLTgxBstLdKi6ACL26yagXbETb2AdWSJtWLbgR262rB2m5sw4/JaoBOA/6w/UssY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865149; c=relaxed/simple;
	bh=4yBAm3yThrOu/ambjcf22BQy58nBko/qfbzA2jst06k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZUUoC76v1xc5ZUtXoQ4vRO52e50OSKFNPKggttvEI4rIYwj35an6xrXKJ4kEry5J+nQ2HMe+pi9P6TR0g9oSjfFaqahVCdqNr22lNGwKE5QpQhmQulvOZaJeU0p5RH5FURc3lf/IJaovvFAD7n97ay0f/eO/jvkUj8nDyW2vcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bWOvAROp; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bWOvAROp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A20EC3BEAA;
	Wed, 28 Aug 2024 13:12:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4yBAm3yThrOu/ambjcf22BQy58nBko/qfbzA2j
	st06k=; b=bWOvAROpOrpBqt/LCDN/U98l1jNwYXly0HzIaW3E0bcALSc6GDgtsR
	E8y46BnEYROwPgixPYq0ZzPrPxI3Xr4Vrp3/C/xTq3Zu8vF5ddMZSdTQ1C5arKCu
	r2/q7/zQfZzwXKLYhIIOSBzR+hB4N1kdbE0r040vqCqZkUUGqPsjo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AACE3BEA9;
	Wed, 28 Aug 2024 13:12:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 141D03BEA8;
	Wed, 28 Aug 2024 13:12:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] reftable: mark unused parameters in empty iterator
 functions
In-Reply-To: <20240828040944.GA4005021@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Aug 2024 00:09:44 -0400")
References: <20240828040944.GA4005021@coredump.intra.peff.net>
Date: Wed, 28 Aug 2024 10:12:22 -0700
Message-ID: <xmqq34mo1si1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B17FB9AE-6560-11EF-B75E-BF444491E1BC-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> This should go on top of ps/reftable-drop-generic. Arguably this could
> have been done as part of the conflict resolution when merging into next
> alongside jk/mark-unused-parameters, but at this point I think a
> separate patch is the best way forward.

As marking with UNUSED used to be optional before -Wno-unused-param
got removed, I agree that it is better to apply this on top to be
explicit, rather than burying it in an evil merge with a topic that
marked other unrelated parameters as UNUSED.
