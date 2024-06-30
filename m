Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7E3716D
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719771593; cv=none; b=SFn/fzoeiqJHqY62Ryb8UkcGuMfr53qJAxa4VYwYxrkQJ1VnR7QrfkVb9N+lxlywxYtJf+vPLfO8VAHiLeMciPugt2uj5CpEISBMQtLzTqYS/1RmjoAdVp1seFz6wpO1uIdNYDnj89f6E0JacMWyxndGv1Gs+KffVCQLXrJBgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719771593; c=relaxed/simple;
	bh=67k9BS2hU1oix0GpgaHUQvDPMLRaI2tfHvKXDEhvyAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aSP4jLaxiV4+5qZTwl3QTPisor0rGq8CBOJ7y5JblUY3YRIESjlj8Y2cOKBtsEnqur/SFb1xlq/M2Dy+1qhPY0kS5DR4mAeDsGXdLdLx5op3y5+S0A2bQD5U1j+y1kx18/ATBKNwnTzj4yJ9c+E9ERiz6z9C4iZd1MzJErIR88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vtufqYTp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vtufqYTp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E0A022ED9;
	Sun, 30 Jun 2024 14:19:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=67k9BS2hU1oix0GpgaHUQvDPMLRaI2tfHvKXDE
	hvyAU=; b=vtufqYTpIGgvP2OS9/W29jj3zS2XZIP03e18BHkJm6jAV3ImFb/+oq
	d8gisZ7+t0HwsMK6ynWHhki1uO3wYEGgFGNr0FYS16WQ8QDlJxR/8NRqEFSZ71fX
	B+utS/bMJDgAGSJDoDy0R1XqkHwRKimNSsVM/g4qrgueQQvk/Fqno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 24BA922ED8;
	Sun, 30 Jun 2024 14:19:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85DF022ED7;
	Sun, 30 Jun 2024 14:19:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusarver@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,  John Cai
 <johncai86@gmail.com>,  Aryan Gupta <garyan447@gmail.com>,  Linus Arver
 <linus@ucla.edu>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
In-Reply-To: <CAMo6p=FMhw2TZ4MdowMjQM0wgb90Lkqa17AENsxNqj-eJk_5WQ@mail.gmail.com>
	(Linus Arver's message of "Sun, 30 Jun 2024 03:12:28 -0700")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
	<xmqq34pqlyou.fsf@gitster.g>
	<F64F4F3A-EF82-4281-8A75-0DDC8FA65D4B@gmail.com>
	<xmqqed99k7xo.fsf@gitster.g>
	<f6abd59c-ea86-423f-9172-79779932418b@app.fastmail.com>
	<xmqqle2o26jy.fsf@gitster.g>
	<CAMo6p=FMhw2TZ4MdowMjQM0wgb90Lkqa17AENsxNqj-eJk_5WQ@mail.gmail.com>
Date: Sun, 30 Jun 2024 11:19:43 -0700
Message-ID: <xmqqv81qz41s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53701164-370D-11EF-84A0-965B910A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusarver@gmail.com> writes:

>>  - Or the welcome message GGG adds to the pull-request that begins
>>    with "Thanks for taking the time to contribute" can mention
>>    something about this?
>
> I've created https://github.com/gitgitgadget/gitgitgadget/pull/1644 to
> address this for now.

Thanks.
