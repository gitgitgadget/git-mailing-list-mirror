Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56F38DE7
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258615; cv=none; b=bzXH8E9Ee0NVDr0amMo/g/c3aa+6jkEmIG3kMgWZyyekckYxmRh4lNpKMkSUXOQy1MFbSOAJCKAeYCTBLsu7TBlcZ8GpaDga+oEKhT9DbFIEcpAdL41StVOjgxCIg4rfBf4mZSdc/AANsModw6AOID3/bRh6/nHmKIWTguOnVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258615; c=relaxed/simple;
	bh=qvvjbOdtQXBBL4kejRLJ8Q5fr1Ahc4AqxTj4GrMZTTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gR3sOO2Omp4RToME1nZOWFYzqMGgbadgEpPbKluCZG9PCLBkNl1w3O8Ker66Bz+3vTyx4caeHVDvrfzqnyK8dDRdrQVtuDLv2KjBtmO7nGYOBRBFcA4CujdESWYLCiImKgopfy4WGr2IXPK0hrHOLS7aXUKCAwbg5LwRC5e1DK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HnYuTaj6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HnYuTaj6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B6031D0F41;
	Thu, 29 Feb 2024 21:03:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qvvjbOdtQXBBL4kejRLJ8Q5fr1Ahc4AqxTj4Gr
	MZTTw=; b=HnYuTaj6eMyl9mqWfW71zx8p2hoHczDH0FZUa3Fm9Jb/9UEOLu95kM
	nk+QGePovuDhBupVgRUgVDsArvPJkmYz2uuedDnstXKdIv9ALHC1/OFJuPj0/FVg
	THf8d6O7bcYgcBl8DZoRd/QELmQsEQNGN6chVqszaRA1eFxzomDFs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01A3F1D0F40;
	Thu, 29 Feb 2024 21:03:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E4D11D0F3F;
	Thu, 29 Feb 2024 21:03:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Michal
 =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Aryan Gupta <garyan447@gmail.com>
Subject: Re: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
In-Reply-To: <CAPig+cQ+JNBwydUq0CsTZGs8mHs3L3fJDuSosd+-WdKwWWw=gg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 29 Feb 2024 19:06:36 -0500")
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
	<pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
	<xmqqle72c17i.fsf@gitster.g>
	<CAPig+cQ5m86=pLTpFrik0xS6XPyK4tZQx_wkc1xh2r9WDFkhuQ@mail.gmail.com>
	<xmqqa5nic06t.fsf@gitster.g>
	<CAPig+cSGtcA15aOmvj07Uv-pFZTE58+9gGsQh=8K4BL4KRieQA@mail.gmail.com>
	<CAPig+cQ+JNBwydUq0CsTZGs8mHs3L3fJDuSosd+-WdKwWWw=gg@mail.gmail.com>
Date: Thu, 29 Feb 2024 18:03:31 -0800
Message-ID: <xmqqwmqmaeto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E7B88A70-D76F-11EE-BEA2-25B3960A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> The double-negative confused me even when suggesting a replacement.
> What I meant was that a better phrasing would perhaps have been:
>
>     'foo' is empty but should not be

+1.  Thanks for caring.
