Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514B1E498
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323667; cv=none; b=Rj0BFWtgNulRdNgHBEA87z8Fh9bkWQ+QoOSnv09T6DWhjhAd/mumLSmL+1Ue97BI3gZy+bWohn+S0IKGYVvH0K5oa2CZo/Gaq5ZCTTsmjEDUQ+rQvo4XUMOst3FoApexF5Ssq9qlK74rgwX82/fVkywz+PESwz/iwZZHjNWPxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323667; c=relaxed/simple;
	bh=fOtOIdMXxv3Bw0+Xl+/vrGyue8D2yj7Z5d9ngk5zDp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fiejr9mIS1RU7PXQUgyRS7Dc8ILhsdomfqfzsy9rEGyMKqwr/DIltHaKVTzKqGwcM8hUC1t8OtBwpDNB+RO5p7KVRJSbZBLf+/uZNyUklT47Hb+9LuO8S5vtpxMvWVS8lFburCZ06wi0g2QHmopFjcom0b22xqIwIJWi+MbYJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vu1Z7Y33; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vu1Z7Y33"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A34091D7213;
	Wed,  7 Feb 2024 11:34:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fOtOIdMXxv3Bw0+Xl+/vrGyue8D2yj7Z5d9ngk
	5zDp4=; b=vu1Z7Y33qzhSYKecfI9JVMechtiPHJL4uL6boKPcido/Sm/tSO24mn
	Fx04HSIeWthH/r4aTmpERTTo+/BwdG8b/OjwCFcWu4npk1vLtnIqdJHjQiEkUlHk
	fPRRUpmR5zG7QPd3EtPCmGGA1WU/u4zSKhOWHoPBHvJsBldfKS7ds=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6D21D7212;
	Wed,  7 Feb 2024 11:34:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0696A1D7210;
	Wed,  7 Feb 2024 11:34:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  John Cai <johncai86@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>,  Elijah Newren
 <newren@gmail.com>,  Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with
 --missing=...
In-Reply-To: <owlyttmkmwaf.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Wed, 07 Feb 2024 01:57:28 -0800")
References: <20240201115809.1177064-1-christian.couder@gmail.com>
	<20240201115809.1177064-4-christian.couder@gmail.com>
	<xmqqil37yix1.fsf@gitster.g>
	<CAP8UFD3Hfgud19y_K1bZOudkBE-ss1_SgWTRVkJ7gUbYJ400yQ@mail.gmail.com>
	<owlyttmkmwaf.fsf@fine.c.googlers.com>
Date: Wed, 07 Feb 2024 08:34:22 -0800
Message-ID: <xmqqfry4cjxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C0A09568-C5D6-11EE-8E02-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> IOW, make the minority (certainly not majority, I think?) of users who
> really need the error propagation use the (new) extra flag, while the
> rest of us (including the version of you who was surprised by the
> limited behavior of "--missing=...", enough to write this series) don't
> have to.

I am skeptical that we even want that.  Those who want to use the
"--missing" and care about special casing missing starting points
can easily check with things like "cat-file -e" before even running
the "rev-list --missing".
