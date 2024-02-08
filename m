Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE5F4EE
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350959; cv=none; b=YtWmvzyAkWm0fhYudgyiHxTw6SemxrjGKCRZKjNMTdCVOAEYcdGBAa+4IK9DllRU3xUUiYgv4Vqb/Gk+Bt3Yqe4hU69jCXokOlyRqa0IUTtlBLPfApmnhL8Pa+w+f/dV4/edLCd2MAWUUYRDc73rH49lABpjFkbky9aEG+rMhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350959; c=relaxed/simple;
	bh=H3gkR45MfJ09FsrSOEeniL4Nh80XnAd9k3WRgHaB5rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h3B0BC1HZ3nICp8Zq5DSAoB83KD7iT5Ao8qYvD151Sajh/9IaAfHZbggy2wzLAA0M/yFsIb3ldPD9ypFXQzqUQdjULy3msFx7YSQw935q/zSFG5H4KR1emb8q9egFSK0LlcdwrFdb5IdAVoTF2fh/2zuOkyTovfnk7Cflptut1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O0//VHbp; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O0//VHbp"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EF87B2CCAD;
	Wed,  7 Feb 2024 19:09:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H3gkR45MfJ09FsrSOEeniL4Nh80XnAd9k3WRgH
	aB5rg=; b=O0//VHbpHNUvQosIevhDMO2oFvJDCEEyiuTzkPxN0tdhNSSdb+Iwgf
	IGikjt1YWlKgP9hPUlx0XnLO5CwmhvUo5rORXn9jJrTdDHyFr6iwKE7oENMyJZvX
	hbyB2aPhIy9l2HesmbLfIFBUsHoNvDPRtFP+t2tAnxRHgJGdfMLpM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E77702CCAC;
	Wed,  7 Feb 2024 19:09:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D5882CCAA;
	Wed,  7 Feb 2024 19:09:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
In-Reply-To: <20240207225802.GA538110@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 7 Feb 2024 17:58:02 -0500")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
	<20240207225802.GA538110@coredump.intra.peff.net>
Date: Wed, 07 Feb 2024 16:09:11 -0800
Message-ID: <xmqqh6ijrf4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A451F02-C616-11EE-9369-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> So I think we probably want to keep it (or possibly move it onto the
> UNIT_TEST_SOURCES line, which keeps it close to the wildcard call).

Sensible.
