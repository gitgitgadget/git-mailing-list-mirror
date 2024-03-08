Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269A4C7B
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911584; cv=none; b=JS+jZYbcx1fYopfdDSJTdqvtoxOT8bRzn/fDghr13bhoIMPJmL/GHpB7V54hvl5jBe4vKxBVlZRGlJvut2kcla7ZxqU+AIHtioAwy2KnsPAilIl1MjVgUvRehUNPK03LMYGah8aYlNemT3o6EnZY/sLUWNaQpOEiroZU75iFtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911584; c=relaxed/simple;
	bh=A8rSXauAJl5cP9hs5NgH3mNaRn2m2mNj03dBrYIMook=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OhxgdJIGnfJeel50XZ8DSSRN64G5mo9SZ6+C6DMZ8vpsRvONhaDnutJsFenU1sSlGBUR+opoDCf3c7HnrRb33/uQLWJ0gc2viukiZt5miWUogPs8IYGbJhDM2GXLFAdFLKnTzNr3r4uNmNCt0HtO5L5xosTbnBMuNFx+mcpvO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WHzeDYDj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WHzeDYDj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0E971DF86F;
	Fri,  8 Mar 2024 10:26:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=A8rSXauAJl5cP9hs5NgH3mNaRn2m2mNj03dBrY
	IMook=; b=WHzeDYDjcd15TlpRNpmdZciyFuHHvlfbRJuodsKu1jDaLwaUprKLbt
	MkoCq/ZsWBMiCGRwLfxhIQzcSwr/aoONydAbvQPA8WJwVwfC9Lz+o8BtmMuhm64J
	kWDz3w2rhQCLH9k499KNAlqYXyFVisuTynOQWqS0aGw71kiRF6Bz4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B77DA1DF86E;
	Fri,  8 Mar 2024 10:26:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 273651DF86D;
	Fri,  8 Mar 2024 10:26:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org,  Jonathan Davies <jonathan.davies@nutanix.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Denton Liu
 <liu.denton@gmail.com>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
In-Reply-To: <1ff36e64-b993-4cbb-ba0a-01aca5396ef6@nutanix.com> (Florian
	Schmidt's message of "Fri, 8 Mar 2024 09:08:50 +0000")
References: <20240307183743.219951-1-flosch@nutanix.com>
	<xmqq34t1n91w.fsf@gitster.g>
	<1ff36e64-b993-4cbb-ba0a-01aca5396ef6@nutanix.com>
Date: Fri, 08 Mar 2024 07:26:20 -0800
Message-ID: <xmqqedckiw2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 377036DA-DD60-11EE-9AC7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Florian Schmidt <flosch@nutanix.com> writes:

> Do you want me to send this version as a v2 to you + the list as per
> the documentation?

It would be the technically correct way to do so, but as a short-cut
to reduce a round-trip, if you are happy with the version I queued
(should be found by fetching the 'seen' branch from any of the
mirrors), you can just say "that looks fine" and we can be done with
this patch.

Thanks.
