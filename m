Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A126AE7
	for <git@vger.kernel.org>; Mon, 27 May 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831792; cv=none; b=q6oo7b1+cEBfOlwuPHIfMR+fdNdciEjVqdCKuBoO2pIOo3wrWsk2GpAVPP2tkFor9bShZ0qR1dxGxtEpt/JuK2IUmXYC1Q1bD4rm9YxTJ7FPUod3lUk5yInX64z7rYXZPVKBW3jov15EHITOcif8vUyUAh03pef5tqWyRnxLHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831792; c=relaxed/simple;
	bh=/4OZTgGYQxO3EDtkji9vCH/FtINkL9DowDvdJOdHmCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUq1bu29CvJ0HXBC9RnzDUdAOFpOWhres5Yw0+5iMAXixddMMGqp6qzM2YBlmxiCwjjcDgC53otl/q0diAVoa3Vf+cnTd4O3g/yJhAMcbyfE1Mv24Y2cgtxJkji74HGlT7rLPEQFNaJ1erR0JoB2dFyx8gHH+UbHGNYPy0x9MCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=APD3Wjqm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="APD3Wjqm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DB8D223AD;
	Mon, 27 May 2024 13:43:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/4OZTgGYQxO3EDtkji9vCH/FtINkL9DowDvdJO
	dHmCQ=; b=APD3Wjqm8w4E1x6qFJOvl/1NlOyMb6E8JdWSt5jzAykjqVBQhrFuye
	nyslaC9f/f3KGhrSblgmRM7/BOD1Yw0OKJ/jasyAbjW0MKN6vp2gSXh+jhNxvYMI
	FryJ+OZpiyrwcvfygZDNcLFRA+s+zBfa5rmrmZ2Wbs05r9PJzl/vU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 848EC223AC;
	Mon, 27 May 2024 13:43:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7720223AB;
	Mon, 27 May 2024 13:43:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
In-Reply-To: <ZlQX0FmIsz2eFgsC@tanuki> (Patrick Steinhardt's message of "Mon,
	27 May 2024 07:19:12 +0200")
References: <20240523225007.2871766-1-gitster@pobox.com>
	<20240523225007.2871766-3-gitster@pobox.com> <ZlB2g5bTuBFz5m5_@tanuki>
	<xmqqo78ukhmk.fsf@gitster.g> <ZlQX0FmIsz2eFgsC@tanuki>
Date: Mon, 27 May 2024 10:43:06 -0700
Message-ID: <xmqqsey39mmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9412C1E4-1C50-11EF-8DD7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The machine can cope alright. But I think that it's way harder to parse
> for a human if there is no clear visual delimiter between the diff and
> the interdiff. And "Interdiff" isn't quite ideal in my opinion because
> it is text, only, and may be quite easy to miss if it follows a long
> diff.

Apparently our messages crossed.   See <xmqqed9qke3k.fsf_-_@gitster.g>
that takes advantage of the fact that "the machine can cope alright"
with an extra blank line ;-).  The message is its own demonstration.

Thanks.

