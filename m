Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792F7E0E8
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402900; cv=none; b=NDYMRghi4p/Xxp1IB+pU8rj1azb4Y1E12auTqRmzfQQo/Ps/YIVD1MhBFwtM3ifvJaOsFzpiYJsin4IfdI3CL+veAmzqkcT2inlbaji7VoUqCfM2D/zvfCiq6dBP/YR1gT0/1NuT/jKSXCKfa63o+MEa5rTo+sxIhLq/mYza9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402900; c=relaxed/simple;
	bh=dq+9fH05yBaPwKm9r87Tb7jAz1hLQ2nPctvNvO2SwGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cL1qc6g4LfO8FnLacS35lsMn9UZuWVCp6BcRfmExYvfDMGjh1EhDmc7af8CtQaR+U6jiudzZ7Tf9dTVDgphNSGuXWcwEeAiBW3LRoo5Lu8rGPI4b6aVRW/GCmcfNSEry4aabz0AXSazRfy3uvsGuK65uitx3FixLyS+CKcttATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vszaegF6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vszaegF6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D3130066;
	Mon, 29 Apr 2024 11:01:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dq+9fH05yBaPwKm9r87Tb7jAz1hLQ2nPctvNvO
	2SwGc=; b=vszaegF6wHFDt62vSq1tLSUhUqFwBQiEW5zWkNnlSlj1wssMK8LQGx
	lRWZZPn83hxru182PnTkQ1VD3blReMaw+r7qLppTV2BAGRxdUuEwrhb+/vNYtwjg
	HT0ZPtVTuf7CA1XT0BNaymyhsr8PeRXj27SyrCuCuxaSd8BBUDR/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69FEE30065;
	Mon, 29 Apr 2024 11:01:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74ED130064;
	Mon, 29 Apr 2024 11:01:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/8] tightening ref handling outside of refs/
In-Reply-To: <20240429081512.GA4130242@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 29 Apr 2024 04:15:12 -0400")
References: <20240429081512.GA4130242@coredump.intra.peff.net>
Date: Mon, 29 Apr 2024 08:01:36 -0700
Message-ID: <xmqq5xw01acv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 60942C0E-0639-11EF-A2BE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> This series teaches check_refname_format() to enforce these rules (when
> instructed; see patch 6 for a discussion of all sorts of complications).
>
> These changes are not backwards-compatible! But that is kind of the
> point. This is stuff that was never supposed to work. My concern would
> just be that somehow somebody is relying on it.

I would of course be worried about the same, but these all look like
reasonable "I wish we did them in this way from the beginning"
changes.
