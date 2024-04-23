Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C272E62F
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914839; cv=none; b=CHGB941pELNhAEcvnaeO+w8l3WAmmZJw6jkYNfXiidFgRLoCjMI3msl0eGn3ZXdTat+QQfS8wLKHxtBG6rv730rHocGKXpZSybe+b1JI/eXwji/Tu+HFV8WTxSyio7Io1LMdmy1tdWL+CamlP3lFXr5DEApN5/RG6gcMqUFuYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914839; c=relaxed/simple;
	bh=FGzNixum0Ym+A45woA+sXaDGBLTis+gw+t7DT8wSDBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HE2d3itPVeaYC3ViQKWkG8DhNiKnrxJVrA4Hybw2jEB1tGK2G/mXzpHgOh1FlktcR5tpDyN82Ujf/gT+CZ19K9r4AZWjU1wJOirUuInXiM4JMQWMmcXhhKZIyDUmFVvNL0GCGi1KmyZKI133ZJOZL+on8P9OSv7OINis1vyPGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xu+1Rt5u; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xu+1Rt5u"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 740EB2EAF3;
	Tue, 23 Apr 2024 19:27:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FGzNixum0Ym+A45woA+sXaDGBLTis+gw+t7DT8
	wSDBA=; b=xu+1Rt5uBZYMZOhRabCkNfqPru8JAvcneNvx5pxGN3K40oi+ah7LbH
	H+rM81NqHEJ01s+X9W9bcyd4PHOv0O0V2Pn/Uqyu2HNg3vi17L3nRgbXJWS/V0V6
	Ymg5O0s50hPzD/YXD6VN/Xcs3aRISMFrC5quaMmOlYmwW3APESPOA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C46C2EAF2;
	Tue, 23 Apr 2024 19:27:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3A752EAF1;
	Tue, 23 Apr 2024 19:27:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 8/8] trailer: retire trailer_info_get() from API
In-Reply-To: <eca77a1a462a624f988fc50f7588d831678f34f4.1713504153.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Fri, 19 Apr 2024 05:22:33
	+0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<eca77a1a462a624f988fc50f7588d831678f34f4.1713504153.git.gitgitgadget@gmail.com>
Date: Tue, 23 Apr 2024 16:27:12 -0700
Message-ID: <xmqqwmon4q3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 03F478CE-01C9-11EF-BC45-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Make trailer_info_get() "static" to be file-scoped to trailer.c, because
> no one outside of trailer.c uses it. Remove its declaration from
> <trailer.h>.

Yay.  But the callers still need to know what parse_trailers() gives
them, and what they can do with the struct.

Other than that, an obvious last step that concludes the series.
Nicely structured.

